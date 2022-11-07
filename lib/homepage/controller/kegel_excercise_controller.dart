import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/homepage/Breathing_screen.dart';
import 'package:klench_/homepage/kegel_screen.dart';
import 'package:klench_/utils/page_loader.dart';

import '../../main.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../alarm_info.dart';
import '../model/kegel_get_model.dart';
import '../model/kegel_post_model.dart';

class Kegel_controller extends GetxController {
  int sets = 0;

  RxBool isuserinfoLoading = true.obs;
  KegelGetModel? kegelGetModel;
  var getUSerModelList = KegelGetModel().obs;

  Future<dynamic> Kegel_get_API(BuildContext context) async {
    isuserinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
        "${URLConstants.base_url}${URLConstants.kegel_get}?userId=$id_user";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
          json.decode(response.body.replaceAll('}[]', '}'));
      kegelGetModel = KegelGetModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (kegelGetModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${kegelGetModel!.data!.length}');
        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // await Get.to(Dashboard());
        isuserinfoLoading(false);

        return kegelGetModel;
      } else {
        isuserinfoLoading(true);

        // hideLoader(context);

        // CommonWidget().showToaster(msg: kegelGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {
      // hideLoader(context);

      CommonWidget().showToaster(msg: kegelGetModel!.message!);
    } else if (response.statusCode == 401) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: kegelGetModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }
  }

  KegelPostModel? kegelPostModel;
  String? start_time ;

  Future<dynamic> Kegel_post_API(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // try {
    //
    // } catch (e) {
    //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // }
    // isLoading(true);
    showLoader(context);
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    print(sets);
    print(sets);
    print(sets);
    Map data = {
      'userId': id_user,
      'sets': '1',
      'numberOf_sets': '1',
      'createdDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'startTime': start_time,
      'finishTime': DateFormat('HH:mm').format(DateTime.now()),
      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);
    var url = (URLConstants.base_url + URLConstants.kegel_post);
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
      // kegelPostModel = KegelPostModel.fromJson(data);
      // print(kegelPostModel);
      if (data["error"] == false) {
        CommonWidget().showToaster(msg: data["message"]);
        await Kegel_get_API(context);
        start_time = "";
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: data["message"]);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }

  bool kegel_performed = false;

  Future<void> alarm_notifications(BuildContext context) async {
    // Timer.periodic(Duration(minutes: 30), () {
    //   click_alarm(alarm_info: "It's time for kegel exercise");
    // });
    Future.delayed(Duration(seconds: 2), () async {
      await click_alarm(
          alarm_info: "It's time for Kegel exercise", route: KegelRoute);
    });
    await Kegel_get_API(context);
    if (kegel_performed) {
      Future.delayed(Duration(hours: 2), () async {
        await click_alarm(
            alarm_info: "It's time for kegel exercise", route: KegelRoute);
      });
    } else {
      if (kegelGetModel!.error == false) {
        if (int.parse(
                kegelGetModel!.data![kegelGetModel!.data!.length - 1].sets!) <=
            3) {
          print("sets incomplete");
          print("sets incomplete");
          Timer.periodic(const Duration(minutes: 30), (timer) async {
            //code to run on every 5 seconds
            await click_alarm(
                alarm_info: "It's time for kegel exercise", route: KegelRoute);
          });
        }
      } else {
        print("Wait forr 2 hoursssssssssssssss");
        Timer.periodic(const Duration(minutes: 30), (timer) async {
          //code to run on every 5 seconds
          await click_alarm(
              alarm_info: "It's time for kegel exercise", route: KegelRoute);

        });
      }
    }
    print("inside Breathing");
    Timer.periodic(const Duration(hours: 2, minutes: 16), (timer) async {
      //code to run on every 5 seconds
      await click_alarm(
          alarm_info: "It's time for Breathing exercise",
          route: BreathingRoute);
    });
  }

  DateTime? _alarmTime;

  Future<void> click_alarm({required String alarm_info, required route}) async {
    _alarmTime = DateTime.now();
    DateTime arch = DateTime.parse("2022-08-15 00:25:24");
    print(DateFormat('EEEE').format(arch)); // Sunday

    DateTime scheduleAlarmDateTime;
    // if (_alarmTime!.isAfter(DateTime.now())) {
    scheduleAlarmDateTime = DateTime.now().add(Duration(seconds: 3));
    // } else {
    //   scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    // }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: 1,
      title: alarm_info,
    );
    // _alarmHelper.insertAlarm(alarmInfo);
    await scheduleAlarm(scheduleAlarmDateTime, alarmInfo, route);
    // Alarm_title.clear();
    // Navigator.pop(context);
    // loadAlarms();
  }

  Future<void> scheduleAlarm(DateTime scheduledNotificationDateTime,
      AlarmInfo alarmInfo, route) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      // 'Channel for Alarm notification',
      icon: 'app_icon',
      enableVibration: true,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound("a_long_cold_sting"),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        sound: "a_long_cold_sting.wav",
        presentAlert: true,
        presentBadge: true,
        threadIdentifier: 'thread_id',
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Klench Exercise',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: route);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  Future<dynamic> KegelRoute(String? payload) async {
    print("indise navigationn");
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => KegelScreen()),
    // );
    Get.to(KegelScreen());
  }

  Future<dynamic> BreathingRoute(String? payload) async {
    print("navigationn");
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => KegelScreen()),
    // );
    Get.to(BreathingScreen());
  }
}
