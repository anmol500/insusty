import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../widgets/Animations/ScaleUpCustomAnimation.dart';
import '../widgets/Animations/SlideCustomAnimation.dart';
import '../widgets/CarousalWidget.dart';

class OffsetPage extends StatefulWidget {
  OffsetPage({Key? key}) : super(key: key);

  @override
  State<OffsetPage> createState() => _OffsetPageState();
}

class _OffsetPageState extends State<OffsetPage> {
  var value = 0.0;
  var monthly = true;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(screenSize.width > 700 ? "images/ui/offsetDesktop.png" : "images/ui/offset.png"),
        fit: BoxFit.fill,
      )),
      child: ListView(
        children: [
          20.height,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                child: Text(
                  'Offset',
                  style: TextStyle(
                    color: Color(0xff00370F),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Remove CO2 and contribute for the planet 🐰',
                  style: TextStyle(
                    color: Color(0xff4A7700),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          screenSize.width > 700 ? 20.height : 10.height,

          screenSize.width > 700
              ? Center(
                  child: SizedBox(
                    height: screenSize.height / 1.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SlideInFromLeftOnVisible(
                          child: CarousalWidget(
                            monthly: monthly,
                            asset: 'images/ui/HomePage/carousel1.png',
                            screenSize: screenSize,
                            monthlyCost: 12.89,
                            yearlyCost: 154.68,
                            monthlyCostAPI: 'price_1Mb7pdLiMJsqTuQlUI6VloFK',
                            yearlyCostAPI: 'price_1Mb7pdLiMJsqTuQlTTUAnc1a',
                            name: 'V-IMPACT',
                            points: 800,
                            individual: true,
                          ),
                        ),
                        ScaleUpCustomAnimation(
                          child: CarousalWidget(
                            monthly: monthly,
                            asset: 'images/ui/HomePage/carousel0.png',
                            screenSize: screenSize,
                            monthlyCost: 5.60,
                            yearlyCost: 67.20,
                            monthlyCostAPI: 'price_1MZZdZLiMJsqTuQlVCW5FymC',
                            yearlyCostAPI: 'price_1Mb7sYLiMJsqTuQlal1WkfTL',
                            name: 'ECO STARTER',
                            points: 300,
                            individual: true,
                          ),
                        ),
                        SlideInFromRightOnVisible(
                          child: CarousalWidget(
                            monthly: monthly,
                            asset: 'images/ui/HomePage/carousel2.png',
                            screenSize: screenSize,
                            monthlyCost: 19.99,
                            yearlyCost: 239.80,
                            monthlyCostAPI: 'price_1Mb7tULiMJsqTuQlQjvqC3Go',
                            yearlyCostAPI: 'price_1Mb7tULiMJsqTuQlMt0JFV7j',
                            name: 'GREEN WORRIERS',
                            points: 1200,
                            individual: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1.0,
                    viewportFraction: 0.5,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    CarousalWidget(
                      monthly: monthly,
                      asset: 'images/ui/HomePage/carousel1.png',
                      screenSize: screenSize,
                      monthlyCost: 12.89,
                      yearlyCost: 154.68,
                      monthlyCostAPI: 'price_1Mb7pdLiMJsqTuQlUI6VloFK',
                      yearlyCostAPI: 'price_1Mb7pdLiMJsqTuQlTTUAnc1a',
                      name: 'V-IMPACT',
                      points: 800,
                      individual: true,
                    ),
                    CarousalWidget(
                      monthly: monthly,
                      asset: 'images/ui/HomePage/carousel0.png',
                      screenSize: screenSize,
                      monthlyCost: 5.60,
                      yearlyCost: 67.20,
                      monthlyCostAPI: 'price_1MZZdZLiMJsqTuQlVCW5FymC',
                      yearlyCostAPI: 'price_1Mb7sYLiMJsqTuQlal1WkfTL',
                      name: 'ECO STARTER',
                      points: 300,
                      individual: true,
                    ),
                    CarousalWidget(
                      monthly: monthly,
                      asset: 'images/ui/HomePage/carousel2.png',
                      screenSize: screenSize,
                      monthlyCost: 19.99,
                      yearlyCost: 239.80,
                      monthlyCostAPI: 'price_1Mb7tULiMJsqTuQlQjvqC3Go',
                      yearlyCostAPI: 'price_1Mb7tULiMJsqTuQlMt0JFV7j',
                      name: 'GREEN WORRIERS',
                      points: 1200,
                      individual: true,
                    ),
                  ],
                ),

/////////////
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.height > 700 ? 140.0 : 0),
            child: Row(children: <Widget>[
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
                'Or',
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Text(
              '✍️',
              style: TextStyle(
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
              'Enter custom amount',
              style: TextStyle(
                color: Color(0xff00370F),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.height > 700 ? 340.0 : 18, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffc1c1c1),
                    blurRadius: 19.0,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Select mt tonnes of carbon you want to offset',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (value > 0) {
                                value = value - 0.5;
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ),
                          ),
                          AnimatedFlipCounter(
                            fractionDigits: 1,
                            duration: Duration(milliseconds: 500),
                            value: value,
                            textStyle: TextStyle(
                              color: Color(0xff3B6BE7),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              value = value + 0.5;
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.height > 700 ? 570.0 : 70, vertical: 18),
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
                    'Confirm',
                    style: TextStyle(
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
          50.height,
        ],
      ),
    );
  }
}
