import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:klench_/utils/page_loader.dart';

import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import '../model/breathing_get_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/breathing_post_model.dart';

class Breathing_controller extends GetxController {

  int sets = 0;

  RxBool isuserinfoLoading = true.obs;
  BreathingGetModel? breathingGetModel;
  var getUSerModelList = BreathingGetModel().obs;

  Future<dynamic> Breathing_get_API(BuildContext context) async {

    print('Inside creator get email');
    isuserinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    print("UserID $id_user");
    String url = "${URLConstants.base_url}${URLConstants.breathing_get}?userId=$id_user";
    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Purchase ${e.toString()}');
    // }
    // showLoader(context);
    var response = await http.get(Uri.parse(url));
    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      breathingGetModel = BreathingGetModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (breathingGetModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${breathingGetModel!.data!.length}');
        isuserinfoLoading(false);
        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // await Get.to(Dashboard());

        return breathingGetModel;
      } else {
        // hideLoader(context);

        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: breathingGetModel!.message!);
    } else if (response.statusCode == 401) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: breathingGetModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }


  }

  BreathingPostModel? breathingPostModel;
  Future<dynamic> Breathing_post_API(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // try {
    //
    // } catch (e) {
    //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // }
    // isLoading(true);
    showLoader(context);
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    Map data = {
      'userId': id_user,
      'sets': "1",
      'numberOf_sets': '1',

      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.breathing_post);
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
      // breathingPostModel = BreathingPostModel.fromJson(data);
      // print(breathingPostModel);
      if (data["error"] == false) {
        CommonWidget().showToaster(msg: data["message"]);

        hideLoader(context);

      } else {
        hideLoader(context);
        CommonWidget().showToaster(msg: data["message"]);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }


}