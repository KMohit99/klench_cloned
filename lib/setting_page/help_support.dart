import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

class Help_Support extends StatefulWidget {
  const Help_Support({Key? key}) : super(key: key);

  @override
  State<Help_Support> createState() => _Help_SupportState();
}

class _Help_SupportState extends State<Help_Support> {
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
          "Help & Support",
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.primary_grey, family: 'PM'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
            margin: EdgeInsets.only(top: 0, right: 8, left: 8),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [

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
                        ],
                      );
                    },
                  ),
                  Container(
                    width: 48,
                    margin: EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                            begin: Alignment(-1.0, -4.0),
                            end: Alignment(1.0, 4.0),
                            colors: [HexColor('#020204'), HexColor('#36393E')])),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        AssetUtils.call_icon,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Toll free number: ',
                                    style: FontStyleUtility.h16(
                                        fontColor: ColorUtils.primary_gold,
                                        family: 'PM')),
                                TextSpan(
                                    text: '987654310',
                                    style: FontStyleUtility.h16(
                                        fontColor: ColorUtils.primary_grey,
                                        family: 'PM')),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'E: ',
                                    style: FontStyleUtility.h16(
                                        fontColor: ColorUtils.primary_gold,
                                        family: 'PM')),
                                TextSpan(
                                    text: 'support@app.com',
                                    style: FontStyleUtility.h16(
                                        fontColor: ColorUtils.primary_grey,
                                        family: 'PM')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
