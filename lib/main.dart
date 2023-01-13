import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Pages/CalcChooseCountry.dart';
import 'package:insusty/Pages/CustomDrawer.dart';
import 'package:insusty/Pages/FAQ_Page.dart';
import 'package:insusty/Pages/HomePage.dart';
import 'package:insusty/Pages/LoginPage.dart';
import 'package:insusty/Pages/OffsetPage.dart';
import 'package:insusty/Pages/SettingsPage.dart';
import 'package:insusty/widgets/Header.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Util/Locator.dart';

main() {
  setPathUrlStrategy();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingsPage(),
          ),
          ShellRoute(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => HomePage(),
                ),
                GoRoute(
                  path: '/Offset',
                  builder: (context, state) => OffsetPage(),
                ),
                GoRoute(
                  path: '/FAQ',
                  builder: (context, state) => FAQ_Page(),
                ),
                GoRoute(
                  path: '/CalcChooseCountry',
                  builder: (context, state) => CalcChooseCountry(),
                ),
                GoRoute(
                  path: '/drawer',
                  builder: (context, state) => CustomDrawer(),
                ),
              ],
              builder: (context, state, child) {
                return Header(
                  child: child,
                );
              }),
        ],
      ),
    );
  }
}
