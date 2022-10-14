import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';

class Authentication_settings extends StatefulWidget {
  const Authentication_settings({Key? key}) : super(key: key);

  @override
  State<Authentication_settings> createState() => _Authentication_settingsState();
}

class _Authentication_settingsState extends State<Authentication_settings> {

  @override
  void initState() {
    init();
  }
  bool? auth;
  bool isLoading = true;
  init() async {
    auth = await PreferenceManager().getbool(URLConstants.authentication_enable);
    print(auth);
    setState((){
      isLoading = false;
    });
  }
  List<Color> _kDefaultRainbowColors = [
    ColorUtils.primary_gold
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
          "Notifications Setting",
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.primary_grey, family: 'PM'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: (isLoading ? Material(
          color: Color(0x66DD4D4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                height: 80,
                width: 200,
                child:
                Material(
                  color: Colors.transparent,
                  child: LoadingIndicator(
                    backgroundColor: Colors.transparent,
                    indicatorType: Indicator.ballScale,
                    colors: _kDefaultRainbowColors,
                    strokeWidth: 4.0,
                    pathBackgroundColor: Colors.yellow,
                    // showPathBackground ? Colors.black45 : null,
                  ),
                ),
              ),
            ],
          ),
        ) :
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
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
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            HexColor("#020204").withOpacity(1),
                            HexColor("#36393E").withOpacity(1),
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0, bottom: 0),
                                child: Text(
                                  'Enable Local Authentication',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PM'),
                                ),
                              ),
                              Container(
                                width: 20,
                                child: Transform.scale(
                                  scale: 0.6,
                                  child: CupertinoSwitch(
                                    trackColor: HexColor('#717171'),
                                    thumbColor: Colors.black87,
                                    activeColor: ColorUtils.primary_gold,
                                    value: auth!,
                                    onChanged: (value) {
                                      setState(() {
                                        auth = value;
                                      });
                                      authentication_method();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
  Future<dynamic> authentication_method() async {
    await PreferenceManager().setbool(URLConstants.authentication_enable, auth!);
  }
}
