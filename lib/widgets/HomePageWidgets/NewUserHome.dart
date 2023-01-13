import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NewUserHome extends StatelessWidget {
  const NewUserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.25,
        enlargeFactor: .1,
        viewportFraction: 0.45,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        NewUserCard(name: 'San', time: 2, donation: 5.34, img: 0, tons: 3),
        NewUserCard(name: 'Pushpalatha', time: 4, donation: 3.44, img: 1, tons: 2),
        NewUserCard(name: 'Peter', time: 5, donation: 15.34, img: 1, tons: 6),
      ],
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'images/ui/HomePage/newUsers$img.png',
            height: 145,
          ),
          SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name.toString(),
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'nt',
                  color: Color(0xff4B4B4B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${tons.toString()} Tonnes of carbon offset/year',
                style: TextStyle(
                  fontFamily: 'nt',
                  color: Color(0xff538D09),
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Donated €${donation.toString()}',
              style: TextStyle(
                fontFamily: 'nt',
                color: Color(0xff538D09),
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: Color(0xff477A09),
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${time.toString()} min ago',
                    style: TextStyle(
                      fontFamily: 'nt',
                      color: Color(0xff538D09),
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
