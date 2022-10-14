import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/homepage/controller/breathing_controller.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:klench_/utils/common_widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';

import '../Dashboard/dashboard_screen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({Key? key}) : super(key: key);

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with TickerProviderStateMixin {
  final Breathing_controller _breathing_controller =
      Get.put(Breathing_controller(), tag: Breathing_controller().toString());

  Stopwatch watch = Stopwatch();
  Stopwatch watch2 = Stopwatch();
  Timer? timer;
  Timer? timer2;
  bool startStop = true;
  bool started = true;

  String elapsedTime = '00';
  String elapsedTime2 = '00';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          print("elapsedTime $elapsedTime");
          // vibration();
          if (elapsedTime == '15') {
            stopWatch();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = '00';
              elapsedTime2 = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${9 - counter} Times left');
              counter++;
              print(counter);
              // paused_time.clear();
            });
            Future.delayed(Duration(seconds: 2), () async {
              if (counter == 10) {
                stopWatch();
                setState(() {
                  elapsedTime = '00';
                  percent = 0.0;
                  // _animationController!.dispose();

                  // watch.stop();
                  counter = 0;
                });
                _breathing_controller.sets++;
                await _breathing_controller.Breathing_post_API(context);
                // if (_breathing_controller.breathingPostModel!.error == false) {
                await getdata();
                // }
                print('Sets-------$_breathing_controller.sets');
                if (_breathing_controller.sets == 3) {
                  stopWatch();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget()
                      .showToaster(msg: "You have completed 3 sets for today");
                }
              } else {
                startWatch();
                startWatch2();
              }
            });
            // start_animation();
          }

          // percent += 1;
          // if (percent >= 100) {
          //   percent = 0.0;
          // }

          // final seconds = myDuration.inSeconds - reduceSecondsBy;
          // if (seconds < 0) {
          //   countdownTimer!.cancel();
          //   print('timesup');
          // } else {
          //   myDuration = Duration(seconds: seconds);
          // }
        });
      }
    }
  }

  updateTime2(Timer timer) {
    if (watch2.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime2 = transformMilliSeconds2(watch2.elapsedMilliseconds);
          // print("elapsedTime $elapsedTime");
          // vibration();
          if (elapsedTime2 == '05') {
            stopWatch2();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime2 = '00';
              watch2.reset();
              // paused_time.clear();
            });
            startWatch2();
            // start_animation();
          }

          // percent += 1;
          // if (percent >= 100) {
          //   percent = 0.0;
          // }

          // final seconds = myDuration.inSeconds - reduceSecondsBy;
          // if (seconds < 0) {
          //   countdownTimer!.cancel();
          //   print('timesup');
          // } else {
          //   myDuration = Duration(seconds: seconds);
          // }
        });
      }
    }
  }

  double percent = 0.0;
  bool back_wallpaper = true;

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 11);

  void startTimer() {
    countdownTimer = Timer.periodic(Duration(microseconds: 100), setCountDown);
  }

  setCountDown(Timer timer) {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
          print('timesup');
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  AnimationController? _animationController;
  Animation? _animation;
  AnimationController? _animationController_1;
  Animation? _animation_1;

  AnimationController? _animationController_shadow1;
  Animation? _animation_shadow1;
  Animation? _animation_shadow1_reverse;
  AnimationController? _animationController_shadow2;
  Animation? _animation_shadow2;

  bool animation_started = false;
  String _status = 'Hold';
  bool shadow_animation1_completed = false;
  bool shadow_animation_pause = false;
  int counter = 0;
  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 1),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 1),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 1),
    const Duration(milliseconds: 1000),
  ];

  Future<void> _init() async {
    bool? canVibrate = await Vibration.hasVibrator();
    setState(() {
      _canVibrate = canVibrate!;
      _canVibrate
          ? debugPrint('This device can vibrate')
          : debugPrint('This device cannot vibrate');
    });
  }

  vibration() async {
    if (_canVibrate) {
      // Vibration.vibrate(
      //     // pattern: [100, 100,100, 100,100, 100,100, 100,],
      //     duration: 4000,
      //     intensities: [1, 255]);
      // print(
      //     "Vibration.hasCustomVibrationsSupport() ${Vibration.hasCustomVibrationsSupport()}");

      if (await Vibration.hasCustomVibrationsSupport() == true) {
        // print("has support");

        if (Platform.isAndroid) {
          // Android-specific code
          Vibration.vibrate(
              // pattern: [100, 100,100, 100,100, 100,100, 100,],
              duration: 5000,
              intensities: [1, 255]);
        } else if (Platform.isIOS) {
          // iOS-specific code
          for (var i = 0; i <= 4; i++) {
            await Future.delayed(const Duration(seconds: 1), () {
              Vibration.vibrate();
            });
          }
        }
      } else {
        print("haddddd support");
        Vibration.vibrate();
        for (var i = 0; i <= 4; i++) {
          await Future.delayed(const Duration(seconds: 1), () {
            Vibration.vibrate();
          });
        }
        // await Future.delayed(Duration(milliseconds: 500));
        // Vibration.vibrate();
      }
      // Vibrate.defaultVibrationDuration;
      // Vibrate.defaultVibrationDuration;
      // Vibrate.vibrateWithPauses(pauses);
    } else {
      CommonWidget().showErrorToaster(msg: 'Device Cannot vibrate');
    }
  }

  vibration_hold() async {
    if (_canVibrate) {
      // Vibration.vibrate(
      //     // pattern: [100, 100,100, 100,100, 100,100, 100,],
      //     duration: 4000,
      //     intensities: [1, 255]);
      // print(
      //     "Vibration.hasCustomVibrationsSupport() ${Vibration.hasCustomVibrationsSupport()}");

      if (await Vibration.hasCustomVibrationsSupport() == true) {
        // print("has support");
        if (Platform.isAndroid) {
          // Android-specific code
          Vibration.vibrate(pattern: [
            900,
            100,
            900,
            100,
            900,
            100,
            900,
            100,
            // 400,
            // 100,
            // 400,
            // 100,
            // 400,
            // 100,
            // 400,
            // 100,
            // 400,
            // 100,
          ], intensities: [
            5,
            255
          ]);
        } else if (Platform.isIOS) {
          // iOS-specific code
          for (var i = 0; i <= 4; i++) {
            await Future.delayed(const Duration(seconds: 1), () {
              Vibration.vibrate();
            });
          }
        }
      } else {
        print("haddddd support");
        Vibration.vibrate();
        // await Future.delayed(Duration(milliseconds: 500));
        for (var i = 0; i <= 4; i++) {
          await Future.delayed(const Duration(seconds: 1), () {
            Vibration.vibrate();
          });
        }
      }
      // Vibrate.defaultVibrationDuration;
      // Vibrate.defaultVibrationDuration;
      // Vibrate.vibrateWithPauses(pauses);
    } else {
      CommonWidget().showErrorToaster(msg: 'Device Cannot vibrate');
    }
  }

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController!.forward();
    vibration();
    setState(() {
      _status = 'Inhale';
      print(_status);
    });
    _animation = Tween(begin: 150.0, end: 170.0).animate(_animationController!)
      ..addStatusListener((status) {
        // Vibrate.vibrateWithPauses(pauses);

        print(status);
        if (status == AnimationStatus.completed) {
          vibration_hold();
          setState(() {
            _status = 'Hold';

            shadow_animation_pause = true;
            _animationController_shadow2!.stop();
            Future.delayed(Duration(seconds: 5), () {
              _animationController_shadow2!.repeat(reverse: true);
              // vibration();
              setState(() {
                // print(_status);
                shadow_animation_pause = false;
              });
            });
            // print("$_status _status");
            // print("shadow_animation_pause $shadow_animation_pause");
          });
          Future.delayed(Duration(seconds: 5), () {
            _animationController!.reverse();
            // vibration();

            setState(() {
              _status = 'Exhale';
              // print(_status);
            });
          });
        } else if (status == AnimationStatus.dismissed) {
          vibration_hold();
          setState(() {
            _status = 'Hold';
            // print(_status);
          });
          Future.delayed(Duration(seconds: 5), () {
            _animationController!.forward();
            vibration();
            setState(() {
              _status = 'Inhale';
              // print(_status);
            });
          });
        }
      });

    _animationController_shadow1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController_shadow1!.forward();
    _animation_shadow1 =
        Tween(begin: 0.0, end: 40.0).animate(_animationController_shadow1!)
          ..addStatusListener((status) {
            print(status);
            if (status == AnimationStatus.completed) {
              // print("elapsedTime");
              setState(() {
                shadow_animation1_completed = true;
                // print(shadow_animation1_completed);
              });
            }
            // shadow_animation1_completed = true;
          });

    _animationController_shadow2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animationController_shadow2!.repeat(reverse: true);
    _animation_shadow2 =
        Tween(begin: 40.0, end: 42.0).animate(_animationController_shadow2!)
          ..addStatusListener((status) {
            if (shadow_animation_pause == true) {}
            // print(status);
            // if (status == AnimationStatus.completed) {}
            // shadow_animation1_completed = true;
          });

    print(_animationController!.status);
  }

  AnimationController? _animationController_middle;
  Animation? _animation_middle;
  bool animation_started_middle = false;
  Animation? _animation_middle2;
  Animation? _animation_middle3;
  Animation? _animation_middle4;

  middle_animation() {
    setState(() {
      animation_started_middle = true;
    });
    _animationController_middle = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController_middle!.forward();
    _animation_middle =
    Tween(begin: 15.0, end: 30.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        // print(status);
        // shadow_animation1_completed = true;
      });
    _animation_middle2 =
    Tween(begin: 15.0, end: 60.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        // print(status);
        // shadow_animation1_completed = true;
      });
    _animation_middle3 =
    Tween(begin: 15.0, end: 160.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        // print(status);
        // shadow_animation1_completed = true;
      });
    _animation_middle4 =
    Tween(begin: 15.0, end: 120.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        // print(status);
        // shadow_animation1_completed = true;
      });
  }

  @override
  dispose() {
    if (animation_started == true) {
      _animationController!.dispose();
      _animationController_shadow1!.dispose();
      _animationController_shadow2!.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    // init();
    getdata();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //  await  _breathing_controller.Breathing_get_API(context);
    //  if(_breathing_controller.breathingGetModel!.error == false){
    //  }
    // });
  }

  Future getdata() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _breathing_controller.Breathing_get_API(context);
      if (_breathing_controller.breathingGetModel!.error == false) {
        setState(() {
          _breathing_controller.sets = int.parse(
              _breathing_controller.breathingGetModel!.data![0].sets!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final seconds = myDuration.inSeconds.remainder(60);
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
          // decoration: BoxDecoration(
          //
          //   image: DecorationImage(
          //     image: AssetImage(AssetUtils.backgroundImage), // <-- BACKGROUND IMAGE
          //     fit: BoxFit.cover,
          //   ),
          // ),
          decoration: (back_wallpaper
              ? BoxDecoration(
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
                        Colors.black.withOpacity(0.5), BlendMode.dst),
                    image: AssetImage(
                      AssetUtils.b_screen_back,
                    ),
                  ),
                )
              : BoxDecoration()),
        ),
        Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   automaticallyImplyLeading: false,
            //   title: Text(
            //     Textutils.breathing,
            //     style: FontStyleUtility.h16(
            //         fontColor: ColorUtils.primary_gold, family: 'PM'),
            //   ),
            //   centerTitle: true,
            //   actions: [
            //     Container(
            //         margin: EdgeInsets.symmetric(horizontal: 10),
            //         alignment: Alignment.center,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               AssetUtils.star_icon,
            //               color: (_breathing_controller.sets >= 1
            //                   ? ColorUtils.primary_gold
            //                   : Colors.grey),
            //               height: 22,
            //               width: 22,
            //             ),
            //             SizedBox(
            //               width: 7,
            //             ),
            //             Image.asset(
            //               AssetUtils.star_icon,
            //               height: 22,
            //               color: (_breathing_controller.sets >= 2
            //                   ? ColorUtils.primary_gold
            //                   : Colors.grey),
            //               width: 22,
            //             ),
            //             SizedBox(
            //               width: 7,
            //             ),
            //             Image.asset(
            //               AssetUtils.star_icon,
            //               color: (_breathing_controller.sets >= 3
            //                   ? ColorUtils.primary_gold
            //                   : Colors.grey),
            //               height: 22,
            //               width: 22,
            //             ),
            //           ],
            //         )),
            //
            //     // IconButton(
            //     //     onPressed: () {},
            //     //     icon: Icon(
            //     //       Icons.notifications_none_rounded,
            //     //       color: ColorUtils.primary_gold,
            //     //     ))
            //   ],
            // ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    snap: false,
                    pinned: false,
                    stretch: false,
                    floating: false,
                    // title: Text(
                    //   Textutils.breathing,
                    //   style: FontStyleUtility.h16(
                    //       fontColor: ColorUtils.primary_gold, family: 'PM'),
                    // ),
                    centerTitle: true,
                    actions: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Obx(() => (_breathing_controller
                                      .isuserinfoLoading.value ==
                                  true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AssetUtils.star_icon,
                                      color: Colors.grey,
                                      height: 22,
                                      width: 22,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Image.asset(
                                      AssetUtils.star_icon,
                                      height: 22,
                                      color: Colors.grey,
                                      width: 22,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Image.asset(
                                      AssetUtils.star_icon,
                                      color: Colors.grey,
                                      height: 22,
                                      width: 22,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AssetUtils.star_icon,
                                      color: (int.parse(_breathing_controller
                                                  .breathingGetModel!
                                                  .data![_breathing_controller
                                                          .breathingGetModel!
                                                          .data!
                                                          .length -
                                                      1]
                                                  .sets!) >=
                                              1
                                          ? ColorUtils.primary_gold
                                          : Colors.grey),
                                      height: 22,
                                      width: 22,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Image.asset(
                                      AssetUtils.star_icon,
                                      height: 22,
                                      color: (int.parse(_breathing_controller
                                                  .breathingGetModel!
                                                  .data![_breathing_controller
                                                          .breathingGetModel!
                                                          .data!
                                                          .length -
                                                      1]
                                                  .sets!) >=
                                              2
                                          ? ColorUtils.primary_gold
                                          : Colors.grey),
                                      width: 22,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Image.asset(
                                      AssetUtils.star_icon,
                                      color: (int.parse(_breathing_controller
                                                  .breathingGetModel!
                                                  .data![_breathing_controller
                                                          .breathingGetModel!
                                                          .data!
                                                          .length -
                                                      1]
                                                  .sets!) >=
                                              3
                                          ? ColorUtils.primary_gold
                                          : Colors.grey),
                                      height: 22,
                                      width: 22,
                                    ),
                                  ],
                                )))),

                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.notifications_none_rounded,
                      //       color: ColorUtils.primary_gold,
                      //     ))
                    ],
                  ),
                ];
              },
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CircularPercentIndicator(
                      //   circularStrokeCap: CircularStrokeCap.round,
                      //   percent: percent / 100,
                      //   animation: true,
                      //   animateFromLastPercent: true,
                      //   radius: 67,
                      //   lineWidth: 0,
                      //   progressColor: Colors.white,
                      //   backgroundColor: Colors.transparent,
                      //   center: Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(color: ColorUtils.primary_gold, width: 10),
                      //         borderRadius: BorderRadius.circular(100)),
                      //     child: Container(
                      //       height: 130,
                      //       width: 130,
                      //       decoration: BoxDecoration(
                      //           color: ColorUtils.primary_gold,
                      //           border: Border.all(color: Colors.black, width: 10),
                      //           borderRadius: BorderRadius.circular(100)),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           IconButton(
                      //             alignment: Alignment.center,
                      //             // visualDensity:
                      //             //     VisualDensity(vertical: -4, horizontal: -4),
                      //             padding: EdgeInsets.only(left: 0.0),
                      //             icon: Image.asset(AssetUtils.breathe_icon,
                      //                 color:
                      //                 Colors.black,
                      //                 height: 40,
                      //                 width: 40),
                      //             onPressed: () {
                      //
                      //             },
                      //           ),
                      //           Container(
                      //             alignment: Alignment.center,
                      //             child: CircleAvatar(
                      //               maxRadius: 20,
                      //               backgroundColor: Colors.black,
                      //               child: Text(
                      //                 elapsedTime,
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 20,
                      //                     fontFamily: 'PR',
                      //                     fontWeight: FontWeight.w900),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      //
                      // ),

                      Container(
                        height: (screenHeight >= 600 && screenHeight <= 700
                            ? (animation_started_middle
                            ? _animation_middle2!.value
                            : 15)
                            : (screenHeight >= 700 && screenHeight <= 800
                            ? (animation_started_middle
                            ? _animation_middle!.value
                            : 15)
                            : (screenHeight >= 800 && screenHeight <= 850
                            ? (animation_started_middle
                            ? _animation_middle4!.value
                            : 15)
                            : (screenHeight >= 850
                            ? (animation_started_middle
                            ? _animation_middle3!.value
                            : 15)
                            : 0)))),
                      ),


                      AvatarGlow(
                          endRadius: 130.0,
                          showTwoGlows: true,
                          animate: false,
                          // (startStop ? false : true),
                          duration: Duration(milliseconds: 900),
                          repeat: true,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: (animation_started
                                  //         ? HexColor('#F5C921')
                                  //         : Colors.transparent),
                                  //     blurRadius: (animation_started
                                  //         ? _animation!.value
                                  //         : 0),
                                  //     spreadRadius: (animation_started
                                  //         ? _animation!.value
                                  //         : 0),
                                  //   )
                                  // ]
                                  boxShadow: [
                                    BoxShadow(
                                      color: (animation_started
                                          ? ColorUtils.primary_gold

                                          : Colors.transparent),
                                      spreadRadius: (animation_started
                                          ? (shadow_animation1_completed
                                              ? _animation_shadow2!.value
                                              : _animation_shadow1!.value)
                                          : 0),
                                      blurRadius: 35,
                                    )
                                  ],
                                ),
                              ),


                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 7.5,
                                dashPattern: [0, 19],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 350,
                                  width: 350,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 7.5,
                                dashPattern: [0, 19],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 320,
                                  width: 320,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 7,
                                dashPattern: [0, 19],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 290,
                                  width: 290,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 8,
                                dashPattern: [0, 19],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 265,
                                  width: 265,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 7,
                                dashPattern: [0, 18],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 240,
                                  width: 240,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 6,
                                dashPattern: [0, 16],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 220,
                                  width: 220,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 5,
                                dashPattern: [0, 14],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 4,
                                dashPattern: [0, 12],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 180,
                                  width: 180,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              (animation_started
                                  ? DottedBorder(
                                borderType: BorderType.Oval,
                                strokeWidth: 3,
                                dashPattern: [0, 10],
                                strokeCap: StrokeCap.round,
                                radius: Radius.circular(100),
                                padding: EdgeInsets.all(0),
                                color: Colors.black,
                                child: Container(
                                  height: 160,
                                  width: 160,
                                  padding: EdgeInsets.all(5),
                                ),
                              )
                                  : SizedBox.shrink()),
                              Container(
                                height: (animation_started
                                    ? _animation!.value
                                    : 150),
                                width: (animation_started
                                    ? _animation!.value
                                    : 150),
                                decoration: (animation_started
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Color(0xFFFCF483),
                                            width: 2.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorUtils
                                                .primary_gold, // darker color
                                          ),
                                          BoxShadow(
                                            color: HexColor('#000000'),
                                            // background color
                                            spreadRadius: -7.0,
                                            blurRadius: 10.0,
                                          ),
                                        ],
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       color:
                                        //       ColorUtils.primary_gold.withOpacity(0.5),
                                        //       spreadRadius: (animation_started
                                        //           ? (shadow_animation1_completed
                                        //           ? _animation_shadow2!.value
                                        //           : _animation_shadow1!.value)
                                        //           : 0),
                                        //       blurRadius: 0)
                                        // ],
                                      )
                                    : const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            alignment: Alignment.center,
                                            image: AssetImage(
                                                AssetUtils.home_button)),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: (animation_started
                                        //         ? HexColor('#F5C921')
                                        //         : Colors.transparent),
                                        //     blurRadius: (animation_started
                                        //         ? _animation!.value
                                        //         : 0),
                                        //     spreadRadius: (animation_started
                                        //         ? _animation!.value
                                        //         : 0),
                                        //   )
                                        // ]
                                      )),
                                // BoxDecoration(
                                //     // border: Border.all(
                                //     //     color: ColorUtils.primary_gold, width: 10),
                                //     boxShadow: [
                                //       BoxShadow(
                                //           color:
                                //               ColorUtils.primary_gold.withOpacity(0.5),
                                //           spreadRadius: (animation_started
                                //               ? (shadow_animation1_completed
                                //                   ? _animation_shadow2!.value
                                //                   : _animation_shadow1!.value)
                                //               : 0),
                                //           blurRadius: 35)
                                //     ],
                                //     borderRadius: BorderRadius.circular(200)),
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     color: ColorUtils.primary_gold,
                                  //     border:
                                  //         Border.all(color: Colors.black, width: 10),
                                  //     borderRadius: BorderRadius.circular(100)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // IconButton(
                                      //   alignment: Alignment.center,
                                      //   // visualDensity:
                                      //   //     VisualDensity(vertical: -4, horizontal: -4),
                                      //   padding: EdgeInsets.only(left: 0.0),
                                      //   icon: Image.asset(AssetUtils.breathe_icon,
                                      //       color: Colors.black, height: 40, width: 40),
                                      //   onPressed: () {},
                                      // ),
                                      Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text('Breathe',
                                                  style: GoogleFonts
                                                      .sourceSerifPro(
                                                    textStyle: TextStyle(
                                                        color:(timer_started? HexColor('#F5C921').withOpacity(0.4):HexColor('#F5C921')),
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  (timer_started
                                                      ? _status
                                                      : ''),
                                                  style: FontStyleUtility.h18(
                                                      fontColor: Colors.white,
                                                      family: 'PSB'),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    (timer_started
                                                        ? elapsedTime2
                                                        : ''),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'PR',
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                        height: (screenHeight >= 600 && screenHeight <= 700
                            ? (animation_started_middle
                            ? _animation_middle2!.value
                            : 15)
                            : (screenHeight >= 700 && screenHeight <= 800
                            ? (animation_started_middle
                            ? _animation_middle!.value
                            : 15)
                            : (screenHeight >= 800 && screenHeight <= 850
                            ? (animation_started_middle
                            ? _animation_middle4!.value
                            : 15)
                            : (screenHeight >= 850
                            ? (animation_started_middle
                            ? _animation_middle3!.value
                            : 15)
                            : 0)))),
                      ),

                      Text(('$counter/10'),
                          style: FontStyleUtility.h25(
                              fontColor: ColorUtils.primary_gold,
                              family: 'PM')),
                      SizedBox(
                        height: 12,
                      ),

                      GestureDetector(
                        onTap: () {
                          if (_breathing_controller.breathingGetModel!.error ==
                                  false &&
                              int.parse(_breathing_controller
                                      .breathingGetModel!.data![0].sets!) >=
                                  3) {
                            print(int.parse(_breathing_controller
                                .breathingGetModel!.data![0].sets!));
                            CommonWidget().showErrorToaster(
                                msg: "You completed your today's sets");
                          } else {
                            if (startStop) {
                              if (_breathing_controller.sets <= 3) {
                                startWatch();
                                middle_animation();
                                back_wallpaper = false;

                              } else {
                                CommonWidget().showErrorToaster(
                                    msg:
                                        "You have completed your today's sets, comback tommorow");
                              }
                            } else {
                              stopWatch();
                              setState(() {
                                back_wallpaper = true;
                                animation_started_middle = false;
                                timer_started = false;
                                _animationController!.dispose();
                                elapsedTime = '00';
                                percent = 0.0;
                                watch.reset();
                                counter == 0;
                                // paused_time.clear();
                              });
                            }
                          }

                          // startOrStop();
                        },
                        child: Container(
                          height: 65,
                          // height: 45,
                          // width:(width ?? 300) ,
                          decoration: BoxDecoration(
                              color: ColorUtils.primary_gold,
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  HexColor("#ECDD8F").withOpacity(0.90),
                                  HexColor("#E5CC79").withOpacity(0.90),
                                  HexColor("#CE952F").withOpacity(0.90),
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
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: Text(
                                (startStop ? 'Start' : 'Finish'),
                                style: FontStyleUtility.h16(
                                    fontColor: Colors.black, family: 'PM'),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.58),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              // stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                HexColor("#020204").withOpacity(0.8),
                                // HexColor("#151619").withOpacity(0.63),
                                HexColor("#36393E").withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
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
                                        margin: EdgeInsets.symmetric(),
                                        child: Text(
                                          'Breathing information',
                                          style: FontStyleUtility.h15(
                                              fontColor: HexColor('#AAAAAA'),
                                              family: 'PM'),
                                        )),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        // color: Colors.black.withOpacity(0.65),
                                        //   gradient: LinearGradient(
                                        //     begin: Alignment.centerLeft,
                                        //     end: Alignment.centerRight,
                                        //     // stops: [0.1, 0.5, 0.7, 0.9],
                                        //     colors: [
                                        //       HexColor("#020204").withOpacity(1),
                                        //       HexColor("#36393E").withOpacity(1),
                                        //     ],
                                        //   ),
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: HexColor('#04060F'),
                                        //       offset: Offset(10,10),
                                        //       blurRadius: 20,
                                        //     ),
                                        //   ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              '1. Inhale 4',
                                              style: FontStyleUtility.h15(
                                                  fontColor:
                                                      HexColor('#DCDCDC'),
                                                  family: 'PR'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Container(
                                            child: Text(
                                              '2. Hold 4 sec',
                                              style: FontStyleUtility.h15(
                                                  fontColor:
                                                      HexColor('#DCDCDC'),
                                                  family: 'PR'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Container(
                                            child: Text(
                                              '3. Exhale 4 sec',
                                              style: FontStyleUtility.h15(
                                                  fontColor:
                                                      HexColor('#DCDCDC'),
                                                  family: 'PR'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Container(
                                            child: Text(
                                              '4. Repeat process 10 times is consider 1 set',
                                              style: FontStyleUtility.h15(
                                                  fontColor:
                                                      HexColor('#DCDCDC'),
                                                  family: 'PR'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Container(
                                            child: Text(
                                              '5. After user completes 1 set, user will receive the color star',
                                              style: FontStyleUtility.h15(
                                                  fontColor:
                                                      HexColor('#DCDCDC'),
                                                  family: 'PR'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 17,
                                          ),
                                          Container(
                                            child: Text(
                                              '6. Star will reset daily',
                                              style: FontStyleUtility.h15(
                                                  fontColor:
                                                      HexColor('#DCDCDC'),
                                                  family: 'PR'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 110,
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  bool timer_started = false;

  startWatch() {
    startWatch2();
    // countdownTimer =
    //     Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    vibration();
    start_animation();
    setState(() {
      timer_started = true;

      startStop = false;
      watch.start();
      // startTimer();
      timer = Timer.periodic(Duration(microseconds: 100), updateTime);
    });
  }

  startWatch2() {
    // countdownTimer =
    //     Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    setState(() {
      watch2.start();
      // startTimer();
      timer2 = Timer.periodic(Duration(microseconds: 100), updateTime2);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      Vibration.cancel();
      animation_started = false;
      _animationController!.stop();
      _animationController_shadow1!.stop();
      watch.stop();
      watch2.stop();
      percent = 0.0;
      setTime();
      setTime2();
      print("___________$counter");
    });
  }

  stopWatch2() {
    setState(() {
      watch2.stop();
      setTime2();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
    print("elapsedTime $elapsedTime");
  }

  setTime2() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime2 = transformMilliSeconds2(timeSoFar);
    });
    print("elapsedTime $elapsedTime2");
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return secondsStr;
  }

  transformMilliSeconds2(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return secondsStr;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
