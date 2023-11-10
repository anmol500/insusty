import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class BusinessAPIkeyPage extends StatefulWidget {
  BusinessAPIkeyPage({Key? key}) : super(key: key);

  @override
  State<BusinessAPIkeyPage> createState() => _BusinessAPIkeyPageState();
}

class _BusinessAPIkeyPageState extends State<BusinessAPIkeyPage> {
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  var apiKey = '';
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  bool loading = false;

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    loading = true;
    setState(() {});
    await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get().then((value) {
      apiKey = value.docs[0]['apiKey'];
    });
    loading = false;
    setState(() {});
  }

  generateAPI() {
    loading = true;
    setState(() {});
    apiKey = getRandomString(10);

    FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get().then((value) {
      FirebaseFirestore.instance.collection('00users').doc(value.docs[0].reference.id).update({
        'apiKey': apiKey,
      }).then((value) {
        loading = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      appBar: AppBar(
        title: Text('API Key'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white),
            child: Center(
              child: loading
                  ? CircularProgressIndicator()
                  : Text(
                      apiKey == '' ? 'Generate API' : apiKey,
                      style: TextStyle(
                        color: Color(0xff00370F),
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          20.height,
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: apiKey));
              snackBar(context, title: 'Copied to your clipboard', backgroundColor: Color(0xff70ae05));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff208207),
                      Color(0xff587B0C),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  child: Center(
                    child: Text(
                      'Copy',
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
            onTap: () async {
              generateAPI();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff208207),
                      Color(0xff587B0C),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  child: Center(
                    child: Text(
                      'Generate New API key',
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
        ],
      ),
    );
  }
}
