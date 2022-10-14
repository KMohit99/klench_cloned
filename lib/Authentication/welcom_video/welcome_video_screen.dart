import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/subscription_plan/subscription_plan_screen.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:video_player/video_player.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/colorUtils.dart';

class WelcomeVideoScreen extends StatefulWidget {
  final bool signup;

  const WelcomeVideoScreen({Key? key, required this.signup}) : super(key: key);

  @override
  State<WelcomeVideoScreen> createState() => _WelcomeVideoScreenState();
}

class _WelcomeVideoScreenState extends State<WelcomeVideoScreen> {
  // BetterPlayerController? _betterPlayerController;
  VideoPlayerController? _controller;

  bool video_skip = false;

  @override
  void initState() {
    // video_code();
    // better_player_code();
    startTimer();

    super.initState();

    Future.delayed(Duration(seconds: 30), () {
      skipper();
      // Do something
    });
    _controller = VideoPlayerController.asset('assets/images/small.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    // _betterPlayerController!.dispose();
    super.dispose();
  }
  String? trial;

  skipper() async {
     trial = await PreferenceManager().getPref(URLConstants.trial);

    setState(() {
      video_skip = true;
    });
    print(video_skip);
  }
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
        print('timesup');
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final seconds = myDuration!.inSeconds.remainder(60);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        decoration: Common_decoration(),
        height: MediaQuery.of(context).size.height,
      ),
      Scaffold(
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
          //               colors: [HexColor('#020204'), HexColor('#36393E')])),
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: Image.asset(
          //           AssetUtils.arrow_back,
          //           height: 14,
          //           width: 15,
          //         ),
          //       )),
          // ),
          title: Container(
            child: Container(
                height: 40,
                width: 170,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 0, bottom: 0),
                child: Image.asset(AssetUtils.Logo_white_icon)),
          ),
          // Text(
          //   Textutils.appName,
          //   style: FontStyleUtility.h16(
          //       fontColor: ColorUtils.primary_grey, family: 'PM'),
          // ),
          centerTitle: true,
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     Get.to(SubscriptionScreen());
            //   },
            //   child: Container(
            //     alignment: Alignment.center,
            //     margin: EdgeInsets.only(right: 30),
            //     child: Text(
            //       'Skip',
            //       textAlign: TextAlign.center,
            //       style: FontStyleUtility.h14(
            //           fontColor: Colors.white, family: 'PR'),
            //     ),
            //   ),
            // )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(left: 20, right: 20, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 45),
                  child: Text(
                    'Welcome video',
                    style: FontStyleUtility.h15(
                        fontColor: ColorUtils.primary_grey, family: 'PM'),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Container(
                        //   child: Stack(
                        //     alignment: Alignment.center,
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.all(8),
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(12),
                        //           child: Stack(
                        //             alignment: Alignment.center,
                        //             children: [
                        //               Container(
                        //                 height: screenHeight / 4,
                        //                 width: screenWidth/1.3,
                        //                 child:
                        //                 Image.asset(AssetUtils.video_img,fit: BoxFit.fitWidth,),
                        //               ),
                        //               Container(
                        //                 child: Container(
                        //                   width: screenWidth/1.3,
                        //                   height: screenHeight / 4,
                        //                   color: HexColor('#000000')
                        //                       .withOpacity(0.65),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //
                        //       GestureDetector(
                        //         onTap:
                        //             () {
                        //           Navigator.pop(
                        //               context);
                        //         },
                        //         child:
                        //         Container(
                        //           height: screenHeight / 4,
                        //           width: screenWidth/1.3,
                        //           margin: EdgeInsets.only(
                        //               left:
                        //               10,bottom: 10),
                        //           alignment:
                        //           Alignment.topRight,
                        //           child:
                        //           Container(
                        //               decoration:
                        //               BoxDecoration(
                        //                 // color: Colors.black.withOpacity(0.65),
                        //                   gradient:
                        //                   LinearGradient(
                        //                     begin: Alignment.centerLeft,
                        //                     end: Alignment.centerRight,
                        //                     // stops: [0.1, 0.5, 0.7, 0.9],
                        //                     colors: [
                        //                       HexColor("#36393E").withOpacity(1),
                        //                       HexColor("#020204").withOpacity(1),
                        //                     ],
                        //                   ),
                        //                   boxShadow: [
                        //                     BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)
                        //                   ],
                        //                   borderRadius: BorderRadius.circular(20)),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(4.0),
                        //                 child: Icon(
                        //                   Icons.cancel_outlined,
                        //                   size: 13,
                        //                   color: ColorUtils.primary_grey,
                        //                 ),
                        //               )),
                        //         ),
                        //       ),
                        //       Container(
                        //         height: 40,
                        //         width: 40,
                        //         alignment: FractionalOffset.center,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(100),
                        //             color: ColorUtils.primary_gold),
                        //         child: IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(
                        //             Icons.play_arrow,
                        //             color: Colors.black87,
                        //           ),
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         // Container(
                        //         //   decoration: BoxDecoration(
                        //         //       gradient: LinearGradient(
                        //         //         begin: Alignment.bottomLeft,
                        //         //         end: Alignment.topRight,
                        //         //         colors: [
                        //         //           HexColor("#020204").withOpacity(
                        //         //               1),
                        //         //           HexColor("#36393E").withOpacity(
                        //         //               1),
                        //         //         ],
                        //         //       ),
                        //         //       boxShadow: [
                        //         //         BoxShadow(
                        //         //           color: HexColor('#2E2E2D'),
                        //         //           offset: Offset(0, 3),
                        //         //           blurRadius: 6,
                        //         //         ),
                        //         //         BoxShadow(
                        //         //           color: HexColor('#04060F'),
                        //         //           offset: Offset(10, 10),
                        //         //           blurRadius: 20,
                        //         //         ),
                        //         //       ],
                        //         //       borderRadius: BorderRadius.circular(
                        //         //           50)),
                        //         //   child: IconButton(
                        //         //     visualDensity: VisualDensity(
                        //         //         horizontal: -4, vertical: -4),
                        //         //     onPressed: () {},
                        //         //     icon: Icon(Icons.access_time_rounded),
                        //         //     color: ColorUtils.primary_grey,
                        //         //   ),
                        //         // ),
                        //         SizedBox(
                        //           width: 7,
                        //         ),
                        //         Text(
                        //           '${seconds} S',
                        //           style: TextStyle(
                        //               fontSize: 12,
                        //               fontFamily: 'PR',
                        //               color: ColorUtils.primary_grey),
                        //         ),
                        //       ],
                        //     )),

                        Container(
                          child: _controller!.value.isInitialized
                              ? Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: VideoPlayer(_controller!)),
                                  ),
                                )
                              : Container(),
                        ),

                        (video_skip
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: common_button_gold(
                                  onTap: () async {
                                    await _controller!.pause();
                                    // (widget.signup
                                    //     ? await Get.to(SubscriptionScreen())
                                    //     : await Get.to(DashboardScreen()));
                                    (trial == 'true'
                                        ? await Get.to(DashboardScreen(page: 1,))
                                        :
                                    await Get.to(SubscriptionScreen()));
                                  },
                                  title_text: 'Skip',
                                ),
                              )
                            :
                        // SizedBox.shrink()
                        Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: common_button_black(
                                  onTap: () async {
                                  },
                                  title_text: 'Skip (${seconds}) S',
                                ),
                              )
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
    ]);
  }
}
