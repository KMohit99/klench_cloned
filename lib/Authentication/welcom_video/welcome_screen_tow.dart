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

class WelcomeVideoScreen2 extends StatefulWidget {
  final bool signup;

  const WelcomeVideoScreen2({Key? key, required this.signup}) : super(key: key);

  @override
  State<WelcomeVideoScreen2> createState() => _WelcomeVideoScreenState();
}

class _WelcomeVideoScreenState extends State<WelcomeVideoScreen2> {
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

  skipper() {
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
    // Future.delayed(Duration.zero, () => pop_up(context));
    final seconds = myDuration!.inSeconds.remainder(60);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenHeight);
    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   // stops: [0.1, 0.5, 0.7, 0.9],
            //   colors: [
            //     HexColor("#000000").withOpacity(0.86),
            //     HexColor("#000000").withOpacity(0.81),
            //     HexColor("#000000").withOpacity(0.44),
            //     HexColor("#000000").withOpacity(1),
            //
            //   ],
            // ),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              image: AssetImage(
                AssetUtils.home_back,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              // title: Container(
              //   alignment: Alignment.center,
              //   child: Container(
              //       width: 170,
              //       margin: EdgeInsets.only(bottom: 10, top: 10),
              //       child: Image.asset(AssetUtils.Logo_white_icon)),
              // ),
              centerTitle: true,
              actions: [
                // GestureDetector(
                //   onTap: (){
                //     Get.to(NotificationsScreen());
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
                //           AssetUtils.notification_icon,
                //           color: ColorUtils.primary_gold,
                //           height: 22,
                //           width: 18,
                //         ),
                //       )),
                // )
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Container(
              //     margin: EdgeInsets.symmetric(horizontal: 10),
              //     alignment: Alignment.topCenter,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Image.asset(
              //           AssetUtils.star_icon,
              //           height: 22,
              //           width: 22,
              //         ),
              //         SizedBox(
              //           width: 7,
              //         ),
              //         Image.asset(
              //           AssetUtils.star_icon,
              //           height: 22,
              //           width: 22,
              //         ),
              //         SizedBox(
              //           width: 7,
              //         ),
              //         Image.asset(
              //           AssetUtils.star_icon,
              //           height: 22,
              //           width: 22,
              //         ),
              //       ],
              //     )),

              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: (screenHeight >= 600 && screenHeight <= 700
                          ? 30
                          : (screenHeight >= 700 && screenHeight <= 800
                          ? 55
                          : (screenHeight >= 800 ? 80 : 0))))),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                        Container(
                          alignment: Alignment.center,
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
                              // (trial == 'true'
                              //     ? await Get.to(DashboardScreen())
                              //     :
                              // await Get.to(SubscriptionScreen());
                             final trial = await PreferenceManager().getPref(URLConstants.trial);

                              // (trial == 'true'
                              //     ?
                              // await Get.to(DashboardScreen())
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) =>
                                      DashboardScreen(page: 1,),
                                  transitionsBuilder:
                                      (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim,
                                          child: child),
                                  transitionDuration:
                                  Duration(milliseconds: 1000),
                                ),
                              );
                              //     :
                              // // await Get.to(SubscriptionScreen())
                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilder(
                              //     pageBuilder: (c, a1, a2) =>
                              //         SubscriptionScreen(),
                              //     transitionsBuilder:
                              //         (c, anim, a2, child) =>
                              //         FadeTransition(
                              //             opacity: anim,
                              //             child: child),
                              //     transitionDuration:
                              //     Duration(milliseconds: 2000),
                              //   ),
                              // ));
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
              ),
            ],
          ),
          // bottomNavigationBar: BottomAppBar(
          //   color: Colors.transparent,
          //   shape: CircularNotchedRectangle(),
          //   child: Container(
          //     margin: EdgeInsets.symmetric(vertical: 5,horizontal: 19),
          //     decoration: BoxDecoration(
          //       // color: Colors.black.withOpacity(0.65),
          //         gradient: LinearGradient(
          //           begin: Alignment.centerLeft,
          //           end: Alignment.centerRight,
          //           // stops: [0.1, 0.5, 0.7, 0.9],
          //           colors: [
          //             HexColor("#020204").withOpacity(1),
          //             HexColor("#36393E").withOpacity(1),
          //           ],
          //         ),
          //         boxShadow: [
          //           BoxShadow(
          //               color: HexColor('#04060F'),
          //               offset: Offset(10, 10),
          //               blurRadius: 10)
          //         ],
          //         borderRadius: BorderRadius.circular(20)),
          //     // color: Colors.black,
          //     height: 65,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         // Container(
          //         //   margin: EdgeInsets.only(top: 0.5, right: 25, left: 25),
          //         //   height: 1,
          //         //   color: ColorUtils.dark_grey.withOpacity(0.5),
          //         // ),
          //         Row(
          //           mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Container(
          //               decoration: BoxDecoration(
          //                 // color: Colors.black.withOpacity(0.65),
          //                   gradient: LinearGradient(
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight,
          //                     // stops: [0.1, 0.5, 0.7, 0.9],
          //                     colors: [
          //                       HexColor("#36393E").withOpacity(1),
          //                       HexColor("#020204").withOpacity(1),
          //
          //                     ],
          //                   ),
          //                   boxShadow: [
          //                     BoxShadow(
          //                         color: HexColor('#04060F'),
          //                         offset: Offset(3, 3),
          //                         blurRadius: 10)
          //                   ],
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(4.0),
          //                 child: Column(
          //                   children: [
          //                     IconButton(
          //                       iconSize: 30.0,
          //                       visualDensity:
          //                       VisualDensity(vertical: -4, horizontal: -4),
          //                       padding: EdgeInsets.only(left: 0.0),
          //                       icon: Image.asset(AssetUtils.profile_icon,
          //                           color: ColorUtils.primary_gold,
          //                           height: 20, width: 20),
          //                       onPressed: () {
          //                       },
          //                     ),
          //
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                 // color: Colors.black.withOpacity(0.65),
          //                   gradient: LinearGradient(
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight,
          //                     // stops: [0.1, 0.5, 0.7, 0.9],
          //                     colors: [
          //                       HexColor("#36393E").withOpacity(1),
          //                       HexColor("#020204").withOpacity(1),
          //
          //                     ],
          //                   ),
          //                   boxShadow: [
          //                     BoxShadow(
          //                         color: HexColor('#04060F'),
          //                         offset: Offset(3, 3),
          //                         blurRadius: 10)
          //                   ],
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(4.0),
          //                 child: Column(
          //                   children: [
          //                     IconButton(
          //                       iconSize: 30.0,
          //                       visualDensity:
          //                       VisualDensity(vertical: -4, horizontal: -4),
          //                       padding: EdgeInsets.only(left: 0.0),
          //                       icon: Image.asset(AssetUtils.home_icon,
          //                           color:ColorUtils.primary_gold,
          //                           height: 20, width: 20),
          //                       onPressed: () {
          //
          //                       },
          //                     ),
          //                     // Text(
          //                     //   'Home',
          //                     //   style: FontStyleUtility.h10(
          //                     //       fontColor: (_page == 1
          //                     //           ? ColorUtils.primary_gold
          //                     //           : ColorUtils.primary_grey),family: 'PM'),
          //                     // )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                 // color: Colors.black.withOpacity(0.65),
          //                   gradient: LinearGradient(
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight,
          //                     // stops: [0.1, 0.5, 0.7, 0.9],
          //                     colors: [
          //                       HexColor("#36393E").withOpacity(1),
          //                       HexColor("#020204").withOpacity(1),
          //
          //                     ],
          //                   ),
          //                   boxShadow: [
          //                     BoxShadow(
          //                         color: HexColor('#04060F'),
          //                         offset: Offset(3, 3),
          //                         blurRadius: 10)
          //                   ],
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(4.0),
          //                 child: Column(
          //                   children: [
          //                     IconButton(
          //                       iconSize: 30.0,
          //                       visualDensity:
          //                       VisualDensity(vertical: -4, horizontal: -4),
          //                       padding: EdgeInsets.only(left: 0.0),
          //                       icon: Image.asset(AssetUtils.breathe_icon,
          //                           color: ColorUtils.primary_gold,
          //                           height: 20, width: 20),
          //                       onPressed: () {
          //
          //                       },
          //                     ),
          //                     // Text(
          //                     //   'Breathing',
          //                     //   style: FontStyleUtility.h10(
          //                     //       fontColor: (_page == 2
          //                     //           ? ColorUtils.primary_gold
          //                     //           : ColorUtils.primary_grey) , family: 'PM'),
          //                     // )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                 // color: Colors.black.withOpacity(0.65),
          //                   gradient: LinearGradient(
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight,
          //                     // stops: [0.1, 0.5, 0.7, 0.9],
          //                     colors: [
          //                       HexColor("#36393E").withOpacity(1),
          //                       HexColor("#020204").withOpacity(1),
          //
          //                     ],
          //                   ),
          //                   boxShadow: [
          //                     BoxShadow(
          //                         color: HexColor('#04060F'),
          //                         offset: Offset(3, 3),
          //                         blurRadius: 10)
          //                   ],
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(4.0),
          //                 child: Column(
          //                   children: [
          //                     IconButton(
          //                       iconSize: 30.0,
          //                       visualDensity:
          //                       VisualDensity(vertical: -4, horizontal: -4),
          //                       padding: EdgeInsets.only(left: 0.0),
          //                       icon: Image.asset(AssetUtils.settings_icon,
          //                           color: ColorUtils.primary_gold,
          //                           height: 20, width: 20),
          //                       onPressed: () {
          //
          //                       },
          //                     ),
          //                     // Text(
          //                     //   'Settings',
          //                     //   style: FontStyleUtility.h10(
          //                     //       fontColor: (_page == 3
          //                     //           ? ColorUtils.primary_gold
          //                     //           : ColorUtils.primary_grey), family: 'PM'),
          //                     // )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         // Container(
          //         //   margin: EdgeInsets.only(bottom: 5, right: 25, left: 25),
          //         //   height: 1,
          //         //   color: ColorUtils.dark_grey.withOpacity(0.5),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),

        ),
      ],
    );
  }
}
