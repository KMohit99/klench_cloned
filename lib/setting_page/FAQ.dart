import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

class faq_screen extends StatefulWidget {
  const faq_screen({Key? key}) : super(key: key);

  @override
  State<faq_screen> createState() => _faq_screenState();
}

class _faq_screenState extends State<faq_screen> {
  bool _isExpanded = false;

  List txt_list = [
    "How to register?",
    "How to get premium member plan?",
    "What are the benefits of this app?",
    "How should I pee?",
    "Methods of masturbation",
    "How to get premium member plan?",
    "What is the benefits of this app?",
    "How should I pee?",
    "Methods of masturbation",
    "How to get premium member plan?",

  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              width: 41,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                      begin: Alignment(-1.0, -4.0),
                      end: Alignment(1.0, 4.0),
                      colors: [HexColor('#020204'), HexColor('#36393E')])),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  AssetUtils.arrow_back,
                  height: 14,
                  width: 15,
                ),
              )),
        ),
        title: Text(
          "FAQ",
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.primary_grey, family: 'PM'),
        ),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor("#36393E").withOpacity(1),
                  HexColor("#020204").withOpacity(1),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: HexColor('#2A2A29'),
              //     offset: Offset(10, 10),
              //     blurRadius: 20,
              //   ),
              // ],
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(top: 0, right: 8, left:8  ),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: ColorUtils.primary_gold,
                        collapsedIconColor: Colors.white,
                        childrenPadding: EdgeInsets.zero,
                        // onExpansionChanged: (value) {
                        //   setState(() {
                        //     _isExpanded = value;
                        //   });
                        // },
                        title: Text(
                          txt_list[index],
                          style: FontStyleUtility.h14(
                              fontColor: Colors.white, family: 'PR'),
                        ),
                        children: <Widget>[
                          ListTile(
                            visualDensity:
                                VisualDensity(vertical: -4, horizontal: -4),
                            dense: true,
                            title: Text(
                              "description",
                              style: FontStyleUtility.h14(
                                  fontColor: ColorUtils.primary_gold,
                                  family: 'PR'),
                            ),
                          )
                        ],
                        // trailing: Icon(
                        //   Icons.keyboard_arrow_down,
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 0, right: 0, left: 0),
                      height: 1,
                      color: ColorUtils.dark_grey.withOpacity(0.5),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }
}
