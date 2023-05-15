import 'package:awesome_dialog/awesome_dialog.dart' as ad;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/StripeCheckout.dart';

class CarousalWidget extends StatelessWidget {
  CarousalWidget({Key? key, required this.monthly, this.asset, required this.screenSize, this.monthlyCost, this.yearlyCost, this.name, this.points, this.individual, this.monthlyCostAPI, this.yearlyCostAPI}) : super(key: key);

  var monthly = true;
  final asset;
  final Size screenSize;
  final monthlyCost;
  final monthlyCostAPI;
  final yearlyCost;
  final yearlyCostAPI;
  final name;
  final points;
  final individual;

  var tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FirebaseAuth fireAuth = FirebaseAuth.instance;
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get().then((value) {
            if (individual == value.docs[0]['individual']) {
              showDialog(
                context: context,
                builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    content: Container(
                      child: Column(
                        children: [
                          Flexible(child: Image.asset(asset)),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  monthly = !monthly;

                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: monthly ? Colors.cyan : Colors.white,
                                      border: Border.all(
                                        color: monthly ? Colors.cyan : Colors.blue,
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: screenSize.width / 12),
                                    child: Center(child: Text('Monthly')),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  monthly = !monthly;

                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: !monthly ? Colors.cyan : Colors.white,
                                      border: Border.all(
                                        color: !monthly ? Colors.cyan : Colors.blue,
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: screenSize.width / 12),
                                    child: Center(child: Text('Yearly')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontFamily: 'nt',
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "€ " + (monthly ? monthlyCost.toString() : yearlyCost.toString()),
                                  style: TextStyle(
                                    fontFamily: 'nt',
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            //fireAuth.currentUser!.email
                            tapped = true;
                            setState(() {});

                            // makePayment(context);
                            1.seconds.delay;
                            redirectToCheckout(context, monthly ? monthlyCostAPI : yearlyCostAPI, (monthly ? 30 : 365), name, (monthly ? points : points * 12), individual, monthly, (monthly ? monthlyCost : yearlyCost));
                            7.seconds.delay;
                            tapped = false;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.green,
                            ),
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: tapped
                                    ? LinearProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Confirm',
                                        style: TextStyle(
                                          fontFamily: 'nt',
                                          color: Color(0xffffffff),
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.redAccent,
                            ),
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontFamily: 'nt',
                                    color: Color(0xffffffff),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
            } else {
              ad.AwesomeDialog(
                context: context,
                dialogType: ad.DialogType.question,
                animType: ad.AnimType.rightSlide,
                title: 'Logged in?',
                desc: 'Please login with ' + (individual ? 'an individual' : 'a business') + ' account',
                btnCancelOnPress: () {},
                btnOkText: 'Login',
                btnOkOnPress: () {
                  context.go('/login');
                },
              )..show();
            }
          });
        } else {
          ad.AwesomeDialog(
            context: context,
            dialogType: ad.DialogType.question,
            animType: ad.AnimType.rightSlide,
            title: 'Logged in?',
            desc: 'Please login with ' + (individual ? 'an individual' : 'a business') + ' account',
            btnCancelOnPress: () {},
            btnOkText: 'Login',
            btnOkOnPress: () {
              context.go('/login');
            },
          )..show();
        }
      },
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
      ),
    );
  }
}
