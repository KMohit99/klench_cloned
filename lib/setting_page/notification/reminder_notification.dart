import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/setting_page/notification/startEndModel.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';
import 'package:klench_/utils/common_widgets.dart';

import '../../utils/Common_buttons.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/UrlConstrant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ReminderNotification extends StatefulWidget {
  const ReminderNotification({Key? key}) : super(key: key);

  @override
  State<ReminderNotification> createState() => _ReminderNotificationState();
}

class _ReminderNotificationState extends State<ReminderNotification> {
  @override
  void initState() {}
  bool _switchValue = true;
  bool _switchValue2 = true;
  DateTime? start_time;

  DateTime? end_time;

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
          "Schedule Notification",
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
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
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
                            SizedBox(
                              height: 20,
                            ),
                            Container(
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
                              child: ExpansionTile(
                                iconColor: ColorUtils.primary_gold,
                                collapsedIconColor: ColorUtils.primary_gold,
                                title: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0,
                                        top: 15,
                                        right: 15,
                                        bottom: 15),
                                    child: Text(
                                      (start_time != null
                                          ? (DateFormat('hh:mm a')
                                              .format(start_time!))
                                          : "Start time"),
                                      textAlign: TextAlign.left,
                                      style: FontStyleUtility.h15(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PM'),
                                    ),
                                  ),
                                ),
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     gradient: LinearGradient(
                                    //       begin: Alignment.topCenter,
                                    //       end: Alignment.bottomCenter,
                                    //       colors: [
                                    //         HexColor("#000000").withOpacity(1),
                                    //         HexColor("#04060F").withOpacity(1),
                                    //         HexColor("#000000").withOpacity(1),
                                    //
                                    //       ],
                                    //     ),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //           color: HexColor('#04060F'),
                                    //           offset: Offset(3, 3),
                                    //           blurRadius: 10)
                                    //     ]),
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
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: HexColor('#04060F'),
                                      //       offset: Offset(3, 3),
                                      //       blurRadius: 10)
                                      // ]
                                    ),

