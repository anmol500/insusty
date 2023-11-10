import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../widgets/TransactionTile.dart';

class BusinessTodayOrder extends StatefulWidget {
  const BusinessTodayOrder({Key? key}) : super(key: key);

  @override
  State<BusinessTodayOrder> createState() => _BusinessTodayOrderState();
}

class _BusinessTodayOrderState extends State<BusinessTodayOrder> {
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
            future: FirebaseFirestore.instance
                .collection('transaction')
                .where(
                  'Business_Email',
                  // isEqualTo: 'somebusiness@com.com',
                  isEqualTo: fireAuth.currentUser!.email,
                )
                .get(),
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
                  if (DateFormat('EEE, d MMM yyy').format(i.data()['timestamp'].toDate()) == DateFormat('EEE, d MMM yyy').format(DateTime.now()))
                    transactionTileList.add(
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(text: i.id.toString()));
                          snackBar(context, title: 'Transaction ID: ${i.id} ', backgroundColor: Color(0xff70ae05));
                        },
                        child: TransactionTile(
                          screenSize: screenSize,
                          businessName: i.data()['Customer_Email'].split('@').first,
                          amount: i.data()['Amount'],
                          date: DateFormat('EEE, d MMM yyy').format(i.data()['timestamp'].toDate()),
                          points: i.data()['Discount Percent'] * 100,
                        ),
                      ),
                    );
                }

                return ListView(
                  children: [
                    if (transactionTileList.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'No Records',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
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
