import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Util/Locator.dart';

class HomePageOffsetCarousel extends StatelessWidget {
  const HomePageOffsetCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.width > 750 ? 550 : 350,
      child: screenSize.width > 700
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'images/ui/HomePage/carousel0.png',
                      fit: BoxFit.contain,
                      scale: 2.6,
                    ),
                    onTap: () {
                      getItPages.setUrlPath('/Offset');
                      context.go('/Offset');
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      getItPages.setUrlPath('/Offset');
                      context.go('/Offset');
                    },
                    child: Image.asset(
                      'images/ui/HomePage/carousel1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getItPages.setUrlPath('/Offset');
                      context.go('/Offset');
                    },
                    child: Image.asset(
                      'images/ui/HomePage/carousel2.png',
                      fit: BoxFit.contain,
                      scale: 2.6,
                    ),
                  ),
                ],
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
                GestureDetector(
                  child: Image.asset(
                    'images/ui/HomePage/carousel0.png',
                    fit: BoxFit.contain,
                  ),
                  onTap: () {
                    getItPages.setUrlPath('/Offset');
                    context.go('/Offset');
                  },
                ),
                GestureDetector(
                  onTap: () {
                    getItPages.setUrlPath('/Offset');
                    context.go('/Offset');
                  },
                  child: Image.asset(
                    'images/ui/HomePage/carousel1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    getItPages.setUrlPath('/Offset');
                    context.go('/Offset');
                  },
                  child: Image.asset(
                    'images/ui/HomePage/carousel2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
    );
  }
}
