import 'package:awesome_dialog/awesome_dialog.dart' as ad;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/widgets/HomePageWidgets/JoinHome.dart';
import 'package:insusty/widgets/HomePageWidgets/NewUserHome.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';
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
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final List<String> images = [
      'images/ui/HomePage/homepage1Desktop.png',
      'images/ui/HomePage/homepage1.png',
      'images/ui/HomePage/Calculate.png',
      'images/ui/HomePage/CalculateDesktop.png',
      'images/ui/HomePage/last.png',
    ];

    // Pre-cache images
    for (String imageUrl in images) {
      precacheImage(AssetImage(imageUrl), context);
    }

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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width > 750 ? 40 : 5),
                    child: Image.asset(
                      screenSize.width > 750 ? images[0] : images[1],
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Choose A Plan',
                      style: TextStyle(
                        fontFamily: 'nt',
                        color: Color(0xff00370F),
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.width > 400 ? 45 : 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'Choose how much of your carbon emissions you \nwould like to offset every month?',
                    style: TextStyle(
                      fontFamily: 'nt',
                      color: Color(0xff4B4B4B),
                      fontSize: screenSize.width > 400 ? 28 : 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  screenSize.width > 750 ? 20.height : 0.height,
                  FirebaseAuth.instance.currentUser == null
                      ? JoinHome(
                          screenSize: screenSize,
                        )
                      : Container(),
                  screenSize.width > 750 ? 50.height : 0.height,
                  HomePageOffsetCarousel(),
                  screenSize.width > 750 ? 50.height : 0.height,
                  NewUserHome(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenSize.width < 750 ? 0 : 58.0),
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
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width > 750 ? 44 : 22.0,
                                  vertical: 12.0,
                                ),
                                child: Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontFamily: 'nt',
                                    color: Colors.white,
                                    fontSize: screenSize.width < 750 ? 14 : 24,
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
                  SizedBox(
                    height: screenSize.height / 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      images[4],
                      fit: BoxFit.contain,
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
                          fontFamily: 'nt',
                          color: Color(0xff00370F),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
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
