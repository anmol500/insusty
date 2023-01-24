import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/QuestionAnswerContainer.dart';

class CalculatorQuestion2 extends StatefulWidget {
  const CalculatorQuestion2({Key? key, this.tapped, this.selected}) : super(key: key);
  final tapped;
  final selected;

  @override
  State<CalculatorQuestion2> createState() => _CalculatorQuestion2State();
}

class _CalculatorQuestion2State extends State<CalculatorQuestion2> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController1;
  late AnimationController animationController2;
  late AnimationController animationController3;
  late AnimationController animationController4;
  late AnimationController animationController5;
  late AnimationController animationController6;

  var contwidth1 = 7.0;
  var contwidth2 = 7.0;
  var contwidth3 = 7.0;
  var contwidth4 = 7.0;
  var contwidth5 = 7.0;
  var contwidth6 = 7.0;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: 400.milliseconds,
    );
    animationController1 = AnimationController(
      vsync: this,
      duration: 200.milliseconds,
    );
    animationController2 = AnimationController(
      vsync: this,
      duration: 200.milliseconds,
    );
    animationController3 = AnimationController(
      vsync: this,
      duration: 200.milliseconds,
    );
    animationController4 = AnimationController(
      vsync: this,
      duration: 200.milliseconds,
    );
    animationController5 = AnimationController(
      vsync: this,
      duration: 200.milliseconds,
    );
    animationController6 = AnimationController(
      vsync: this,
      duration: 200.milliseconds,
    );

    animationController.forward().whenComplete(() {
      Timer(
          200.milliseconds,
          () => animationController1.forward().whenComplete(() {
                contwidth1 = 800;
                setState(() {});
                Timer(
                    200.milliseconds,
                    () => animationController2.forward().whenComplete(() {
                          contwidth2 = 800;
                          setState(() {});
                          Timer(
                              200.milliseconds,
                              () => animationController3.forward().whenComplete(() {
                                    contwidth3 = 800;
                                    setState(() {});
                                    Timer(
                                        200.milliseconds,
                                        () => animationController4.forward().whenComplete(() {
                                              contwidth4 = 800;
                                              setState(() {});
                                              Timer(
                                                  200.milliseconds,
                                                  () => animationController5.forward().whenComplete(() {
                                                        contwidth5 = 800;
                                                        setState(() {});
                                                        Timer(
                                                            200.milliseconds,
                                                            () => animationController6.forward().whenComplete(() {
                                                                  contwidth6 = 800;
                                                                  setState(() {});
                                                                }));
                                                      }));
                                            }));
                                  }));
                        }));
              }));
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController1.dispose();
    animationController2.dispose();
    animationController3.dispose();
    animationController4.dispose();
    animationController5.dispose();
    animationController6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalcQuestion(title: 'Describe your diet', animationController: animationController),
          20.height,
          CalcAnswer(
            title: 'Vegan🥑🍑🥦',
            animationController2: animationController1,
            width: contwidth1,
            tapped: widget.tapped,
            selected: widget.selected[0],
            index: 0,
            score: 0.8,
          ),
          CalcAnswer(
            title: 'Vegetarian 🍑🥦🧀',
            animationController2: animationController2,
            width: contwidth2,
            tapped: widget.tapped,
            selected: widget.selected[1],
            index: 1,
            score: 0.9,
          ),
          CalcAnswer(
            title: 'Eggetarian🥚🥚',
            animationController2: animationController3,
            width: contwidth3,
            tapped: widget.tapped,
            selected: widget.selected[2],
            index: 2,
            score: 1,
          ),
          CalcAnswer(
            title: 'Pescatarian 🐟🐟',
            animationController2: animationController4,
            width: contwidth4,
            tapped: widget.tapped,
            selected: widget.selected[3],
            index: 3,
            score: 1.2,
          ),
          CalcAnswer(
            title: 'Less meat in the diet 🥩🥩',
            animationController2: animationController5,
            width: contwidth5,
            tapped: widget.tapped,
            selected: widget.selected[4],
            index: 4,
            score: 1.5,
          ),
          CalcAnswer(
            title: 'Meaty diet 🥩🥩🥩',
            animationController2: animationController6,
            width: contwidth6,
            tapped: widget.tapped,
            selected: widget.selected[5],
            index: 5,
            score: 2,
          ),
        ],
      ),
    );
  }
}
