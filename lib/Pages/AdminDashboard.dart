import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insusty/Pages/AdminTotalUsers.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Pages/BusinessTodayOrder.dart';
import 'package:insusty/Pages/BusinessTotalOrder.dart';

import '../Util/Locator.dart';
import '../widgets/BusinessDashboardTiles.dart';
import 'AdminTotalOrder.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  var totalUsers = 0;
  var totalBusiness = 0;

  var totalUsersSubs = 0;
  var totalBusinessSubs = 0;

  var total = 0;
  var today = 0;

  var loading = false;
  getUser() async {
    loading = true;
    setState(() {});
    FirebaseFirestore.instance.collection('transaction').get().then((value) async {
      //total orders
      total = value.docs.length;

      //today's order
      for (var i in value.docs) {
        if (DateFormat('EEE, d MMM yyy').format(i.data()['timestamp'].toDate()) == DateFormat('EEE, d MMM yyy').format(DateTime.now())) today = today + 1;
      }

      //total users and businesses
      await FirebaseFirestore.instance.collection('00users').get().then((value) {
        for (var i in value.docs) {
          if (i['individual']) {
            totalUsers = totalUsers + 1;
          } else {
            totalBusiness = totalBusiness + 1;
          }
        }
      });

      //total Subscriptions
      await FirebaseFirestore.instance.collection('Subscription').get().then((value) {
        for (var i in value.docs) {
          if (i['individual'] == 'true') {
            totalUsersSubs = 1 + totalUsersSubs;
          } else {
            totalBusinessSubs = 1 + totalBusinessSubs;
          }
        }
      });

      loading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.green,
            ))
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 28),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('/');
                          getItPages.setUrlPath('/');
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 4.5,
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontFamily: 'nt',
                          color: Color(0xff00370F),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BusinessDashboardTiles(
                        onTap: () {
                          Navigator.push((context), MaterialPageRoute(builder: (context) => AdminTotalOrder()));
                        },
                        title: 'Total Orders',
                        value: total,
                        asset: 'images/ui/dashboard1.png',
                        screenSize: screenSize,
                      ),
                      BusinessDashboardTiles(
                        onTap: () {},
                        title: 'Certificates',
                        value: today,
                        asset: 'images/ui/dashboard2.png',
                        screenSize: screenSize,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BusinessDashboardTiles(
                        onTap: () {
                          Navigator.push((context), MaterialPageRoute(builder: (context) => AdminTotalUsers(individual: false)));
                        },
                        title: 'Total Brands',
                        value: totalBusiness,
                        asset: 'images/ui/dashboard1.png',
                        screenSize: screenSize,
                      ),
                      BusinessDashboardTiles(
                        onTap: () {
                          Navigator.push((context), MaterialPageRoute(builder: (context) => AdminTotalUsers(individual: true)));
                        },
                        title: 'Total Users',
                        value: totalUsers,
                        asset: 'images/ui/dashboard2.png',
                        screenSize: screenSize,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BusinessDashboardTiles(
                        onTap: () {},
                        value: totalUsersSubs,
                        title: 'User Subscription',
                        asset: 'images/ui/dashboard3.png',
                        screenSize: screenSize,
                      ),
                      BusinessDashboardTiles(
                        onTap: () {},
                        value: totalBusinessSubs,
                        title: 'Business Subscription',
                        asset: 'images/ui/dashboard3.png',
                        screenSize: screenSize,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    getItPages.setUrlPath('/');
                    context.go('/');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 5.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff208207),
                            Color(0xff587B0C),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                        child: Center(
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
