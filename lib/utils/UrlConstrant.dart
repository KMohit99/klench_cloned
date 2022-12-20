import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage/m_screen.dart';

class URLConstants {
  static const String base_url = "http://foxyserver.com/klench/api/";
  // static const String base_url = "https://foxytechnologies.com/klench/api/";

  static const signUpApi = "signup.php";
  static const loginApi = "login.php";
  static const EditProfileApi = "edit-profile.php";
  static const sendOtpApi = "send-otp.php";
  static const ResendOtpApi = "resend-otp.php";
  static const verifyOtpApi = "otp-verify.php";
  static const ForgotpassverifyOtpApi = "forgot-verify-otp.php";
  static const getProfileApi = "get-profile.php";
  static const forgotPasswordApi = "forgot-password.php";
  static const resetPasswordApi = "reset-password.php";
  static const CheckUserApi = "check-user.php";
  static const CheckPasswordApi = "check-pssword.php";

  ///Breathing
  static const breathing_get = "get-kegel-breathing.php";
  static const breathing_post = "kegel-breathing.php";

 ///Kegel
  static const kegel_get = "get-kegel.php";
  static const kegel_alarm_get = "get-kegel-alarm.php";
  static const kegel_post = "kegel.php";
  static const kegel_alarm_post = "kegel-alarm.php";
  static const kegel_alarm_delete = "deleteKegelAlarm.php";
  ///
  ///
  static const start_end_notification = "postSetTime.php";
  static const get_start_end_notification = "getSetTime.php";


  ///masturbation
  static const masturbation_get_method = "getMasturbationExercise.php";
  static const masturbation_post_method = "postMasturbationExercise.php";


  static const masturbation_get_weekly_data = "weekly-mMehod.php";
  static const masturbation_get_lifetime_data = "lifetime-mMethod.php";
  static const masturbation_get_daily_data = "daily-mMethod.php";
  static const masturbation_post = "masturbation.php";
  static const masturbation_method_delete = "delete-mMethod.php";
  static const masturbation_method_edit = "edit-mscreenMethod.php";

  ///Pee
  static const pee_get = "get-pee.php";
  static const pee_post = "pee.php";

  ///contact_us
  static const contact_post = "contact-us.php";

  ///toekn
  static const token_device_post = "device.php";
  ///notified_status
  static const update_notified_status = "update-notified-status.php";

 ///intro_video
  static const intro_video_get = "introvideoList.php";

 ///intro_video
  static const postNotificationSetting = "postNotificationSetting.php";
  static const getNotificationSetting = "getNotificationSetting.php";


  static String id = "id";
  static String method_list = "list";
  static String trial = 'false';
  static String socail_signup = 'false';
  static String levels = "level";
  static String stages = "0";
  static String username = "username";
  static String authentication_enable = 'Authentication';
}

class PreferenceManager {
  late SharedPreferences sharedPreferences;

  // set data in preference
  Future<bool> remove() async {
    print("remove preferences");
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  // set data in preference
  Future setList(String key,   value) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }

  // get data in preference
  Future getList(String key) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? [];
  }


  // set data in preference
  Future<bool> setPref(String key, String value) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }


  // get data in preference
  Future<String> getPref(String key) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? "";
  }

  Future<bool> setbool(String key, bool value) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(key, value);
  }

  Future<bool> getbool(String key) async {
    //SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

}
