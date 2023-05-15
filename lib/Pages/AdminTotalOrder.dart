import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insusty/widgets/TransactionTileAdmin.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../widgets/TransactionTile.dart';

class AdminTotalOrder extends StatefulWidget {
  const AdminTotalOrder({Key? key}) : super(key: key);

  @override
  State<AdminTotalOrder> createState() => _AdminTotalOrderState();
}

class _AdminTotalOrderState extends State<AdminTotalOrder> {
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
            future: FirebaseFirestore.instance.collection('transaction').get(),
            // future: FirebaseFirestore.instance.collection('transaction').where('Customer_Email', isEqualTo: FirebaseAuth.instance.currentUser!.email).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return SelectableText(snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.done) {
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data = snapshot.data!.docs;
                List transactionTileList = [];
                // Timestamp().toDate().month;
                for (var i in data) {
                  print(i.id);
                  transactionTileList.add(
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: i.id.toString()));
                        snackBar(context, title: 'Transaction ID: ${i.id} ', backgroundColor: Color(0xff70ae05));
                      },
                      child: TransactionTileAdmin(
                        id: i.id.toString(),
                        screenSize: screenSize,
                        customerName: i.data()['Customer_Email'].toString().contains('@') ? i.data()['Customer_Email'].split('@').first : i.data()['Customer_Email'],
                        businessName: i.data()['Business_Email'].toString().contains('@') ? i.data()['Business_Email'].split('@').first : i.data()['Business_Email'],
                        amount: i.data()['Amount'],
                        date: DateFormat('EEE, d MMM yyy').format(i.data()['timestamp'].toDate()),
                        points: i.data()['Discount Percent'] * 100,
                      ),
                    ),
                  );
                }

                return ListView(
                  children: [
                    ...transactionTileList,
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
