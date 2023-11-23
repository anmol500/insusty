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

  void fadeRow() {
    if (getItPages.urlPath != '/drawer') {
      getItPages.headerOpacity = 1.0;
    } else {
      getItPages.headerOpacity = 0.0;
    }
  }

  getPref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isReady = true;
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
    animationController = AnimationController(vsync: this, duration: 500.milliseconds);

    getItPages.addListener(() {
      fadeRow();
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (getItPages.urlPath != '/drawer') {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFFCF2),
              Color(0xffECF8DE),
              Color(0xffD9F9B0),
            ],
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
                      'images/logo.png',
                      height: screenSize.height / (screenSize.width > 400 ? 12 : 18),
                    ),
                  ),
                  screenSize.width > 750
                      ? AnimatedOpacity(
                          opacity: getItPages.headerOpacity,
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
                                name: 'Business',
                                onTap: () {
                                  getItPages.setUrlPath('/b2b');
                                  context.go('/b2b');
                                },
                                isActive: getItPages.urlPath == "/b2b",
                              ),
                              DrawerMenuDesktop(
                                name: 'About us',
                                onTap: () {
                                  getItPages.setUrlPath('/KnowMorePage');
                                  context.go('/KnowMorePage');
                                },
                                isActive: getItPages.urlPath == "/KnowMorePage",
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
                      if (getItPages.urlPath == '/drawer') {
                        getItPages.setUrlPath(getItPages.drawerOnUrl);
                        context.go(getItPages.drawerOnUrl);
                      } else {
                        getItPages.drawerOnUrl = Uri.base.toString().replaceAll(Uri.base.origin, '');
                        getItPages.setUrlPath('/drawer');
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
