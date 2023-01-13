import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Pages/HomePage.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
            Image.asset(
              'images/logo.png',
              height: screenSize.height / 12,
            ),
            80.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
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
              onTap: () {
                GoRouter.of(context).go('/');
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
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
                    child: Center(
                      child: Text(
                        'Sign Up',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: Image.asset(
                'images/ui/LoginPage/googleSignin.png',
                height: screenSize.height / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
