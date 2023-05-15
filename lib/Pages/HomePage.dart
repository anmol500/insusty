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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  var homepageImagePaddingDesktopH = 108.0;
  var homepageImagePaddingDesktopV = 30.0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width > 400 ? homepageImagePaddingDesktopH : 0),
                child: Image.asset(
                  'images/ui/HomePage/homepage1.png',
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width > 400 ? homepageImagePaddingDesktopH : 10,
                  vertical: screenSize.width > 400 ? homepageImagePaddingDesktopV : 10,
                ),
                child: InkWell(
                  onTap: () {
                    getItPages.setUrlPath('/Offset');
                    context.go('/Offset');
                  },
                  child: Image.asset(
                    'images/ui/HomePage/homepage2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width > 400 ? homepageImagePaddingDesktopH : 10,
                  vertical: screenSize.width > 400 ? homepageImagePaddingDesktopV : 10,
                ),
                child: InkWell(
                  onTap: () {
                    getItPages.setUrlPath('/Offset');
                    context.go('/Offset');
                  },
                  child: Image.asset(
                    'images/ui/HomePage/homepage3.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width > 400 ? homepageImagePaddingDesktopH : 10,
                  vertical: screenSize.width > 400 ? homepageImagePaddingDesktopV : 10,
                ),
                child: InkWell(
                  onTap: () {
                    getItPages.setUrlPath('/Offset');
                    context.go('/Offset');
                  },
                  child: Image.asset(
                    'images/ui/HomePage/homepage4.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height / 18,
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
                  fontSize: screenSize.width > 400 ? 30 : 15,
                ),
                textAlign: TextAlign.center,
              ),
              screenSize.width > 400 ? 20.height : 0.height,
              HomePageOffsetCarousel(),
              screenSize.width > 400 ? 20.height : 0.height,
              FirebaseAuth.instance.currentUser == null
                  ? screenSize.width < 400
                      ? JoinHome(
                          screenSize: screenSize,
                        )
                      : Container()
                  : Container(),
              screenSize.width < 400
                  ? SizedBox(
                      height: screenSize.height / 20,
                    )
                  : Container(),
              screenSize.width < 400 ? NewUserHome() : Container(),
              SizedBox(
                height: screenSize.height / 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset('images/ui/HomePage/Calculate.png'),
                  Positioned.fill(
                    bottom: -10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          if (FirebaseAuth.instance.currentUser == null) {
                            ad.AwesomeDialog(
                              context: context,
                              dialogType: ad.DialogType.question,
                              animType: ad.AnimType.rightSlide,
                              title: 'Logged in?',
                              desc: 'Please login with an individual',
                              btnCancelOnPress: () {},
                              btnOkText: 'Login',
                              btnOkOnPress: () {
                                context.go('/login');
                              },
                            )..show();
                          } else {
                            getItPages.setUrlPath('/CalcChooseCountry');

                            context.go('/CalcChooseCountry');
                          }
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
                            padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 12),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontFamily: 'nt',
                                color: Colors.white,
                                fontSize: 18,
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
                height: 40,
              ),
              GestureDetector(
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
    );
  }
}
