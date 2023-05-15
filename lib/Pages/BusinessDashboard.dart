import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insusty/Pages/BusinessAPIkeyPage.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Pages/BusinessTodayOrder.dart';
import 'package:insusty/Pages/BusinessTotalOrder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';
import '../widgets/BusinessDashboardTiles.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({Key? key}) : super(key: key);

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  var dayLeft = 0;
  var total = 0;
  var today = 0;
  var loading = false;
  getUser() async {
    loading = true;
    setState(() {});
    FirebaseFirestore.instance
        .collection('transaction')
        .where(
          'Business_Email',
          // isEqualTo: 'somebusiness@com.com',
          isEqualTo: fireAuth.currentUser!.email,
        )
        .get()
        .then((value) async {
      total = value.docs.length;
      for (var i in value.docs) {
        if (DateFormat('EEE, d MMM yyy').format(i.data()['timestamp'].toDate()) == DateFormat('EEE, d MMM yyy').format(DateTime.now())) today = today + 1;
      }
      await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get().then((value) {
        dayLeft = value.docs[0]['dayleft'];
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
                          Navigator.push((context), MaterialPageRoute(builder: (context) => BusinessTotalOrder()));
                        },
                        title: 'Orders',
                        value: total,
                        asset: 'images/ui/dashboard1.png',
                        screenSize: screenSize,
                      ),
                      BusinessDashboardTiles(
                        onTap: () {
                          Navigator.push((context), MaterialPageRoute(builder: (context) => BusinessTodayOrder()));
                        },
                        title: 'Today\'s Orders',
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
                          getItPages.setUrlPath('/BusinessDashboard');
                          context.go('/settings');
                        },
                        title: 'Settings',
                        asset: 'images/ui/dashboard3.png',
                        screenSize: screenSize,
                      ),
                      BusinessDashboardTiles(
                        onTap: () {
                          getItPages.setUrlPath('/b2b');
                          context.go('/b2b');
                        },
                        title: 'Renew Plan in',
                        value: dayLeft.toString(),
                        asset: 'images/ui/dashboard4.png',
                        screenSize: screenSize,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'More Options',
                        style: TextStyle(
                          fontFamily: 'nt',
                          color: Color(0xff00370F),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      5.height,
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push((context), MaterialPageRoute(builder: (context) => BusinessAPIkeyPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'API Keys',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xff00370F),
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          getItPages.setUrlPath('/APIDocs');
                          context.go('/APIDocs');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'API Docs',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xff00370F),
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('userEmail', '');
                          FirebaseAuth.instance.signOut();
                          getItPages.setUrlPath('/');
                          context.go('/');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xff00370F),
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
