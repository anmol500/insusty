import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Util/Locator.dart';
import 'package:insusty/widgets/Header.dart';
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
        : Container(
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
            child: Stack(
              children: [
                Padding(
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
                          name: 'Subscription',
                          onTap: () {
                            getItPages.setUrlPath('/Offset');
                            context.go('/Offset');
                          }),
                      DrawerMenu(
                          name: 'Brand',
                          onTap: () {
                            getItPages.setUrlPath('/BrandPage');
                            context.go('/BrandPage');
                          }),
                      DrawerMenu(
                          name: 'About us',
                          onTap: () {
                            getItPages.setUrlPath('/KnowMorePage');
                            context.go('/KnowMorePage');
                          }),
                      DrawerMenu(
                          name: 'For business',
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
                                getItPages.setHeaderOpacity(1);
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setString('userEmail', '');
                                FirebaseAuth.instance.signOut();
                                getItPages.setUrlPath('/');
                                context.go('/');
                              })
                          : Container(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: Center(
                      child: Text(getItPages.language),
                    ),
                    onPressed: () {
                      if (getItPages.language == 'eng') {
                        getItPages.language = 'fr';
                      } else {
                        getItPages.language = 'eng';
                      }
                      getItPages.setUrlPath('/');
                      context.go('/');
                    },
                  ),
                )
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
          mainAxisAlignment: MainAxisAlignment.center,
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
