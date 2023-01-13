import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CalcChooseCountry extends StatefulWidget {
  CalcChooseCountry({Key? key}) : super(key: key);

  @override
  State<CalcChooseCountry> createState() => _CalcChooseCountryState();
}

class _CalcChooseCountryState extends State<CalcChooseCountry> {
  var country;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: screenSize.height / 3.4,
        ),
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: false,
              showSearch: false,
              onSelect: (Country country) {
                this.country = country;
                setState(() {});
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          country == null ? '🇫🇷' : country.flagEmoji,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        20.width,
                        SizedBox(
                          width: 160,
                          child: Text(
                            country == null ? 'France' : country.displayNameNoCountryCode.toString().splitBefore('('),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'nt',
                              color: Color(0xff2F410F),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ).cornerRadiusWithClipRRect(12),
          ),
        ),
      ],
    );
  }
}
