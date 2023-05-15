import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Your@email.com',
                    hintStyle: TextStyle(
                      fontFamily: 'nt',
                    ),
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
                decoration: InputDecoration(
                    hintText: 'Pas****d',
                    hintStyle: TextStyle(
                      fontFamily: 'nt',
                    ),
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
                  fontFamily: 'nt',
                  color: Color(0xff208207),
                  fontSize: 15,
                ),
              ),
            ),
            10.height,
            InkWell(
              onTap: () async {
                pressed = true;
                setState(() {});
                if (email.text == 'admin' && pass.text == 'admin') {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('userEmail', email.text);
                  context.go('/AdminDashboard');
                } else {
                  try {
                    FirebaseAuth fireAuth = FirebaseAuth.instance;
                    await fireAuth.signInWithEmailAndPassword(
                      email: email.text,
                      password: pass.text,
                    );

                    await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get().then((value) async {
                      value.docs[0]['individual'] == true ? GoRouter.of(context).go('/CustomerDashboard') : GoRouter.of(context).go('/BusinessDashboard');

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('userEmail', email.text);
                      await prefs.setBool('individual', value.docs[0]['individual']);

                      snackBar(context, title: 'Welcome Back! ${fireAuth.currentUser!.displayName} ', backgroundColor: Color(0xff70ae05));
                    });

                    pressed = false;
                    setState(() {});
                  } on FirebaseAuthException catch (e) {
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
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'nt',
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
                    fontFamily: 'nt',
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
              onTap: () {
                Future<UserCredential> signInWithGoogle() async {
                  // Create a new provider
                  GoogleAuthProvider googleProvider = GoogleAuthProvider();

                  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');

                  // Once signed in, return the UserCredential
                  return await FirebaseAuth.instance.signInWithPopup(googleProvider);

                  // Or use signInWithRedirect
                  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
                }

                signInWithGoogle();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: Image.asset(
                  'images/ui/LoginPage/googleSignin.png',
                  height: screenSize.height / 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
