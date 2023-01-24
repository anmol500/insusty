import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LinearLine extends StatelessWidget {
  const LinearLine({
    Key? key,
    required this.screenSize,
    this.percentage,
    this.title,
    required this.color,
    required this.tons,
  }) : super(key: key);

  final Size screenSize;
  final percentage;
  final title;
  final double tons;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 10,
            width: screenSize.width * (tons / 4.2) / 2.3,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'nt',
                  color: Color(0xffffffff),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                tons.toStringAsFixed(1) + ' Tons',
                style: TextStyle(
                  fontFamily: 'nt',
                  color: Color(0xffffffff),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        10.height,
      ],
    );
  }
}
