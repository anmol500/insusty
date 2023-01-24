import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Util/Locator.dart';
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
          DrawerMenu(
              name: FirebaseAuth.instance.currentUser != null ? 'Dashboard' : 'Login',
              onTap: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  getItPages.setUrlPath('/login');
                  context.go('/login');
                } else {
                  context.go('/CustomerDashboard');
                }
              }),
          DrawerMenu(
              name: 'Offset',
              onTap: () {
                getItPages.setUrlPath('/Offset');
                context.go('/Offset');
              }),
          DrawerMenu(
              name: 'Discover',
              onTap: () {
                getItPages.setUrlPath('/DiscoverPage');
                context.go('/DiscoverPage');
              }),
          DrawerMenu(
              name: 'Know More',
              onTap: () {
                getItPages.setUrlPath('/KnowMorePage');
                context.go('/KnowMorePage');
              }),
          DrawerMenu(
              name: 'B2B APIs',
              onTap: () {
                getItPages.setUrlPath('/DiscoverPage');
                context.go('/DiscoverPage');
              }),
          DrawerMenu(
              name: 'Blogs',
              onTap: () {
                getItPages.setUrlPath('/BlogPage');
                context.go('/BlogPage');
              }),
          DrawerMenu(
              name: 'FAQ’s',
              onTap: () {
                getItPages.setUrlPath('/FAQ');
                context.go('/FAQ');
              }),
          DrawerMenu(
              name: 'Contact Us',
              onTap: () {
                getItPages.setUrlPath('/ContactUs');
                context.go('/ContactUs');
              }),
          SizedBox(
            height: screenSize.height / 20,
          ),
          DrawerMenu(
              name: 'Settings',
              icon: Icons.settings,
              onTap: () {
                context.go('/settings');
              }),
          FirebaseAuth.instance.currentUser != null
              ? DrawerMenu(
                  name: 'Log Out',
                  icon: Icons.logout_rounded,
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    getItPages.setUrlPath('/');
                    context.go('/');
                  })
              : Container(),
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
        padding: const EdgeInsets.all(14.0),
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