                                    child: Stack(
                                      children: [
                                        CupertinoTheme(
                                          data: CupertinoThemeData(
                                            brightness: Brightness.dark,
                                          ),
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.time,
                                            onDateTimeChanged:
                                                (DateTime value) {
                                              setState(() {
                                                start_time = value;
                                              });
                                              print(
                                                  "${value.hour}:${value.minute}");
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
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
                              child: ExpansionTile(
                                iconColor: ColorUtils.primary_gold,
                                collapsedIconColor: ColorUtils.primary_gold,
                                title: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0,
                                        top: 15,
                                        right: 15,
                                        bottom: 15),
                                    child: Text(
                                      (end_time != null
                                          ? (DateFormat('hh:mm a')
                                              .format(end_time!))
                                          : "End time"),
                                      textAlign: TextAlign.left,
                                      style: FontStyleUtility.h15(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PM'),
                                    ),
                                  ),
                                ),
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //     gradient: LinearGradient(
                                    //       begin: Alignment.topCenter,
                                    //       end: Alignment.bottomCenter,
                                    //       colors: [
                                    //         HexColor("#000000").withOpacity(1),
                                    //         HexColor("#04060F").withOpacity(1),
                                    //         HexColor("#000000").withOpacity(1),
                                    //
                                    //       ],
                                    //     ),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //           color: HexColor('#04060F'),
                                    //           offset: Offset(3, 3),
                                    //           blurRadius: 10)
                                    //     ]),
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
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: HexColor('#04060F'),
                                      //       offset: Offset(3, 3),
                                      //       blurRadius: 10)
                                      // ]
                                    ),

                                    child: Stack(
                                      children: [
                                        CupertinoTheme(
                                          data: CupertinoThemeData(
                                            brightness: Brightness.dark,
                                          ),
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.time,
                                            onDateTimeChanged:
                                                (DateTime value) {
                                              setState(() {
                                                end_time = value;
                                              });
                                              print((DateFormat('HH:mm')
                                                  .format(end_time!)));
                                              // print(
                                              //     "${end_time!.hour}:${end_time!.minute}");
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       alignment: Alignment.centerLeft,
                            //       margin: EdgeInsets.only(top: 0, bottom: 0),
                            //       child: Text(
                            //         'Repeat',
                            //         style: FontStyleUtility.h14(
                            //             fontColor: ColorUtils.primary_grey,
                            //             family: 'PM'),
                            //       ),
                            //     ),
                            //     Container(
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             'Weekdays',
                            //             style: FontStyleUtility.h13(
                            //                 fontColor: ColorUtils.primary_grey,
                            //                 family: 'PR'),
                            //           ),
                            //           Icon(
                            //             Icons.arrow_forward_ios,
                            //             size: 15,
                            //             color: ColorUtils.primary_grey,
                            //           ),
                            //         ],
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       alignment: Alignment.centerLeft,
                            //       margin: EdgeInsets.only(top: 0, bottom: 0),
                            //       child: Text(
                            //         'Label',
                            //         style: FontStyleUtility.h14(
                            //             fontColor: ColorUtils.primary_grey,
                            //             family: 'PM'),
                            //       ),
                            //     ),
                            //     Container(
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             'Morning Alarms',
                            //             style: FontStyleUtility.h13(
                            //                 fontColor: ColorUtils.primary_grey,
                            //                 family: 'PR'),
                            //           ),
                            //           Icon(
                            //             Icons.arrow_forward_ios,
                            //             size: 15,
                            //             color: ColorUtils.primary_grey,
                            //           ),
                            //         ],
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       alignment: Alignment.centerLeft,
                            //       margin: EdgeInsets.only(top: 0, bottom: 0),
                            //       child: Text(
                            //         'Sound',
                            //         style: FontStyleUtility.h14(
                            //             fontColor: ColorUtils.primary_grey,
                            //             family: 'PM'),
                            //       ),
                            //     ),
                            //     Container(
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             'Uplift',
                            //             style: FontStyleUtility.h13(
                            //                 fontColor: ColorUtils.primary_grey,
                            //                 family: 'PR'),
                            //           ),
                            //           Icon(
                            //             Icons.arrow_forward_ios,
                            //             size: 15,
                            //             color: ColorUtils.primary_grey,
                            //           ),
                            //         ],
                            //       ),
                            //     )
                            //   ],
                            // ),
                            common_button_gold(
                              onTap: () async {
                                if (start_time != null && end_time != null) {
                                  await Start_End_notification_API(context);
                                  if(_startEndModel!.error == false){
                                    _scaleDialog(context: context, message: '');
                                  }
                                } else {
                                  CommonWidget().showErrorToaster(
                                      msg: "Please select start and end time");
                                }
                                // Get.to(SignInScreen());
                              },
                              title_text: 'Save',
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
      ),
    );
  }

  Future<void> _scaleDialog({
    required BuildContext context,
    required String message,
  }) async {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
            scale: curve,
            child: AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                elevation: 0.0,
                // title: Center(child: Text("Evaluation our APP")),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorUtils.primary_gold, width: 1),
                                // color: Colors.black.withOpacity(0.65),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  // stops: [0.1, 0.5, 0.7, 0.9],
                                  colors: [
                                    // HexColor("#000000").withOpacity(1),
                                    // HexColor("#000000").withOpacity(1),
                                    HexColor("#ce942f").withOpacity(1),

                                    HexColor("#ecdc8f").withOpacity(1),
                                    HexColor("#e5cc79").withOpacity(1),
                                    HexColor("#ce942f").withOpacity(1),
                                    // HexColor("#37393D").withOpacity(1),
                                    // ColorUtils.primary_gold.withOpacity(1),

                                    // HexColor("#000000").withOpacity(1),
                                    // ColorUtils.primary_gold.withOpacity(1),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: HexColor('#04060F'),
                                      offset: Offset(10, 10),
                                      blurRadius: 10)
                                ],
                                borderRadius: BorderRadius.circular(15)),
                            child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    // width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 5),
                                      child: Text(
                                        "You will receive notification between ${DateFormat('hh:mm a').format(start_time!)} and ${DateFormat('hh:mm a').format(end_time!)} only !",
                                        textAlign: TextAlign.center,
                                        style: FontStyleUtility.h16(
                                            fontColor: Colors.black,
                                            family: 'PM'),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 3, bottom: 3),
                            alignment: Alignment.topRight,
                            child: Container(
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
                                      // BoxShadow(
                                      //     color: HexColor('#04060F'),
                                      //     offset: Offset(0, 3),
                                      //     blurRadius: 5)
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    size: 20,
                                    color: ColorUtils.primary_grey,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ],
                )));
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  StartEndModel? _startEndModel;

  Future<dynamic> Start_End_notification_API(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // try {
    //
    // } catch (e) {
    //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // }
    // isLoading(true);
    // showLoader(context);
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    Map data = {
      'user_id': id_user,
      'start_time': DateFormat('HH:mm').format(start_time!),
      'end_time': DateFormat('HH:mm').format(end_time!),

      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);
    var url = (URLConstants.base_url + URLConstants.start_end_notification);
    print("url : $url");
    print("body : $data");

    var response = await http.post(
      Uri.parse(url),
      body: data,
    );
    print(response.body);
    print(response.request);
    print(response.statusCode);
    // var final_data = jsonDecode(response.body);

    // print('final data $final_data');
    if (response.statusCode == 200) {
      // isLoading(false);
      var data = jsonDecode(response.body);
      _startEndModel = StartEndModel.fromJson(data);
      // print(kegelPostModel);
      if (_startEndModel!.error == false) {
        CommonWidget().showToaster(msg: _startEndModel!.message!);
        return _startEndModel;
      } else {
        CommonWidget().showErrorToaster(msg: _startEndModel!.message!);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }
}
