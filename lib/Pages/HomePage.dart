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
  final List<String> images = [
    'images/ui/HomePage/homepage1Desktop.png',
    'images/ui/HomePage/homepage1.png',
    'images/ui/HomePage/Calculate.png',
    'images/ui/HomePage/CalculateDesktop.png',
    'images/ui/HomePage/last.png',
  ];
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width > 750 ? 40 : 5),
                      child: Image.asset(
                        screenSize.width > 750 ? images[0] : images[1],
                        fit: BoxFit.contain,
                      ),
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
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenSize.width < 750 ? 10 : 58.0),
                          child: Image.asset(screenSize.width < 750 ? images[2] : images[3]),
                        ),
                        Positioned.fill(
                          bottom: 0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                getItPages.setUrlPath('/CalcChooseCountry');
                                context.go('/CalcChooseCountry');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff2D9F54),
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width > 750 ? 44 : 18.0,
                                    vertical: 12.0,
                                  ),
                                  child: Text(
                                    'Get Started',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenSize.width < 750 ? 12 : 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 20,
                  ),
                  FadeInCustomAnimation(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        images[4],
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
