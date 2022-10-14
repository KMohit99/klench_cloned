
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:klench_/utils/page_loader.dart';

import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import '../model/pee_get_model.dart';
import '../model/pee_post_model.dart';
import 'dart:convert' as convert;

class PeeScreenController extends GetxController {
  int sets = 0;

  PeePostModel? peePostModel;
  Future<dynamic> Pee_post_API(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // try {
    //
    // } catch (e) {
    //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // }
    // isLoading(true);
    showLoader(context);
    String idUser = await PreferenceManager().getPref(URLConstants.id);

    Map data = {
      'userId': idUser,
      'sets': "1",
      'createdDate' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.pee_post);
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
      // peePostModel = PeePostModel.fromJson(data);
      print(peePostModel);
      if (data["error"] == false) {
        // CommonWidget().showToaster(msg: peePostModel!.message!);
        hideLoader(context);
      } else {
        hideLoader(context);
        // CommonWidget().showErrorToaster(msg: peePostModel!.message!);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }


  PeeGetModel? peeGetModel;
  RxBool isLoading = true.obs;
  // var getUSerModelList = M_ScreenGetModel().obs;

  Future<dynamic> Pee_get_API(BuildContext context) async {

    debugPrint('Inside creator get email');
    isLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url = "${URLConstants.base_url}${URLConstants.pee_get}?userId=$id_user";
    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Purchase ${e.toString()}');
    // }
    showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      peeGetModel = PeeGetModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (peeGetModel!.error == false) {
        isLoading(false);
        hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${peeGetModel!.data!.length}');
        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // await Get.to(Dashboard());
        // CommonWidget().showToaster(msg: peeGetModel!.message!);

        return peeGetModel;
      } else {
        isLoading(true);

        hideLoader(context);

        // CommonWidget().showToaster(msg: peeGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {
      isLoading(true);
      hideLoader(context);
      CommonWidget().showToaster(msg: peeGetModel!.message!);
    } else if (response.statusCode == 401) {
      isLoading(true);
      hideLoader(context);
      CommonWidget().showToaster(msg: peeGetModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }


  }

}
