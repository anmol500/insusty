import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';

class Header extends StatefulWidget {
  const Header({Key? key, this.child}) : super(key: key);
  final child;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  var color = [
    Color(0xffFFFCF2),
    Color(0xffECF8DE),
    Color(0xffD9F9B0),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getItPages.addListener(() {
    //   setState(() {});
    // });

    animationController = AnimationController(vsync: this, duration: 500.milliseconds);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage("images/ui/Calculator/CalcChooseCountry.png"),
                  fit: BoxFit.fill,
                )
              : getItPages.urlPath == '/Offset'
                  ? DecorationImage(
                      image: AssetImage("images/ui/offset.png"),
                      fit: BoxFit.fill,
                    )
                  : getItPages.urlPath == '/ContactUs'
                      ? DecorationImage(
                          image: AssetImage("images/ui/Contact Us.png"),
                          fit: BoxFit.fill,
                        )
                      : getItPages.urlPath == '/DiscoverPage'
                          ? DecorationImage(
                              image: AssetImage("images/ui/Discover.png"),
                              fit: BoxFit.fill,
                            )
                          : getItPages.urlPath == '/BlogPage'
                              ? DecorationImage(
                                  image: AssetImage("images/ui/Blogs.png"),
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
                      'images/logo.png',
                      height: screenSize.height / (screenSize.width > 400 ? 12 : 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print(getItPages.urlPath);

                      print(Uri.base.toString().replaceAll(Uri.base.origin, ''));
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
            SizedBox(
              height: screenSize.height / 40,
            ),
            Expanded(child: widget.child)
          ],
        ),
      ),
    );
  }
}
