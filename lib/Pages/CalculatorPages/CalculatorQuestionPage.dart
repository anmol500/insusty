import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      print('asad');
      var currentScore = getItCalculator.finalScore;
      getItCalculator.setScore(currentScore + score);
    } else {
      getItCalculator.apart = apart;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Container(
            color: Colors.red,
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
                    color: Color(0xff3B6BE7),
                    fontWeight: FontWeight.bold,
                    fontSize: 75,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
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
                pageController.nextPage(duration: 300.milliseconds, curve: Curves.linear);
              } else {
                Future<QuerySnapshot<Map<String, dynamic>>> user = FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: 'anmol@gmail.com').get();
                user.then((value) {
                  FirebaseFirestore.instance.collection('00users').doc(value.docs[0].reference.id).update({'tons': getItCalculator.finalScore});

                  context.go('/');
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
    );
  }
}
