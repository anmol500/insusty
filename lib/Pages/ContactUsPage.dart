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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset('images/ui/ContactUsHero.png'),
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text(
            '>> Let’s Talk >>',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff0F6D2F),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Your Name Please',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'nt',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'And Your Email too!',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'nt',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Company / Organisation',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'nt',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: DropdownButtonFormField<String>(
            value: dropDownValue,
            icon: Icon(
              Icons.nat,
              color: Colors.transparent,
              size: 0,
            ),
            iconSize: 15,
            elevation: 16,
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
              'Business',
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
                    fontFamily: 'nt',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: TextField(
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'nt',
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
          padding: const EdgeInsets.all(18.0),
          child: Row(
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
                  fontFamily: 'nt',
                  color: Color(0xff4B4B4B),
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
              child: Center(
                child: Text(
                  'Send Message',
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
        50.height,
      ],
    );
  }
}
