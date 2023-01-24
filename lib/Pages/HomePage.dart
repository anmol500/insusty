import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/widgets/HomePageWidgets/JoinHome.dart';
import 'package:insusty/widgets/HomePageWidgets/NewUserHome.dart';

import '../Util/Locator.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Image.asset('images/ui/HomePage/homepage1.png'),
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
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'Choose how much of your carbon emissions you \nwould like to offset every month?',
                style: TextStyle(
                  fontFamily: 'nt',
                  color: Color(0xff4B4B4B),
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
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
                    Image.asset(
                      'images/ui/HomePage/carousel0.png',
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'images/ui/HomePage/carousel1.png',
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'images/ui/HomePage/carousel2.png',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              JoinHome(
                screenSize: screenSize,
              ),
              SizedBox(
                height: screenSize.height / 20,
              ),
              NewUserHome(),
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
                          getItPages.setUrlPath('/CalcChooseCountry');

                          context.go('/CalcChooseCountry');
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
                height: 150,
              )
            ],
          ),
        ),
      ],
    );
  }
}
