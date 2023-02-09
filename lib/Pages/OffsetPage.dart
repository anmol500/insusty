import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
    return ListView(
      children: [
        20.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Text(
            'Offset',
            style: TextStyle(
              fontFamily: 'nt',
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
              fontFamily: 'nt',
              color: Color(0xff4A7700),
              fontSize: 16,
            ),
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
                asset: 'images/ui/HomePage/carousel1.png',
                screenSize: screenSize,
                monthlyCost: 12.89,
                yearlyCost: 154.68,
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
                name: 'GREEN WORRIERS',
                points: 1200,
                individual: true,
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
            'Enter custom amount',
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
                        fontFamily: 'nt',
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
                  'Confirm',
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
        50.height,
      ],
    );
  }
}
