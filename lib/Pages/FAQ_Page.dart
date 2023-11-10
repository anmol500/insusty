import 'package:flutter/material.dart';
import 'package:flutter_next/views/next_accordion.dart';
import 'package:insusty/Util/FAQ_DATA.dart';
import 'package:insusty/Util/Locator.dart';
import 'package:nb_utils/nb_utils.dart';

class FAQ_Page extends StatelessWidget {
  const FAQ_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(answersFr.length);
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        children: [
          getItPages.language == 'eng'
              ? Image.asset(
                  screenSize.width > 700 ? 'images/ui/FAQDesktop.png' : 'images/ui/FAQ.png',
                )
              : Image.asset(
                  screenSize.width > 700 ? 'images/ui/FAQDesktopFr.png' : 'images/ui/FAQFr.png',
                ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Get Started',
              style: TextStyle(
                color: Color(0xff0F6D2F),
                fontSize: screenSize.height > 700 ? 28 : 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    ...List.generate(
                        getItPages.language == 'eng' ? questionEng.length : questionsFr.length,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width > 700 ? 50 : 8.0,
                                vertical: screenSize.width > 700 ? 8 : 0,
                              ),
                              child: CustomAcorrdion(
                                question: getItPages.language == 'eng' ? questionEng[index] : questionsFr[index],
                                answer: getItPages.language == 'eng' ? answersEng[index] : answersFr[index],
                              ),
                            )),
                  ],
                ),
              ),
              screenSize.width > 700
                  ? Image.asset(
                      'images/ui/FAQ_SideImage.png',
                      scale: 3,
                    )
                  : Container()
            ],
          ),
          70.height,
        ],
      ),
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
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width > 700 ? 100 : 18.0, vertical: screenSize.width > 700 ? 4 : 8),
      child: NextAccordion(
        borderColor: Colors.transparent,
        initiallyExpanded: open,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            question,
            style: TextStyle(
              color: Color(0xff222F19),
              fontSize: screenSize.width > 700 ? 19 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              answer,
              style: TextStyle(
                color: Color(0xff495F3B),
                fontSize: screenSize.width > 700 ? 18 : 16,
              ),
            ),
          )
        ],
      ).cornerRadiusWithClipRRect(12),
    );
  }
}
