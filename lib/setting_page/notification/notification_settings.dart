import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/setting_page/notification/Display_reminder.dart';
import 'package:klench_/setting_page/notification/reminder_notification.dart';
import 'package:klench_/setting_page/notification/upcoming_notification.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../../front_page/FrontpageScreen.dart';
import '../../utils/Common_textfeild.dart';
import '../../utils/TextStyle_utils.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {}
  bool _switchValue = true;
  bool _switchValue2 = true;

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
        child: Container(
          height: screenHeight,
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
                          // GestureDetector(
                          //   onTap: (){
                          //     Get.to(UpcomingNotification());
                          //   },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         alignment: Alignment.centerLeft,
                          //         margin: EdgeInsets.only(top: 0, bottom: 0),
                          //         child: Text(
                          //           'Upcoming notification',
                          //           style: FontStyleUtility.h14(
                          //               fontColor: ColorUtils.primary_grey,
                          //               family: 'PM'),
                          //         ),
                          //       ),
                          //       Container(
                          //         child: Icon(
                          //           Icons.arrow_forward_ios,
                          //           size: 15,
                          //           color: ColorUtils.primary_grey,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          // GestureDetector(
                          //   onTap: (){
                          //     Get.to(ReminderNotification());
                          //   },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         alignment: Alignment.centerLeft,
                          //         margin: EdgeInsets.only(top: 0, bottom: 0),
                          //         child: Text(
                          //           'Reminder notification',
                          //           style: FontStyleUtility.h14(
                          //               fontColor: ColorUtils.primary_grey,
                          //               family: 'PM'),
                          //         ),
                          //       ),
                          //       Container(
                          //         child: Icon(
                          //           Icons.arrow_forward_ios,
                          //           size: 15,
                          //           color: ColorUtils.primary_grey,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          // GestureDetector(
                          //   onTap: (){
                          //     Get.to(DisplayReminder());
                          //   },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         alignment: Alignment.centerLeft,
                          //         margin: EdgeInsets.only(top: 0, bottom: 0),
                          //         child: Text(
                          //           'Display reminder',
                          //           style: FontStyleUtility.h14(
                          //               fontColor: ColorUtils.primary_grey,
                          //               family: 'PM'),
                          //         ),
                          //       ),
                          //       Container(
                          //         child: Icon(
                          //           Icons.arrow_forward_ios,
                          //           size: 15,
                          //           color: ColorUtils.primary_grey,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0, bottom: 0),
                                child: Text(
                                  'Push notification',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PM'),
                                ),
                              ),
                              Container(
                                width: 20,
                                child: Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    trackColor: HexColor('#717171'),
                                    thumbColor: Colors.black87,
                                    activeColor: ColorUtils.primary_gold,
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0, bottom: 0),
                                child: Text(
                                  'When new feature added in app',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PM'),
                                ),
                              ),
                              Container(
                                width: 20,
                                child: Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    trackColor: HexColor('#717171'),
                                    thumbColor: Colors.black87,
                                    activeColor: ColorUtils.primary_gold,
                                    value: _switchValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue2 = value;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 13,
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
}
