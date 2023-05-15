import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Util/Locator.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var prefs;
  @override
  initState() {
    getPref();
    super.initState();
  }

  var loading = true;
  getPref() async {
    prefs = await SharedPreferences.getInstance();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return loading
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                DrawerMenu(
                    name: FirebaseAuth.instance.currentUser != null || (prefs.getString('userEmail') == 'admin') ? 'Dashboard' : 'Login',
                    onTap: () async {
                      if (FirebaseAuth.instance.currentUser == null && (prefs.getString('userEmail') != 'admin')) {
                        getItPages.setUrlPath('/login');
                        context.go('/login');
                      } else {
                        var individual;

                        individual = prefs.getBool('individual');
                        if (prefs.getString('userEmail') == 'admin') {
                          context.go('/AdminDashboard');
                        } else {
                          individual ? context.go('/CustomerDashboard') : context.go('/BusinessDashboard');
                        }
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
                      getItPages.setUrlPath('/b2b');
                      context.go('/b2b');
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
                FirebaseAuth.instance.currentUser != null
                    ? DrawerMenu(
                        name: 'Settings',
                        icon: Icons.settings,
                        onTap: () {
                          context.go('/settings');
                        })
                    : Container(),
                FirebaseAuth.instance.currentUser != null || (prefs.getString('userEmail') == 'admin')
                    ? DrawerMenu(
                        name: 'Log Out',
                        icon: Icons.logout_rounded,
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('userEmail', '');
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
