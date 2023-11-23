import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ContactUsPage extends StatefulWidget {
  ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  var dropDownValue = 'I want to';
  bool checked = true;
  double opacityLevel = 1.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var padding = EdgeInsets.symmetric(
      horizontal: screenSize.width > 700 ? 150 : 20.0,
      vertical: screenSize.width > 700 ? 8 : 5,
    );
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              screenSize.width > 700 ? 'images/ui/ContactUsDeshtopBg.png' : "images/ui/Contact Us.png",
            ),
            fit: BoxFit.fill,
          )),
          child: ListView(
            children: [
              Image.asset(
                screenSize.width > 700 ? 'images/ui/ContactUsHeroDesktop.png' : 'images/ui/ContactUsHero.png',
                fit: BoxFit.cover,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'Let’s Talk',
                            style: TextStyle(
                              color: Color(0xff0F6D2F),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: '🐨️  Your Name Please',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: '🐼️  And Your Email too!',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: '🏦️  Company / Organisation',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: DropdownButtonFormField<String>(
                            value: dropDownValue,
                            elevation: 16,
                            padding: EdgeInsets.all(0),
                            borderRadius: BorderRadius.circular(10),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                            onChanged: (newValue) {
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            },
                            items: [
                              'I want to',
                              'Learn more',
                              'Partner with Insusty',
                              'Get help in buying carbon credits',
                              'Request API Access',
                              'Sell carbon credits',
                              'Something else',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontWeight: value != 'I want to' ? FontWeight.bold : null,
                                    color: value != 'I want to' ? Color(0xff0F6D2F) : Color(0xff282828),
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: padding,
                          child: TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: '✍️️  Message',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        screenSize.height > 700 ? 10.height : 0.height,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSize.width > 700 ? 250 : 10.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  activeColor: Color(0xff208207),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  value: checked,
                                  onChanged: (c) {
                                    checked = c!;
                                    setState(() {});
                                  }),
                              Text(
                                'I agree to receive communications from Insusty*',
                                style: TextStyle(
                                  color: Color(0xff4B4B4B),
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSize.width > 700 ? 320 : 45.0, vertical: 10),
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
                                color: Color(0xff008A2F)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                              child: Center(
                                child: Text(
                                  'Send Message',
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
                        50.height,
                      ],
                    ),
                  ),
                  screenSize.width > 700
                      ? Padding(
                          padding: const EdgeInsets.only(right: 88.0, top: 20),
                          child: Image.asset(
                            'images/ui/ContactUsSide.png',
                            scale: 2.4,
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: opacityLevel == 0.0,
          child: AnimatedContainer(
            color: Color(0xffFFFCF2).withOpacity(opacityLevel),
            duration: 300.milliseconds,
            height: screenSize.height,
            width: screenSize.width,
          ),
        ),
      ],
    );
  }
}
