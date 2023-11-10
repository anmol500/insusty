import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Pages/APIDocs.dart';
import 'package:insusty/Pages/AdminDashboard.dart';
import 'package:insusty/Pages/BlogPage.dart';
import 'package:insusty/Pages/BusinessDashboard.dart';
import 'package:insusty/Pages/CalculatorPages/CalculatorQuestionPage.dart';
import 'package:insusty/Pages/ContactUsPage.dart';
import 'package:insusty/Pages/CustomerDashboard2.dart';
import 'package:insusty/Pages/PrivacyPolicy.dart';
import 'package:insusty/Pages/ThankYouPage.dart';
import 'package:insusty/widgets/CustomDrawer.dart';
import 'package:insusty/Pages/FAQ_Page.dart';
import 'package:insusty/Pages/HomePage.dart';
import 'package:insusty/Pages/KnowMorePage.dart';
import 'package:insusty/Pages/LoginPage.dart';
import 'package:insusty/Pages/OffsetPage.dart';
import 'package:insusty/Pages/SettingsPage.dart';
import 'package:insusty/Pages/SignUpPage.dart';
import 'package:insusty/widgets/Header.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Pages/BusinessOffsetPage.dart';
import 'Pages/CalculatorPages/CalcChooseCountry.dart';
import 'Pages/DiscoverPage.dart';
import 'Util/Locator.dart';

import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setPathUrlStrategy();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'newsletter',
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: '/signUp/:refer',
            builder: (context, state) => SignUpPage(
              refer: state.params['refer'],
            ),
          ),
          GoRoute(
            // path: '/signUp',
            path: '/signUp',
            builder: (context, state) => SignUpPage(
              refer: '',
            ),
          ),
          GoRoute(
            path: '/CustomerDashboard',
            builder: (context, state) => CustomerDashboard2(),
          ),
          GoRoute(
            // path: '/BusinessDashboard',
            path: '/BusinessDashboard',
            builder: (context, state) => BusinessDashboard(),
          ),
          GoRoute(
            // path: '/BusinessDashboard',
            path: '/PrivacyPolicy',
            builder: (context, state) => PrivacyPolicy(),
          ),
          GoRoute(
            // path: '/BusinessDashboard',
            path: '/AdminDashboard',
            builder: (context, state) => AdminDashboard(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingsPage(),
          ),
          GoRoute(
            path: '/ThankYouPage/:days/:name/:points/:individual/:monthly/:price',
            builder: (context, state) => ThankYouPage(
              days: state.params['days'],
              name: state.params['name'],
              points: state.params['points'],
              individual: state.params['individual'],
              monthly: state.params['monthly'],
              price: state.params['price'],
            ),
          ),
          GoRoute(
            path: '/CalculatorQuestion',
            builder: (context, state) => CalculatorQuestionPage(),
          ),
          ShellRoute(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => HomePage(),
              ),
              GoRoute(
                path: '/BrandPage',
                builder: (context, state) => BrandPage(),
              ),
              GoRoute(
                path: '/KnowMorePage',
                builder: (context, state) => KnowMorePage(),
              ),
              GoRoute(
                path: '/BlogPage',
                builder: (context, state) => BlogPage(),
              ),
              GoRoute(
                path: '/ContactUs',
                builder: (context, state) => ContactUsPage(),
              ),
              GoRoute(
                path: '/Offset',
                builder: (context, state) => OffsetPage(),
              ),
              GoRoute(
                path: '/b2b',
                builder: (context, state) => BusinessOffsetPage(),
              ),
              GoRoute(
                path: '/APIDocs',
                builder: (context, state) => APIDocs(),
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
            },
          ),
        ],
      ),
    );
  }
}
