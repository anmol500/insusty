import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NewUserHome extends StatelessWidget {
  const NewUserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: screenSize.width > 750 ? 3.5 : 1.15,
          enlargeFactor: 0.1,
          viewportFraction: screenSize.width > 750 ? 0.2 : 0.50,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: [
          NewUserCard(name: 'San', time: 2, donation: 5.34, img: 6, tons: 3),
          NewUserCard(name: 'Lomna', time: 4, donation: 3.44, img: 2, tons: 2),
          NewUserCard(name: 'Nancy', time: 5, donation: 15.34, img: 4, tons: 6),
          NewUserCard(name: 'Grace', time: 5, donation: 15.34, img: 2, tons: 6),
          NewUserCard(name: 'Mathew', time: 5, donation: 15.34, img: 3, tons: 6),
          NewUserCard(name: 'Kavin', time: 5, donation: 15.34, img: 5, tons: 6),
        ],
      ),
    );
  }
}

class NewUserCard extends StatelessWidget {
  const NewUserCard({Key? key, this.name, this.time, this.donation, this.img, this.tons}) : super(key: key);
  final name;
  final time;
  final donation;
  final img;
  final tons;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 10,
                  child: Image.asset(
                    'images/ui/HomePage/newUsers$img.jpg',
                    fit: BoxFit.fill,
                  ).cornerRadiusWithClipRRectOnly(topLeft: 12, topRight: 12),
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      screenSize.width > 500 ? 10.height : 4.height,
                      SizedBox(
                        width: screenSize.width > 500 ? 245 : 140,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            name.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xff4B4B4B),
                              fontSize: screenSize.width > 500 ? 25 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width > 500 ? 245 : 140,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${tons.toString()} Tonnes of carbon \noffset/year',
                            style: TextStyle(
                              color: Color(0xff538D09),
                              fontSize: screenSize.width > 500 ? 20 : 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      screenSize.width > 500 ? 10.height : 0.height,
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          'Donated €${donation.toString()}',
                          style: TextStyle(
                            color: Color(0xff7C7006),
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width > 500 ? 25 : 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_filled,
                  color: Color(0xff477A09),
                  size: screenSize.width > 500 ? 15 : 14,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${time.toString()} min ago',
                  style: TextStyle(
                    color: Color(0xff538D09),
                    fontSize: screenSize.width > 500 ? 18 : 14,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
