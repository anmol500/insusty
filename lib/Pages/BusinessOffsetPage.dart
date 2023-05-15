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
        20.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Text(
            'Choose a Plan',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff00370F),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Choose how much of your carbon emissions you would like to offset every month?',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff4A7700),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 350,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.0,
              viewportFraction: 0.5,
              enlargeCenterPage: true,
            ),
            items: [
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
            ],
          ),
        ),
        Row(children: <Widget>[
          Expanded(
            child: new Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Color(0xff4B4B4B),
                  height: 36,
                  thickness: 0.3,
                )),
          ),
          Text(
            'API Docs',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 3, fontSize: 13, fontFamily: 'nt'),
          ),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Color(0xff4B4B4B),
                  height: 36,
                  thickness: 0.3,
                )),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Text(
            '✍️',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff00370F),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Developer API Docs',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff00370F),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xffc1c1c1),
                  blurRadius: 10.0,
                  offset: Offset(1, 1),
                  spreadRadius: 1,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Learn how to use Insusty API System',
                    style: TextStyle(
                      fontFamily: 'nt',
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            getItPages.setUrlPath('/APIDocs');
            context.go('/APIDocs');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 70),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffc1c1c1),
                    blurRadius: 19.0,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                  ),
                ],
                color: Color(0xff208207),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Continue to Docs',
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
        ),
        50.height,
      ],
    );
  }
}
