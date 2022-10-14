import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SignUp/SignUp_screen.dart';
import 'package:klench_/Authentication/ask_signUp.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/Common_textfeild.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/TexrUtils.dart';
import '../Forgot_pass/Forgot_screen.dart';
import '../instagram/instagram_view.dart';
import 'controller/SignIn_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInScreenController _signInScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
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
            'Sign in',
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
                  decoration: Common_decoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 29, horizontal: 19),
                    child: Column(
                      children: [
                        Container(
                          child: CommonTextFormField_text(
                            title: 'Username',
                            labelText: 'Enter Username',
                            controller:
                                _signInScreenController.usernameController,
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(vertical: -4, horizontal: -4),
                              icon: Image.asset(
                                AssetUtils.signIN_user_icon,
                                color: HexColor("#606060"),
                                height: 17,
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField_text_reversed(
                            title: 'Password',
                            labelText: 'Enter Password',
                            controller:
                                _signInScreenController.passwordController,
                            isObscure: _obscureText,
                            maxLines: 1,
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(vertical: -4, horizontal: -4),
                              icon: Image.asset(
                                (_obscureText
                                    ? AssetUtils.eye_open_icon
                                    : AssetUtils.eye_close_icon),
                                color: HexColor("#606060"),
                                height: 20,
                                width: 20,
                              ),
                              onPressed: () {
                                _toggle();
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ForgotScreen());
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: FontStyleUtility.h13(
                                  fontColor: ColorUtils.primary_grey,
                                  family: 'PM'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 52,
                        ),
                        common_button_gold(
                          onTap: () async {
                            await _signInScreenController.SignInAPi(
                                context: context);
                            if (_signInScreenController.singInModel!.error ==
                                    false &&
                                _signInScreenController.userInfoModel!.error ==
                                    false) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen(page: 1,)));
                            }
                          },
                          title_text: 'Sign In',
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        // common_button_gold(
                        //   onTap: () {
                        //     _signInScreenController.signInWithFacebook(
                        //         context: context, login_type: '');
                        //   },
                        //   title_text: 'Facebook',
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        // common_button_gold(
                        //   onTap: () {
                        //     // _signInScreenController.signInWithFacebook(context: context, login_type: '');
                        //     Get.to(InstagramView(
                        //       context: context,
                        //       login_type: 'Creator',
                        //     ));
                        //   },
                        //   title_text: 'Instagram',
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    'OR',
                    style: FontStyleUtility.h13(
                        fontColor: ColorUtils.primary_grey, family: 'PM'),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                          color: HexColor('#04060F'),
                          offset: Offset(10, 10),
                          blurRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(InstagramView(
                              context: context,
                              login_type: 'Creator',
                            ));
                          },
                          child: Image.asset(
                            AssetUtils.instagram_icon,
                            scale: 3,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            _signInScreenController.signInWithFacebook(
                                context: context, login_type: '');
                          },
                          child: Image.asset(
                            AssetUtils.facebook_icon,
                            scale: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
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
                            color: HexColor('#04060F'),
                            offset: Offset(10, 10),
                            blurRadius: 20,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      highlightColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: FontStyleUtility.h13(
                                    fontColor: ColorUtils.primary_grey,
                                    family: 'PR')),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(AskSignUp());
                              },
                              child: Text(
                                "Sign Up!",
                                style: FontStyleUtility.h13(
                                    fontColor: ColorUtils.primary_gold,
                                    family: 'PB'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
