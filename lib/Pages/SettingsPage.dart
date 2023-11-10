import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffDEEED0),
              Color(0xffFDED92),
            ],
          ),
        ),
        child: ListView(
          children: [
            40.height,
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(getItPages.urlPath);
                        context.go(getItPages.urlPath);
                      },
                      child: Icon(
                        Icons.close_rounded,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width / 3.7,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Color(0xff00370F),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            40.height,
            CircleAvatar(
              minRadius: 50,
              backgroundColor: Color(0xff006239),
              child: Center(
                child: Text(
                  fireAuth.currentUser!.displayName!.split(' ').first[0].toString() + fireAuth.currentUser!.displayName!.split(' ').last[0].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            20.height,
            Text(
              fireAuth.currentUser!.displayName.toString(),
              style: TextStyle(
                color: Color(0xff2F900D),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            8.height,
            Text(
              fireAuth.currentUser!.email.toString(),
              style: TextStyle(
                color: Color(0xff53785F),
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 115.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff208207),
                      Color(0xff587B0C),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            30.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            20.height,
            SettingMenu(name: 'Notifications'),
            SettingMenu(name: 'Subscription'),
            SettingMenu(name: 'Privacy Settings'),
          ],
        ),
      ),
    );
  }
}

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    Key? key,
    this.name,
    this.onTap,
  }) : super(key: key);

  final name;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Color(0xff00370F),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.start,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
