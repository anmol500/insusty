import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/QuestionAnswerContainer.dart';

class CalculatorQuestion5 extends StatefulWidget {
  const CalculatorQuestion5({Key? key, this.tapped, this.selected}) : super(key: key);
  final tapped;
  final selected;
  @override
  State<CalculatorQuestion5> createState() => _CalculatorQuestion5State();
}

class _CalculatorQuestion5State extends State<CalculatorQuestion5> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController1;
  late AnimationController animationController2;
  late AnimationController animationController3;

  var contwidth1 = 7.0;
  var contwidth2 = 7.0;
  var contwidth3 = 7.0;
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
          CalcQuestion(title: 'Do you have renewable electricity at home?', animationController: animationController),
          20.height,
          CalcAnswer(
            title: 'Yes 👍🏻',
            animationController2: animationController1,
            width: contwidth1,
            tapped: widget.tapped,
            selected: widget.selected[0],
            index: 0,
            score: 0,
          ),
          CalcAnswer(
            title: 'No 👎🏻',
            animationController2: animationController2,
            width: contwidth2,
            tapped: widget.tapped,
            selected: widget.selected[1],
            index: 1,
            score: 2.1,
          ),
          CalcAnswer(
            title: 'I don\'t know 🤔',
            animationController2: animationController3,
            width: contwidth3,
            tapped: widget.tapped,
            selected: widget.selected[2],
            index: 2,
            score: 1.1,
          ),
        ],
      ),
    );
  }
}
