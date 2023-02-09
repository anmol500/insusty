import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../widgets/CarousalWidget.dart';
import 'dart:html' as html;

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
              CarousalWidget(monthly: monthly, asset: 'images/ui/business2.png', screenSize: screenSize, monthlyCost: 699, yearlyCost: 8388, name: 'MID GREENS', points: 0, individual: false),
              CarousalWidget(monthly: monthly, asset: 'images/ui/business1.png', screenSize: screenSize, monthlyCost: 249, yearlyCost: 2988, name: 'ECO STARTER', points: 0, individual: false),
              CarousalWidget(monthly: monthly, asset: 'images/ui/business3.png', screenSize: screenSize, monthlyCost: 1499, yearlyCost: 17988, name: 'BIG CHANGEMAKERS', points: 0, individual: false),
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
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            html.window.open('http://149.28.148.8:8013/docs', '_self');
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
                    'Continue to FastAPI Docs',
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
