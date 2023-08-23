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
                pageBuilder: (context, state) => customTransition(context, state, HomePage()),
              ),
              GoRoute(
                path: '/BrandPage',
                pageBuilder: (context, state) => customTransition(context, state, BrandPage()),
              ),
              GoRoute(
                path: '/KnowMorePage',
                pageBuilder: (context, state) => customTransition(context, state, KnowMorePage()),
              ),
              GoRoute(
                path: '/BlogPage',
                pageBuilder: (context, state) => customTransition(context, state, BlogPage()),
              ),
              GoRoute(
                path: '/ContactUs',
                pageBuilder: (context, state) => customTransition(context, state, ContactUsPage()),
              ),
              GoRoute(
                path: '/Offset',
                pageBuilder: (context, state) => customTransition(context, state, OffsetPage()),
              ),
              GoRoute(
                path: '/b2b',
                pageBuilder: (context, state) => customTransition(context, state, BusinessOffsetPage()),
              ),
              GoRoute(
                path: '/APIDocs',
                pageBuilder: (context, state) => customTransition(context, state, APIDocs()),
              ),
              GoRoute(
                path: '/FAQ',
                pageBuilder: (context, state) => customTransition(context, state, FAQ_Page()),
              ),
              GoRoute(
                path: '/CalcChooseCountry',
                pageBuilder: (context, state) => customTransition(context, state, CalcChooseCountry()),
              ),
              GoRoute(
                path: '/drawer',
                pageBuilder: (context, state) => customTransition(context, state, CustomDrawer()),
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

customTransition(context, state, child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: 0.milliseconds,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
