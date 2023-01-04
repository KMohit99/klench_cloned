import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:klench_/homepage/Breathing_screen.dart';
import 'package:klench_/homepage/kegel_screen.dart';
import 'package:klench_/utils/page_loader.dart';

import '../../main.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import '../alarm_info.dart';
import '../model/IntroVideoModel.dart';
import '../model/getTechniqueModel.dart';
import '../model/kegelGetAlarmModel.dart';
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

  RxBool isinfoLoading = true.obs;
  GetTechniqueModel? KegelTechniqueModel;
  GetTechniqueModel? PeeTechniqueModel;
  GetTechniqueModel? MasturbationTechniqueModel;
  GetTechniqueModel? WarmupTechniqueModel;
  GetTechniqueModel? BreathingTechniqueModel;

  Future<dynamic> Kegel_technique_API({required BuildContext context,required String method}) async {
    isinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
    // "${URLConstants.base_url}${URLConstants.kegel_technique}";
        "${URLConstants.base_url}$method";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      KegelTechniqueModel = GetTechniqueModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (KegelTechniqueModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${KegelTechniqueModel!.data!}');
        isinfoLoading(false);

        return KegelTechniqueModel;
      } else {
        isinfoLoading(false);

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
  Future<dynamic> pee_technique_API({required BuildContext context,required String method}) async {
    isinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
    // "${URLConstants.base_url}${URLConstants.kegel_technique}";
        "${URLConstants.base_url}$method";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      PeeTechniqueModel = GetTechniqueModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (PeeTechniqueModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${PeeTechniqueModel!.data!}');
        isinfoLoading(false);

        return PeeTechniqueModel;
      } else {
        isinfoLoading(false);

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
  Future<dynamic> warmup_technique_API({required BuildContext context,required String method}) async {
    isinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
    // "${URLConstants.base_url}${URLConstants.kegel_technique}";
        "${URLConstants.base_url}$method";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      WarmupTechniqueModel = GetTechniqueModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (WarmupTechniqueModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${WarmupTechniqueModel!.data!}');
        isinfoLoading(false);

        return WarmupTechniqueModel;
      } else {
        isinfoLoading(false);

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
  Future<dynamic> masturbation_technique_API({required BuildContext context,required String method}) async {
    isinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
    // "${URLConstants.base_url}${URLConstants.kegel_technique}";
        "${URLConstants.base_url}$method";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      MasturbationTechniqueModel = GetTechniqueModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (MasturbationTechniqueModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${MasturbationTechniqueModel!.data!}');
        isinfoLoading(false);

        return MasturbationTechniqueModel;
      } else {
        isinfoLoading(false);

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
  Future<dynamic> breathing_technique_API({required BuildContext context,required String method}) async {
    isinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
    // "${URLConstants.base_url}${URLConstants.kegel_technique}";
        "${URLConstants.base_url}$method";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      BreathingTechniqueModel = GetTechniqueModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (BreathingTechniqueModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${BreathingTechniqueModel!.data!}');
        isinfoLoading(false);

        return BreathingTechniqueModel;
      } else {
        isinfoLoading(false);

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

  KegelGetAlarmModel? kegelGetAlarmModel;
  RxBool isAlarmLoading = true.obs;

  Future<dynamic> Kegel_alarm_get_API(BuildContext context) async {
    isAlarmLoading(true);
    print('2-2-2-2-2-2 Inside the Get UserInfo Controller Details ');
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
        "${URLConstants.base_url}${URLConstants.kegel_alarm_get}?user_id=$id_user";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      kegelGetAlarmModel = KegelGetAlarmModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (kegelGetAlarmModel!.error == false) {
        // hideLoader(context);
        isAlarmLoading(false);

        for (var i = 0; i < kegelGetAlarmModel!.data!.length; i++) {
          if (Platform.isAndroid) {
            final String dateTimeString =
                "${kegelGetAlarmModel!.data![i].alarmTime}";
            final DateFormat format = new DateFormat("hh:mm");
            print(
                "format.parse(dateTimeString) ${format.parse(dateTimeString).minute}");
            print(
                "format.parse(dateTimeString) ${format.parse(dateTimeString).hour}");

            FlutterAlarmClock.createAlarm(format.parse(dateTimeString).hour,
                format.parse(dateTimeString).minute,
                title: 'Kegel ${(i + 1)}');
          } else {}
        }

        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${kegelGetAlarmModel!.data!.length}');
        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // await Get.to(Dashboard());
        // isuserinfoLoading(false);

        return kegelGetAlarmModel;
      } else {
        // isuserinfoLoading(true);
        isAlarmLoading(false);

        // hideLoader(context);

        // CommonWidget().showToaster(msg: kegelGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {
      // hideLoader(context);
      isAlarmLoading(false);

      CommonWidget().showToaster(msg: kegelGetModel!.message!);
    } else if (response.statusCode == 401) {
      // hideLoader(context);
      isAlarmLoading(false);

      CommonWidget().showToaster(msg: kegelGetModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }
  }

  KegelPostModel? kegelPostModel;
  String? start_time;

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
    print("sets");
    print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
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
    await click_alarm(
        alarm_info: "It's time for Breathing exercise", route: KegelRoute);
    // await Kegel_get_API(context);
    // if (kegel_performed) {
    //   Future.delayed(Duration(hours: 2), () async {
    //     await click_alarm(
    //         alarm_info: "It's time for kegel exercise", route: KegelRoute);
    //   });
    // } else {
    //   if (kegelGetModel!.error == false) {
    //     if (int.parse(
    //             kegelGetModel!.data![kegelGetModel!.data!.length - 1].sets!) <=
    //         3) {
    //       print("sets incomplete");
    //       print("sets incomplete");
    //       Timer.periodic(const Duration(minutes: 30), (timer) async {
    //         //code to run on every 5 seconds
    //         await click_alarm(
    //             alarm_info: "It's time for kegel exercise", route: KegelRoute);
    //       });
    //     }
    //   } else {
    //     print("Wait forr 2 hoursssssssssssssss");
    //     Timer.periodic(const Duration(minutes: 30), (timer) async {
    //       //code to run on every 5 seconds
    //       await click_alarm(
    //           alarm_info: "It's time for kegel exercise", route: KegelRoute);
    //
    //     });
    //   }
    // }
    print("inside Breathing");
    // Timer.periodic(const Duration(hours: 2, minutes: 16), (timer) async {
    //   //code to run on every 5 seconds
    //   await click_alarm(
    //       alarm_info: "It's time for Breathing exercise",
    //       route: BreathingRoute);
    // });
  }

  DateTime? _alarmTime;

  Future<void> click_alarm({required String alarm_info, required route}) async {
    _alarmTime = DateTime.now();
    DateTime arch = DateTime.parse("2022-08-15 00:25:24");
    print("DateFormat('EEEE').format(arch)"); // Sunday
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

  Future<dynamic> update_notified_status(
      {required BuildContext context, required String status}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // showLoader(context);
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    Map data = {
      'userId': id_user,
      'notified_status': status
      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);
    var url = (URLConstants.base_url + URLConstants.update_notified_status);
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
        // CommonWidget().showToaster(msg: data["message"]);
        // hideLoader(context);
      } else {
        // hideLoader(context);
        CommonWidget().showErrorToaster(msg: data["message"]);
      }
    } else {}
  }

  IntroVideoModel? introVideoModel;
  List<File> imgFile_list = [];

  Future<dynamic> IntroVideo_get_API(BuildContext context) async {
    print('Inside creator get email');
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    print("UserID $id_user");
    String url = "${URLConstants.base_url}${URLConstants.intro_video_get}";
    var response = await http.get(Uri.parse(url));
    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      introVideoModel = IntroVideoModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (introVideoModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${introVideoModel!.data!.length}');
        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // await Get.to(Dashboard());
        for (int i = 0; i < introVideoModel!.data!.length; i++) {
          // final uint8list = await VideoThumbnail.thumbnailFile(
          //   video:
          //       ("http://foxyserver.com/funky/video/${introVideoModel!.data![i].uploadVideo}"),
          //   thumbnailPath: (await getTemporaryDirectory()).path,
          //   imageFormat: ImageFormat.PNG,
          //   // maxHeight: 64,
          //   // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
          //   quality: 30,
          // );
          // print(uint8list);
          //
          // imgFile_list.add(File(uint8list!));
          // print("imgFile_list[i] ${imgFile_list[i]}");
          // hideLoader(context);
          // print("test----------${imgFile_list[i].path}");
        }

        return introVideoModel;
      } else {
        // hideLoader(context);

        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: introVideoModel!.message!);
    } else if (response.statusCode == 401) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: introVideoModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }
  }
}
