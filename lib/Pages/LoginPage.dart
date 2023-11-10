import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/painting/gradient.dart' as ll;
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rive/rive.dart';

import '../Util/CustomClipper.dart';
import '../Util/Locator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool pressed = false;

  //animation
  late StateMachineController? stateMachineController;
  late SMIBool isChecking, isHandsUp;
  late SMITrigger trigSuccess, trigFail;
  late SMINumber numLook;

  var artboard;

  @override
  void initState() {
    super.initState();
    initializingRive();
  }

  initializingRive() {
    rootBundle.load('images/rive.riv').then((value) {
      final art = RiveFile.import(value).mainArtboard;
      stateMachineController = StateMachineController.fromArtboard(art, 'Login Machine');
      if (stateMachineController != null) {
        art.addController(stateMachineController!);

        for (SMIInput element in stateMachineController!.inputs) {
          if (element.name == 'isChecking') {
            isChecking = element as SMIBool;
          } else if (element.name == 'numLook') {
            numLook = element as SMINumber;
          } else if (element.name == 'isHandsUp') {
            isHandsUp = element as SMIBool;
          } else if (element.name == 'trigSuccess') {
            trigSuccess = element as SMITrigger;
          } else if (element.name == 'trigFail') {
            trigFail = element as SMITrigger;
          } else {
            // Handle the case where element.name does not match any variable
            // You can choose to ignore it or handle it according to your requirement
          }
        }
      }
      artboard = art;
      setState(() {});
    });
  }

  checking() {
    isChecking.change(true);
    isHandsUp.change(false);
  }

  numLockF(v) {
    numLook.change(v.length.toDouble() * 2);
  }

  handsUp() {
    isChecking.change(false);
    isHandsUp.change(true);
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
          // crossAxisAlignment: CrossAxisAlignment.stretch,
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
            20.height,
            if (artboard != null)
              Container(
                height: 200,
                child: ClipOval(
                  clipper: CustomCircleClipper(),
                  child: Rive(
                    artboard: artboard!,
                  ),
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
                      onTap: checking,
                      onChanged: (v) => numLockF(v),
                      controller: email,
                      decoration: InputDecoration(
                          hintText: 'Your@email.com',
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
                      onTap: handsUp,
                      controller: pass,
                      decoration: InputDecoration(
                          hintText: 'Pas****d',
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
                  25.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color(0xff208207),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  10.height,
                  InkWell(
                    onTap: () async {
                      email.text = email.text.trim();
                      pass.text = pass.text.trim();
                      pressed = true;
                      setState(() {});

                      if (email.text == 'admin' && pass.text == 'admin') {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('userEmail', email.text);

                        context.go('/AdminDashboard');
                      } else {
                        try {
                          FirebaseAuth fireAuth = FirebaseAuth.instance;

                          await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: email.text).get().then((value) async {
                            isHandsUp.change(false);
                            isChecking.change(false);
                            trigSuccess.fire();
                            await 1.seconds.delay;

                            if (value.docs.isNotEmpty) {
                              print(value.docs[0]);
                              if (value.docs[0]['password'] != 'google') {
                                await fireAuth.signInWithEmailAndPassword(
                                  email: email.text,
                                  password: pass.text,
                                );

                                value.docs[0]['individual'] == true ? GoRouter.of(context).go('/CustomerDashboard') : GoRouter.of(context).go('/BusinessDashboard');

                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setString('userEmail', email.text);
                                await prefs.setBool('individual', value.docs[0]['individual']);

                                snackBar(context, title: 'Welcome Back! ${fireAuth.currentUser!.displayName} ', backgroundColor: Color(0xff70ae05));
                              } else {
                                snackBar(context, title: 'Please sign in using Google sign-in button below ');
                              }
                            }
                          });

                          pressed = false;
                          setState(() {});
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          isHandsUp.change(false);
                          isChecking.change(false);
                          trigFail.change(true);
                          await 2.seconds.delay;
                          if (e.code == 'user-not-found') {
                            snackBar(context, title: 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            snackBar(context, title: 'Wrong password provided for that user.');
                          }
                          pressed = false;
                          setState(() {});
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          gradient: ll.LinearGradient(
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
                                    'Log In',
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
                      GoRouter.of(context).go('/signUp');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Text(
                        'Don’t have an account? Sign Up',
                        style: TextStyle(
                          color: Color(0xff208207),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  12.height,
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
                  GestureDetector(
                    onTap: () async {
                      GoogleAuthProvider googleProvider = GoogleAuthProvider();
                      final prefs = await SharedPreferences.getInstance();

                      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                      var user = (await firebaseAuth.signInWithPopup(googleProvider)).user;
                      isHandsUp.change(false);
                      isChecking.change(false);
                      trigSuccess.fire();
                      await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: user?.email).get().then((value) {
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
                            'individual': true,
                            'refer_link': user!.email!.split('@').first.replaceAll(new RegExp(r'[^\w\s]+'), '') + Random().nextInt(20).toString(),
                          }).then((value) async {
                            await prefs.setString('userEmail', firebaseAuth.currentUser!.email.toString());

                            GoRouter.of(context).go('/CustomerDashboard');
                            snackBar(context, title: 'Welcome To Insusty, ${user?.displayName}!', backgroundColor: Color(0xff70ae05));
                          });

                        if (prefs.getDouble('tons') != null)
                          value.docs.first.reference.update(
                            {'tons': prefs.getDouble('tons')},
                          );
                      });
                      await prefs.setBool('individual', true);
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
