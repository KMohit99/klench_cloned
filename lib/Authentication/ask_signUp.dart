import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';
import 'SignUp/SignUp_screen.dart';
import 'SingIn/controller/SignIn_controller.dart';
import 'instagram/instagram_view.dart';

class AskSignUp extends StatefulWidget {

  const AskSignUp({Key? key}) : super(key: key);

  @override
  State<AskSignUp> createState() => _AskSignUpState();
}

class _AskSignUpState extends State<AskSignUp> {
  final SignInScreenController _signInScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

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
            'Sign up',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Container(
                      height: 49,
                      width: 170,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20, bottom: 50),
                      child: Image.asset(AssetUtils.Logo_white_icon)),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(SignUpScreen());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                        child: Container(
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
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0,),
                            child: Text("SignUp with Email",
                                textAlign: TextAlign.center,
                                style: FontStyleUtility.h13(
                                    fontColor: ColorUtils.primary_grey,
                                    family: 'PR')),
                          ),
                        ),
                      ),
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
                        fontColor: ColorUtils.primary_grey,
                        family: 'PM'),
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
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [



                        GestureDetector(
                          onTap: (){
                            _signInScreenController.signInWithFacebook(
                                context: context, login_type: '');
                          },
                          child: Image.asset(
                            AssetUtils.facebook_icon,
                            scale: 3,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
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
                      ],
                    ),
                  ),
                ),


                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
