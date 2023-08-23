import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/services.dart';
import '../Util/Locator.dart';
import '../widgets/LinearLine.dart';
import '../widgets/TransactionTile.dart';
import '../widgets/VerticalChart.dart';

class CustomerDashboard2 extends StatefulWidget {
  const CustomerDashboard2({Key? key}) : super(key: key);

  @override
  State<CustomerDashboard2> createState() => _CustomerDashboard2State();
}

class _CustomerDashboard2State extends State<CustomerDashboard2> {
  late VideoPlayerController _controller;
  PageController pageController = PageController();
  bool viewMore = false;

  var tons = 0.0;
  var refer = '';
  var points = 0.0;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUser();
    _controller = VideoPlayerController.asset('images/ui/video/tree.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      }).onError((error, stackTrace) {
        print(error);
        print(stackTrace);
      })
      ..setLooping(true);

    _controller.play();
  }

  getUser() async {
    await FirebaseFirestore.instance.collection('00users').where('email', isEqualTo: fireAuth.currentUser!.email).get().then((value) {
      tons = double.parse(value.docs[0]['tons'].toString());
      refer = value.docs[0]['refer_link'];
      points = double.parse(value.docs[0]['points'].toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          controller: pageController,
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: screenSize.height,
              child: VisibilityDetector(
                key: Key('video'),
                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleFraction > 0) {
                    _controller.play();
                  }
                },
                child: Stack(
                  children: [
                    AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
                    Container(
                      height: screenSize.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x3C131313),
                            Color(0xB6090909),
                            Color(0xF7050505),
                            Color(0xff000000),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          70.height,
                          Text(
                            'Your annual carbon footprint is',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xffffffff),
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          20.height,
                          Text(
                            tons.toStringAsFixed(2),
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xffffffff),
                              fontSize: 75,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Tons CO',
                                style: TextStyle(
                                  fontFamily: 'nt',
                                  color: Color(0xffffffff),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '2',
                                style: TextStyle(
                                  fontFamily: 'nt',
                                  color: Color(0xffffffff),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          25.height,
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'By Consumption Category',
                              style: TextStyle(
                                fontFamily: 'nt',
                                color: Color(0xffffffff),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: screenSize.height / 20),
                              child: VerticalChart(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: 30,
                        child: IconButton(
                          onPressed: () {
                            getItPages.setUrlPath('/');
                            context.go('/');
                          },
                          icon: Icon(
                            Icons.close_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Color(0xff000000),
                    Color(0xFF0C0C0C),
                    Color(0xFF1E1E1E),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'images/ui/swirl.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  RefreshIndicator(
                    backgroundColor: Colors.transparent,
                    color: Colors.transparent,
                    onRefresh: () async {
                      pageController.animateToPage(
                        pageController.initialPage,
                        duration: 1500.milliseconds,
                        curve: Curves.easeInOutCubicEmphasized,
                      );
                    },
                    child: Column(
                      children: [
                        10.height,
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            'By Consumption Category',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xffffffff),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LinearLine(screenSize: screenSize, color: Color(0xffFF9458), title: 'Your Carbon Footprint', percentage: 80, tons: tons),
                              LinearLine(screenSize: screenSize, color: Color(0xff82A3F6), title: 'Avg France', percentage: 70, tons: 6.8),
                              LinearLine(screenSize: screenSize, color: Color(0xff75C933), title: 'Avg World', percentage: 30, tons: 4.2),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Padding(
                            padding: EdgeInsets.only(right: screenSize.width / 2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                  )
                                ],
                                color: Colors.white,
                              ),
                              height: 50,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'My Loyalty Points',
                                  style: TextStyle(
                                    fontFamily: 'nt',
                                    color: Color(0xff2F410F),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go('/Offset');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Padding(
                              padding: EdgeInsets.only(left: screenSize.width / 3),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x40000000),
                                      offset: Offset(0, 4),
                                      blurRadius: 4.0,
                                    )
                                  ],
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        points.toString(),
                                        style: TextStyle(
                                          fontFamily: 'nt',
                                          color: Color(0xff0F6D2F),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 60,
                                        ),
                                      ),
                                      Text(
                                        'Points',
                                        style: TextStyle(
                                          fontFamily: 'nt',
                                          color: Color(0xff0F6D2F),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(text: "Register to Insusty to start offsetting carbon for better future \nhttps://www.insusty.com/signUp/$refer"));
                            snackBar(context, title: 'Link copied to your clipboard', backgroundColor: Color(0xff70ae05));
                            // copied successfully
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/ui/referFriend.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xffffffff),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xc2363636),
                            ),
                            child: FutureBuilder(
                                future: viewMore
                                    ? FirebaseFirestore.instance.collection('transaction').where('Customer_Email', isEqualTo: fireAuth.currentUser!.email).get()
                                    : FirebaseFirestore.instance.collection('transaction').limit(3).where('Customer_Email', isEqualTo: fireAuth.currentUser!.email).get(),
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
                                      transactionTileList.add(TransactionTile(
                                        screenSize: screenSize,
                                        businessName: i.data()['Business_Email'].split('@').first,
                                        amount: i.data()['Amount'],
                                        date: DateFormat('EEE, d MMM yyy').format(i.data()['timestamp'].toDate()),
                                        points: i.data()['Discount Percent'] * 100,
                                      ));
                                    }

                                    return Column(
                                      children: [
                                        ...transactionTileList,
                                        GestureDetector(
                                          onTap: () {
                                            viewMore = !viewMore;
                                            setState(() {});
                                          },
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: screenSize.width / 3.5, vertical: 10),
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                                child: Center(
                                                  child: Text(
                                                    transactionTileList.length == 0
                                                        ? 'No Records'
                                                        : viewMore
                                                            ? 'View Less'
                                                            : "View More",
                                                    style: TextStyle(
                                                      fontFamily: 'nt',
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/ui/ambassador.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            'More Option',
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xffffffff),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/ui/certificate.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/ui/learnMoreKlima.png'),
                        ),
                        GestureDetector(
                          onTap: () {
                            getItPages.setUrlPath('/CalcChooseCountry');

                            context.go('/CalcChooseCountry');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/ui/calculateAgain.png'),
                          ),
                        ),
                        50.height,
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
