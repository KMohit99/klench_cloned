import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../utils/TextStyle_utils.dart';

class UpcomingNotification extends StatefulWidget {
  const UpcomingNotification({Key? key}) : super(key: key);

  @override
  State<UpcomingNotification> createState() => _UpcomingNotificationState();
}

class _UpcomingNotificationState extends State<UpcomingNotification> {
  @override
  void initState() {}
  bool _switchValue = true;
  bool _switchValue2 = true;
  DateTime? selected_date ;

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
          "Upcoming Notification",
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
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 0, bottom: 0),
                            child: Text(
                              'Set alarm for notification',
                              style: FontStyleUtility.h14(
                                  fontColor: ColorUtils.primary_grey,
                                  family: 'PR'),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    HexColor("#000000").withOpacity(1),
                                    HexColor("#04060F").withOpacity(1),
                                    HexColor("#000000").withOpacity(1),

                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: HexColor('#04060F'),
                                      offset: Offset(3, 3),
                                      blurRadius: 10)
                                ]),
                            child: Stack(
                              children: [
                                CupertinoTheme(
                                  data: CupertinoThemeData(
                                    brightness: Brightness.dark,
                                  ),
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.time,
                                    onDateTimeChanged: (DateTime value) {
                                      selected_date= value;
                                      print("${value.hour}:${value.minute}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0, bottom: 0),
                                child: Text(
                                  'Repeat',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PM'),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Weekdays',
                                      style: FontStyleUtility.h13(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PR'),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: ColorUtils.primary_grey,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0, bottom: 0),
                                child: Text(
                                  'Label',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PM'),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Morning Alarms',
                                      style: FontStyleUtility.h13(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PR'),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: ColorUtils.primary_grey,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0, bottom: 0),
                                child: Text(
                                  'Sound',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PM'),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Uplift',
                                      style: FontStyleUtility.h13(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PR'),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: ColorUtils.primary_grey,
                                    ),
                                  ],
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
        ),
      ),
    );
  }
}
