import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insusty/Util/Locator.dart';
import 'package:nb_utils/nb_utils.dart';

class CalcChooseCountry extends StatefulWidget {
  CalcChooseCountry({Key? key}) : super(key: key);

  @override
  State<CalcChooseCountry> createState() => _CalcChooseCountryState();
}

class _CalcChooseCountryState extends State<CalcChooseCountry> {
  var country;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    List.generate(
        8,
        (index) => precacheImage(
            Image.asset(
              MediaQuery.of(context).size.width > 750 ? 'images/q&a/qDesktop${index + 1}.png' : 'images/q&a/q${index + 1}.png',
              gaplessPlayback: true,
              fit: BoxFit.fill,
            ).image,
            context));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        getItPages.setUrlPath('/');
        return true;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width > 750 ? 450 : 8.0),
        child: Column(
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
                  countryListTheme: CountryListThemeData(
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    bottomSheetHeight: 500,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    inputDecoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
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
            screenSize.width > 750 ? 50.height : 150.height,
            GestureDetector(
              onTap: () {
                context.go('/CalculatorQuestion');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                    child: Center(
                      child: Text(
                        'Confirm',
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
          ],
        ),
      ),
    );
  }
}
