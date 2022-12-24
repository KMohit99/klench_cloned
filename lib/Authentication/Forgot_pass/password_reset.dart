import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SignUp/SignUp_screen.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/Common_container_color.dart';
import 'package:klench_/utils/Common_textfeild.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/common_widgets.dart';
import '../Forgot_pass/Forgot_screen.dart';
import 'controller/forgot_password_controller.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final ForgotPasswordController _forgotPasswordController = Get.put(
      ForgotPasswordController(),
      tag: ForgotPasswordController().toString());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 41,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                        begin: Alignment(-1.0, -4.0),
                        end: Alignment(1.0, 4.0),
                        colors: [HexColor('#020204'), HexColor('#36393E')])),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    AssetUtils.arrow_back,
                    height: 14,
                    width: 15,
                  ),
                )),
          ),
          title: Text(
            "Create a new password",
            style: FontStyleUtility.h16(
                fontColor: ColorUtils.primary_grey, family: 'PM'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  child: Container(
                      height: 49,
                      width: 170,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20, bottom: 50),
                      child: Image.asset(AssetUtils.Logo_white_icon)),
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.65),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        // stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          HexColor("#36393E").withOpacity(1),
                          HexColor("#020204").withOpacity(1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#2A2A29'),
                          offset: Offset(5, 5),
                          blurRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36, horizontal: 14),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(colors: [
                                HexColor('#36393E'),
                                HexColor('#020204')
                              ]),
                              boxShadow: [
                                BoxShadow(
                                    color: HexColor('#04060F'),
                                    offset: Offset(3, 3),
                                    blurRadius: 10)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(27.0),
                            child: Image.asset(
                              AssetUtils.key_icons_big,
                              color: ColorUtils.primary_grey,
                              height: 26,
                              width: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: CommonTextFormField_text_reversed(
                            title: 'New password',
                            labelText: 'xxxxxxxxx',
                            controller:
                                _forgotPasswordController.newPasswordController,
                            onChanged: (value) {
                              print(value);
                              checkPassword();
                            },
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.key_icons,
                                color: ColorUtils.primary_grey,
                                height: 17,
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        (alpha_num == false
                            ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 5),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '\u2022 Password must has atleast 6 characters',
                                  style: TextStyle(
                                      height: 1.5,
                                      wordSpacing: 2,
                                      color: Colors.red,
                                      fontFamily: 'PM'),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\u2022 ',
                                      style: TextStyle(
                                          height: 1.5,
                                          wordSpacing: 2,
                                          color: Colors.red,
                                          fontFamily: 'PM'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'That include at leat 1 Lowercase, 1 Uppercase, 1 number',
                                        maxLines: 2,
                                        style: TextStyle(
                                            height: 1.5,
                                            wordSpacing: 2,
                                            color: Colors.red,
                                            fontFamily: 'PM'),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '\u2022 1 Special character in (!@#\$%^&*)',
                                  style: TextStyle(
                                      height: 1.5,
                                      wordSpacing: 2,
                                      color: Colors.red,
                                      fontFamily: 'PM'),
                                ),
                              ],
                            ),
                          ),
                        )
                            : SizedBox.shrink()),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField_text_reversed(
                            title: 'Confirm new password',
                            labelText: 'xxxxxxxxxx',
                            controller: _forgotPasswordController
                                .ConfirmNewPasswordController,
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.key_icons,
                                color: ColorUtils.primary_grey,
                                height: 17,
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 52,
                        ),
                        common_button_gold(
                          onTap: () async {
                            if (_forgotPasswordController
                                    .newPasswordController.text.length ==
                                0) {
                              CommonWidget()
                                  .showErrorToaster(msg: "Password empty");
                              return;
                            }
                            if (_forgotPasswordController
                                    .newPasswordController.text !=
                                _forgotPasswordController
                                    .ConfirmNewPasswordController.text) {
                              CommonWidget().showErrorToaster(
                                  msg: "Password doesn't match");
                              return;
                            }
                            await _forgotPasswordController.ResetPasswordAPi(
                                context: context,
                                id: _forgotPasswordController
                                    .forgotPasswordModel!.data!.id!);
                            if (_forgotPasswordController
                                    .passwordResetModel!.error ==
                                false) {
                              selectTowerBottomSheet(context);
                              // Future.delayed(const Duration(seconds: 5),
                              //     () async {
                              //   Navigator.pop(context);
                              //   await Get.to(SignInScreen());
                              //   setState(() {});
                              // });
                            }
                          },
                          title_text: 'Done',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool alpha_num = true;
  var alpha_numeric =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  checkPassword() {
    if (!alpha_numeric
        .hasMatch(_forgotPasswordController
        .newPasswordController.text)) {
      print("eorrrrr");
      setState(() {
        alpha_num = false;
      });
    } else if (_forgotPasswordController
        .newPasswordController.text.isEmpty) {
      setState(() {
        alpha_num = true;
      });
    } else {
      setState(() {
        alpha_num = true;
      });
    }
  }

  selectTowerBottomSheet(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: StatefulBuilder(
            builder: (context, state) {
              return Container(
                height: screenheight * 0.445,
                width: screenwidth,
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.65),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    // stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      HexColor("#020204").withOpacity(1),
                      HexColor("#36393E").withOpacity(1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: HexColor('#04060F'),
                      offset: Offset(10, 10),
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(33.9),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          AssetUtils.happy_Face_icon,
                          color: ColorUtils.primary_grey,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 42),
                        child: Text('You have successfully reset password',
                            style: FontStyleUtility.h15(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR')),
                      ),
                      common_button_gold(
                        onTap: () {
                          Get.to(SignInScreen());
                        },
                        title_text: 'Login now',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
