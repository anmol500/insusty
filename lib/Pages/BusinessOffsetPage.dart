import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';
import '../widgets/CarousalWidget.dart';

class BusinessOffsetPage extends StatefulWidget {
  BusinessOffsetPage({Key? key}) : super(key: key);

  @override
  State<BusinessOffsetPage> createState() => _BusinessOffsetPageState();
}

class _BusinessOffsetPageState extends State<BusinessOffsetPage> {
  var value = 0.0;
  var monthly = true;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        getItPages.language == 'eng'
            ? Image.asset(
                screenSize.width > 700 ? 'images/ui/BusinessApiDesktopEng.png' : 'images/ui/BusinessApiMobileEng.png',
              )
            : Image.asset(
                screenSize.width > 700 ? 'images/ui/BusinessApiDesktopFr.png' : 'images/ui/BusinessApiMobileFr.png',
              ),
        Container(
          height: screenSize.width > 700 ? 550 : 350,
          padding: EdgeInsets.symmetric(vertical: screenSize.width > 700 ? 50 : 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                screenSize.width > 700 ? Color(0xffF3FDD8) : Color(0xffF7FBD0),
                Color(0xffD9F9B0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.0,
              viewportFraction: screenSize.width > 700 ? 0.23 : 0.67,
            ),
            items: [
              CarousalWidget(
                monthly: monthly,
                asset: 'images/ui/business1.png',
                screenSize: screenSize,
                monthlyCost: 249,
                yearlyCost: 2988,
                monthlyCostAPI: 'price_1Mb7vwLiMJsqTuQlILDmWi6X',
                yearlyCostAPI: 'price_1Mb7vwLiMJsqTuQlIL5l2US6',
                name: 'ECO STARTER',
                points: 0,
                individual: false,
              ),
              CarousalWidget(
                monthly: monthly,
                asset: 'images/ui/business2.png',
                screenSize: screenSize,
                monthlyCost: 699,
                yearlyCost: 8388,
                monthlyCostAPI: 'price_1Mb7tULiMJsqTuQlQjvqC3Go',
                yearlyCostAPI: 'price_1Mb7tULiMJsqTuQlMt0JFV7j',
                name: 'MID GREENS',
                points: 0,
                individual: false,
              ),
              CarousalWidget(
                monthly: monthly,
                asset: 'images/ui/business3.png',
                screenSize: screenSize,
                monthlyCost: 1499,
                yearlyCost: 17988,
                monthlyCostAPI: 'price_1Mb7wWLiMJsqTuQl9yUWDV4M',
                yearlyCostAPI: 'price_1Mb7wWLiMJsqTuQltRuWrx2O',
                name: 'BIG CHANGEMAKERS',
                points: 0,
                individual: false,
              ),
              CarousalWidget(
                monthly: monthly,
                asset: 'images/ui/business4.png',
                screenSize: screenSize,
                monthlyCost: 1499,
                yearlyCost: 17988,
                monthlyCostAPI: 'price_1Mb7wWLiMJsqTuQl9yUWDV4M',
                yearlyCostAPI: 'price_1Mb7wWLiMJsqTuQltRuWrx2O',
                name: 'ECO GIANTS',
                points: 0,
                individual: false,
              ),
            ],
          ),
        ),
        50.height,
      ],
    );
  }
}
