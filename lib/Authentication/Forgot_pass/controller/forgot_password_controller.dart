import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/UrlConstrant.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/page_loader.dart';
import '../../SignUp/model/verifyOtpModel.dart';
import '../Otp_verification.dart';
import '../model/ForgotPassModel.dart';
import 'package:http/http.dart' as http;

import '../model/ResetPassModel.dart';
import '../password_reset.dart';

class ForgotPasswordController extends GetxController {

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController MobilenoController = TextEditingController();
  final TextEditingController OtpController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController ConfirmNewPasswordController = TextEditingController();
  String dialCodedigits = "+91";

  ForgotPasswordModel? forgotPasswordModel;
  RxBool isLoading = false.obs;

  Future<dynamic> ForgotPasswordAPi(
      {required BuildContext context,required String phone_no}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    isLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    // Map data = {
    //   'email': emailAddressController.text,
    //   'phone':  MobilenoController.text,
    //   'countryCode': dialCodedigits ,
    // };
    // print(data);
    // String body = json.encode(data);

    // var url = (URLConstants.base_url + URLConstants.forgotPasswordApi);
    var url = ("${URLConstants.base_url +URLConstants.checkUserApi}?phone_number=$phone_no");
    print("url : $url");
    // print("body : $data");

    // var response = await http.post(
    //   Uri.parse(url),
    //   body: data,
    // );
    var response = await http.get(Uri.parse(url));

    print(response.body);
    print(response.request);
    print(response.statusCode);
    // var final_data = jsonDecode(response.body);

    // print('final data $final_data');

    if (response.statusCode == 200) {
      isLoading(false);
      var data = jsonDecode(response.body);
      forgotPasswordModel = ForgotPasswordModel.fromJson(data);
      print(forgotPasswordModel);
      if (forgotPasswordModel!.error == false) {

        // print(forgotPasswordModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        // await CommonWidget().showToaster(msg: 'OTP sent');
        // await Get.to(DashboardScreen());
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
      }
    } else {}
  }

  VerifyOtpModel? verifyOtpModel;
  RxBool verifyOtpLoading = false.obs;

  Future<dynamic> VerifyOtpAPi({required BuildContext context}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    verifyOtpLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'otp': OtpController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.ForgotpassverifyOtpApi);
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
      verifyOtpLoading(false);
      var data = jsonDecode(response.body);
      verifyOtpModel = VerifyOtpModel.fromJson(data);
      print(verifyOtpModel);
      if (verifyOtpModel!.error == false) {
        await CommonWidget().showToaster(msg: "Otp Verified");
        // await SignUpAPi(context: context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Otp");
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }


  PasswordResetModel? passwordResetModel;

  Future<dynamic> ResetPasswordAPi(
      {required BuildContext context,required String id}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // isLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'id': id,
      'password': newPasswordController.text,
    };
    print(data);
    // String body = json.encode(data);


    var url = (URLConstants.base_url + URLConstants.resetPasswordApi);
    print("url : $url");
    print("body : $data");

    // var response = await http.get(Uri.parse(url));

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
      passwordResetModel = PasswordResetModel.fromJson(data);
      print(passwordResetModel);
      if (passwordResetModel!.error == false) {
        // print(passwordResetModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        // await CommonWidget().showToaster(msg: passwordResetModel!.message!);
        // await Get.to(DashboardScreen());
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
      }
    } else {}
  }

}