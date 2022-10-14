import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';
import 'package:share_plus/share_plus.dart';

import '../../front_page/FrontpageScreen.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TextStyle_utils.dart';

class RefferalLinkScreen extends StatefulWidget {
  const RefferalLinkScreen({Key? key}) : super(key: key);

  @override
  State<RefferalLinkScreen> createState() => _RefferalLinkScreenState();
}

class _RefferalLinkScreenState extends State<RefferalLinkScreen> {
  TextEditingController Emailcontroller = new TextEditingController();

  String link = 'https://foxytechnologies.com/';

  @override
  void initState() {
    Emailcontroller.text = link;
    print(Emailcontroller.text);
  }

  PageController? controller;
  int _curr = 0;

  List img_icons = [
    AssetUtils.wp_icons,
    AssetUtils.twitter_icons,
    AssetUtils.telegram_icons,
    AssetUtils.line_icons,
    AssetUtils.facebook_icons,
    AssetUtils.snapchat_icons,
    AssetUtils.instagram_icons,
    AssetUtils.Foursquare_icons,
  ];
  List img_icons_text = [
    'WhatsApp',
    "Twitter",
    "Telegran",
    "Line",
    "Facebook",
    "Snapchat",
    "Instagram",
    "Foursquare",
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
          "Refferal link",
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
          margin: EdgeInsets.only(bottom: 20, right: 8, left: 8),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 33),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            HexColor('#020204'),
                            HexColor('#36393E'),
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: HexColor('#04060F'),
                            offset: Offset(3, 3),
                            blurRadius: 10)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Image.asset(
                      AssetUtils.referralLink_icons,
                      color: ColorUtils.primary_gold,
                      height: 26,
                      width: 26,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            HexColor("#36393E").withOpacity(1),
                            HexColor("#020204").withOpacity(1),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: HexColor('#04060F'),
                              offset: Offset(3, 3),
                              blurRadius: 10)
                        ]),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 21),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 20, bottom: 0),
                            child: Text(
                              'Copy and share referral link',
                              style: FontStyleUtility.h14(
                                  fontColor: ColorUtils.primary_grey,
                                  family: 'PM'),
                            ),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Container(
                            child: CommonTextFormField_reversed(
                              labelText: 'Email Address',
                              maxLines: 2,
                              controller: Emailcontroller,
                              readOnly: true,
                              iconData: IconButton(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                icon: Image.asset(
                                  AssetUtils.copy_icons,
                                  height: 17,
                                  width: 15,
                                  color: HexColor("#606060"),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          GestureDetector(
                            onTap: () {
                              _onShare(context);
                              // selectTowerBottomSheet(context);
                            },
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        HexColor('#020204'),
                                        HexColor('#36393E'),
                                      ]),
                                  boxShadow: [
                                    BoxShadow(
                                        color: HexColor('#04060F'),
                                        offset: Offset(3, 3),
                                        blurRadius: 10)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetUtils.share_icon,
                                        color: ColorUtils.primary_gold,
                                        height: 28,
                                        width: 26,
                                      ),
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Text(
                                        'Share',
                                        style: FontStyleUtility.h12(
                                            fontColor: ColorUtils.primary_grey,
                                            family: 'PR'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectTowerBottomSheet(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: StatefulBuilder(
            builder: (context, state) {
              return Container(
                height: screenheight * 0.5,
                width: screenwidth,
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.65),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    // stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      HexColor("#36393E").withOpacity(1),
                      HexColor("#020204").withOpacity(1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: HexColor('#04060F'),
                      offset: Offset(10, 10),
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(33.9),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 0),
                        child: Text('Select media',
                            style: FontStyleUtility.h16(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR')),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: screenheight / 5,
                        child: PageView(
                          children: [
                            Container(
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 20),
                                  itemCount: 8,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            img_icons[index],
                                            height: 40,
                                            width: 40,
                                          ),
                                          Text(
                                            img_icons_text[index],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontFamily: 'PR'),
                                          )
                                        ],
                                      ),
                                      // decoration: BoxDecoration(
                                      //     color: Colors.amber,
                                      //     borderRadius:
                                      //         BorderRadius.circular(15)),
                                    );
                                  }),
                            ),
                            Center(
                                child: Container(
                              child: Text(
                                'Second',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                            Center(
                                child: Container(
                              child: Text('Third',
                                  style: TextStyle(color: Colors.white)),
                            ))
                          ],
                          scrollDirection: Axis.horizontal,
                          // reverse: true,
                          // physics: BouncingScrollPhysics(),
                          controller: controller,
                          onPageChanged: (num) {
                            setState(() {
                              _curr = num;
                              print(_curr);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: common_button_gold(title_text: 'Share'))
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    Share.share(link, subject: 'Share App');
  }
}
