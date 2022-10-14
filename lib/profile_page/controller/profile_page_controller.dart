import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:klench_/utils/page_loader.dart';
import 'dart:convert' as convert;

import '../../Authentication/SignUp/model/signUpmodel.dart';
import '../../Dashboard/dashboard_screen.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import '../model/Editprofile.dart';
import '../model/userInfoModel.dart';

class Profile_page_controller extends GetxController {
  TextEditingController FullnameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emailAddressController = new TextEditingController();
  TextEditingController dateOfbirthController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  String? dialCodedigits;


  EditProfile? editProfile;
  RxBool isLoading = false.obs;
  File? imgFile;
  String? selected_difficulty;

  Future<dynamic> Editprofile({required BuildContext context}) async {
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    showLoader(context);
    var url = (URLConstants.base_url + URLConstants.EditProfileApi);
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (imgFile != null) {
      var files = await http.MultipartFile(
          'image',
          File(imgFile!.path).readAsBytes().asStream(),
          File(imgFile!.path).lengthSync(),
          filename: imgFile!.path.split("/").last);
      request.files.add(files);
    }
    request.fields['id'] = id_user;
    request.fields['fullName'] = FullnameController.text;
    // request.fields['username'] = nameController.text;
    request.fields['countryCode'] = dialCodedigits!;
    request.fields['phone'] = phoneNumberController.text;
    request.fields['email'] = emailAddressController.text;
    request.fields['dob'] = dateOfbirthController.text;
    request.fields['gender'] = genderController.text;
    request.fields['levels'] = selected_difficulty!;

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = json.decode(responsed.body);
      editProfile = EditProfile.fromJson(data);
      print(editProfile);
      print(data);
      if (editProfile!.error == false) {
        // await PreferenceManager()
        //     .setPref(URLConstants.id, signUpModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        await CommonWidget().showToaster(msg: 'User Updated');
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen(page: 1,)));
        Get.to(DashboardScreen(page: 1,));

        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
        // print('Please try again');
        // print('Please try again');
      }
      hideLoader(context);
    } else {
      print("ERROR");
    }
  }
}
