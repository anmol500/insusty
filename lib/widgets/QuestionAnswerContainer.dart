import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CalcQuestion extends StatelessWidget {
  const CalcQuestion({
    Key? key,
    required this.animationController,
    required this.title,
  }) : super(key: key);

  final AnimationController animationController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(3, 0),
        end: Offset.zero,
      ).animate(animationController),
      child: Padding(
        padding: const EdgeInsets.only(right: 38.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x40000000),
                offset: Offset(0, 4),
                blurRadius: 4.0,
              )
            ],
            color: Colors.white,
          ),
          height: 50,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          )),
        ),
      ),
    );
  }
}

class CalcAnswer extends StatelessWidget {
  CalcAnswer({
    Key? key,
    required this.animationController2,
    required this.width,
    required this.title,
    this.tapped,
    this.selected,
    this.index,
    this.score,
    this.apart,
  }) : super(key: key);

  final AnimationController animationController2;
  final double width;
  final String title;
  final selected;
  final tapped;
  final index;
  final score;
  final apart;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(8, 0),
        end: Offset.zero,
      ).animate(animationController2),
      child: GestureDetector(
        onTap: () {
          tapped(index: index, apart: apart, score: score);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 38.0, top: 15),
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 4),
                  blurRadius: 4.0,
                ),
              ],
              color: selected ? Colors.red : Colors.white,
            ),
            duration: 500.milliseconds,
            curve: Curves.easeOut,
            height: 40,
            width: width,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
