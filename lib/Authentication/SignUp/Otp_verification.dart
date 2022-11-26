import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/colorUtils.dart';
import 'controller/sign_up_controller.dart';
import 'face_scan_screen.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final FocusNode _pinOTPFocus = FocusNode();
  String? varification;
  bool resend_otp = true;
  final SignUpScreenController _signUpScreenController = Get.put(
      SignUpScreenController(),
      tag: SignUpScreenController().toString());

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _signUpScreenController.dialCodedigits +
            _signUpScreenController.phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => createUser()));
              print("Otp verifiredddddddd");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text(e.message.toString()),
          //       duration: const Duration(seconds: 10),)
          // );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            varification = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            varification = verificationId;
          });
        },
        timeout: Duration(seconds: 60));
  }

  final BoxDecoration pinOTPDecoration = BoxDecoration(
// color: Colors.black.withOpacity(0.65),
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
// stops: [0.1, 0.5, 0.7, 0.9],
        colors: [
          HexColor("#020204").withOpacity(1),
          HexColor("#36393E").withOpacity(1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: HexColor('#2E2E2D'),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
        BoxShadow(
          color: HexColor('#04060F'),
          offset: Offset(10, 10),
          blurRadius: 20,
        ),
      ],
      borderRadius: BorderRadius.circular(6));
  Timer? countdownTimer;
  Duration? myDuration;

  void startTimer() {
    myDuration = Duration(seconds: 30);
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration!.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        resend_otp = false;
        print('timesup');
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  String codeValue = "";

  @override
  void initState() {

    // verifyPhonenumber();
    super.initState();
    startTimer();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Call your function
      init();
      _listOPT();
    });
  }
  init() async {
    print("data");
    await _signUpScreenController.SendOtpAPi(
        context: context);
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = myDuration!.inSeconds.remainder(60);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: Common_decoration(),
          height: MediaQuery.of(context).size.height,
        ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              // leading: GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Container(
              //       width: 41,
              //       margin: EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(100),
              //           gradient: LinearGradient(
              //               begin: Alignment(-1.0, -4.0),
              //               end: Alignment(1.0, 4.0),
              //               colors: [
              //                 HexColor('#020204'),
              //                 HexColor('#36393E')
              //               ])),
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Image.asset(
              //           AssetUtils.arrow_back,
              //           height: 14,
              //           width: 15,
              //         ),
              //       )),
              // ),
              title: Text(
                'Verify OTP',
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
                        height: 49,
                        width: 170,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 20, bottom: 0),
                        child: Image.asset(AssetUtils.Logo_white_icon)),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30, right: 30, top: 35, bottom: 35),
                      child: Text(
                        'Enter OTP',
                        style: FontStyleUtility.h16(
                            fontColor: ColorUtils.primary_grey, family: 'PM'),
                      ),
                    ),
                    // TextField(
                    //   autofocus: true,
                    //   autofillHints: [AutofillHints.newPassword],
                    // ),
                    Stack(
                      children: [
                        PinFieldAutoFill(
                          currentCode: codeValue,
                          codeLength: 4,
                          onCodeChanged: (code) async {
                            print("onCodeChanged $code");
                            setState(() {
                              codeValue = code.toString();
                              _signUpScreenController.OtpController.text =
                                  codeValue;
                            });
                            await _signUpScreenController.VerifyOtpAPi(
                                context: context);
                            if (_signUpScreenController.signUpModel!.error ==
                                false) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FaceScanScreen()));
                              // await selectTowerBottomSheet(context);
                              // (ontapped)
                              //     ? Navigator.pop(context)
                              //     : {
                              //   Future.delayed(
                              //       const Duration(seconds: 5),
                              //           () async {
                              //         Navigator.pop(context);
                              //         await Navigator.push(context,
                              //             MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     FaceScanScreen()));
                              //         // await Get.to(FaceScanScreen());
                              //         // setState(() {});
                              //       })
                              // };
                            }
                          },
                          onCodeSubmitted: (val) {
                            print("onCodeSubmitted $val");
                          },
                        ),
                        Container(
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
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: PinPut(
                                    autofocus: true,
                                    autofillHints: const [
                                      AutofillHints.oneTimeCode
                                    ],
                                    fieldsCount: 4,
                                    textStyle: TextStyle(
                                        fontFamily: 'PM',
                                        fontSize: 25,
                                        color: ColorUtils.primary_gold),
                                    eachFieldHeight: 45,
                                    eachFieldWidth: 45,
                                    eachFieldMargin: EdgeInsets.all(7),
                                    focusNode: _pinOTPFocus,
                                    controller:
                                        _signUpScreenController.OtpController,
                                    submittedFieldDecoration: pinOTPDecoration,
                                    selectedFieldDecoration: pinOTPDecoration,
                                    followingFieldDecoration: pinOTPDecoration,
                                    pinAnimationType: PinAnimationType.scale,
                                    onSubmit: (pin) async {
                                      // try {
                                      //   await FirebaseAuth.instance
                                      //       .signInWithCredential(
                                      //           PhoneAuthProvider.credential(
                                      //               verificationId:
                                      //                   varification!,
                                      //               smsCode: pin))
                                      //       .then((value) {
                                      //     if (value.user != null) {
                                      //       print("Otp verifiredddddddd");
                                      //     }
                                      //   });
                                      // } catch (e) {
                                      //   FocusScope.of(context).unfocus();
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(SnackBar(
                                      //     content: Text('invalid otp'),
                                      //     duration: Duration(seconds: 3),
                                      //   ));
                                      // }
                                    },
                                  ),
                                ),
                                // Container(
                                //   child: PinFieldAutoFill(
                                //     decoration: UnderlineDecoration(
                                //       textStyle: TextStyle(
                                //           fontSize: 20, color: Colors.black),
                                //       colorBuilder: FixedColorBuilder(
                                //           Colors.black.withOpacity(0.3)),
                                //     ),
                                //     codeLength: 4,
                                //     onCodeSubmitted: (code) {},
                                //     onCodeChanged: (code) {
                                //       if (code!.length == 6) {
                                //         FocusScope.of(context)
                                //             .requestFocus(FocusNode());
                                //       }
                                //     },
                                //   ),
                                // ),
                                SizedBox(
                                  height: 28,
                                ),
                                // PinFieldAutoFill(
                                //   currentCode: codeValue,
                                //   codeLength: 4,
                                //   onCodeChanged: (code) {
                                //     print("onCodeChanged $code");
                                //     setState(() {
                                //       codeValue = code.toString();
                                //       _signUpScreenController.OtpController.text = codeValue;
                                //     });
                                //   },
                                //   onCodeSubmitted: (val) {
                                //     print("onCodeSubmitted $val");
                                //   },
                                // ),
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              HexColor("#020204")
                                                  .withOpacity(1),
                                              HexColor("#36393E")
                                                  .withOpacity(1),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor('#2E2E2D'),
                                              offset: Offset(0, 3),
                                              blurRadius: 6,
                                            ),
                                            BoxShadow(
                                              color: HexColor('#04060F'),
                                              offset: Offset(10, 10),
                                              blurRadius: 20,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        onPressed: () {},
                                        icon: Icon(Icons.access_time_rounded),
                                        color: ColorUtils.primary_grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '${seconds} S',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'PR',
                                          color: ColorUtils.primary_grey),
                                    ),
                                  ],
                                )),
                                GestureDetector(
                                  onTap: () {
                                    if (resend_otp == false) {
                                      _signUpScreenController.ReSendOtpAPi(
                                          context: context);
                                      if (_signUpScreenController
                                              .sendOtpModel!.error ==
                                          false) {
                                        resend_otp = true;
                                        startTimer();
                                      }
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: (resend_otp
                                            ? Border.all(
                                                color: Colors.transparent,
                                                width: 1)
                                            : Border.all(
                                                color: ColorUtils.primary_gold,
                                                width: 1))),
                                    margin: const EdgeInsets.only(
                                        top: 28, bottom: 28),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Resend',
                                        style: FontStyleUtility.h12(
                                            fontColor: HexColor('#818181'),
                                            family: 'PM'),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    await _signUpScreenController.VerifyOtpAPi(
                                        context: context);
                                    if (_signUpScreenController
                                            .signUpModel!.error ==
                                        false) {
                                      await selectTowerBottomSheet(context);
                                      Future.delayed(Duration(seconds: 2),
                                          () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FaceScanScreen()));
                                      });
                                      // (ontapped)
                                      //     ? Navigator.pop(context)
                                      //     : {
                                      //   Future.delayed(
                                      //       const Duration(seconds: 5),
                                      //           () async {
                                      //         Navigator.pop(context);
                                      //         await Navigator.push(context,
                                      //             MaterialPageRoute(
                                      //                 builder: (context) =>
                                      //                     FaceScanScreen()));
                                      //         // await Get.to(FaceScanScreen());
                                      //         // setState(() {});
                                      //       })
                                      // };
                                    }
                                  },
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        child: Text(
                                          'Verify',
                                          style: FontStyleUtility.h15(
                                              fontColor:
                                                  ColorUtils.primary_grey,
                                              family: 'PM'),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool ontapped = false;

  _listOPT() async {
    print("inseide sms");
    print(codeValue);
    await SmsAutoFill().listenForCode;
  }

  selectTowerBottomSheet(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
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
                        child: Text('OTP has been verified',
                            style: FontStyleUtility.h15(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR')),
                      ),
                      // common_button_gold(
                      //   onTap: () {
                      //     // setState(() {
                      //     ontapped = true;
                      //     print(ontapped);
                      //     // });
                      //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>FaceScanScreen()));
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => FaceScanScreen()));
                      //     // Get.to(FaceScanScreen());
                      //   },
                      //   title_text: 'Proceed',
                      // ),
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
