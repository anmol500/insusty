import 'package:flutter/material.dart';


class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          'images/ui'
          '/BlogHero.png',
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
