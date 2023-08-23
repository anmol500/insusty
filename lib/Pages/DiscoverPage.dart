import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/views/next_grid_view.dart';
import 'package:flutter_next/widgets/next_grid_item.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            'Brand',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff00370F),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          height: 250,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.0,
              viewportFraction: 1,
            ),
            items: [
              Image.asset(
                'images/ui/demo1.png',
                fit: BoxFit.contain,
              ),
              Image.asset(
                'images/ui/demo1.png',
                fit: BoxFit.contain,
              ),
              Image.asset(
                'images/ui/demo1.png',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NextGridView(
            sizes: "col-6 col-md-3 col-lg-4 col-xl-3 col-xs-5",
            childrens: List.generate(
              12,
              (index) => NextGridItem(
                child: SizedBox(
                  height: 150,
                  child: Image.asset(
                    'images/ui/demo1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
