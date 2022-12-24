import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SignUp/SignUp_screen.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/Common_textfeild.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import 'Otp_verification.dart';
import 'controller/forgot_password_controller.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

enum Pet { email, phone }

class _ForgotScreenState extends State<ForgotScreen> {
  Pet _pet = Pet.email;

  final ForgotPasswordController _forgotPasswordController = Get.put(
      ForgotPasswordController(),
      tag: ForgotPasswordController().toString());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
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
            "Forgot password?",
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
                    height: 49,
                    width: 170,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 20, bottom: 35),
                    child: Image.asset(AssetUtils.Logo_white_icon)),
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
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 58, horizontal: 14),
                    child: Column(
                      children: [
                        Text("We need to verify your identity",
                            style: FontStyleUtility.h15(
                                fontColor: HexColor('#F1F1F1'), family: 'PR')),
                        SizedBox(
                          height: 50,
                        ),
                        // ListTile(
                        //   visualDensity:
                        //       VisualDensity(horizontal: -4, vertical: -4),
                        //   title: Text('email......test@gmmail.com',
                        //       style: FontStyleUtility.h15(
                        //           fontColor: Colors.white, family: 'PM')),
                        //   leading: Theme(
                        //     data: ThemeData(
                        //       unselectedWidgetColor: ColorUtils.primary_grey,
                        //     ),
                        //     child: Radio<Pet>(
                        //       activeColor: ColorUtils.primary_gold,
                        //       value: Pet.email,
                        //       groupValue: _pet,
                        //       onChanged: (Pet? value) {
                        //         setState(() {
                        //           _pet = value!;
                        //         });
                        //         print(value);
                        //       },
                        //     ),
                        //   ),
                        // ),
                        // ListTile(
                        //   visualDensity:
                        //       VisualDensity(horizontal: -4, vertical: -4),
                        //   title: Text(
                        //     'Text  8xxxxxxx23',
                        //     style: FontStyleUtility.h15(
                        //         fontColor: Colors.white, family: 'PM'),
                        //   ),
                        //   leading: Theme(
                        //     data: ThemeData(
                        //       unselectedWidgetColor: ColorUtils.primary_grey,
                        //     ),
                        //     child: Radio<Pet>(
                        //       activeColor: ColorUtils.primary_gold,
                        //       value: Pet.phone,
                        //       groupValue: _pet,
                        //       onChanged: (Pet? value) {
                        //         setState(() {
                        //           _pet = value!;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),
                        Container(
                          child: CommonTextFormField(
                            labelText: 'Email Address',
                            maxLines: 1,
                            controller:
                            _forgotPasswordController.emailAddressController,
                            iconData: IconButton(
                              visualDensity:
                              VisualDensity(vertical: -4, horizontal: -4),
                              icon: Image.asset(
                                AssetUtils.key_icons,
                                color: HexColor("#606060"),
                                height: 17,
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 14,
                                color: HexColor('#AAAAAA'),
                                fontFamily: 'PR'),
                          ),
                        ),
                        Row(
                          children: [
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
                                  borderRadius: BorderRadius.circular(10)),
                              child: CountryCodePicker(
                                onChanged: (country) {
                                  setState(() {
                                    _forgotPasswordController.dialCodedigits =
                                    country.dialCode!;
                                    print(_forgotPasswordController
                                        .dialCodedigits);
                                  });
                                },
                                initialSelection: "IN",
                                textStyle: FontStyleUtility.h15(
                                    fontColor: ColorUtils.primary_gold,
                                    family: 'PM'),
                                showCountryOnly: false,
                                showFlagMain: false,
                                padding: EdgeInsets.zero,
                                showFlag: true,
                                showOnlyCountryWhenClosed: false,
                                favorite: ["+1", "US", "+91", "IN"],
                                barrierColor: Colors.white,
                                backgroundColor: Colors.black,
                                dialogSize: Size.fromHeight(screenHeight / 2),
                              ),
                            ),
                            Container(
                              width: 10,),
                            Expanded(
                              child: Container(
                                child: CommonTextFormField_reversed(
                                  labelText: 'Phone number',
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  controller:
                                  _forgotPasswordController.MobilenoController,
                                  iconData: IconButton(
                                    visualDensity:
                                    VisualDensity(vertical: -4, horizontal: -4),
                                    icon: Image.asset(
                                      AssetUtils.mobile_icons,
                                      color: HexColor("#606060"),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 71,
                        ),
                        common_button_gold(
                          onTap: () async {
                            // Get.to(DashboardScreen());
                            await _forgotPasswordController.ForgotPasswordAPi(
                                context: context,
                                phone_no: _forgotPasswordController
                                    .MobilenoController.text);
                            if(_forgotPasswordController.forgotPasswordModel!.error == false){
                              await Get.to(OtpScreen());
                            }

                            // await _forgotPasswordController.ForgotPasswordAPi(
                            //     context: context);
                            // if(_forgotPasswordController.forgotPasswordModel!.error == false){
                            //   await selectTowerBottomSheet(context);
                            //   Future.delayed(const Duration(seconds: 5), () async {
                            //     Navigator.pop(context);
                            //     await Get.to(OtpScreen());
                            //   });
                            // }
                          },
                          title_text: 'Verify',
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

  selectTowerBottomSheet(BuildContext context) {
    final screenheight = MediaQuery
        .of(context)
        .size
        .height;
    final screenwidth = MediaQuery
        .of(context)
        .size
        .width;
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
                        child: Text(
                            'OTP has been sent to your email/phone number',
                            textAlign: TextAlign.center,
                            style: FontStyleUtility.h15(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR')),
                      ),
                      common_button_gold(
                        onTap: () {
                          Get.to(OtpScreen());
                        },
                        title_text: 'Verify now',
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
