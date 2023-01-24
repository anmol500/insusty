import 'package:flutter/material.dart';

class JoinHome extends StatefulWidget {
  const JoinHome({Key? key, this.screenSize}) : super(key: key);
  final screenSize;
  @override
  State<JoinHome> createState() => _JoinHomeState();
}

class _JoinHomeState extends State<JoinHome> {
  var dropDownValue = 'Individual';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'images/ui/HomePage/join.png',
          fit: BoxFit.contain,
        ),
        Positioned.fill(
          bottom: 140,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: widget.screenSize.width / 3.5),
              child: Row(
                children: [
                  Text(
                    'You are',
                    style: TextStyle(
                      fontFamily: 'nt',
                      color: Color(0xff282828),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      value: dropDownValue,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 20,
                      ),
                      iconSize: 15,
                      elevation: 16,
                      underline: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                      items: ['Individual', 'Business'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xff282828),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 80,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                  child: Text(
                    'Join Now',
                    style: TextStyle(
                      fontFamily: 'nt',
                      color: Color(0xff2F410F),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
