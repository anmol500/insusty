import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as ad;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestion2.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestion3.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestion4.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestion5.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestion6.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestion7.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestion8.dart';
import 'package:insusty/Util/Locator.dart';
import 'package:nb_utils/nb_utils.dart';

import 'CalculatorQuestion1.dart';

class CalculatorQuestionPage extends StatefulWidget {
  CalculatorQuestionPage({Key? key}) : super(key: key);

  @override
  State<CalculatorQuestionPage> createState() => _CalculatorQuestionPageState();
}

class _CalculatorQuestionPageState extends State<CalculatorQuestionPage> {
  PageController pageController = PageController();
  var page = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItCalculator.addListener(() {
      setState(() {});
    });
  }

  var selected = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  tapped({index, score, apart}) {
    selected = [false, false, false, false, false, false];
    selected[index] = true;

    print(apart);
    if (apart == null) {
      var currentScore = getItCalculator.finalScore;
      getItCalculator.setScore(currentScore + score);
    } else {
      getItCalculator.apart = apart;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    page = 0;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              screenSize.width > 750 ? 'images/q&a/qDesktop${page + 1}.png' : 'images/q&a/q${page + 1}.png',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    5.width,
                    AnimatedFlipCounter(
                      fractionDigits: 2,
                      duration: Duration(milliseconds: 500),
                      value: getItCalculator.score,
                      textStyle: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 75,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: screenSize.width > 750 ? EdgeInsets.symmetric(vertical: 18.0, horizontal: 450) : EdgeInsets.all(0),
                    child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CalculatorQuestion1(selected: selected, tapped: tapped),
                        CalculatorQuestion2(selected: selected, tapped: tapped),
                        CalculatorQuestion3(selected: selected, tapped: tapped),
                        CalculatorQuestion4(selected: selected, tapped: tapped),
                        CalculatorQuestion5(selected: selected, tapped: tapped),
                        CalculatorQuestion6(selected: selected, tapped: tapped),
                        CalculatorQuestion7(selected: selected, tapped: tapped),
                        CalculatorQuestion8(selected: selected, tapped: tapped),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  selected = [false, false, false, false, false, false];
                  setState(() {});

                  getItCalculator.setFinalScore(getItCalculator.score);
                  if (pageController.page! < 7) {
                    page = pageController.page! + 1;
                    setState(() {});
                    pageController.nextPage(duration: 300.milliseconds, curve: Curves.linear);
                  } else if (FirebaseAuth.instance.currentUser != null) {
                    FirebaseAuth fireAuth = FirebaseAuth.instance;

                    Future<QuerySnapshot<Map<String, dynamic>>> user = FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get();
                    user.then((value) {
                      FirebaseFirestore.instance.collection('00users').doc(value.docs[0].reference.id).update({'tons': getItCalculator.finalScore});

                      context.go('/CustomerDashboard');
                    });
                  } else {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setDouble('tons', getItCalculator.finalScore);

                    ad.AwesomeDialog(
                      context: context,
                      width: 500,
                      dialogType: ad.DialogType.success,
                      animType: ad.AnimType.rightSlide,
                      title: 'Your score is ${getItCalculator.finalScore}',
                      desc: 'Please login to save your score',
                      btnCancelOnPress: () {},
                      btnOkText: 'Login',
                      btnOkOnPress: () {
                        context.go('/login');
                      },
                    )..show();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
                  child: Image.asset(
                    'images/ui/Calculator/nextBtn.png',
                    scale: screenSize.width > 750 ? 4 : 1,
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: screenSize.width > 750 ? 30 : 10,
            top: screenSize.width > 750 ? 30 : 20,
            child: GestureDetector(
              onTap: () {
                getItCalculator.finalScore = 0;
                getItCalculator.score = 0;
                getItPages.setUrlPath('/CalcChooseCountry');
                context.go('/CalcChooseCountry');
              },
              child: Image.asset(
                'images/ui/Calculator/cross.png',
                scale: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
