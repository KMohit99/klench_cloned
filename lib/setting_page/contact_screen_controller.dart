
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klench_/setting_page/setting_screen.dart';

import '../utils/UrlConstrant.dart';
import '../utils/common_widgets.dart';
import '../utils/page_loader.dart';
import 'package:http/http.dart' as http;

import 'contact_post_model.dart';

class ConactScreenController extends GetxController {
  int sets = 0;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController reasonsController = TextEditingController();

  ContactPostModel? contactPostModel;

  Future<dynamic> ContactUsPostApi({required BuildContext context}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // isLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'username': usernameController.text,
      'email': emailController.text,
      'reasion': reasonsController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.contact_post);
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);

      var data = jsonDecode(response.body);
      contactPostModel = ContactPostModel.fromJson(data);
      print(contactPostModel);
      if (contactPostModel!.error == false) {
        hideLoader(context);

       await CommonWidget().showToaster(msg: contactPostModel!.message!);
       usernameController.clear();
       emailController.clear();
       reasonsController.clear();
       // await Get.to(SettingScreen());
      }
      else {
        CommonWidget().showToaster(msg: contactPostModel!.message!);

        hideLoader(context);
        // CommonWidget().showToaster(msg: 'Error');
        return null;
      }
    } else if (response.statusCode == 422) {
      hideLoader(context);
      CommonWidget().showToaster(msg: contactPostModel!.message!);

      // CommonWidget().showToaster(msg: userInfoModel!.message!);
    } else if (response.statusCode == 401) {
      hideLoader(context);
      CommonWidget().showToaster(msg: contactPostModel!.message!);

      // CommonWidget().showToaster(msg: userInfoModel!.message!);

    } else {
      CommonWidget().showToaster(msg: contactPostModel!.message!);

      hideLoader(context);
      // CommonWidget().showToaster(msg: userInfoModel!.message!);

    }
  }

}