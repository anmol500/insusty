import 'package:flutter/material.dart';
import 'package:flutter_next/views/next_accordion.dart';
import 'package:insusty/Util/FAQ_DATA.dart';
import 'package:nb_utils/nb_utils.dart';

class FAQ_Page extends StatelessWidget {
  const FAQ_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        Image.asset('images/ui/FAQ.png'),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'Get Started',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff0F6D2F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        ...List.generate(
            question.length,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width > 400 ? 50 : 8.0,
                    vertical: screenSize.width > 400 ? 8 : 0,
                  ),
                  child: CustomAcorrdion(
                    question: question[index],
                    answer: answer[index],
                  ),
                )),
        70.height,
      ],
    );
  }
}

class CustomAcorrdion extends StatelessWidget {
  CustomAcorrdion({Key? key, this.question, this.answer, this.open = false}) : super(key: key);

  final question;
  final answer;
  var open;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
      child: NextAccordion(
        borderColor: Colors.transparent,
        initiallyExpanded: open,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            question,
            style: TextStyle(fontFamily: 'nt', color: Color(0xff222F19), fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              answer,
              style: TextStyle(
                fontFamily: 'nt',
                color: Color(0xff495F3B),
                fontSize: 16,
              ),
            ),
          )
        ],
      ).cornerRadiusWithClipRRect(12),
    );
  }
}
