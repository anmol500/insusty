// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key, this.points, this.name, this.days, this.individual, this.monthly, this.price}) : super(key: key);
  final points;
  final name;
  final days;
  final individual;
  final monthly;
  final price;
  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateFirebase();
  }

  updateFirebase() {
    //update user info
    FirebaseAuth fireAuth = FirebaseAuth.instance;
    FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get().then((value) {
      FirebaseFirestore.instance.collection('00users').doc(value.docs[0].reference.id).update({
        'points': (double.parse(value.docs[0]['points'].toString()) + double.parse(widget.points.toString())).toString(),
        'dayleft': (double.parse(value.docs[0]['dayleft'].toString()) + double.parse(widget.days.toString())).toString(),
        'plan': widget.name,
      }).then((value) {
        //adding subscription
        FirebaseFirestore.instance.collection('Subscription').add({
          'individual': widget.individual,
          'monthly': widget.monthly,
          'name': widget.name,
          'price': widget.price,
          'timestamp': DateTime.now(),
          'email': fireAuth.currentUser!.email,
        }).then((value) {
          5.seconds.delay;
          context.go('/');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "images/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Payment done Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "You will be redirected to the home page shortly\nor click here to return to home page",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: HomeButton(
                title: 'Home',
                onTap: () {
                  context.go('/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  HomeButton({Key? key, this.title, this.onTap}) : super(key: key);

  String? title;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
