import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_next/views/next_accordion.dart';
import 'package:insusty/Util/FAQ_DATA.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:html' as html;

class APIDocs extends StatelessWidget {
  const APIDocs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset('images/ui/FAQ.png'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'Get Started With APIs For Your Business',
            style: TextStyle(
              fontFamily: 'nt',
              color: Color(0xff0F6D2F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        ...List.generate(
            apiQuestions.length,
            (index) => CustomAcorrdion(
                  question: apiQuestions[index],
                  answer: apiAnswer[index],
                  editor: index == 0 ? false : true,
                  query: index == 0
                      ? ''
                      : index == 1
                          ? "<query params = \n{\t\n\$API_Key, \n\$customer_email, \t\n\$iPoint, \t\n\$cartAmount,\n}>"
                          : index == 2
                              ? "query params = \n{\t\n\$API_Key, \n\$customer_email, \t\n\$iPoint, \t\n\$cartAmount, \t\n\$YOUR_Email,\n}"
                              : '',
                  url: index == 0
                      ? 'API_Link'
                      : index == 1
                          ? "getPrice"
                          : index == 2
                              ? "savePurchase"
                              : '',
                )),
        GestureDetector(
          onTap: () {
            html.window.open('https://api.insusty.com/docs', '_self');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 50),
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
                    'Go to FastApi Docs to test',
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
        40.height,
      ],
    );
  }
}

class CustomAcorrdion extends StatelessWidget {
  CustomAcorrdion({Key? key, this.question, this.answer, this.open = false, this.editor, this.url, this.query}) : super(key: key);

  final question;
  final answer;
  var open;
  final editor;
  final url;
  final query;

  @override
  Widget build(BuildContext context) {
    List<String> contentOfPage1 = [
      "<API Link>",
      "<URL = https://api.insusty.com/$url>",
      query,
    ];
    List<FileEditor> files = [
      FileEditor(
        name: "page1.html",
        language: "html",
        code: contentOfPage1.join("\n"), // [code] needs a string
      ),
    ];

    EditorModel model = EditorModel(
      files: files, // the files created above
      // you can customize the editor as you want
      styleOptions: EditorModelStyleOptions(
        fontSize: 13,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
      child: NextAccordion(
        borderColor: Colors.transparent,
        initiallyExpanded: open,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            question,
            style: TextStyle(fontFamily: 'nt', color: Color(0xff222F19), fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              answer,
              style: TextStyle(
                fontFamily: 'nt',
                color: Color(0xff495F3B),
                fontSize: 16,
              ),
            ),
          ),
          editor
              ? CodeEditor(
                  model: model,
                  edit: true,
                )
              : Container(),
        ],
      ).cornerRadiusWithClipRRect(12),
    );
  }
}
