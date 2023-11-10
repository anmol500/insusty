import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';

class KnowMorePage extends StatelessWidget {
  const KnowMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  getItPages.language == 'eng'
                      ? Image.asset(
                          screenSize.width > 700 ? 'images/ui/AboutUsDesktop.png' : 'images/ui/AboutUs.png',
                        )
                      : Image.asset(
                          screenSize.width > 700 ? 'images/ui/AboutUsDesktopFr.png' : 'images/ui/AboutUsFr.png',
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
                              screenSize.width > 700 ? 'images/ui/AboutUsBottom.png' : 'images/ui/AboutUsMobileBottom.png',
                            )
                          : Image.asset(
                              screenSize.width > 700 ? 'images/ui/AboutUsBottomFr.png' : 'images/ui/AboutUsMobileBottomFr.png',
                            ),
                    ),
                  ),
                  40.height,
                ],
              ),
              Positioned(
                bottom: 10,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    getItPages.setUrlPath('/ContactUs');
                    context.go('/ContactUs');
                  },
                  child: Container(
                    height: 500,
                    width: 500,
                    color: Colors.transparent,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
