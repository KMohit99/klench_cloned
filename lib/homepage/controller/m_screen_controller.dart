import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klench_/homepage/model/m_screen_weekly_data_model.dart';

// import 'package:get/get.dart';
import 'package:klench_/utils/page_loader.dart';

import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import '../../utils/page_loader.dart';
import '../m_screen.dart';
import '../model/breathing_post_model.dart';
import '../model/m_Screen_data_delete_Model.dart';
import '../model/m_Screen_data_edit_Model.dart';
import '../model/m_screen_get_model.dart';
import '../model/m_screen_post_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Masturbation_screen_controller {
  M_ScreenPostModel? masturbationPostModel;
  final Dio _dio = Dio();

  TextEditingController method_new_name = new TextEditingController();
  List<methods_list> method_list = <methods_list>[
    methods_list(method_name: "Hand",color:  '#FF0000'),
    methods_list(method_name: "Dildo",color:  "#0000FF"),
    methods_list(method_name: "Sex",color:  "#00FF00"),
    methods_list(method_name: "Fleshlight",color:  "#A020F0"),
  ];

  Future<dynamic> m_method_post_API({
    required BuildContext context,
    required List<ListMethodClass> method_data,
    required String pauses,
  }) async {
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    // print


    // showLoader(context);
    var url = (URLConstants.base_url + URLConstants.masturbation_post);
    // var request = http.MultipartRequest('POST', Uri.parse(url));

    // request.fields['userId'] = id_user;
    // List<MultipartFile> methodname_list = <MultipartFile>[];
    // List<MultipartFile> pauses_list = <MultipartFile>[];
    // List<MultipartFile> totalTime_list = <MultipartFile>[];
    //
    // for (var i = 0; i < method_data.length; i++) {
    //   dynamic multipartFile =
    //       MultipartFile.fromString(method_data[i].method_name!);
    //   dynamic multipartFile2 = MultipartFile.fromString(method_data[i].pauses!);
    //   dynamic multipartFile3 =
    //       MultipartFile.fromString(method_data[i].total_time!);
    //   methodname_list.add(multipartFile);
    //   pauses_list.add(multipartFile2);
    //   totalTime_list.add(multipartFile3);
    // }
    print("mohitttttt : $pauses");

    var formData = FormData.fromMap({
      'userId': id_user,
      // 'methods[]': [
      //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
      //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
      // ],
      'methodName[]': method_data[method_data.length - 1].method_name,
      'pauses[]': method_data[method_data.length - 1].pauses,
      // .map((item) => MultipartFile.fromString(item.pauses!))
      // .toList(),
      'totalPauses[]': method_data[method_data.length - 1].pauses,
      // .map((item) => MultipartFile.fromString(item.pauses!))
      // .toList(),
      'totalTime[]': method_data[method_data.length - 1].total_time,
      'colorCode[]': method_data[method_data.length - 1].color,
      'pauses_time' : pauses.toString(),
      // .map((item) => MultipartFile.fromString(item.total_time!))
      // .toList(),
    });
    print("Data ${formData}");
    var response = await _dio.post(url, data: formData);
    print("Response $response");
    // var response = await request.send();
    // var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = (response.data);
      print("data :${data}");
      masturbationPostModel = M_ScreenPostModel.fromJson(response.data);
      // print(breathingPostModel);
      if (masturbationPostModel!.error == false) {
        // await PreferenceManager()
        //     .setPref(URLConstants.id, signUpModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        await CommonWidget().showToaster(msg: masturbationPostModel!.message!);

        // hideLoader(context);
      } else {
        // hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
        // print('Please try again');
        // print('Please try again');
      }
      // hideLoader(context);
    } else {
      print("ERROR");
    }

    // debugPrint('0-0-0-0-0-0-0 username');
    // // try {
    // //
    // // } catch (e) {
    // //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // // }
    // // isLoading(true);
    // // showLoader(context);
    // String id_user = await PreferenceManager().getPref(URLConstants.id);
    //
    // List<dynamic> ProductItems = [];
    // print(method_data.length);
    // for (int i = 0; i < method_data.length; i++) {
    //   // List PauseItems = [];
    //   // print("pause length${method_data[i].pauses}");
    //   // for (int j = 0; j < method_data[i].pauses!.length; j++) {
    //   //   {
    //   //     Map products1 = {
    //   //       "pauses" : method_data[j].pauses,
    //   //     };
    //   //     PauseItems.add(products1);
    //   //   }
    //   // }
    //   Map<String, String> products = {
    //     // "id": '',
    //     "methodName": method_data[i].method_name!,
    //     "pauses": method_data[i].pauses!,
    //     "totalPauses": method_data[i].pauses!,
    //     "totalTime": method_data[i].total_time!,
    //   };
    //   ProductItems.add(products);
    // }
    //
    // Map<dynamic, dynamic> data = {
    //   'userId': id_user,
    //   'methods': ProductItems,
    //   // 'type': login_type,
    // };
    //
    // // var usersDataFromJson = parsedJson['data'];
    // // List<String> userData = List<String>.from(usersDataFromJson);
    //
    // print(data);
    // String body = json.encode(data);
    //
    // var url = (URLConstants.base_url + URLConstants.masturbation_post);
    // print("url : $url");
    // print("body : $data");
    //
    // var response = await http.post(
    //   Uri.parse(url),
    //   body: data,
    // );
    // print(response.body);
    // print(response.request);
    // print(response.statusCode);
    // // var final_data = jsonDecode(response.body);
    //
    // // print('final data $final_data');
    // if (response.statusCode == 200) {
    //   // isLoading(false);
    //   var data = jsonDecode(response.body);
    //   // breathingPostModel = BreathingPostModel.fromJson(data);
    //   // print(breathingPostModel);
    //   if (data["error"] == false) {
    //     CommonWidget().showToaster(msg: data["message"]);
    //
    //     // hideLoader(context);
    //   } else {
    //     hideLoader(context);
    //     CommonWidget().showErrorToaster(msg: data["message"]);
    //     print('Please try again');
    //     print('Please try again');
    //   }
    // } else {}
  }

  M_ScreenGetModel? m_screenGetModel;

  // var getUSerModelList = M_ScreenGetModel().obs;

  Future<dynamic> MasturbationData_get_API(BuildContext context) async {
    print('Inside creator get email');
    showLoader(context);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    print("UserID $id_user");
    String url =
        "${URLConstants.base_url}${URLConstants.masturbation_get}?userId=$id_user";
    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Purchase ${e.toString()}');
    // }

    http.Response response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = convert.jsonDecode(response.body);
      m_screenGetModel = M_ScreenGetModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (m_screenGetModel!.error == false) {
        hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenGetModel!.data!.length}');
        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // await Get.to(Dashboard());
        // CommonWidget().showToaster(msg: m_screenGetModel!.message!);

        return m_screenGetModel;
      } else {
        hideLoader(context);

        // CommonWidget().showToaster(msg: m_screenGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {
      hideLoader(context);
      CommonWidget().showToaster(msg: m_screenGetModel!.message!);
    } else if (response.statusCode == 401) {
      hideLoader(context);
      CommonWidget().showToaster(msg: m_screenGetModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }
  }

  M_ScreenWeeklyDataModel? m_screenWeeklyDataModel;

  // var getUSerModelList = M_ScreenGetModel().obs;
  var x_axis = ["M", "T", "W", "T", "F", "S", "S"];
  List<ChartData> gst_payable_list = [];

  Future MasturbationWeekly_Data_get_API(BuildContext context) async {
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    var url =
        "${URLConstants.base_url}${URLConstants.masturbation_get_weekly_data}?userId=$id_user";

    try {
      showLoader(context);
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // var data = convert.jsonDecode(response.body);
        Map<String, dynamic> data =
            json.decode(response.body.replaceAll('}[]', '}'));
        print("Data: ${data['data']}");
        m_screenWeeklyDataModel = M_ScreenWeeklyDataModel.fromJson(data);
        // getUSerModelList(userInfoModel_email);
        if (m_screenWeeklyDataModel!.error == false) {
          hideLoader(context);
          debugPrint(
              '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenWeeklyDataModel!.data!.length}');
          // CommonWidget().showToaster(msg: breathingGetModel!.message!);
          // CommonWidget().showToaster(msg: data["success"].toString());
          // await Get.to(Dashboard());
          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          //
          // for (var i = 0; i < m_screenWeeklyDataModel!.data!.length; i++) {
          //   // x_axis = data_sales[i]["month"];
          //   var y1 = double.parse(
          //       m_screenWeeklyDataModel!.data![0].days![i]);
          //   // var y2 = data_gst_receivable[i]['value'];
          //   // var y3 =
          //   gst_payable_list.add(ChartData(
          //     x_axis[i],
          //     y1,
          //     y1,
          //     y1,
          //   ));
          // }
          print("gst_payable_list");
          print(gst_payable_list);

          return m_screenWeeklyDataModel;
        } else {
          hideLoader(context);

          CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          return null;
        }
      } else if (response.statusCode == 422) {
        hideLoader(context);
        CommonWidget().showToaster(msg: m_screenGetModel!.message!);
      } else if (response.statusCode == 401) {
        hideLoader(context);
        CommonWidget().showToaster(msg: m_screenGetModel!.message!);
      } else {
        // CommonWidget().showToaster(msg: msg.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }

  M_ScreenDeleteModel? m_screenDeleteModel;

  Future<dynamic> MasturbationData_delete_API(
      {required BuildContext context, required String methodId}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'id': methodId,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.masturbation_method_delete);
    print("url : $url");
    print("body : $data");

    var response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    print(response.request);
    print(response.statusCode);
    // var final_data = jsonDecode(response.body);

    // print('final data $final_data');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      m_screenDeleteModel = M_ScreenDeleteModel.fromJson(data);
      print(m_screenDeleteModel);
      if (m_screenDeleteModel!.error == false) {
        CommonWidget().showToaster(msg: m_screenDeleteModel!.message!);
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: m_screenDeleteModel!.message!);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }

  M_ScreenEditModel? m_screenEditModel;
  Future<dynamic> MasturbationData_edit_API(
      {required BuildContext context, required String methodId}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'id': methodId,
      'methodName' : method_new_name.text
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.masturbation_method_edit);
    print("url : $url");
    print("body : $data");

    var response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    print(response.request);
    print(response.statusCode);
    // var final_data = jsonDecode(response.body);

    // print('final data $final_data');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      m_screenEditModel = M_ScreenEditModel.fromJson(data);
      print(m_screenEditModel);
      if (m_screenEditModel!.error == false) {
        CommonWidget().showToaster(msg: m_screenEditModel!.message!);
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: m_screenEditModel!.message!);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }



}
