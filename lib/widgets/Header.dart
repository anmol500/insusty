import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/Locator.dart';
import 'DrawerMenuDesktop.dart';

class Header extends StatefulWidget {
  const Header({Key? key, this.child}) : super(key: key);
  final child;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isReady = false;
  var prefs;

  double opacityLevel = 1.0; // Fully visible

  void fadeRow() {
    if (opacityLevel == 0) {
      opacityLevel = 1.0;
      getItPages.headerOpacity = 1.0;
    } else {
      opacityLevel = 0.0; // Fully transparent
      getItPages.headerOpacity = 0.0;
    }
  }

  getPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isReady = true;
    });
  }

  var color = [
    Color(0xffFFFCF2),
    Color(0xffECF8DE),
    Color(0xffD9F9B0),
  ];

  @override
  void initState() {
    getPref();
    super.initState();
    animationController = AnimationController(vsync: this, duration: 500.milliseconds);

    getItPages.addListener(() {
      setState(() {
        fadeRow();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "images/ui/Calculator/CalcChooseCountry.png",
      "images/ui/offset.png",
      "images/ui/Contact Us.png",
      "images/ui/Discover.png",
      "images/ui/Blogs.png",
      'images/logo.png',
      "images/ui/Calculator/CalcChooseCountryDesktop.png",
    ];

    // Pre-cache images
    for (String imageUrl in images) {
      precacheImage(AssetImage(imageUrl), context);
    }

    if (getItPages.urlPath != '/drawer') {
      color = [
        Color(0xffFFFCF2),
        Color(0xffECF8DE),
        Color(0xffD9F9B0),
      ];
      animationController.reverse();
    } else {
      color = [
        Color(0xffDEEED0),
        Color(0xffFDED92),
      ];
      animationController.forward();
    }
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: getItPages.urlPath == '/CalcChooseCountry'
              ? DecorationImage(
                  image: AssetImage(screenSize.width < 750 ? images[0] : images[6]),
                  fit: BoxFit.fill,
                )
              : getItPages.urlPath == '/Offset'
                  ? DecorationImage(
                      image: AssetImage(images[1]),
                      fit: BoxFit.fill,
                    )
                  : getItPages.urlPath == '/ContactUs'
                      ? DecorationImage(
                          image: AssetImage(images[2]),
                          fit: BoxFit.fill,
                        )
                      : getItPages.urlPath == '/BrandPage'
                          ? DecorationImage(
                              image: AssetImage(images[3]),
                              fit: BoxFit.fill,
                            )
                          : getItPages.urlPath == '/BlogPage'
                              ? DecorationImage(
                                  image: AssetImage(images[4]),
                                  fit: BoxFit.fill,
                                )
                              : null,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: color,
          ),
        ),
        child: Column(
          children: [
            20.height,
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      getItPages.setUrlPath('/');

                      context.go('/');
                    },
                    child: Image.asset(
                      images[5],
                      height: screenSize.height / (screenSize.width > 400 ? 12 : 18),
                    ),
                  ),
                  screenSize.width > 750
                      ? AnimatedOpacity(
                          opacity: opacityLevel,
                          duration: Duration(milliseconds: 400),
                          child: Row(
                            children: [
                              DrawerMenuDesktop(
                                name: 'Home',
                                onTap: () {
                                  getItPages.setUrlPath('/');
                                  context.go('/');
                                },
                                isActive: getItPages.urlPath == "/",
                              ),
                              DrawerMenuDesktop(
                                name: 'Subscription',
                                onTap: () {
                                  getItPages.setUrlPath('/Offset');
                                  context.go('/Offset');
                                },
                                isActive: getItPages.urlPath == "/Offset",
                              ),
                              DrawerMenuDesktop(
                                name: 'Brand',
                                onTap: () {
                                  getItPages.setUrlPath('/BrandPage');
                                  context.go('/BrandPage');
                                },
                                isActive: getItPages.urlPath == "/BrandPage",
                              ),
                              DrawerMenuDesktop(
                                name: 'Blogs',
                                onTap: () {
                                  getItPages.setUrlPath('/BlogPage');
                                  context.go('/BlogPage');
                                },
                                isActive: getItPages.urlPath == "/BlogPage",
                              ),
                              DrawerMenuDesktop(
                                name: 'Contact Us',
                                onTap: () {
                                  getItPages.setUrlPath('/ContactUs');
                                  context.go('/ContactUs');
                                },
                                isActive: getItPages.urlPath == "/ContactUs",
                              ),
                              isReady
                                  ? DrawerMenuDesktop(
                                      name: FirebaseAuth.instance.currentUser != null || (prefs.getString('userEmail') == 'admin') ? 'Dashboard' : 'Login',
                                      onTap: () async {
                                        if (FirebaseAuth.instance.currentUser == null && (prefs.getString('userEmail') != 'admin')) {
                                          getItPages.setUrlPath('/login');
                                          context.go('/login');
                                        } else {
                                          var individual;

                                          individual = prefs.getBool('individual');
                                          if (prefs.getString('userEmail') == 'admin') {
                                            context.go('/AdminDashboard');
                                          } else {
                                            individual ? context.go('/CustomerDashboard') : context.go('/BusinessDashboard');
                                          }
                                        }
                                      },
                                      isActive: getItPages.urlPath == "/login" || getItPages.urlPath == "/AdminDashboard" || getItPages.urlPath == "/CustomerDashboard" || getItPages.urlPath == "/BusinessDashboard",
                                    )
                                  : Container(),
                              SizedBox(
                                height: screenSize.height / 20,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  GestureDetector(
                    onTap: () {
                      fadeRow();

                      if (getItPages.urlPath == '/drawer') {
                        getItPages.urlPath = getItPages.drawerOnUrl;
                        context.go(getItPages.drawerOnUrl);
                      } else {
                        getItPages.drawerOnUrl = Uri.base.toString().replaceAll(Uri.base.origin, '');
                        getItPages.urlPath = '/drawer';
                        context.go('/drawer');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, right: 10),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: animationController,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: widget.child)
          ],
        ),
      ),
    );
  }
}
