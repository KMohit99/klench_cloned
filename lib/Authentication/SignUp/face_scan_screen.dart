import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/welcom_video/welcome_video_screen.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/common_widgets.dart';
import 'package:klench_/utils/page_loader.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/colorUtils.dart';
import '../subscription_plan/subscription_plan_screen.dart';
import '../welcom_video/welcome_screen_tow.dart';

class FaceScanScreen extends StatefulWidget {
  const FaceScanScreen({Key? key}) : super(key: key);

  @override
  State<FaceScanScreen> createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {
  bool face_scan_enabled = false;
  bool finger_print_enabled = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: Common_decoration(),
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
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
              "Face Scan",
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () async {
                  String socail_sign = await PreferenceManager().getPref(URLConstants.socail_signup);

                  // Get.to(SubscriptionScreen());
                  (socail_sign == 'true'
                      ? Get.to(WelcomeVideoScreen2(signup: true,))
                      : Get.to(WelcomeVideoScreen(signup: true,)));
                  // Get.to(WelcomeVideoScreen(signup: true,));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    'Skip',
                    textAlign: TextAlign.center,
                    style: FontStyleUtility.h14(
                        fontColor: ColorUtils.primary_grey, family: 'PR'),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 49,
                      width: 170,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Image.asset(AssetUtils.Logo_white_icon)),
                  Container(
                    decoration: Common_reverse_decoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 17.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          HexColor("#020204").withOpacity(1),
                                          HexColor("#36393E").withOpacity(1),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: HexColor('#2E2E2D'),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        ),
                                        BoxShadow(
                                          color: HexColor('#04060F'),
                                          offset: Offset(10, 10),
                                          blurRadius: 20,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      AssetUtils.secure_sheild_icon,
                                      height: 15,
                                      color: ColorUtils.primary_grey,
                                      width: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 11.8,
                                ),
                                Text(
                                  'Fast and Secure login',
                                  style: FontStyleUtility.h16(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PR'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            height: 1,
                            color: ColorUtils.light_black,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                face_scan_enabled =
                                    (face_scan_enabled ? false : true);
                              });
                              (face_scan_enabled
                                  ? print('facescan enabled')
                                  : print('disabled'));
                              authentication_method(context);

                              // Get.to(DashboardScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      HexColor("#020204").withOpacity(1),
                                      HexColor("#36393E").withOpacity(1),
                                    ],
                                  ),
                                  border: (face_scan_enabled
                                      ? Border.all(
                                          color: ColorUtils.primary_gold,
                                          width: 2)
                                      : Border.all(
                                          color: Colors.transparent, width: 0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor('#04060F'),
                                      offset: Offset(3, 3),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  AssetUtils.Face_unlock_icon,
                                  color: ColorUtils.primary_grey,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text('OR',
                                style: FontStyleUtility.h14(
                                    fontColor: ColorUtils.primary_grey,
                                    family: 'PR')),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                finger_print_enabled =
                                    (finger_print_enabled ? false : true);
                              });
                              authentication_method(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      HexColor("#020204").withOpacity(1),
                                      HexColor("#36393E").withOpacity(1),
                                    ],
                                  ),
                                  border: (finger_print_enabled
                                      ? Border.all(
                                          color: ColorUtils.primary_gold,
                                          width: 2)
                                      : Border.all(
                                          color: Colors.transparent, width: 0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor('#04060F'),
                                      offset: Offset(3, 3),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Stack(children: [
                                    Opacity(
                                        child: Image.asset(
                                          AssetUtils.Finger_print_icon,
                                          color: Colors.white,
                                          height: 80,
                                          width: 80,
                                        ),
                                        opacity: 0.2),
                                    ClipRect(
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5.0, sigmaY: 5.0),
                                            child: Image.asset(
                                              AssetUtils.Finger_print_icon,
                                              color: Colors.black,
                                              height: 80,
                                              width: 80,
                                            )))
                                  ])),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 1,
                            color: ColorUtils.light_black,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 17.5, horizontal: 30),
                            child: Text(
                                'Add face recognition or thumb for fast login',
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: FontStyleUtility.h14(
                                    fontColor: ColorUtils.primary_grey,
                                    family: 'PR')),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            height: 1,
                            color: ColorUtils.light_black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> authentication_method(BuildContext context) async {
    // showLoader(context);
    await PreferenceManager().setbool(URLConstants.authentication_enable, true);
    CommonWidget().showToaster(msg: 'Authentication added');
    // Timer(Duration(seconds: 3), () async {
    // Get.to(FrontScreen());
    // hideLoader(context);
    String socail_sign = await PreferenceManager().getPref(URLConstants.socail_signup);

    (socail_sign == 'true'
        ? Get.to(WelcomeVideoScreen2(signup: true,))
        : Get.to(WelcomeVideoScreen(signup: true,)));


    // });   N

    (finger_print_enabled ? print('facescan enabled') : print('disabled'));
  }
}
