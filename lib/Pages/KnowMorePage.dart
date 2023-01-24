import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Util/Locator.dart';

class KnowMorePage extends StatelessWidget {
  const KnowMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Image.asset(
              'images/ui/Know More.jpg',
              fit: BoxFit.contain,
            ),
            Positioned(
              bottom: 10,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  getItPages.setUrlPath('/ContactUs');
                  context.go('/ContactUs');
                },
                child: Container(
                  height: 500,
                  width: 500,
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
