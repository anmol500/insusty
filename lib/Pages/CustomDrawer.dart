import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Util/Locator.dart';
import 'package:insusty/widgets/Header.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView(
        children: [
          20.height,
          DrawerMenu(
              name: 'Dashboard',
              onTap: () {
                context.go('/login');
              }),
          DrawerMenu(
              name: 'Offset',
              onTap: () {
                getItPages.setUrlPath('/Offset');
                context.go('/Offset');
              }),
          DrawerMenu(name: 'Discover', onTap: () {}),
          DrawerMenu(name: 'Know More', onTap: () {}),
          DrawerMenu(name: 'B2B APIs', onTap: () {}),
          DrawerMenu(
              name: 'FAQ’s',
              onTap: () {
                getItPages.setUrlPath('/FAQ');
                context.go('/FAQ');
              }),
          DrawerMenu(name: 'Contact Us', onTap: () {}),
          SizedBox(
            height: screenSize.height / 10,
          ),
          DrawerMenu(
              name: 'Settings',
              icon: Icons.settings,
              onTap: () {
                context.go('/settings');
              }),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    this.name,
    this.onTap,
    this.icon,
  }) : super(key: key);

  final name;
  final onTap;
  final icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            icon == null
                ? Container()
                : Icon(
                    icon,
                    size: 28,
                  ),
            10.width,
            Text(
              name,
              style: TextStyle(
                fontFamily: 'nt',
                color: Color(0xff00370F),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
