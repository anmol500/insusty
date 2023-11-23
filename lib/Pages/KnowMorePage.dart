import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';

class KnowMorePage extends StatefulWidget {
  const KnowMorePage({Key? key}) : super(key: key);

  @override
  State<KnowMorePage> createState() => _KnowMorePageState();
}

class _KnowMorePageState extends State<KnowMorePage> {
  double opacityLevel = 1.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffF7FFE0),
                  Color(0xffFEF8DB),
                  Color(0xffE4F4C9),
                  Color(0xffB4E8B9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                getItPages.language == 'eng'
                    ? Image.asset(
                        screenSize.width > 700 ? 'images/ui/AboutUsDesktop.png' : 'images/ui/AboutUsMobileEng.png',
                      )
                    : Image.asset(
                        screenSize.width > 700 ? 'images/ui/AboutUsDesktopFr.png' : 'images/ui/AboutUsMobileFr.png',
                      ),
                GestureDetector(
                  onTap: () {
                    getItPages.setUrlPath('/ContactUs');
                    context.go('/ContactUs');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width > 700 ? 100 : 0),
                    child: getItPages.language == 'eng'
                        ? Image.asset(
                            screenSize.width > 700 ? 'images/ui/AboutUsDesktopBottomEng.png' : 'images/ui/AboutUsMobileBottomEng.png',
                          )
                        : Image.asset(
                            screenSize.width > 700 ? 'images/ui/AboutUsDesktopBottomFr.png' : 'images/ui/AboutUsMobileBottomFr.png',
                          ),
                  ),
                ),
                screenSize.width > 700 ? 40.height : 0.height,
              ],
            ),
          ),
        ),
        IgnorePointer(
          ignoring: opacityLevel == 0.0,
          child: AnimatedContainer(
            color: Color(0xffFFFCF2).withOpacity(opacityLevel),
            duration: 300.milliseconds,
            height: screenSize.height,
            width: screenSize.width,
          ),
        ),
      ],
    );
  }
}
