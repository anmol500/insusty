import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insusty/widgets/TransactionTileAdmin.dart';
import 'package:insusty/widgets/UsersTile.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../widgets/TransactionTile.dart';

class AdminTotalUsers extends StatefulWidget {
  const AdminTotalUsers({Key? key, this.individual}) : super(key: key);
  final individual;

  @override
  State<AdminTotalUsers> createState() => _AdminTotalUsersState();
}

class _AdminTotalUsersState extends State<AdminTotalUsers> {
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Transactions'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('00users').get(),
            // future: FirebaseFirestore.instance.collection('transaction').where('Customer_Email', isEqualTo: FirebaseAuth.instance.currentUser!.email).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return SelectableText(snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.done) {
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data = snapshot.data!.docs;
                List tileList = [];
                // Timestamp().toDate().month;
                for (var i in data) {
                  print(i.data()['individual']);
                  if (widget.individual) {
                    if (i.data()['individual']) {
                      tileList.add(
                        UsersTile(
                          screenSize: screenSize,
                          name: i.data()['full_name'],
                          email: i.data()['email'],
                          plan: i.data()['plan'],
                          daysLeft: i.data()['dayleft'],
                          individual: true,
                          points: i.data()['points'],
                        ),
                      );
                    }
                  } else {
                    if (!i.data()['individual']) {
                      tileList.add(
                        UsersTile(
                          screenSize: screenSize,
                          name: i.data()['full_name'],
                          email: i.data()['email'],
                          plan: i.data()['plan'],
                          daysLeft: i.data()['dayleft'],
                          individual: false,
                          points: i.data()['points'],
                        ),
                      );
                    }
                  }
                }

                return ListView(
                  children: [
                    ...tileList,
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.green,
                )),
              );
            }),
      ),
    );
  }
}
