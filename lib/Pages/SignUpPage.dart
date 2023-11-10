import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Util/Locator.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.refer}) : super(key: key);
  final refer;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController confPass = TextEditingController();

  bool pressed = false;
  bool individual = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    individual = getItPages.individual;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/ui/LoginPage/Login.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            50.height,
            GestureDetector(
              onTap: () {
                getItPages.setUrlPath('/');
                context.go('/');
              },
              child: Image.asset(
                'images/logo.png',
                height: screenSize.height / 12,
              ),
            ),
            80.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width > 750 ? 400 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      individual = !individual;

                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: individual ? Color(0xff459268) : Colors.white,
                          border: Border.all(
                            color: individual ? Color(0xff459268) : Color(0xff6A8856),
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: screenSize.width / (screenSize.width > 750 ? 12 : 10)),
                        child: Center(child: Text('Individual')),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      individual = !individual;

                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: !individual ? Color(0xff459268) : Colors.white,
                          border: Border.all(
                            color: !individual ? Color(0xff459268) : Color(0xff6A8856),
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: screenSize.width / (screenSize.width > 750 ? 12 : 10)),
                        child: Center(child: Text('Business')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width > 750 ? 400 : 0),
              child: Column(
                children: [
                  20.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: individual ? 'Your Name' : 'Name of your Brand',
                          hintStyle: TextStyle(),
                          filled: true,
                          fillColor: Color(0xffECECEC),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  30.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          hintText: individual ? 'Your@email.com' : 'Brand@brand.com',
                          hintStyle: TextStyle(),
                          filled: true,
                          fillColor: Color(0xffECECEC),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  30.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(),
                          filled: true,
                          fillColor: Color(0xffECECEC),
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  30.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: confPass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(),
                          filled: true,
                          fillColor: Color(0xffECECEC),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  10.height,
                  InkWell(
                    onTap: () async {
                      pressed = true;
                      setState(() {});
                      try {
                        final prefs = await SharedPreferences.getInstance();
                        FirebaseAuth fireAuth = FirebaseAuth.instance;
                        CollectionReference users = FirebaseFirestore.instance.collection('00users');
                        await fireAuth.createUserWithEmailAndPassword(
                          email: email.text.trim(),
                          password: pass.text,
                        );
                        users.add({
                          'full_name': name.text, // John Doe
                          "email": email.text.trim(),
                          'password': pass.text,
                          'points': 0,
                          'tons': prefs.getDouble('tons') ?? 0,
                          'dayleft': 0,
                          'apiKey': '',
                          'plan': 'none',
                          'individual': individual,
                          'refer_link': email.text.split('@').first.replaceAll(new RegExp(r'[^\w\s]+'), '') + Random().nextInt(20).toString(),
                        }).then((value) async {
                          //give refree 50 points
                          if (widget.refer.toString() != '') {
                            FirebaseFirestore.instance.collection('00users').where('refer_link', isEqualTo: widget.refer).get().then((value) {
                              FirebaseFirestore.instance.collection('00users').doc(value.docs[0].reference.id).update({'points': value.docs[0]['points'] + 50}).then((value) async {
                                fireAuth.currentUser?.updateDisplayName(name.text);

                                await prefs.setString('userEmail', fireAuth.currentUser!.email.toString());
                                await prefs.setBool('individual', individual);
                                individual ? GoRouter.of(context).go('/CustomerDashboard') : GoRouter.of(context).go('/BusinessDashboard');
                                snackBar(context, title: 'Welcome To Insusty, ${name.text}!', backgroundColor: Color(0xff70ae05));
                              });
                            });
                          } else {
                            fireAuth.currentUser?.updateDisplayName(name.text);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('userEmail', fireAuth.currentUser!.email.toString());
                            await prefs.setBool('individual', individual);
                            individual ? GoRouter.of(context).go('/CustomerDashboard') : GoRouter.of(context).go('/BusinessDashboard');
                            snackBar(context, title: 'Welcome To Insusty, ${name.text}!', backgroundColor: Color(0xff70ae05));
                          }
                        }).onError((error, stackTrace) {
                          print(error);
                          print(stackTrace);
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.toString().contains('weak-password')) {
                          snackBar(context, title: 'The password provided is too weak.');
                        } else if (e.toString().contains('email-already-in-use')) {
                          snackBar(context, title: 'The account already exists for that email.');
                        }
                        print(e.code);
                        print(e);
                        pressed = false;
                        setState(() {});
                      } catch (e) {
                        print(e);
                        pressed = false;
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff459268),
                              Color(0xff6A8856),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: pressed ? 10 : 18),
                          child: Center(
                            child: pressed
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Sign Up',
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
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/login');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Text(
                        'Already have an account? Log in',
                        style: TextStyle(
                          color: Color(0xff208207),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            color: Color(0xff4B4B4B),
                            height: 36,
                            thickness: 0.3,
                          )),
                    ),
                    Text(
                      'Or',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 3, fontSize: 13, fontFamily: 'nt'),
                    ),
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            color: Color(0xff4B4B4B),
                            height: 36,
                            thickness: 0.3,
                          )),
                    ),
                  ]),
                  12.height,
                  GestureDetector(
                    onTap: () async {
                      GoogleAuthProvider googleProvider = GoogleAuthProvider();
                      final prefs = await SharedPreferences.getInstance();

                      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                      var user = (await firebaseAuth.signInWithPopup(googleProvider)).user;
                      await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: user?.email).get().then((value) {
                        print(value.docs);
                        if (value.docs.length == 0)
                          FirebaseFirestore.instance.collection('00users').add({
                            'full_name': user?.displayName, // John Doe
                            "email": user?.email,
                            'password': 'google',
                            'points': 0,
                            'tons': prefs.getDouble('tons') ?? 0,
                            'dayleft': 0,
                            'apiKey': '',
                            'plan': 'none',
                            'individual': individual,
                            'refer_link': user!.email!.split('@').first.replaceAll(new RegExp(r'[^\w\s]+'), '') + Random().nextInt(20).toString(),
                          }).then((value) async {
                            await prefs.setString('userEmail', firebaseAuth.currentUser!.email.toString());

                            individual ? GoRouter.of(context).go('/CustomerDashboard') : GoRouter.of(context).go('/BusinessDashboard');
                            snackBar(context, title: 'Welcome To Insusty, ${user?.displayName}!', backgroundColor: Color(0xff70ae05));
                          });
                      });
                      await prefs.setBool('individual', individual);
                      GoRouter.of(context).go('/CustomerDashboard');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Image.asset(
                        'images/ui/LoginPage/googleSignin.png',
                        scale: screenSize.width > 750 ? 4 : 2,
                      ),
                    ),
                  ),
                  40.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
