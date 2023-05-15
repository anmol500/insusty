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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    List.generate(8, (index) => precacheImage(Image.asset(
      'images/q&a/q${index + 1}.png',
      gaplessPlayback: true,
      fit: BoxFit.fill,
    ).image, context));

  }

  @override
  Widget build(BuildContext context) {
    print(page);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/q&a/q${page + 1}.png',
              gaplessPlayback: true,
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
              GestureDetector(
                onTap: () {
                  selected = [false, false, false, false, false, false];
                  setState(() {});

                  getItCalculator.setFinalScore(getItCalculator.score);
                  if (pageController.page! < 7) {
                    page = pageController.page! + 1;
                    setState(() {});
                    pageController.nextPage(duration: 300.milliseconds, curve: Curves.linear);
                  } else {
                    FirebaseAuth fireAuth = FirebaseAuth.instance;
                    Future<QuerySnapshot<Map<String, dynamic>>> user = FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get();
                    user.then((value) {
                      FirebaseFirestore.instance.collection('00users').doc(value.docs[0].reference.id).update({'tons': getItCalculator.finalScore});

                      context.go('/CustomerDashboard');
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
                  child: Image(
                    image: AssetImage('images/ui/Calculator/nextBtn.png'),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 10,
            top: 20,
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
