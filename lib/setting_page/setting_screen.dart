import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';
import 'package:klench_/notifications/notifications_screen.dart';
import 'package:klench_/setting_page/authentication_screen.dart';
import 'package:klench_/setting_page/help_support.dart';
import 'package:klench_/setting_page/intro_video.dart';
import 'package:klench_/setting_page/premium_plan_screen.dart';
import 'package:klench_/setting_page/privacy_policy_screen.dart';
import 'package:klench_/setting_page/qr_code/qr_code_screen.dart';
import 'package:klench_/setting_page/refferal_link.dart';
import 'package:klench_/setting_page/terms_conditions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/SignUp/controller/sign_up_controller.dart';
import '../Authentication/subscription_plan/subscription_plan_screen.dart';
import '../front_page/FrontpageScreen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import 'About_us_screen.dart';
import 'FAQ.dart';
import 'Reset_Password.dart';
import 'contact_screen.dart';
import 'notification/notification_settings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List Icon_data = [
    AssetUtils.qrcode_icons,
    AssetUtils.privacy_icons,
    AssetUtils.FaQ_icons,
    AssetUtils.aboutUs_icons,
    AssetUtils.contact_icons,
    AssetUtils.terms_icons,
    AssetUtils.help_support_icons,
    AssetUtils.reset_pass_icons,
    AssetUtils.intro_video_icons,
    AssetUtils.referralLink_icons,
    AssetUtils.notification_icons,
    AssetUtils.premium_icons,
    AssetUtils.authentication_icons,
    AssetUtils.logout_icons,
  ];

  List txt_list = [
    "My QR",
    "Privacy Policy",
    "FAQ",
    "About us",
    "Contact us",
    "Terms & Conditions",
    "Help & support",
    "Reset password",
    "Intro video",
    "Referral link",
    "Notification",
    "Premium Membership",
    "Authentication",
    "Logout",
  ];

  getdata() async {
    print("insssiiiiiii");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_route', "/settings");
    String? lastRoute = prefs.getString('last_route');
    print("lastRoute $lastRoute");

  }

  @override
  void initState() {
    getdata().then((value) => print("Success"));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: FontStyleUtility.h16(fontColor: Colors.white, family: 'PM'),
        ),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  HexColor("#36393E").withOpacity(1),
                  HexColor("#020204").withOpacity(1),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: HexColor('#2A2A29'),
              //     offset: Offset(10, 10),
              //     blurRadius: 20,
              //   ),
              // ],
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(top: 0, right: 8, left: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: Icon_data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        print(index);
                        (index == 0
                            ? Get.to(QrCodeScreen())
                            : (index == 1
                                ? Get.to(PrivacyPolicy())
                                : (index == 2
                                    ? Get.to(faq_screen())
                                    : (index == 3
                                        ? Get.to(AboutUs_Screen())
                                        : (index == 4
                                            ? Get.to(ContactScreen())
                                            : (index == 5
                                                ? Get.to(
                                                    TermsConditionsScreen())
                                                : (index == 6
                                                    ? Get.to(Help_Support())
                                                    : (index == 7
                                                        ? Get.to(
                                                            ResetPassword())
                                                        : (index == 8
                                                            ? Get.to(
                                                                Intro_videoScreen())
                                                            : (index == 9
                                                                ? Get.to(
                                                                    RefferalLinkScreen())
                                                                : (index == 10
                                                                    ? Get.to(
                                                                        NotificationSettings())
                                                                    : (index ==
                                                                            11
                                                                        ? Get.to(
                                                                            PremiumPlanScreen())
                                                                        : (index ==
                                                                                12
                                                                            ? Get.to(
                                                                                Authentication_settings())
                                                                            : (index == 13
                                                                                ? logout()
                                                                                : null))))))))))))));
                        // if(index == 0){
                        //   Get.to(QrCodeScreen());
                        // }else if(index == 1){
                        //   Get.to(PrivacyPolicy());
                        // }else if(index == 2){
                        //   Get.to(faq_screen());
                        // }else if(index == 3){
                        //   Get.to(AboutUs_Screen());
                        // }else if(index == 4){
                        //   Get.to(ContactScreen());
                        // }
                      },
                      child: Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          leading: SizedBox(
                            child: Image.asset(
                              Icon_data[index],
                              height: 20,
                              width: 18,
                            ),
                          ),
                          title: Text(
                            txt_list[index],
                            style: FontStyleUtility.h16(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR'),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: ColorUtils.dark_grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, right: 0, left: 0),
                      height: 1,
                      color: ColorUtils.dark_grey.withOpacity(0.5),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }

  final SignUpScreenController _signUpScreenController = Get.put(
      SignUpScreenController(),
      tag: SignUpScreenController().toString());

  logout() async {
    // await PreferenceManager().setPref(URLConstants.id, 'id');
    // await PreferenceManager().setPref(URLConstants.username, 'username');
    //
    // String id_user = await PreferenceManager().getPref(URLConstants.id);

    // final cacheDir = await getTemporaryDirectory();
    //
    // if (cacheDir.existsSync()) {
    //   cacheDir.deleteSync(recursive: true);
    // }
    //
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      print('delete data');
      appDir.deleteSync(recursive: true);
    }

    await PreferenceManager().remove();
    _signUpScreenController.clear();
    // print(id_user);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> FrontScreen()));
    // await Get.to(FrontScreen());
  }
}
