import 'package:awesome_dialog/awesome_dialog.dart' as ad;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/widgets/HomePageWidgets/JoinHome.dart';
import 'package:insusty/widgets/HomePageWidgets/NewUserHome.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';
import '../widgets/Animations/FadeInCustomAnimation.dart';
import '../widgets/Animations/ScaleUpCustomAnimation.dart';
import '../widgets/HomePageWidgets/HomePageCarousel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: screenSize.height / 30,
                  ),
                  FadeInCustomAnimation(
                    child: getItPages.language == 'eng'
                        ? Image.asset(
                            screenSize.width > 700 ? 'images/ui/HomePage/HomepageHeroDesktopEng.png' : 'images/ui/HomePage/HomepageHeroMobileEng.png',
                          )
                        : Image.asset(
                            screenSize.width > 700 ? 'images/ui/HomePage/HomepageHeroDesktopFr.png' : 'images/ui/HomePage/HomepageHeroMobileFr.png',
                          ),
                  ),
                  20.height,
                  FirebaseAuth.instance.currentUser == null
                      ? FadeInCustomAnimation(
                          child: JoinHome(screenSize: screenSize),
                        )
                      : Container(),
                  screenSize.width > 750 ? 50.height : 0.height,
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Choose A Plan',
                      style: TextStyle(
                        color: Color(0xff00370F),
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.width > 500 ? 45 : 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'Choose how much of your carbon emissions you \nwould like to offset every month?',
                    style: TextStyle(
                      color: Color(0xff4B4B4B),
                      fontSize: screenSize.width > 500 ? 28 : 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  screenSize.width > 750 ? 50.height : 0.height,
                  HomePageOffsetCarousel(),
                  screenSize.width > 750 ? 50.height : 0.height,
                  NewUserHome(),
                  10.height,
                  FadeInCustomAnimation(
                    child: GestureDetector(
                      onTap: () {
                        getItPages.setUrlPath('/CalcChooseCountry');
                        context.go('/CalcChooseCountry');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(screenSize.width < 700 ? 10 : 58.0),
                        child: getItPages.language == 'eng'
                            ? Image.asset(
                                screenSize.width > 700 ? 'images/ui/HomePage/CalculateDesktopEng.png' : 'images/ui/HomePage/CalculateMobileEng.png',
                              )
                            : Image.asset(
                                screenSize.width > 700 ? 'images/ui/HomePage/CalculateDesktopFr.png' : 'images/ui/HomePage/CalculateMobileFr.png',
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 20,
                  ),
                  FadeInCustomAnimation(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        'images/ui/HomePage/last.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.go('/PrivacyPolicy');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xff00370F),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                cacheExtent: 3000,
              ),
            ),
          ],
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
