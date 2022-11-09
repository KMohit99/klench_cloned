import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';

import '../../../Dashboard/dashboard_screen.dart';
import '../../../profile_page/controller/profile_page_controller.dart';
import '../../../profile_page/model/Editprofile.dart';
import '../../../profile_page/model/userInfoModel.dart';
import '../../../utils/UrlConstrant.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/page_loader.dart';
import '../../SignUp/controller/sign_up_controller.dart';
import '../../SignUp/face_scan_screen.dart';
import '../../SignUp/model/signUpmodel.dart';
import '../../welcom_video/welcome_video_screen.dart';
import '../model/SignInModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../social_signup_details.dart';

class SignInScreenController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  dynamic userData;

  SingInModel? singInModel;
  RxBool isLoading = false.obs;

  Future<dynamic> SignInAPi({required BuildContext context}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    isLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'username': usernameController.text,
      'password': passwordController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.loginApi);
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
      isLoading(false);
      var data = jsonDecode(response.body);
      singInModel = SingInModel.fromJson(data);
      print(singInModel);
      if (singInModel!.error == false) {
        await PreferenceManager()
            .setPref(URLConstants.id, singInModel!.user![0].id!);
        await PreferenceManager()
            .setPref(URLConstants.username, singInModel!.user![0].username!);

        // await PreferenceManager()
        //     .setPref(URLConstants.levels, userInfoModel!.data![0].levels!);
        print(singInModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        // await CommonWidget().showToaster(msg: 'Successfully Loggedin');
        await clear_method();
       // await Get.to(WelcomeVideoScreen(signup: false,));
        await GetUserInfo( context);
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
      }
    } else {}
  }

  RxBool isuserinfoLoading = true.obs;
  UserInfoModel? userInfoModel;
  var getUSerModelList = UserInfoModel().obs;
  int? level_rank;
  int selectedCard = 0;

  final Profile_page_controller _profile_page_controller = Get.put(
      Profile_page_controller(),
      tag: Profile_page_controller().toString());

  Future<dynamic> GetUserInfo(BuildContext context) async {
    // showLoader(context);
    isuserinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
        (URLConstants.base_url + URLConstants.getProfileApi + "?id=${id_user}");
    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      userInfoModel = UserInfoModel.fromJson(data);
      getUSerModelList(userInfoModel);
      if (userInfoModel!.error == false) {
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${userInfoModel!.data!.length}');
        await PreferenceManager()
            .setPref(URLConstants.levels, userInfoModel!.data![0].levels!);
        await PreferenceManager()
            .setPref(URLConstants.stages, userInfoModel!.data![0].stage!);

        _profile_page_controller.nameController.text =
            userInfoModel!.data![0].username!;
        _profile_page_controller.FullnameController.text =
            userInfoModel!.data![0].fullName!;
        _profile_page_controller.dialCodedigits =
            userInfoModel!.data![0].countryCode!;
        _profile_page_controller.phoneNumberController.text =
            userInfoModel!.data![0].phone!;
        _profile_page_controller.emailAddressController.text =
            userInfoModel!.data![0].email!;
        _profile_page_controller.dateOfbirthController.text =
            userInfoModel!.data![0].dob!;
        _profile_page_controller.genderController.text =
            userInfoModel!.data![0].gender!;

        (userInfoModel!.data![0].levels == 'Very Easy'
            ? level_rank = 0
            : (userInfoModel!.data![0].levels == 'Easy'
                ? level_rank = 1
                : (userInfoModel!.data![0].levels == 'Normal'
                    ? level_rank = 2
                    : (userInfoModel!.data![0].levels == 'Hard'
                        ? level_rank = 3
                        : (userInfoModel!.data![0].levels == 'ထ'
                            ? level_rank = 4
                            : level_rank = 0)))));

        print("Level : ${userInfoModel!.data![0].levels}");
        print('Rank level : $level_rank');

        isuserinfoLoading(false);
        selectedCard = level_rank!;
        // hideLoader(context);
        // await Get.to(DashboardScreen());

        return userInfoModel;
      }
      else {
        isuserinfoLoading(false);

        // hideLoader(context);
        // CommonWidget().showToaster(msg: 'Error');
        return null;
      }
    } else if (response.statusCode == 422) {
      isuserinfoLoading(false);

      // CommonWidget().showToaster(msg: userInfoModel!.message!);
    } else if (response.statusCode == 401) {
      isuserinfoLoading(false);
      // CommonWidget().showToaster(msg: userInfoModel!.message!);

    } else {
      isuserinfoLoading(false);
      // CommonWidget().showToaster(msg: userInfoModel!.message!);

    }
  }

  UserCredential? userCredential;

  SignUpModel? signUpModel;

  Future<Resource?> signInWithFacebook(
      {required BuildContext context, required String login_type}) async {
    // try {
    // showLoader(context);
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);

    switch (result.status) {
      case LoginStatus.success:
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);



        await SignUpAPi(
            context: context,
            type: 'facebook',
            username: userCredential!.user!.displayName!);

        // Fluttertoast.showToast(
        //   msg: "login successfully",
        //   textColor: Colors.white,
        //   backgroundColor: Colors.black,
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.BOTTOM,
        // );
        // Get.to(Dashboard());

        print(userCredential!.user!.displayName);
        return Resource(status: Status.Success);
      case LoginStatus.cancelled:
        return Resource(status: Status.Cancelled);
      case LoginStatus.failed:
        return Resource(status: Status.Error);
      default:
        return null;
    }

    // on FirebaseAuthException catch (e) {
    //   throw e;
    // }
  }

  Future<dynamic> SignUpAPi({
    required BuildContext context,
    required String type,
    required String username,
  }) async {
    showLoader(context);
    var url = (URLConstants.base_url + URLConstants.signUpApi);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // List<int> imageBytes = imgFile!.readAsBytesSync();
    // String baseimage = base64Encode(imageBytes);

    print("username$username");
    request.fields['image'] = '';
    request.fields['username'] = username;
    request.fields['fullName'] = username;
    request.fields['countryCode'] = '';
    request.fields['phone'] = '';
    request.fields['email'] = '';
    request.fields['dob'] = '';
    request.fields['gender'] = '';
    request.fields['password'] = '';
    request.fields['levels'] = '';
    request.fields['type'] = type;

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    print(response.statusCode);
    print("response - ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = json.decode(responsed.body);
      signUpModel = SignUpModel.fromJson(data);
      print("status${signUpModel!.statusCode}");
      print("message${signUpModel!.message}");
      print("error${signUpModel!.error}");
      if (signUpModel!.error == false) {
        await PreferenceManager()
            .setPref(URLConstants.id, signUpModel!.user![0].id!);

        print("signUpModel!.user![0].id! ${signUpModel!.user![0].id!}");
        // await PreferenceManager()
        //     .setPref(URLConstants.id, signUpModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        await CommonWidget().showToaster(msg: signUpModel!.message!);

        print("signUpModel!.message");
        await GetUserInfo( context);
        await Get.to(SocialSignupDetails(
          username_: username,
          type_: type,
        ));
        await CommonWidget().showToaster(msg: "Please Update user Profile");

        // await  SendOtpAPi(context: context);
        //  await Get.to(DashboardScreen());
        hideLoader(context);
      } else {
        hideLoader(context);
        // CommonWidget().showErrorToaster(msg: signUpModel!.message!);
        if (signUpModel!.message! == 'User Already Exists') {
          await PreferenceManager()
              .setPref(URLConstants.id, signUpModel!.user![0].id!);

          // await PreferenceManager()
          //     .setPref(URLConstants.id, signUpModel!.user![0].id!);
          // await PreferenceManager()
          //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
          // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
          await CommonWidget().showToaster(msg: signUpModel!.message!);

          print("signUpModel!.message");
          await GetUserInfo(context);

          await Get.to(DashboardScreen(page: 1,));
          await CommonWidget().showToaster(msg: "Please Update user Profile");
        }
        // print('Please try again');
        // print('Please try again');
      }
      hideLoader(context);
    } else {
      print("ERROR");
    }
  }

  TextEditingController FullnameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emailAddressController = new TextEditingController();
  TextEditingController dateOfbirthController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  final TextEditingController usernameController_ = TextEditingController();
  final TextEditingController passwordController_ = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController DoBController = TextEditingController();
  final TextEditingController OtpController = TextEditingController();

  String dialCodedigits = "+91";

  String? date_birth;
  String? selected_gender;
  String? level;

  EditProfile? editProfile;
  // RxBool isLoading = false.obs;
  File? imgFile;

  Future<dynamic> Editprofile({required BuildContext context}) async {
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    showLoader(context);
    var url = (URLConstants.base_url + URLConstants.EditProfileApi);
    var request = http.MultipartRequest('POST', Uri.parse(url));

    print("idddddddd $id_user");
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
    request.fields['username'] = nameController.text;
    request.fields['countryCode'] = dialCodedigits;
    request.fields['phone'] = phoneNumberController.text;
    request.fields['email'] = emailAddressController.text;
    request.fields['dob'] = DoBController.text;
    request.fields['gender'] = genderController.text;
    request.fields['levels'] = level!;


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
        // await Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => DashboardScreen()));
        await PreferenceManager()
            .setPref(URLConstants.socail_signup, 'true');
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => FaceScanScreen()));
        // await Get.to(FaceScanScreen());

        // Get.to(DashboardScreen());

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



  clear_method() {
    usernameController.clear();
    passwordController.clear();
  }

  Future<dynamic> Add_token_API(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // try {
    //
    // } catch (e) {
    //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // }
    // isLoading(true);

    // showLoader(context);
    String idUser = await PreferenceManager().getPref(URLConstants.id);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcmToken : $fcmToken");

    Map data = {
      'userId': idUser,
      'token' : fcmToken,
      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.token_device_post);
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
      // alarmPostModel = AlarmPostModel.fromJson(data);
      if (data["error"] == false) {
        // CommonWidget().showToaster(msg: peePostModel!.message!);
        // hideLoader(context);
      } else {
        // hideLoader(context);
        // CommonWidget().showErrorToaster(msg: peePostModel!.message!);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }

}

class Resource {
  final Status status;

  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }
