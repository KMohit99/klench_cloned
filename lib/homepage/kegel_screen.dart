import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform, sleep;
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:klench_/homepage/controller/kegel_excercise_controller.dart';
import 'package:klench_/homepage/swipe_controller.dart';
import 'package:klench_/homepage/theme_data.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibration/vibration.dart';

import '../Authentication/SingIn/controller/SignIn_controller.dart';
import '../main.dart';
import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';
import '../utils/page_loader.dart';
import 'Breathing_screen.dart';
import 'alarm_helper.dart';
import 'alarm_info.dart';
import 'model/AlarmPostModel.dart';

class KegelScreen extends StatefulWidget {
  KegelScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<KegelScreen> createState() => _KegelScreenState();
}
// @override
// State<StatefulWidget> createState() {
//   _MyQuizAppState createState() => _MyQuizAppState();
// }

class _KegelScreenState extends State<KegelScreen>
    with TickerProviderStateMixin {
  final Kegel_controller _kegel_controller =
      Get.put(Kegel_controller(), tag: Kegel_controller().toString());

  Stopwatch watch = Stopwatch();
  Stopwatch watch3 = Stopwatch();

  Timer? timer;
  Timer? timer3;

  bool startStop = true;
  bool started = true;

  String elapsedTime = '00';
  String elapsedTime2 = '00';

  TextEditingController Alarm_title = new TextEditingController();
  List Alarm_title_list = [];

  // updateTime(Timer timer) {
  //   if (watch.isRunning) {
  //     if (mounted) {
  //       setState(() {
  //         print("startstop Inside=$startStop");
  //         elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
  //         // percent += 1;
  //         // if (percent >= 100) {
  //         //   percent = 0.0;
  //         // }
  //         print(elapsedTime);
  //
  //         if (elapsedTime == '05') {
  //           stopWatch_finish();
  //           // _animationController_shadow1!.reverse();
  //           setState(() {
  //             elapsedTime = '00';
  //             percent = 0.0;
  //             watch.reset();
  //             CommonWidget().showToaster(msg: '${9 - counter} Times left');
  //             counter++;
  //             print(counter);
  //             // paused_time.clear();
  //           });
  //           Future.delayed(Duration(seconds: 2), () {
  //             if (counter == 4) {
  //               stopWatch_finish();
  //               setState(() {
  //                 elapsedTime = '00';
  //                 // watch.stop();
  //                 counter = 0;
  //               });
  //               sets++;
  //               print('Sets-------$sets');
  //               if (sets == 3) {
  //                 stopWatch_finish();
  //                 setState(() {
  //                   elapsedTime = '00';
  //                   percent = 0.0;
  //                   // watch.stop();
  //                   counter = 0;
  //                 });
  //                 CommonWidget().showToaster(msg: "Method Complete");
  //               }
  //             } else {
  //               startWatch();
  //             }
  //           });
  //         }
  //       });
  //     }
  //   }
  // }
  updateTime_Super_Easy_stage1(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          (four_started ? Vibration.cancel() : Vibration.vibrate());

          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          Future.delayed(Duration(seconds: 1), () {
            // Vibration.vibrate();
          });
          print(elapsedTime);
          if (elapsedTime == '03') {
            _animationController!.reverse();
            _animationController_button!.reverse();
            stopWatch_finish();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              four_started = true;
              // paused_time.clear();
            });
            CommonWidget().showToaster(msg: '${3 - counter} Times left');

            counter++;
            print(counter);
            startWatch2();

            Future.delayed(const Duration(seconds: 3), () async {
              print('indise 4 seconds');
              if (counter == 4) {
                print("Insidededededdddededddd");
               await stopWatch_finish();
                setState(() {
                  started = true;
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                  watch.reset();
                  _kegel_controller.kegel_performed = true;
                });
                Vibration.cancel();
                _kegel_controller.sets++;
                await _kegel_controller.Kegel_post_API(context);
                await _kegel_controller.alarm_notifications(context);
                print('Sets-------$_kegel_controller.sets');
                // await Get.to(DashboardScreen(page: 1));
                await getdata();
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    started = true;
                    // watch.stop();
                    counter = 0;
                  });
                  // CommonWidget().showToaster(msg: "Method Complete");
                  // await click_alarm();
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After two week it will automatically switch to second stage");
                  });
                }
              } else {

                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                });
                start_animation();

                startWatch();
              }
            });
          }
        });
      }
    }
  }

  updateTime_Super_Easy_stage2(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          (four_started ? Vibration.cancel() : Vibration.vibrate());

          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          print(elapsedTime);

          if (elapsedTime == '05') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${5 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;

              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 3), () async {
              print('indise 4 seconds');
              if (counter == 6) {
                stopWatch_finish();
                setState(() {
                  started = true;
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                  _kegel_controller.kegel_performed = true;
                });
                _kegel_controller.sets++;
                print("_kegel_controller.kegel_performed");
                print(_kegel_controller.kegel_performed);
                await _kegel_controller.Kegel_post_API(context);
                await _kegel_controller.alarm_notifications(context);
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    started = true;
                    // watch.stop();
                    counter = 0;
                  });
                  // CommonWidget().showToaster(msg: "Method Complete");
                  await click_alarm();
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After two weeks it will automatically switch to third stage");
                  });
                }
              } else {
                _animationController!.reverse();
                _animationController_button!.reverse();
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                });
                start_animation();

                startWatch();
              }
            });
          }
        });
      }
    }
  }

  updateTime_Super_Easy_stage3(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          (four_started ? Vibration.cancel() : Vibration.vibrate());

          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          print(elapsedTime);

          if (elapsedTime == '07') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;

              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 3), () async {
              print('indise 4 seconds');
              if (counter == 8) {
                stopWatch_finish();
                setState(() {
                  started = true;
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                  _kegel_controller.kegel_performed = true;
                });
                _kegel_controller.sets++;
                print("_kegel_controller.kegel_performed");
                print(_kegel_controller.kegel_performed);
                await _kegel_controller.Kegel_post_API(context);
                await _kegel_controller.alarm_notifications(context);
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    started = true;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  await click_alarm();
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Easy");
                  });
                }
              } else {
                _animationController!.reverse();
                _animationController_button!.reverse();
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                });
                start_animation();

                startWatch();
              }
            });
          }
        });
      }
    }
  }

  updateTime_Easy(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // Future.delayed(Duration(microseconds: 500), () {
          (four_started ? Vibration.cancel() : Vibration.vibrate());
          // });
          // percent += 1;
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          print(elapsedTime);

          if (elapsedTime == '09') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;

              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 3), () async {
              print('indise 4 seconds');
              if (counter == 8) {
                stopWatch_finish();
                setState(() {
                  started = true;
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                  _kegel_controller.kegel_performed = true;
                });
                _kegel_controller.sets++;
                print("_kegel_controller.kegel_performed");
                print(_kegel_controller.kegel_performed);
                await _kegel_controller.Kegel_post_API(context);
                await _kegel_controller.alarm_notifications(context);
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    started = true;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  await click_alarm();
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Normal");
                  });
                }
              } else {
                _animationController!.reverse();
                _animationController_button!.reverse();
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                });
                start_animation();

                startWatch();
              }
            });
          }
        });
      }
    }
  }

  bool four_started = false;

  updateTime_Normal(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // Future.delayed(Duration(microseconds: 500), () {
          (four_started ? Vibration.cancel() : Vibration.vibrate());
          // });
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          Future.delayed(Duration(seconds: 1), () {
            // Vibration.vibrate();
          });
          print(elapsedTime);
          if (elapsedTime == '11') {
            _animationController!.reverse();
            _animationController_button!.reverse();
            stopWatch_finish();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${9 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;
              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 3), () async {
              if (counter == 10) {
                stopWatch_finish();
                setState(() {
                  elapsedTime = '00';
                  started = true;
                  // watch.stop();
                  counter = 0;
                  watch.reset();
                  _kegel_controller.kegel_performed = true;
                });
                Vibration.cancel();
                // setState(() {
                //   _swipe_setup_controller.k_running = false;
                //   timer_started = false;
                //   counter = 0;
                //
                //   elapsedTime = '00';
                //   percent = 0.0;
                //   back_wallpaper = true;
                //   button_height = 150;
                //   text_k_size = 70;
                //   text_time_size = 25;
                //   watch.reset();
                //   // paused_time.clear();
                // });
                _kegel_controller.sets++;
                // print("_kegel_controller.sets++ ${_kegel_controller.sets++}");
                // print(_kegel_controller.sets++);
                await _kegel_controller.Kegel_post_API(context);
                Future.delayed(Duration(hours: 2), () {
                  _kegel_controller.alarm_notifications(context);
                });
                // await _kegel_controller.Kegel_get_API(context);
                // if (_kegel_controller.kegelPostModel!.error == false) {
                await getdata();
                // }
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    started = true;

                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Hard");
                  });
                }
              } else {
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                });
                start_animation();

                startWatch();
              }
            });
          }
        });
      }
    }
  }

  updateTime_Hard(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // Future.delayed(Duration(microseconds: 500), () {
          (four_started ? Vibration.cancel() : Vibration.vibrate());
          // });
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          // Vibration.vibrate();

          print(elapsedTime);

          if (elapsedTime == '13') {
            _animationController!.reverse();
            _animationController_button!.reverse();
            stopWatch_finish();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${11 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;
              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 3), () async {
              if (counter == 12) {
                stopWatch_finish();
                setState(() {
                  elapsedTime = '00';
                  started = true;
                  // watch.stop();
                  counter = 0;
                  watch.reset();
                  _kegel_controller.kegel_performed = true;
                });
                Vibration.cancel();
                // setState(() {
                //   _swipe_setup_controller.k_running = false;
                //   timer_started = false;
                //   counter = 0;
                //
                //   elapsedTime = '00';
                //   percent = 0.0;
                //   back_wallpaper = true;
                //   button_height = 150;
                //   text_k_size = 70;
                //   text_time_size = 25;
                //   watch.reset();
                //   // paused_time.clear();
                // });
                _kegel_controller.sets++;
                // print("_kegel_controller.sets++ ${_kegel_controller.sets++}");
                // print(_kegel_controller.sets++);
                await _kegel_controller.Kegel_post_API(context);
                Future.delayed(Duration(hours: 2), () {
                  _kegel_controller.alarm_notifications(context);
                });
                // await _kegel_controller.Kegel_get_API(context);
                // if (_kegel_controller.kegelPostModel!.error == false) {
                await getdata();
                // }
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    started = true;

                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Hard");
                  });
                }
              } else {
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                  watch3.reset();
                });
                start_animation();

                startWatch();
              }
            });
          }
        });
      }
    }
  }

  updateTime_Infinite(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // Future.delayed(Duration(microseconds: 500), () {
          Vibration.vibrate();
          // });
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          // Vibration.vibrate();

          print(elapsedTime);

          if (elapsedTime == '13') {
            _animationController!.reverse();
            _animationController_button!.reverse();
            stopWatch_finish();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${12 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;
              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 3), () async {
              if (counter == 10) {
                stopWatch_finish();
                setState(() {
                  elapsedTime = '00';
                  started = true;
                  // watch.stop();
                  counter = 0;
                  watch.reset();
                  _kegel_controller.kegel_performed = true;
                });
                Vibration.cancel();
                // setState(() {
                //   _swipe_setup_controller.k_running = false;
                //   timer_started = false;
                //   counter = 0;
                //
                //   elapsedTime = '00';
                //   percent = 0.0;
                //   back_wallpaper = true;
                //   button_height = 150;
                //   text_k_size = 70;
                //   text_time_size = 25;
                //   watch.reset();
                //   // paused_time.clear();
                // });
                _kegel_controller.sets++;
                // print("_kegel_controller.sets++ ${_kegel_controller.sets++}");
                // print(_kegel_controller.sets++);
                await _kegel_controller.Kegel_post_API(context);
                Future.delayed(Duration(hours: 2), () {
                  _kegel_controller.alarm_notifications(context);
                });
                // await _kegel_controller.Kegel_get_API(context);
                // if (_kegel_controller.kegelPostModel!.error == false) {
                await getdata();
                // }
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    started = true;

                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Hard");
                  });
                }
              } else {
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                  watch3.reset();
                });
                start_animation();

                startWatch();
              }
            });
          }
        });
      }
    }
  }

  updateTime3(Timer timer) {
    if (watch3.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime2 = transformMilliSeconds(watch3.elapsedMilliseconds);

          if (elapsedTime2 == '03') {
            // stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              // elapsedTime2 = '00';
              percent = 0.0;
              // watch.reset();
              // four_started = true;
            });
            startWatch();
          }
        });
      }
    }
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                if (value != null && value != selectedDate) {
                  setState(() {
                    selectedDate = value;
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2019,
              maximumYear: 2021,
            ),
          );
        });
  }

  int counter = 0;

  double percent = 0.0;

  bool back_wallpaper = true;

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 3);
  bool timer_started = false;

  void startTimer() {
    setState(() {
      timer_started = true;
    });
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
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

  // AnimationController? _animationController_vibrate;
  Animation? _animation_vibrate;

  AnimationController? _animationController_button;
  Animation? _animation_button;

  // AnimationController? _animationController_textK;
  Animation? _animation_textK;

  // AnimationController? _animationController_textTime;
  Animation? _animation_textTime;

  bool animation_started = false;
  bool animation_started_middle = false;
  double button_height = 200;
  double text_k_size = 50;
  double text_time_size = 40;

  bool shadow_animation1_completed = false;

  bool get wantKeepAlive => true;

  // start_animation() {
  //   setState(() {
  //     animation_started = true;
  //     print(animation_started);
  //   });
  //   // vibration();
  //   // (counter > 0 ? vibration(12) : vibration(15));
  //
  //   _animationController =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 1));
  //   _animationController!.repeat(reverse: true);
  //   _animation = Tween(begin: 0.0, end: 65.0).animate(_animationController!)
  //     ..addStatusListener((status) {
  //       print(status);
  //
  //       // shadow_animation1_completed = true;
  //     });
  //
  //   // _animationController_vibrate =
  //   //     AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  //   // _animationController_vibrate!.repeat(reverse: true);
  //   // _animation_vibrate =
  //   //     Tween(begin: 25.0, end: 28.0).animate(_animationController_vibrate!)
  //   //       ..addListener(() {
  //   //         // print(status);
  //   //         // if (status == AnimationStatus.completed) {}
  //   //         // shadow_animation1_completed = true;
  //   //       });aa
  //
  //   _animationController_button =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 5));
  //   _animationController_button!.forward();
  //   _animation_button =
  //       Tween(begin: 200.0, end: 150.0).animate(_animationController_button!)
  //         ..addStatusListener((status) {
  //           // print(status);
  //           // if (status == AnimationStatus.completed) {
  //           //   setState(() {});
  //           //   _animationController_button!.reverse();
  //           // } else if (status == AnimationStatus.dismissed) {
  //           //   setState(() {});
  //           //   _animationController_button!.forward();
  //           // }
  //         });
  //
  //   // _animationController_textK =
  //   //     AnimationController(vsync: this, duration: Duration(seconds: 5));
  //   // _animationController_textK!.forward();
  //   _animation_textK =
  //       Tween(begin: 100.0, end: 70.0).animate(_animationController_button!)
  //         ..addStatusListener((status) {
  //           // print(status);
  //           // if (status == AnimationStatus.completed) {
  //           //   setState(() {});
  //           //   _animationController_button!.reverse();
  //           // } else if (status == AnimationStatus.dismissed) {
  //           //   setState(() {});
  //           //   _animationController_button!.forward();
  //           // }
  //         });
  //
  //   // _animationController_textTime =
  //   //     AnimationController(vsync: this, duration: Duration(seconds: 5));
  //   // _animationController_textTime!.forward();
  //   _animation_textTime =
  //       Tween(begin: 40.0, end: 25.0).animate(_animationController_button!)
  //         ..addStatusListener((status) {
  //           // print(status);
  //           // if (status == AnimationStatus.completed) {
  //           //   setState(() {});
  //           //   _animationController_button!.reverse();
  //           // } else if (status == AnimationStatus.dismissed) {
  //           //   setState(() {});
  //           //   _animationController_button!.forward();
  //           // }
  //         });
  // }

  bool shadow_animation_pause = false;

  AnimationController? _animationController_shadow1;
  Animation? _animation_shadow1;
  Animation? _animation_shadow1_reverse;
  AnimationController? _animationController_shadow2;
  Animation? _animation_shadow2;

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    // _incrementCounter();
    // vibration();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    // _animationController!.repeat(reverse: true);
    _animationController!.forward();

    _animation = Tween(begin: 0.0, end: 65.0).animate(_animationController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
        // print(_animation!.value);
      });
    setState(() {
      // _status = 'Inhale';
      // print(_status);
    });
    _animationController_button =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController_button!.forward();
    _animation_button = Tween(begin: 200.0, end: 150.0)
        .animate(_animationController_button!)
      ..addStatusListener((status) {});
    _animationController_shadow1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController_shadow1!.forward();
    _animation_shadow1 =
        Tween(begin: 0.0, end: 65.0).animate(_animationController_shadow1!)
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
        Tween(begin: 65.0, end: 70.0).animate(_animationController_shadow2!)
          ..addStatusListener((status) {
            if (shadow_animation_pause == true) {}
            // print(status);
            // if (status == AnimationStatus.completed) {}
            // shadow_animation1_completed = true;
          });

    // _animationController_textK =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));
    // _animationController_textK!.forward();
    _animation_textK =
        Tween(begin: 50.0, end: 30.0).animate(_animationController_button!)
          ..addStatusListener((status) {
            // print(status);
            // if (status == AnimationStatus.completed) {
            //   setState(() {});
            //   _animationController_button!.reverse();
            // } else if (status == AnimationStatus.dismissed) {
            //   setState(() {});
            //   _animationController_button!.forward();
            // }
          });

    // _animationController_textTime =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));
    // _animationController_textTime!.forward();
    _animation_textTime =
        Tween(begin: 40.0, end: 25.0).animate(_animationController_button!)
          ..addStatusListener((status) {
            // print(status);
            // if (status == AnimationStatus.completed) {
            //   setState(() {});
            //   _animationController_button!.reverse();
            // } else if (status == AnimationStatus.dismissed) {
            //   setState(() {});
            //   _animationController_button!.forward();
            // }
          });
  }

  AnimationController? _animationController_middle;
  Animation? _animation_middle;
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
        Tween(begin: 15.0, end: 50.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");
            // shadow_animation1_completed = true;
          });
    _animation_middle2 =
        Tween(begin: 15.0, end: 45.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");
            // shadow_animation1_completed = true;
          });
    _animation_middle3 =
        Tween(begin: 15.0, end: 120.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");
            // shadow_animation1_completed = true;
          });
    _animation_middle4 =
        Tween(begin: 15.0, end: 100.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");

            // shadow_animation1_completed = true;
          });
  }
  done_animation(){
    _animationController_middle = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animationController_middle!.forward();
    _animation_middle =
    Tween(begin: 50.0, end: 15.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        print("status $status");
        // shadow_animation1_completed = true;
      });
    _animation_middle2 =
    Tween(begin: 45.0, end: 15.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        print("status $status");
        // shadow_animation1_completed = true;
      });
    _animation_middle3 =
    Tween(begin: 120.0, end: 15.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        print("status $status");
        // shadow_animation1_completed = true;
      });
    _animation_middle4 =
    Tween(begin: 100.0, end: 15.0).animate(_animationController_middle!)
      ..addStatusListener((status) {
        print("status $status");

        // shadow_animation1_completed = true;
      });



    _animationController_button =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController_button!.forward();
    _animation_button = Tween(begin: 150.0, end: 200.0)
        .animate(_animationController_button!)
      ..addStatusListener((status) {});
    _animationController_shadow1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController_shadow1!.forward();
    _animation_shadow1 =
    Tween(begin: 65.0, end: 0.0).animate(_animationController_shadow1!)
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
    _animationController_shadow2!.repeat(reverse: false);
    _animation_shadow2 =
    Tween(begin: 70.0, end: 65.0).animate(_animationController_shadow2!)
      ..addStatusListener((status) {
        if (shadow_animation_pause == true) {}
        // print(status);
        // if (status == AnimationStatus.completed) {}
        // shadow_animation1_completed = true;
      });

    // _animationController_textK =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));
    // _animationController_textK!.forward();
    _animation_textK =
    Tween(begin: 30.0, end: 50.0).animate(_animationController_button!)
      ..addStatusListener((status) {
        // print(status);
        // if (status == AnimationStatus.completed) {
        //   setState(() {});
        //   _animationController_button!.reverse();
        // } else if (status == AnimationStatus.dismissed) {
        //   setState(() {});
        //   _animationController_button!.forward();
        // }
      });

    // _animationController_textTime =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));
    // _animationController_textTime!.forward();
    _animation_textTime =
    Tween(begin: 25.0, end: 40.0).animate(_animationController_button!)
      ..addStatusListener((status) {
        // print(status);
        // if (status == AnimationStatus.completed) {
        //   setState(() {});
        //   _animationController_button!.reverse();
        // } else if (status == AnimationStatus.dismissed) {
        //   setState(() {});
        //   _animationController_button!.forward();
        // }
      });
  }

  AnimationController? _animController;
  Animation<Offset>? _animOffset;
  bool text_started_middle = false;

  text_animation() {
    setState(() {
      text_started_middle = true;
    });
    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController!);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    _animController!.forward();
  }

  String? levels;
  String? stages;

  @override
  dispose() {
    if (animation_started == true) {
      _animationController!.dispose(); // you need this
      _animationController_button!.dispose();
    }
    if (animation_started_middle == true) {
      _animationController_middle!.dispose();
    }
    Vibration.cancel();
    // _animationController_textTime!.dispose();
    // _animationController_textK!.dispose();// you need this
    super.dispose();
  }

  @override
  void initState() {
    // getdata();
    //

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      init();
      _init();
    });
    // _alarmTime = DateTime.now();
    // _alarmHelper.initializeDatabase().then((value) {
    //   print('------database intialized');
    //   loadAlarms();
    // });
    // get_saved_data();
    super.initState();
  }

  init() async {
    await getdata();
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) async {
      print('------database intialized');
      await loadAlarms();
    });
  }

  DateTime? _alarmTime;
  String? _alarmTimeString;
  final AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  Future loadAlarms() async {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  get_saved_data() async {
    // print("Levels $levels");
    // print("Dateformat ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
    // setState(() {});
  }

  final SignInScreenController _signInScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

  Future getdata() async {
    await _signInScreenController.GetUserInfo(context);

    levels = await PreferenceManager().getPref(URLConstants.levels);
    print("LEvelsssssssssssssssss $levels");
    stages = await PreferenceManager().getPref(URLConstants.stages);
    setState(() {});
    await _kegel_controller.Kegel_get_API(context);
    if (_kegel_controller.kegelGetModel!.error == false) {
      setState(() {
        _kegel_controller.sets =
            int.parse(_kegel_controller.kegelGetModel!.data![0].sets!);
      });
    }

    print("Setssss : ${_kegel_controller.sets}");
  }

  DateTime selectedDate = DateTime.now();

  String? selected_date_sets = '';
  String? selected_date = '';
  var selected_time;

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
              ? const BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,`
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
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AssetUtils.k_screen_back,
                    ),
                  ),
                )
              : BoxDecoration()),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   automaticallyImplyLeading: false,
            //   leading: GestureDetector(
            //     onTap: () {
            //       (started
            //           ? Navigator.pop(context)
            //           : CommonWidget()
            //               .showErrorToaster(msg: "Please finish the method"));
            //     },
            //     child: Container(
            //         width: 41,
            //         margin: const EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(100),
            //             gradient: LinearGradient(
            //                 begin: const Alignment(-1.0, -4.0),
            //                 end: const Alignment(1.0, 4.0),
            //                 colors: [HexColor('#020204'), HexColor('#36393E')])),
            //         child: Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Image.asset(
            //             AssetUtils.arrow_back,
            //             height: 14,
            //             width: 15,
            //           ),
            //         )),
            //   ),
            //   title: Text(
            //     Textutils.kegel,
            //     style: FontStyleUtility.h16(
            //         fontColor: ColorUtils.primary_grey, family: 'PM'),
            //   ),
            //   centerTitle: true,
            //   actions: [
            //     Container(
            //         margin: const EdgeInsets.symmetric(horizontal: 10),
            //         alignment: Alignment.center,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               AssetUtils.star_icon,
            //               color: (_kegel_controller.sets >= 1
            //                   ? ColorUtils.primary_gold
            //                   : Colors.grey),
            //               height: 22,
            //               width: 22,
            //             ),
            //             const SizedBox(
            //               width: 7,
            //             ),
            //             Image.asset(
            //               AssetUtils.star_icon,
            //               height: 22,
            //               color: (_kegel_controller.sets >= 2
            //                   ? ColorUtils.primary_gold
            //                   : Colors.grey),
            //               width: 22,
            //             ),
            //             const SizedBox(
            //               width: 7,
            //             ),
            //             Image.asset(
            //               AssetUtils.star_icon,
            //               color: (_kegel_controller.sets >= 3
            //                   ? ColorUtils.primary_gold
            //                   : Colors.grey),
            //               height: 22,
            //               width: 22,
            //             ),
            //           ],
            //         )),
            //
            //     // Container(
            //     //     width: 41,
            //     //     margin: EdgeInsets.all(8),
            //     //     decoration: BoxDecoration(
            //     //         color: Colors.white,
            //     //         borderRadius: BorderRadius.circular(100),
            //     //         gradient: LinearGradient(
            //     //             begin: Alignment(-1.0, -4.0),
            //     //             end: Alignment(1.0, 4.0),
            //     //             colors: [HexColor('#020204'), HexColor('#36393E')])),
            //     //     child: Padding(
            //     //       padding: const EdgeInsets.all(10.0),
            //     //       child: Image.asset(
            //     //         AssetUtils.notification_icon,
            //     //         color: ColorUtils.primary_gold,
            //     //         height: 14,
            //     //         width: 15,
            //     //       ),
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

                    leading: GestureDetector(
                      onTap: () {
                        (started
                            ? Navigator.pop(context)
                            : CommonWidget().showErrorToaster(
                                msg: "Please finish the method"));
                      },
                      child: Container(
                          width: 41,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(
                                  begin: const Alignment(-1.0, -4.0),
                                  end: const Alignment(1.0, 4.0),
                                  colors: [
                                    HexColor('#020204'),
                                    HexColor('#36393E')
                                  ])),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              AssetUtils.arrow_back,
                              height: 14,
                              width: 15,
                            ),
                          )),
                    ),
                    // title: Text(
                    //   Textutils.kegel,
                    //   style: FontStyleUtility.h16(
                    //       fontColor: ColorUtils.primary_grey, family: 'PM'),
                    // ),
                    centerTitle: true,
                    actions: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Obx(() => (_kegel_controller
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
                                      color: (int.parse(_kegel_controller
                                                  .kegelGetModel!
                                                  .data![_kegel_controller
                                                          .kegelGetModel!
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
                                      color: (int.parse(_kegel_controller
                                                  .kegelGetModel!
                                                  .data![_kegel_controller
                                                          .kegelGetModel!
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
                                      color: (int.parse(_kegel_controller
                                                  .kegelGetModel!
                                                  .data![_kegel_controller
                                                          .kegelGetModel!
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
                      // Container(
                      //     width: 41,
                      //     margin: EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(100),
                      //         gradient: LinearGradient(
                      //             begin: Alignment(-1.0, -4.0),
                      //             end: Alignment(1.0, 4.0),
                      //             colors: [HexColor('#020204'), HexColor('#36393E')])),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Image.asset(
                      //         AssetUtils.notification_icon,
                      //         color: ColorUtils.primary_gold,
                      //         height: 14,
                      //         width: 15,
                      //       ),
                      //     ))
                    ],
                    // TabBar(
                    //   labelPadding: EdgeInsets.zero,
                    //   indicatorColor: Colors.black,
                    //   controller: _tabController,
                    //   tabs: <Widget>[
                    //     Container(
                    //       margin: EdgeInsets.only(bottom: 0),
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //           color: Colors.black,
                    //           borderRadius: BorderRadius.circular(50),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: HexColor(CommonColor.blue),
                    //               // spreadRadius: 5,
                    //               blurRadius: 6,
                    //               offset:
                    //                   Offset(0, 3), // changes position of shadow
                    //             ),
                    //           ],
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             // stops: [0.1, 0.5, 0.7, 0.9],
                    //             colors: [
                    //               HexColor("#000000"),
                    //               HexColor("#C12265"),
                    //               // HexColor("#FFFFFF").withOpacity(0.67),
                    //             ],
                    //           ),
                    //           border: Border.all(
                    //               color: HexColor(CommonColor.blue), width: 1.5)),
                    //       child: IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             index == 0;
                    //           });
                    //           print(index);
                    //         },
                    //         icon: Image.asset(
                    //           AssetUtils.story1,
                    //           height: 25,
                    //           width: 25,
                    //           color: HexColor(CommonColor.blue),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.all(0),
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(50),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: HexColor(CommonColor.green),
                    //               // spreadRadius: 5,
                    //               blurRadius: 6,
                    //               offset:
                    //                   Offset(0, 3), // changes position of shadow
                    //             ),
                    //           ],
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             // stops: [0.1, 0.5, 0.7, 0.9],
                    //             colors: [
                    //               HexColor("#000000"),
                    //               HexColor("#C12265"),
                    //               // HexColor("#FFFFFF").withOpacity(0.67),
                    //             ],
                    //           ),
                    //           border: Border.all(
                    //               color: HexColor(CommonColor.green), width: 1.5)),
                    //       child: IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             index == 1;
                    //           });
                    //           print(index);
                    //         },
                    //         icon: Image.asset(
                    //           AssetUtils.story2,
                    //           height: 25,
                    //           width: 25,
                    //           color: HexColor(CommonColor.green),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.all(0),
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: HexColor(CommonColor.tile),
                    //               // spreadRadius: 5,
                    //               blurRadius: 6,
                    //               offset:
                    //                   Offset(0, 3), // changes position of shadow
                    //             ),
                    //           ],
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             // stops: [0.1, 0.5, 0.7, 0.9],
                    //             colors: [
                    //               HexColor("#000000"),
                    //               HexColor("#C12265"),
                    //               // HexColor("#FFFFFF").withOpacity(0.67),
                    //             ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(50),
                    //           border: Border.all(
                    //               color: HexColor(CommonColor.tile), width: 1.5)),
                    //       child: IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             index == 2;
                    //           });
                    //           print(index);
                    //         },
                    //         icon: Image.asset(
                    //           AssetUtils.story3,
                    //           height: 25,
                    //           width: 25,
                    //           color: HexColor(CommonColor.tile),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.all(0),
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: HexColor(CommonColor.orange),
                    //               // spreadRadius: 5,
                    //               blurRadius: 6,
                    //               offset:
                    //                   Offset(0, 3), // changes position of shadow
                    //             ),
                    //           ],
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             // stops: [0.1, 0.5, 0.7, 0.9],
                    //             colors: [
                    //               HexColor("#000000"),
                    //               HexColor("#C12265"),
                    //               // HexColor("#FFFFFF").withOpacity(0.67),
                    //             ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(50),
                    //           border: Border.all(
                    //               color: HexColor(CommonColor.orange), width: 1.5)),
                    //       child: IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             index == 3;
                    //           });
                    //           print(index);
                    //         },
                    //         icon: Image.asset(
                    //           AssetUtils.story4,
                    //           height: 25,
                    //           width: 25,
                    //           color: HexColor(CommonColor.orange),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.all(0),
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.white,
                    //               // spreadRadius: 5,
                    //               blurRadius: 6,
                    //               offset:
                    //                   Offset(0, 3), // changes position of shadow
                    //             ),
                    //           ],
                    //           gradient: LinearGradient(
                    //             begin: Alignment.topLeft,
                    //             end: Alignment.bottomRight,
                    //             // stops: [0.1, 0.5, 0.7, 0.9],
                    //             colors: [
                    //               HexColor("#000000"),
                    //               HexColor("#C12265"),
                    //               // HexColor("#FFFFFF").withOpacity(0.67),
                    //             ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(50),
                    //           border: Border.all(color: Colors.white, width: 1.5)),
                    //       child: IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             index == 4;
                    //           });
                    //           print(index);
                    //         },
                    //         icon: Image.asset(
                    //           AssetUtils.story5,
                    //           height: 25,
                    //           width: 25,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //
                    //   ],
                    // ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.only(top: 15, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: (animation_started_middle
                      //       ? _animation_middle!.value
                      //       : 15),
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
                      Container(
                          // color: Colors.white,
                          child: AvatarGlow(
                        endRadius: 170.0,
                        showTwoGlows: true,
                        animate: false,
                        // (startStop ? false : true),
                        duration: const Duration(milliseconds: 900),
                        repeat: true,
                        child: GestureDetector(
                          onTap: () {
                            print('helllllllooooooooooooooo');
                            // startOrStop();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0,0),
                                      color: (animation_started
                                          ? HexColor('#E64A9B')
                                          : Colors.transparent),
                                      spreadRadius: (animation_started
                                          ? (shadow_animation1_completed
                                              ? _animation_shadow2!.value
                                              : _animation_shadow1!.value)
                                          : 0),
                                      blurRadius: 35,
                                    ),
                                    BoxShadow(
                                      // offset: Offset(0,10),
                                      color: (animation_started
                                          ? HexColor('#000000')
                                          : Colors.transparent),
                                      spreadRadius: 35,
                                      blurRadius: 35,
                                    ),
                                    
                                  ],
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: (animation_started
                                  //         ? HexColor('#E64A9B')
                                  //         : Colors.transparent),
                                  //     blurRadius: (animation_started
                                  //         ? _animation!.value
                                  //         : 0),
                                  //     spreadRadius: (animation_started
                                  //         ? _animation!.value
                                  //         : 0),
                                  //   )
                                  // ]
                                ),
                              ),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 6],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 340,
                              //           width: 340,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 8.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 330,
                              //           width: 330,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 7.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 320,
                              //           width: 320,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 7.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 310,
                              //           width: 310,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 8],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 300,
                              //           width: 300,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 8.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 290,
                              //           width: 290,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 9],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 280,
                              //           width: 280,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Circle,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 8.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 270,
                              //           width: 270,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 10],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 260,
                              //           width: 260,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 9.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 250,
                              //           width: 250,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 9],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 240,
                              //           width: 240,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 8.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 230,
                              //           width: 230,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 7],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 220,
                              //           width: 220,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 7.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 210,
                              //           width: 210,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 7],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 200,
                              //           width: 200,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 6.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 190,
                              //           width: 190,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 6],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 180,
                              //           width: 180,
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 5.5],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 170,
                              //           width: 170,
                              //           padding: EdgeInsets.all(5),
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //         borderType: BorderType.Oval,
                              //         strokeWidth: 3,
                              //         dashPattern: [0, 7],
                              //         strokeCap: StrokeCap.round,
                              //         radius: Radius.circular(100),
                              //         padding: EdgeInsets.all(0),
                              //         color: Colors.black,
                              //         child: Container(
                              //           height: 160,
                              //           width: 160,
                              //           padding: EdgeInsets.all(5),
                              //         ),
                              //       )
                              //     : SizedBox.shrink()),

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
                                    ? _animation_button!.value
                                    : button_height),
                                width: (animation_started
                                    ? _animation_button!.value
                                    : button_height),
                                decoration: (animation_started
                                    ? BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.pinkAccent,
                                            width: 2.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: HexColor(
                                                '#E64A9B'), // darker color
                                          ),
                                          BoxShadow(
                                            color: HexColor('#000000'),
                                            // background color
                                            spreadRadius: -7.0,
                                            blurRadius: 10.0,
                                          ),
                                        ],
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
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text('Kegel',
                                          style: GoogleFonts.sourceSerifPro(
                                              textStyle: TextStyle(
                                            color: (four_started
                                                ? HexColor('#E64A9B')
                                                    .withOpacity(0.4)
                                                : (timer_started
                                                ?  HexColor('#E64A9B')
                                                .withOpacity(0.4)
                                                :  HexColor('#E64A9B')
                                            )),
                                            fontSize: (animation_started
                                                ? _animation_textK!.value
                                                : text_k_size),
                                            fontWeight: FontWeight.w600,
                                          ))
                                          // style: TextStyle(
                                          //     color: HexColor('#E64A9B')
                                          //         .withOpacity(0.4),
                                          //     fontSize: (animation_started
                                          //         ? _animation_textK!.value
                                          //         : text_k_size),
                                          //     fontWeight: FontWeight.w600),
                                          ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: (four_started
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "PUSH",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: (animation_started
                                                          ? _animation_textTime!
                                                              .value
                                                          : text_time_size),
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                Text(
                                                  elapsedTime,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: (animation_started
                                                          ? _animation_textTime!
                                                              .value
                                                          : text_time_size),
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              (timer_started
                                                  ? ('$seconds' == '3'
                                                      ? 'Ready'
                                                      : ('$seconds' == '2'
                                                          ? 'Set'
                                                          : ('$seconds' == '1'
                                                              ? 'Kegel'
                                                              : elapsedTime)))
                                                  : ''),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: (animation_started
                                                      ? _animation_textTime!
                                                          .value
                                                      : text_time_size),
                                                  fontWeight: FontWeight.w900),
                                            )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      // SizedBox(
                      //   height: (animation_started_middle
                      //       ? _animation_middle!.value
                      //       : 25),
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
                      // (timer_started
                      //     ? Container(
                      //         child: Text(
                      //         ('$seconds' == '3'
                      //             ? 'Ready'
                      //             : ('$seconds' == '2'
                      //                 ? 'Set'
                      //                 : ('$seconds' == '1' ? 'Kegel' : ''))),
                      //         style: FontStyleUtility.h22(
                      //             fontColor: Colors.white60, family: "PR"),
                      //       ))
                      //     : SizedBox.shrink()),
                      (timer_started
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        // color: Colors.red,
                                        child: ('$seconds' == '3'
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Set',
                                                          style: FontStyleUtility.h18(
                                                              fontColor: Colors
                                                                  .transparent,
                                                              family: "PR"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: 80,
                                                      // decoration: BoxDecoration(
                                                      //     borderRadius:
                                                      //         BorderRadius
                                                      //             .circular(10),
                                                      //     border: Border.all(
                                                      //         color:
                                                      //             Colors.white,
                                                      //         width: 0.5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Ready',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FontStyleUtility.h22(
                                                              fontColor: ColorUtils
                                                                  .primary_gold,
                                                              family: "PM"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ('$seconds' == '2'
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Ready',
                                                                  style: FontStyleUtility.h14(
                                                                      fontColor:
                                                                          Colors
                                                                              .white,
                                                                      family:
                                                                          "PR"),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: 80,
                                                          // decoration: BoxDecoration(
                                                          //     borderRadius:
                                                          //         BorderRadius
                                                          //             .circular(
                                                          //                 10),
                                                          //     border: Border.all(
                                                          //         color: Colors
                                                          //             .white,
                                                          //         width: 0.5)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Set',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FontStyleUtility.h22(
                                                                  fontColor:
                                                                      ColorUtils
                                                                          .primary_gold,
                                                                  family: "PM"),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : ('$seconds' == '1'
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child: Text(
                                                                  'Ready',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: FontStyleUtility.h14(
                                                                      fontColor:
                                                                          Colors
                                                                              .white,
                                                                      family:
                                                                          "PR"),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child: Text(
                                                                  'Set',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: FontStyleUtility.h14(
                                                                      fontColor:
                                                                          Colors
                                                                              .white,
                                                                      family:
                                                                          "PR"),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              width: 100,
                                                              // decoration: BoxDecoration(
                                                              //     borderRadius:
                                                              //         BorderRadius
                                                              //             .circular(
                                                              //                 10),
                                                              //     border: Border.all(
                                                              //         color: Colors
                                                              //             .white,
                                                              //         width:
                                                              //             0.5)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Squeeze',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FontStyleUtility.h22(
                                                                      fontColor:
                                                                          ColorUtils
                                                                              .primary_gold,
                                                                      family:
                                                                          "PM"),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : (four_started
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            0.0),
                                                                    child: Text(
                                                                      'Push',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: FontStyleUtility.h14(
                                                                          fontColor: Colors
                                                                              .white,
                                                                          family:
                                                                              "PR"),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  width: 100,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            0.0),
                                                                    child: Text(
                                                                      'Squeeze',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      style: FontStyleUtility.h14(
                                                                          fontColor: Colors
                                                                              .white,
                                                                          family:
                                                                              "PR"),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  // decoration: BoxDecoration(
                                                                  //     borderRadius:
                                                                  //         BorderRadius.circular(
                                                                  //             10),
                                                                  //     border: Border.all(
                                                                  //         color: Colors
                                                                  //             .white,
                                                                  //         width:
                                                                  //             0.5)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'Push',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: FontStyleUtility.h22(
                                                                          fontColor: ColorUtils
                                                                              .primary_gold,
                                                                          family:
                                                                              "PM"),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : (counter > 0
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(0.0),
                                                                        child:
                                                                            Text(
                                                                          'Squeeze',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style: FontStyleUtility.h14(
                                                                              fontColor: Colors.white,
                                                                              family: "PR"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(0.0),
                                                                        child:
                                                                            Text(
                                                                          'Push',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style: FontStyleUtility.h14(
                                                                              fontColor: Colors.white,
                                                                              family: "PR"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      // decoration: BoxDecoration(
                                                                      //     borderRadius:
                                                                      //         BorderRadius
                                                                      //             .circular(
                                                                      //                 10),
                                                                      //     border: Border.all(
                                                                      //         color: Colors
                                                                      //             .white,
                                                                      //         width:
                                                                      //             0.5)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'Squeeze',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FontStyleUtility.h22(
                                                                              fontColor: ColorUtils.primary_gold,
                                                                              family: "PM"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(0.0),
                                                                        child:
                                                                            Text(
                                                                          'Ready',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style: FontStyleUtility.h14(
                                                                              fontColor: Colors.white,
                                                                              family: "PR"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(0.0),
                                                                        child:
                                                                            Text(
                                                                          'Set',
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style: FontStyleUtility.h14(
                                                                              fontColor: Colors.white,
                                                                              family: "PR"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          100,
                                                                      // decoration: BoxDecoration(
                                                                      //     borderRadius:
                                                                      //         BorderRadius
                                                                      //             .circular(
                                                                      //                 10),
                                                                      //     border: Border.all(
                                                                      //         color: Colors
                                                                      //             .white,
                                                                      //         width:
                                                                      //             0.5)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          'Squeeze',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FontStyleUtility.h22(
                                                                              fontColor: ColorUtils.primary_gold,
                                                                              family: "PM"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )))))),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        // color: Colors.red,
                                        child: ('$seconds' == '3'
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'Set',
                                                        style: FontStyleUtility
                                                            .h14(
                                                                fontColor:
                                                                    Colors
                                                                        .white,
                                                                family: "PR"),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ('$seconds' == '2'
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Squeeze',
                                                            style: FontStyleUtility
                                                                .h14(
                                                                    fontColor:
                                                                        Colors
                                                                            .white,
                                                                    family:
                                                                        "PR"),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : ('$seconds' == '1'
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: Text(
                                                                'Push',
                                                                style: FontStyleUtility.h14(
                                                                    fontColor:
                                                                        Colors
                                                                            .white,
                                                                    family:
                                                                        "PR"),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Squeeze',
                                                                style: FontStyleUtility.h14(
                                                                    fontColor:
                                                                        Colors
                                                                            .white,
                                                                    family:
                                                                        "PR"),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : (four_started
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                // width: 100,

                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          0.0),
                                                                  child: Text(
                                                                    'Squeeze',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: FontStyleUtility.h14(
                                                                        fontColor:
                                                                            Colors
                                                                                .white,
                                                                        family:
                                                                            "PR"),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    'Push',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    style: FontStyleUtility.h14(
                                                                        fontColor:
                                                                            Colors
                                                                                .white,
                                                                        family:
                                                                            "PR"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          0.0),
                                                                  child: Text(
                                                                    'Push',
                                                                    style: FontStyleUtility.h14(
                                                                        fontColor:
                                                                            Colors
                                                                                .white,
                                                                        family:
                                                                            "PR"),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    'Squeeze',
                                                                    style: FontStyleUtility.h14(
                                                                        fontColor:
                                                                            Colors
                                                                                .white,
                                                                        family:
                                                                            "PR"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ))))),
                                      ),
                                    )
                                  ],
                                ),
                                // Container(
                                //   // color: Colors.red,
                                //   child: ('$seconds' == '3'
                                //       ? SizedBox(
                                //     height : 40
                                //   )
                                //       : ('$seconds' == '2'
                                //       ? const SizedBox(height : 40
                                //   )
                                //       :('$seconds' == '1'?
                                //   Container(
                                //     child: Padding(
                                //       padding:
                                //       const EdgeInsets
                                //           .all(8.0),
                                //       child: Text(
                                //         'Squeeze',
                                //         textAlign:
                                //         TextAlign
                                //             .center,
                                //         style: FontStyleUtility.h16(
                                //             fontColor: Colors
                                //                 .white,
                                //             family:
                                //             "PR"),
                                //       ),
                                //     ),
                                //   )  : (four_started
                                //       ? Container(
                                //     height : 40,
                                //
                                //     child: Text(
                                //       'Push',
                                //       textAlign:
                                //       TextAlign
                                //           .center,
                                //       style: FontStyleUtility.h16(
                                //           fontColor: Colors.white,
                                //           family:
                                //           "PM"),
                                //     ),
                                //   )
                                //       : Container(
                                //     height : 40,
                                //     child: Padding(
                                //       padding:
                                //       const EdgeInsets
                                //           .all(8.0),
                                //       child: Text(
                                //         'Squeeze',
                                //         textAlign:
                                //         TextAlign
                                //             .center,
                                //         style: FontStyleUtility.h16(
                                //             fontColor: Colors
                                //                 .white,
                                //             family:
                                //             "PR"),
                                //       ),
                                //     ),
                                //   ) )))),
                                // ),
                              ],
                            )
                          : SizedBox(
                              height: 0,
                            )),

                      // (text_started_middle
                      //     ? FadeTransition(
                      //         child: SlideTransition(
                      //           position: _animOffset!,
                      //           child: Container(
                      //               child: Text(
                      //             ('$seconds' == '3'
                      //                 ? 'Ready'
                      //                 : ('$seconds' == '2'
                      //                     ? 'Set'
                      //                     : ('$seconds' == '1' ? 'Kegel' : ''))),
                      //             style: FontStyleUtility.h22(
                      //                 fontColor: Colors.white60, family: "PR"),
                      //           )),
                      //         ),
                      //         opacity: _animController!,
                      //       )
                      //     : SizedBox.shrink()),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_kegel_controller.kegelGetModel!.error == false &&
                              int.parse(_kegel_controller
                                      .kegelGetModel!.data![_kegel_controller
                                  .kegelGetModel!
                                  .data!
                                  .length -
                                  1].sets!) >=
                                  3) {
                            print(int.parse(_kegel_controller
                                .kegelGetModel!.data![_kegel_controller
                                .kegelGetModel!
                                .data!
                                .length -
                                1].sets!));
                            CommonWidget().showErrorToaster(
                                msg: "You have completed your today's sets");
                          } else {
                            if (started) {
                              back_wallpaper = false;

                              setState(() {
                                _kegel_controller.start_time =DateFormat('HH:mm').format(DateTime.now());
                              });
                              print(_kegel_controller.start_time);
                              // start_animation();
                              // start_button_animation();
                              startTimer();
                              (counter > 0 ? startWatch() : startWatch3());
                              start_animation();
                              middle_animation();
                              text_animation();
                              // startTimer();
                              // await startWatch();

                              // Future.delayed(const Duration(seconds: 1),
                              //     () async {
                              //   // startTimer();
                              // });
                              // Future.delayed(const Duration(seconds: 3),
                              //     () async {
                              //   await startWatch();
                              // });
                            } else {
                              await done_animation();

                              if (four_started) {
                                null;
                              } else {
                                await stopWatch_finish();
                                // await _animationController_middle!.reverse();
                                Vibration.cancel();
                                setState(() {
                                  animation_started = false;
                                  started = true;
                                  _swipe_setup_controller.k_running = false;
                                  timer_started = false;
                                  elapsedTime = '00';
                                  percent = 0.0;
                                  back_wallpaper = true;
                                  button_height = 150;
                                  text_k_size = 30;
                                  text_time_size = 25;
                                  watch.reset();
                                  // paused_time.clear();
                                });

                              }
                              // print('method_time : ${method_time[0].total_time}');
                              // print('method_name : ${method_time[0].method_name}');
                            }
                          }
                        },
                        child: Container(
                          height: 65,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
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
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: Text(
                                (started ? 'Start' : 'Finish'),
                                style: FontStyleUtility.h16(
                                    fontColor: Colors.black, family: 'PM'),
                              )),
                        ),
                      ),

                      // Container(
                      //   child: IconButton(
                      //       onPressed: (){
                      //         var date = DateTime.now().add(Duration(minutes: 1));
                      //         print("${date.hour} : ${date.minute}");
                      //         FlutterAlarmClock.createAlarm(date.hour, date.minute, title: '');
                      //
                      //       },
                      //       icon: Icon(Icons.add_circle,color: Colors.white,)
                      //   ),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.all(25),
                      //   child: TextButton(
                      //     child: const Text(
                      //       'Create alarm',
                      //       style: TextStyle(fontSize: 20.0),
                      //     ),
                      //     onPressed: () {
                      //       int hour;
                      //       int minutes;
                      //       var date = DateTime.now().add(Duration(minutes: 1));
                      //       hour = date.hour;
                      //       minutes = date.minute;
                      //
                      //       // creating alarm after converting hour
                      //       // and minute into integer
                      //       FlutterAlarmClock.createAlarm(hour, minutes);
                      //     },
                      //   ),
                      // ),

                      SizedBox(
                        height: 10,
                      ),
                      // GestureDetector(
                      //   onTap: () async {
                      //
                      //     click_alarm();
                      //   },
                      //   child: Container(
                      //     height: 50,
                      //     margin: const EdgeInsets.symmetric(horizontal: 15),
                      //     // height: 45,
                      //     // width:(width ?? 300) ,
                      //     decoration: BoxDecoration(
                      //         color: ColorUtils.primary_gold,
                      //         gradient: LinearGradient(
                      //           begin: Alignment.centerLeft,
                      //           end: Alignment.centerRight,
                      //           // stops: [0.1, 0.5, 0.7, 0.9],
                      //           colors: [
                      //             HexColor("#ECDD8F").withOpacity(0.90),
                      //             HexColor("#E5CC79").withOpacity(0.90),
                      //             HexColor("#CE952F").withOpacity(0.90),
                      //           ],
                      //         ),
                      //         borderRadius: BorderRadius.circular(15)),
                      //     child: Container(
                      //         alignment: Alignment.center,
                      //         margin: const EdgeInsets.symmetric(
                      //           vertical: 12,
                      //         ),
                      //         child: Text(
                      //           ('Alarm'),
                      //           style: FontStyleUtility.h12(
                      //               fontColor: Colors.black, family: 'PM'),
                      //         )),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      Text(
                          // (levels == 'Easy'
                          //     ? ('$counter/8')
                          //     : (levels == 'Normal'
                          //         ? ('$counter/10')
                          //         : ('$counter/10'))),
                          (levels == 'Easy'
                              ? '$counter/8'
                              : (levels == 'Normal'
                                  ? '$counter/10'
                                  : (levels == 'Super Easy'
                                      ? (stages == '1'
                                          ? '$counter/4'
                                          : (stages == '2'
                                              ? '$counter/6'
                                              : (stages == '3'
                                                  ? '$counter/8'
                                                  : '$counter/10')))
                                      : (levels == 'Hard'
                                          ? '$counter/12'
                                          : (levels == 'Infinite'
                                              ? '$counter/12'
                                              : '$counter/10'))))),
                          style: FontStyleUtility.h25(
                              fontColor: ColorUtils.primary_gold,
                              family: 'PM')),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() => _kegel_controller.isuserinfoLoading.value ==
                              false
                          ? Container(
                              margin: const EdgeInsets.symmetric(horizontal: 0),
                              // height: 45,
                              // width:(width ?? 300) ,
                              decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.65),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#36393E").withOpacity(0.9),
                                      HexColor("#020204").withOpacity(0.9),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TableCalendar(
                                  availableGestures: AvailableGestures.none,

                                  // initialCalendarFormat: CalendarFormat.week,
                                  calendarStyle: CalendarStyle(
                                    defaultTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    todayTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    todayDecoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    // todayColor: Colors.orange,
                                    selectedTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.green),
                                    weekendTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    isTodayHighlighted: true,
                                    selectedDecoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),

                                  headerStyle: HeaderStyle(
                                    leftChevronIcon: Icon(
                                      Icons.arrow_back_ios,
                                      color: ColorUtils.primary_gold,
                                      size: 15,
                                    ),
                                    rightChevronIcon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorUtils.primary_gold,
                                      size: 15,
                                    ),
                                    formatButtonVisible: false,
                                    titleTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.white),
                                    // centerHeaderTitle: true,
                                    formatButtonDecoration: BoxDecoration(
                                      color: ColorUtils.primary_gold,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    formatButtonTextStyle:
                                        const TextStyle(color: Colors.black),
                                    formatButtonShowsNext: false,
                                  ),
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                      weekdayStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: Colors.white),
                                      weekendStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: Colors.white)),
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  onDaySelected: (date, events) async {
                                    // print(date);
                                    // print(DateFormat('yyyy-MM-dd').format(date));
                                    //
                                    // Data? person = await _peeScreenController
                                    //     .peeGetModel!.data!
                                    //     .firstWhereOrNull(
                                    //   (element) =>
                                    //       element.createdDate ==
                                    //       DateFormat('yyyy-MM-dd').format(date),
                                    // );
                                    // // print("person  $person");
                                    // if (person != null) {
                                    //   print("person ${person.sets}");
                                    //   print(
                                    //       "User peed ${person.sets} on ${person.createdDate}");
                                    // } else {
                                    //   print("no data found");
                                    // }
                                  },
                                  // builders: CalendarBuilders(
                                  //   selectedDayBuilder: (context, date, events) => Container(
                                  //       margin: const EdgeInsets.all(4.0),
                                  //       alignment: Alignment.center,
                                  //       decoration: BoxDecoration(
                                  //           color: Theme.of(context).primaryColor,
                                  //           borderRadius: BorderRadius.circular(10.0)),
                                  //       child: Text(
                                  //         date.day.toString(),
                                  //         style: TextStyle(color: Colors.white),
                                  //       )),
                                  //   todayDayBuilder: (context, date, events) => Container(
                                  //       margin: const EdgeInsets.all(4.0),
                                  //       alignment: Alignment.center,
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.orange,
                                  //           borderRadius: BorderRadius.circular(10.0)),
                                  //       child: Text(
                                  //         date.day.toString(),
                                  //         style: TextStyle(color: Colors.white),
                                  //       )),

                                  calendarBuilders: CalendarBuilders(
                                    markerBuilder:
                                        (BuildContext context, date, events) {
                                      for (var i = 0;
                                          i <
                                              _kegel_controller
                                                  .kegelGetModel!.data!.length;
                                          i++) {
                                        if (DateFormat('yyyy-MM-dd')
                                                .format(date) ==
                                            _kegel_controller.kegelGetModel!
                                                .data![i].createdDate) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selected_date_sets =
                                                    _kegel_controller
                                                        .kegelGetModel!
                                                        .data![i]
                                                        .numberOfSets!;
                                                selected_date =
                                                    _kegel_controller
                                                        .kegelGetModel!
                                                        .data![i]
                                                        .createdDate!;
                                              });
                                              print(selected_date_sets);
                                              print(selected_date);
                                            },
                                            child: Container(
                                              // color: Colors.white60,
                                              alignment: Alignment.center,
                                              padding:
                                                  EdgeInsets.only(bottom: 7),
                                              // margin: EdgeInsets.only(bottom: 7),
                                              // decoration: BoxDecoration(
                                              //   borderRadius:
                                              //       BorderRadius.circular(100),
                                              //   border: Border.all(
                                              //       color:
                                              //           ColorUtils.primary_gold,
                                              //       width: 2),
                                              // ),
                                              child:
                                                  (int.parse(_kegel_controller
                                                              .kegelGetModel!
                                                              .data![i]
                                                              .numberOfSets!) <
                                                          3
                                                      ? Image.asset(
                                                          "assets/images/white-star.png",
                                                          color: Colors.white,
                                                          height: 40,
                                                        )
                                                      // Icon(
                                                      //         Icons
                                                      //             .star_border_rounded,
                                                      //         color: Colors.white
                                                      //             .withOpacity(0.8),
                                                      //         size: 50,
                                                      //       )
                                                      : Image.asset(
                                                          "assets/images/white-star (1).png",
                                                          color: ColorUtils
                                                              .primary_gold
                                                              .withOpacity(0.8),
                                                          height: 40,
                                                        )
                                                  // Icon(
                                                  //         Icons.star_rounded,
                                                  //         color: ColorUtils
                                                  //             .primary_gold
                                                  //             .withOpacity(0.8),
                                                  //         size: 50,
                                                  //       )
                                                  ),
                                            ),
                                          );
                                        }
                                      }
                                      // return ListView.builder(
                                      //     shrinkWrap: true,
                                      //     scrollDirection: Axis.horizontal,
                                      //     itemCount: events.length,
                                      //     itemBuilder: (context, index) {
                                      //       return Container(
                                      //         margin: const EdgeInsets.only(top: 20),
                                      //         padding: const EdgeInsets.all(1),
                                      //         child: Container(
                                      //           // height: 7,
                                      //           width: 5,
                                      //           decoration: BoxDecoration(
                                      //               shape: BoxShape.circle,
                                      //               color: Colors.primaries[Random()
                                      //                   .nextInt(Colors.primaries.length)]),
                                      //         ),
                                      //       );
                                      //     });
                                    },
                                  ),

                                  calendarFormat: CalendarFormat.month,
                                  // calendarController: _controller,
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: DateTime.now(),
                                ),
                              ),
                            )
                          : SizedBox.shrink()),
                      const SizedBox(
                        height: 10,
                      ),
                      (selected_date_sets!.isEmpty
                          ? SizedBox.shrink()
                          : Container(
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
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15),
                                child: Text(
                                  'Exercise performed ${selected_date_sets} times on ${selected_date}',
                                  style: FontStyleUtility.h14(
                                      fontColor: HexColor('#FFFFFF'),
                                      family: 'PM'),
                                ),
                              ),
                            )),
                      const SizedBox(
                        height: 10,
                      ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //       // color: Colors.black.withOpacity(0.65),
                      //       gradient: LinearGradient(
                      //         begin: Alignment.centerLeft,
                      //         end: Alignment.centerRight,
                      //         // stops: [0.1, 0.5, 0.7, 0.9],
                      //         colors: [
                      //           HexColor("#36393E").withOpacity(1),
                      //           HexColor("#020204").withOpacity(1),
                      //         ],
                      //       ),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: HexColor('#04060F'),
                      //             offset: const Offset(10, 10),
                      //             blurRadius: 20)
                      //       ],
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: Column(
                      //     children: [
                      //       // if (_currentAlarms!.length < 5)
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 16, vertical: 0),
                      //         child: ListTile(
                      //           leading: Container(
                      //             margin: EdgeInsets.only(left: 0),
                      //             child: Text(
                      //               "Add Alarm",
                      //               style: FontStyleUtility.h16(
                      //                   fontColor: ColorUtils.primary_gold,
                      //                   family: 'PM'),
                      //             ),
                      //           ),
                      //           title: GestureDetector(
                      //               onTap: () {
                      //                 _alarmTimeString =
                      //                     DateFormat('HH:mm').format(selectedDate);
                      //                 showModalBottomSheet(
                      //                   useRootNavigator: true,
                      //                   context: context,
                      //                   clipBehavior: Clip.antiAlias,
                      //                   shape: const RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.vertical(
                      //                       top: Radius.circular(24),
                      //                     ),
                      //                   ),
                      //                   builder: (context) {
                      //                     return StatefulBuilder(
                      //                       builder: (context, setModalState) {
                      //                         return Container(
                      //                           decoration: BoxDecoration(
                      //                               // color: Colors.black.withOpacity(0.65),
                      //                               gradient: LinearGradient(
                      //                                 begin: Alignment.centerLeft,
                      //                                 end: Alignment.centerRight,
                      //                                 // stops: [0.1, 0.5, 0.7, 0.9],
                      //                                 colors: [
                      //                                   HexColor("#020204")
                      //                                       .withOpacity(1),
                      //                                   HexColor("#36393E")
                      //                                       .withOpacity(1),
                      //                                 ],
                      //                               ),
                      //                               boxShadow: [
                      //                                 BoxShadow(
                      //                                     color:
                      //                                         HexColor('#04060F'),
                      //                                     offset:
                      //                                         const Offset(-10, 10),
                      //                                     blurRadius: 20)
                      //                               ],
                      //                               borderRadius:
                      //                                   const BorderRadius.only(
                      //                                       topLeft:
                      //                                           Radius.circular(20),
                      //                                       topRight:
                      //                                           Radius.circular(
                      //                                               20))),
                      //                           padding: const EdgeInsets.all(32),
                      //                           child: SingleChildScrollView(
                      //                             child: Column(
                      //                               children: [
                      //                                 // FlatButton(
                      //                                 //   onPressed:
                      //                                 //       () async {
                      //                                 //     // var selectedTime = await showTimePicker(
                      //                                 //     //   context: context,
                      //                                 //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                      //                                 //     //   initialEntryMode: TimePickerEntryMode.dial,
                      //                                 //     //   initialTime: TimeOfDay.now(),
                      //                                 //     //   builder: (context, child) {
                      //                                 //     //     return Theme(
                      //                                 //     //       data: Theme.of(
                      //                                 //     //               context)
                      //                                 //     //           .copyWith(
                      //                                 //     //         colorScheme:
                      //                                 //     //             ColorScheme
                      //                                 //     //                 .dark(
                      //                                 //     //           primary:
                      //                                 //     //               Colors.black,
                      //                                 //     //           onPrimary:
                      //                                 //     //               Colors.white,
                      //                                 //     //           surface:
                      //                                 //     //               ColorUtils.primary_gold,
                      //                                 //     //           // onPrimary: Colors.black, // <-- SEE HERE
                      //                                 //     //           onSurface:
                      //                                 //     //               Colors.black,
                      //                                 //     //         ),
                      //                                 //     //         dialogBackgroundColor:
                      //                                 //     //             ColorUtils
                      //                                 //     //                 .primary_gold,
                      //                                 //     //         textButtonTheme:
                      //                                 //     //             TextButtonThemeData(
                      //                                 //     //           style: TextButton
                      //                                 //     //               .styleFrom(
                      //                                 //     //             primary:
                      //                                 //     //                 Colors.black, // button text color
                      //                                 //     //           ),
                      //                                 //     //         ),
                      //                                 //     //       ),
                      //                                 //     //       child:
                      //                                 //     //           child!,
                      //                                 //     //     );
                      //                                 //     //   },
                      //                                 //     // );
                      //                                 //     // if (selectedTime !=
                      //                                 //     //     null) {
                      //                                 //     //   final now =
                      //                                 //     //       DateTime
                      //                                 //     //           .now();
                      //                                 //     //   var selectedDateTime = DateTime(
                      //                                 //     //       now.year,
                      //                                 //     //       now.month,
                      //                                 //     //       now.day,
                      //                                 //     //       selectedTime
                      //                                 //     //           .hour,
                      //                                 //     //       selectedTime
                      //                                 //     //           .minute);
                      //                                 //     //   _alarmTime =
                      //                                 //     //       selectedDateTime;
                      //                                 //     //   setModalState(
                      //                                 //     //       () {
                      //                                 //     //     _alarmTimeString =
                      //                                 //     //         DateFormat(
                      //                                 //     //                 'HH:mm')
                      //                                 //     //             .format(
                      //                                 //     //                 selectedDateTime);
                      //                                 //     //   });
                      //                                 //     // }
                      //                                 //   },
                      //                                 //   child: Text(
                      //                                 //       _alarmTimeString!,
                      //                                 //       style: FontStyleUtility.h35(
                      //                                 //           fontColor:
                      //                                 //               ColorUtils
                      //                                 //                   .primary_gold,
                      //                                 //           family:
                      //                                 //               'PM')),
                      //                                 // ),
                      //                                 Container(
                      //                                   height: 150,
                      //                                   decoration: BoxDecoration(
                      //                                       borderRadius:
                      //                                           BorderRadius
                      //                                               .circular(15),
                      //                                       gradient:
                      //                                           LinearGradient(
                      //                                         begin: Alignment
                      //                                             .topCenter,
                      //                                         end: Alignment
                      //                                             .bottomCenter,
                      //                                         colors: [
                      //                                           HexColor("#000000")
                      //                                               .withOpacity(1),
                      //                                           HexColor("#04060F")
                      //                                               .withOpacity(1),
                      //                                           HexColor("#000000")
                      //                                               .withOpacity(1),
                      //                                         ],
                      //                                       ),
                      //                                       boxShadow: [
                      //                                         BoxShadow(
                      //                                             color: HexColor(
                      //                                                 '#04060F'),
                      //                                             offset:
                      //                                                 Offset(3, 3),
                      //                                             blurRadius: 10)
                      //                                       ]),
                      //                                   child: Stack(
                      //                                     children: [
                      //                                       CupertinoTheme(
                      //                                         data:
                      //                                             CupertinoThemeData(
                      //                                           brightness:
                      //                                               Brightness.dark,
                      //                                         ),
                      //                                         child:
                      //                                             CupertinoDatePicker(
                      //                                           // use24hFormat: true,
                      //                                           mode:
                      //                                               CupertinoDatePickerMode
                      //                                                   .time,
                      //                                           onDateTimeChanged:
                      //                                               (DateTime
                      //                                                   value) {
                      //                                             selected_time =
                      //                                                 value;
                      //                                             print(
                      //                                                 "${value.hour}:${value.minute}");
                      //
                      //                                             if (selected_time !=
                      //                                                 null) {
                      //                                               final now =
                      //                                                   DateTime
                      //                                                       .now();
                      //                                               var selectedDateTime = DateTime(
                      //                                                   now.year,
                      //                                                   now.month,
                      //                                                   now.day,
                      //                                                   selected_time
                      //                                                       .hour,
                      //                                                   selected_time
                      //                                                       .minute);
                      //                                               _alarmTime =
                      //                                                   selectedDateTime;
                      //                                               setModalState(
                      //                                                   () {
                      //                                                 _alarmTimeString =
                      //                                                     DateFormat(
                      //                                                             'HH:mm')
                      //                                                         .format(
                      //                                                             selectedDateTime);
                      //                                               });
                      //                                             }
                      //                                           },
                      //                                         ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ),
                      //
                      //                                 ListTile(
                      //                                   onTap: () {
                      //                                     showDialog(
                      //                                       context: context,
                      //                                       builder: (BuildContext
                      //                                           context) {
                      //                                         double width =
                      //                                             MediaQuery.of(
                      //                                                     context)
                      //                                                 .size
                      //                                                 .width;
                      //                                         double height =
                      //                                             MediaQuery.of(
                      //                                                     context)
                      //                                                 .size
                      //                                                 .height;
                      //                                         return BackdropFilter(
                      //                                           filter: ImageFilter
                      //                                               .blur(
                      //                                                   sigmaX: 10,
                      //                                                   sigmaY: 10),
                      //                                           child: AlertDialog(
                      //                                               backgroundColor:
                      //                                                   Colors
                      //                                                       .transparent,
                      //                                               contentPadding:
                      //                                                   EdgeInsets
                      //                                                       .zero,
                      //                                               elevation: 0.0,
                      //                                               // title: Center(child: Text("Evaluation our APP")),
                      //                                               content: Column(
                      //                                                 mainAxisAlignment:
                      //                                                     MainAxisAlignment
                      //                                                         .center,
                      //                                                 children: [
                      //                                                   Stack(
                      //                                                     children: [
                      //                                                       Padding(
                      //                                                         padding:
                      //                                                             const EdgeInsets.all(8.0),
                      //                                                         child:
                      //                                                             Container(
                      //                                                           decoration:
                      //                                                               BoxDecoration(
                      //                                                                   // color: Colors.black.withOpacity(0.65),
                      //                                                                   gradient:
                      //                                                                       LinearGradient(
                      //                                                                     begin: Alignment.centerLeft,
                      //                                                                     end: Alignment.centerRight,
                      //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                      //                                                                     colors: [
                      //                                                                       HexColor("#020204").withOpacity(1),
                      //                                                                       HexColor("#36393E").withOpacity(1),
                      //                                                                     ],
                      //                                                                   ),
                      //                                                                   boxShadow: [
                      //                                                                     BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //                                                                   ],
                      //                                                                   borderRadius: BorderRadius.circular(15)),
                      //                                                           child: Align(
                      //                                                               alignment: Alignment.center,
                      //                                                               child: Padding(
                      //                                                                 padding: const EdgeInsets.all(8.0),
                      //                                                                 child: Column(
                      //                                                                   children: [
                      //                                                                     SizedBox(
                      //                                                                       height: 0,
                      //                                                                     ),
                      //
                      //                                                                     Column(
                      //                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                                                                       children: [
                      //                                                                         Container(
                      //                                                                           margin: EdgeInsets.only(left: 18),
                      //                                                                           child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                      //                                                                         ),
                      //                                                                         SizedBox(
                      //                                                                           height: 11,
                      //                                                                         ),
                      //                                                                         Container(
                      //                                                                           margin: EdgeInsets.symmetric(horizontal: 10),
                      //                                                                           // width: 300,
                      //                                                                           decoration: BoxDecoration(
                      //                                                                               // color: Colors.black.withOpacity(0.65),
                      //                                                                               gradient: LinearGradient(
                      //                                                                                 begin: Alignment.centerLeft,
                      //                                                                                 end: Alignment.centerRight,
                      //                                                                                 // stops: [0.1, 0.5, 0.7, 0.9],
                      //                                                                                 colors: [
                      //                                                                                   HexColor("#36393E").withOpacity(1),
                      //                                                                                   HexColor("#020204").withOpacity(1),
                      //                                                                                 ],
                      //                                                                               ),
                      //                                                                               boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                      //                                                                               borderRadius: BorderRadius.circular(20)),
                      //
                      //                                                                           child: TextFormField(
                      //                                                                             maxLength: 150,
                      //                                                                             decoration: InputDecoration(
                      //                                                                               contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                      //                                                                               alignLabelWithHint: false,
                      //                                                                               isDense: true,
                      //                                                                               hintText: 'Add alarm title',
                      //                                                                               counterStyle: TextStyle(
                      //                                                                                 height: double.minPositive,
                      //                                                                               ),
                      //                                                                               counterText: "",
                      //                                                                               filled: true,
                      //                                                                               border: InputBorder.none,
                      //                                                                               enabledBorder: const OutlineInputBorder(
                      //                                                                                 borderSide: BorderSide(color: Colors.transparent, width: 1),
                      //                                                                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                      //                                                                               ),
                      //                                                                               hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                      //                                                                             ),
                      //                                                                             style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //                                                                             controller: Alarm_title,
                      //                                                                             keyboardType: TextInputType.text,
                      //                                                                           ),
                      //                                                                         ),
                      //                                                                       ],
                      //                                                                     ),
                      //                                                                     SizedBox(
                      //                                                                       height: 10,
                      //                                                                     ),
                      //                                                                     GestureDetector(
                      //                                                                       onTap: () {
                      //                                                                         setState(() {
                      //                                                                           Alarm_title_list.add(Alarm_title.text);
                      //                                                                           Navigator.pop(context);
                      //                                                                         });
                      //                                                                       },
                      //                                                                       child: Container(
                      //                                                                         alignment: Alignment.topRight,
                      //                                                                         child: Text(
                      //                                                                           'Add',
                      //                                                                           style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //                                                                         ),
                      //                                                                       ),
                      //                                                                     )
                      //                                                                     // common_button_gold(
                      //                                                                     //   onTap: () {
                      //                                                                     //     Get
                      //                                                                     //         .to(
                      //                                                                     //         DashboardScreen());
                      //                                                                     //   },
                      //                                                                     //   title_text: 'Go to Dashboard',
                      //                                                                     // ),
                      //                                                                   ],
                      //                                                                 ),
                      //                                                               )),
                      //                                                         ),
                      //                                                       ),
                      //                                                       GestureDetector(
                      //                                                         onTap:
                      //                                                             () {
                      //                                                           Navigator.pop(context);
                      //                                                         },
                      //                                                         child:
                      //                                                             Container(
                      //                                                           margin:
                      //                                                               EdgeInsets.only(right: 10),
                      //                                                           alignment:
                      //                                                               Alignment.topRight,
                      //                                                           child: Container(
                      //                                                               decoration: BoxDecoration(
                      //                                                                   // color: Colors.black.withOpacity(0.65),
                      //                                                                   gradient: LinearGradient(
                      //                                                                     begin: Alignment.centerLeft,
                      //                                                                     end: Alignment.centerRight,
                      //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                      //                                                                     colors: [
                      //                                                                       HexColor("#36393E").withOpacity(1),
                      //                                                                       HexColor("#020204").withOpacity(1),
                      //                                                                     ],
                      //                                                                   ),
                      //                                                                   boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //                                                                   borderRadius: BorderRadius.circular(20)),
                      //                                                               child: Padding(
                      //                                                                 padding: const EdgeInsets.all(4.0),
                      //                                                                 child: Icon(
                      //                                                                   Icons.cancel_outlined,
                      //                                                                   size: 13,
                      //                                                                   color: ColorUtils.primary_grey,
                      //                                                                 ),
                      //                                                               )),
                      //                                                         ),
                      //                                                       )
                      //                                                     ],
                      //                                                   ),
                      //                                                 ],
                      //                                               )),
                      //                                         );
                      //                                       },
                      //                                     );
                      //                                   },
                      //                                   title: Text('Title',
                      //                                       style: FontStyleUtility.h14(
                      //                                           fontColor: ColorUtils
                      //                                               .primary_grey,
                      //                                           family: 'PR')),
                      //                                   trailing: const Icon(
                      //                                       Icons.arrow_forward_ios,
                      //                                       size: 15,
                      //                                       color: Colors.white),
                      //                                 ),
                      //                                 ListTile(
                      //                                   title: Text(
                      //                                     'Repeat',
                      //                                     style: FontStyleUtility.h14(
                      //                                         fontColor: ColorUtils
                      //                                             .primary_gold,
                      //                                         family: 'PR'),
                      //                                   ),
                      //                                   trailing: const Icon(
                      //                                     Icons.arrow_forward_ios,
                      //                                     size: 15,
                      //                                     color: Colors.white,
                      //                                   ),
                      //                                 ),
                      //                                 GestureDetector(
                      //                                   onTap: () {
                      //                                     print('object');
                      //
                      //                                     showDialog(
                      //                                       context: context,
                      //                                       builder: (BuildContext
                      //                                           context) {
                      //                                         double width =
                      //                                             MediaQuery.of(
                      //                                                     context)
                      //                                                 .size
                      //                                                 .width;
                      //                                         double height =
                      //                                             MediaQuery.of(
                      //                                                     context)
                      //                                                 .size
                      //                                                 .height;
                      //                                         return AlertDialog(
                      //                                             backgroundColor:
                      //                                                 Colors
                      //                                                     .transparent,
                      //                                             contentPadding:
                      //                                                 EdgeInsets
                      //                                                     .zero,
                      //                                             elevation: 0.0,
                      //                                             // title: Center(child: Text("Evaluation our APP")),
                      //                                             content: Column(
                      //                                               mainAxisAlignment:
                      //                                                   MainAxisAlignment
                      //                                                       .center,
                      //                                               children: [
                      //                                                 Stack(
                      //                                                   children: [
                      //                                                     Container(
                      //                                                       // height: 150,
                      //                                                       // height: double.maxFinite,
                      //                                                       height:
                      //                                                           MediaQuery.of(context).size.height /
                      //                                                               4,
                      //                                                       width: double
                      //                                                           .maxFinite,
                      //                                                       decoration:
                      //                                                           BoxDecoration(
                      //                                                               // color: Colors.black.withOpacity(0.65),
                      //                                                               gradient:
                      //                                                                   LinearGradient(
                      //                                                                 begin: Alignment.centerLeft,
                      //                                                                 end: Alignment.centerRight,
                      //                                                                 // stops: [0.1, 0.5, 0.7, 0.9],
                      //                                                                 colors: [
                      //                                                                   HexColor("#020204").withOpacity(1),
                      //                                                                   HexColor("#36393E").withOpacity(1),
                      //                                                                 ],
                      //                                                               ),
                      //                                                               boxShadow: [
                      //                                                                 BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //                                                               ],
                      //                                                               borderRadius: BorderRadius.circular(20)),
                      //                                                       margin: EdgeInsets.symmetric(
                      //                                                           horizontal:
                      //                                                               10,
                      //                                                           vertical:
                      //                                                               10),
                      //                                                       // height: 122,
                      //                                                       // width: 133,
                      //                                                       // padding: const EdgeInsets.all(8.0),
                      //                                                       child:
                      //                                                           Column(
                      //                                                         mainAxisAlignment:
                      //                                                             MainAxisAlignment.center,
                      //                                                         children: [
                      //                                                           Container(
                      //                                                             // color: Colors.white,
                      //                                                             alignment: Alignment.center,
                      //                                                             child: ListView.builder(
                      //                                                               padding: EdgeInsets.only(bottom: 0),
                      //
                      //                                                               // physics: NeverScrollableScrollPhysics(),
                      //                                                               itemCount: list_alarm.length,
                      //                                                               shrinkWrap: true,
                      //                                                               itemBuilder: (BuildContext context, int index) {
                      //                                                                 return GestureDetector(
                      //                                                                   onTap: () {
                      //                                                                     setState(() {
                      //                                                                       Selected_sound = list_alarm[index];
                      //                                                                       print("method_selected $Selected_sound");
                      //                                                                     });
                      //                                                                     Navigator.pop(context);
                      //                                                                   },
                      //                                                                   child: Container(
                      //                                                                     margin: EdgeInsets.symmetric(vertical: 8.5),
                      //                                                                     alignment: Alignment.center,
                      //                                                                     child: Text(
                      //                                                                       list_alarm[index],
                      //                                                                       style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                      //                                                                     ),
                      //                                                                   ),
                      //                                                                 );
                      //                                                               },
                      //                                                             ),
                      //                                                           ),
                      //                                                         ],
                      //                                                       ),
                      //                                                     ),
                      //                                                     GestureDetector(
                      //                                                       onTap:
                      //                                                           () {
                      //                                                         Navigator.pop(
                      //                                                             context);
                      //                                                       },
                      //                                                       child:
                      //                                                           Container(
                      //                                                         margin:
                      //                                                             EdgeInsets.only(right: 0),
                      //                                                         alignment:
                      //                                                             Alignment.topRight,
                      //                                                         child: Container(
                      //                                                             decoration: BoxDecoration(
                      //                                                                 // color: Colors.black.withOpacity(0.65),
                      //                                                                 gradient: LinearGradient(
                      //                                                                   begin: Alignment.centerLeft,
                      //                                                                   end: Alignment.centerRight,
                      //                                                                   // stops: [0.1, 0.5, 0.7, 0.9],
                      //                                                                   colors: [
                      //                                                                     HexColor("#36393E").withOpacity(1),
                      //                                                                     HexColor("#020204").withOpacity(1),
                      //                                                                   ],
                      //                                                                 ),
                      //                                                                 boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //                                                                 borderRadius: BorderRadius.circular(20)),
                      //                                                             child: Padding(
                      //                                                               padding: const EdgeInsets.all(4.0),
                      //                                                               child: Icon(
                      //                                                                 Icons.cancel_outlined,
                      //                                                                 size: 20,
                      //                                                                 color: ColorUtils.primary_grey,
                      //                                                               ),
                      //                                                             )),
                      //                                                       ),
                      //                                                     )
                      //                                                   ],
                      //                                                 ),
                      //                                               ],
                      //                                             ));
                      //                                       },
                      //                                     );
                      //                                   },
                      //                                   child: ListTile(
                      //                                     title: Text('Sound',
                      //                                         style: FontStyleUtility.h14(
                      //                                             fontColor: ColorUtils
                      //                                                 .primary_gold,
                      //                                             family: 'PR')),
                      //                                     trailing: const Icon(
                      //                                         Icons
                      //                                             .arrow_forward_ios,
                      //                                         size: 15,
                      //                                         color: Colors.white),
                      //                                   ),
                      //                                 ),
                      //                                 GestureDetector(
                      //                                   onTap: () async {
                      //                                     if (Alarm_title
                      //                                         .text.isEmpty) {
                      //                                       CommonWidget()
                      //                                           .showErrorToaster(
                      //                                               msg:
                      //                                                   "Enter Alarm title");
                      //                                       return;
                      //                                     } else {
                      //                                       await onSaveAlarm();
                      //                                     }
                      //                                   },
                      //                                   child: Container(
                      //                                     width:
                      //                                         MediaQuery.of(context)
                      //                                                 .size
                      //                                                 .width /
                      //                                             3,
                      //                                     decoration: BoxDecoration(
                      //                                         borderRadius:
                      //                                             BorderRadius
                      //                                                 .circular(30),
                      //                                         border: Border.all(
                      //                                             color: ColorUtils
                      //                                                 .primary_grey,
                      //                                             width: 1)),
                      //                                     child: Padding(
                      //                                       padding:
                      //                                           const EdgeInsets
                      //                                                   .symmetric(
                      //                                               vertical: 12.0,
                      //                                               horizontal: 8),
                      //                                       child: Row(
                      //                                         mainAxisAlignment:
                      //                                             MainAxisAlignment
                      //                                                 .center,
                      //                                         children: [
                      //                                           const Icon(
                      //                                             Icons.alarm,
                      //                                             color:
                      //                                                 Colors.white,
                      //                                             size: 25,
                      //                                           ),
                      //                                           const SizedBox(
                      //                                             width: 10,
                      //                                           ),
                      //                                           Text(
                      //                                             'Save',
                      //                                             style: FontStyleUtility.h16(
                      //                                                 fontColor:
                      //                                                     ColorUtils
                      //                                                         .primary_gold,
                      //                                                 family: 'PR'),
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 )
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         );
                      //                       },
                      //                     );
                      //                   },
                      //                 );
                      //                 // scheduleAlarm();
                      //               },
                      //               child: Container(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(0.0),
                      //                   child: Icon(
                      //                     Icons.add_circle_outline,
                      //                     color: ColorUtils.primary_grey,
                      //                   ),
                      //                 ),
                      //               )),
                      //           // trailing: Padding(
                      //           //   padding: const EdgeInsets.symmetric(
                      //           //       horizontal: 16, vertical: 10),
                      //           //   child: GestureDetector(
                      //           //       onTap: () {
                      //           //         _alarmTimeString = DateFormat('HH:mm')
                      //           //             .format(selectedDate);
                      //           //         showModalBottomSheet(
                      //           //           useRootNavigator: true,
                      //           //           context: context,
                      //           //           clipBehavior: Clip.antiAlias,
                      //           //           shape: const RoundedRectangleBorder(
                      //           //             borderRadius: BorderRadius.vertical(
                      //           //               top: Radius.circular(24),
                      //           //             ),
                      //           //           ),
                      //           //           builder: (context) {
                      //           //             return StatefulBuilder(
                      //           //               builder: (context, setModalState) {
                      //           //                 return Container(
                      //           //                   decoration: BoxDecoration(
                      //           //                       // color: Colors.black.withOpacity(0.65),
                      //           //                       gradient: LinearGradient(
                      //           //                         begin: Alignment.centerLeft,
                      //           //                         end: Alignment.centerRight,
                      //           //                         // stops: [0.1, 0.5, 0.7, 0.9],
                      //           //                         colors: [
                      //           //                           HexColor("#020204")
                      //           //                               .withOpacity(1),
                      //           //                           HexColor("#36393E")
                      //           //                               .withOpacity(1),
                      //           //                         ],
                      //           //                       ),
                      //           //                       boxShadow: [
                      //           //                         BoxShadow(
                      //           //                             color:
                      //           //                                 HexColor('#04060F'),
                      //           //                             offset: const Offset(
                      //           //                                 -10, 10),
                      //           //                             blurRadius: 20)
                      //           //                       ],
                      //           //                       borderRadius:
                      //           //                           const BorderRadius.only(
                      //           //                               topLeft:
                      //           //                                   Radius.circular(
                      //           //                                       20),
                      //           //                               topRight:
                      //           //                                   Radius.circular(
                      //           //                                       20))),
                      //           //                   padding: const EdgeInsets.all(32),
                      //           //                   child: SingleChildScrollView(
                      //           //                     child: Column(
                      //           //                       children: [
                      //           //                         // FlatButton(
                      //           //                         //   onPressed:
                      //           //                         //       () async {
                      //           //                         //     // var selectedTime = await showTimePicker(
                      //           //                         //     //   context: context,
                      //           //                         //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                      //           //                         //     //   initialEntryMode: TimePickerEntryMode.dial,
                      //           //                         //     //   initialTime: TimeOfDay.now(),
                      //           //                         //     //   builder: (context, child) {
                      //           //                         //     //     return Theme(
                      //           //                         //     //       data: Theme.of(
                      //           //                         //     //               context)
                      //           //                         //     //           .copyWith(
                      //           //                         //     //         colorScheme:
                      //           //                         //     //             ColorScheme
                      //           //                         //     //                 .dark(
                      //           //                         //     //           primary:
                      //           //                         //     //               Colors.black,
                      //           //                         //     //           onPrimary:
                      //           //                         //     //               Colors.white,
                      //           //                         //     //           surface:
                      //           //                         //     //               ColorUtils.primary_gold,
                      //           //                         //     //           // onPrimary: Colors.black, // <-- SEE HERE
                      //           //                         //     //           onSurface:
                      //           //                         //     //               Colors.black,
                      //           //                         //     //         ),
                      //           //                         //     //         dialogBackgroundColor:
                      //           //                         //     //             ColorUtils
                      //           //                         //     //                 .primary_gold,
                      //           //                         //     //         textButtonTheme:
                      //           //                         //     //             TextButtonThemeData(
                      //           //                         //     //           style: TextButton
                      //           //                         //     //               .styleFrom(
                      //           //                         //     //             primary:
                      //           //                         //     //                 Colors.black, // button text color
                      //           //                         //     //           ),
                      //           //                         //     //         ),
                      //           //                         //     //       ),
                      //           //                         //     //       child:
                      //           //                         //     //           child!,
                      //           //                         //     //     );
                      //           //                         //     //   },
                      //           //                         //     // );
                      //           //                         //     // if (selectedTime !=
                      //           //                         //     //     null) {
                      //           //                         //     //   final now =
                      //           //                         //     //       DateTime
                      //           //                         //     //           .now();
                      //           //                         //     //   var selectedDateTime = DateTime(
                      //           //                         //     //       now.year,
                      //           //                         //     //       now.month,
                      //           //                         //     //       now.day,
                      //           //                         //     //       selectedTime
                      //           //                         //     //           .hour,
                      //           //                         //     //       selectedTime
                      //           //                         //     //           .minute);
                      //           //                         //     //   _alarmTime =
                      //           //                         //     //       selectedDateTime;
                      //           //                         //     //   setModalState(
                      //           //                         //     //       () {
                      //           //                         //     //     _alarmTimeString =
                      //           //                         //     //         DateFormat(
                      //           //                         //     //                 'HH:mm')
                      //           //                         //     //             .format(
                      //           //                         //     //                 selectedDateTime);
                      //           //                         //     //   });
                      //           //                         //     // }
                      //           //                         //   },
                      //           //                         //   child: Text(
                      //           //                         //       _alarmTimeString!,
                      //           //                         //       style: FontStyleUtility.h35(
                      //           //                         //           fontColor:
                      //           //                         //               ColorUtils
                      //           //                         //                   .primary_gold,
                      //           //                         //           family:
                      //           //                         //               'PM')),
                      //           //                         // ),
                      //           //                         Container(
                      //           //                           height: 150,
                      //           //                           decoration: BoxDecoration(
                      //           //                               borderRadius:
                      //           //                                   BorderRadius
                      //           //                                       .circular(15),
                      //           //                               gradient:
                      //           //                                   LinearGradient(
                      //           //                                 begin: Alignment
                      //           //                                     .topCenter,
                      //           //                                 end: Alignment
                      //           //                                     .bottomCenter,
                      //           //                                 colors: [
                      //           //                                   HexColor(
                      //           //                                           "#000000")
                      //           //                                       .withOpacity(
                      //           //                                           1),
                      //           //                                   HexColor(
                      //           //                                           "#04060F")
                      //           //                                       .withOpacity(
                      //           //                                           1),
                      //           //                                   HexColor(
                      //           //                                           "#000000")
                      //           //                                       .withOpacity(
                      //           //                                           1),
                      //           //                                 ],
                      //           //                               ),
                      //           //                               boxShadow: [
                      //           //                                 BoxShadow(
                      //           //                                     color: HexColor(
                      //           //                                         '#04060F'),
                      //           //                                     offset: Offset(
                      //           //                                         3, 3),
                      //           //                                     blurRadius: 10)
                      //           //                               ]),
                      //           //                           child: Stack(
                      //           //                             children: [
                      //           //                               CupertinoTheme(
                      //           //                                 data:
                      //           //                                     CupertinoThemeData(
                      //           //                                   brightness:
                      //           //                                       Brightness
                      //           //                                           .dark,
                      //           //                                 ),
                      //           //                                 child:
                      //           //                                     CupertinoDatePicker(
                      //           //                                   // use24hFormat: true,
                      //           //                                   mode:
                      //           //                                       CupertinoDatePickerMode
                      //           //                                           .time,
                      //           //                                   onDateTimeChanged:
                      //           //                                       (DateTime
                      //           //                                           value) {
                      //           //                                     selected_time =
                      //           //                                         value;
                      //           //                                     print(
                      //           //                                         "${value.hour}:${value.minute}");
                      //           //
                      //           //                                     if (selected_time !=
                      //           //                                         null) {
                      //           //                                       final now =
                      //           //                                           DateTime
                      //           //                                               .now();
                      //           //                                       var selectedDateTime = DateTime(
                      //           //                                           now.year,
                      //           //                                           now.month,
                      //           //                                           now.day,
                      //           //                                           selected_time
                      //           //                                               .hour,
                      //           //                                           selected_time
                      //           //                                               .minute);
                      //           //                                       _alarmTime =
                      //           //                                           selectedDateTime;
                      //           //                                       setModalState(
                      //           //                                           () {
                      //           //                                         _alarmTimeString = DateFormat(
                      //           //                                                 'HH:mm')
                      //           //                                             .format(
                      //           //                                                 selectedDateTime);
                      //           //                                       });
                      //           //                                     }
                      //           //                                   },
                      //           //                                 ),
                      //           //                               ),
                      //           //                             ],
                      //           //                           ),
                      //           //                         ),
                      //           //
                      //           //                         ListTile(
                      //           //                           onTap: () {
                      //           //                             showDialog(
                      //           //                               context: context,
                      //           //                               builder: (BuildContext
                      //           //                                   context) {
                      //           //                                 double width =
                      //           //                                     MediaQuery.of(
                      //           //                                             context)
                      //           //                                         .size
                      //           //                                         .width;
                      //           //                                 double height =
                      //           //                                     MediaQuery.of(
                      //           //                                             context)
                      //           //                                         .size
                      //           //                                         .height;
                      //           //                                 return BackdropFilter(
                      //           //                                   filter: ImageFilter
                      //           //                                       .blur(
                      //           //                                           sigmaX:
                      //           //                                               10,
                      //           //                                           sigmaY:
                      //           //                                               10),
                      //           //                                   child:
                      //           //                                       AlertDialog(
                      //           //                                           backgroundColor:
                      //           //                                               Colors
                      //           //                                                   .transparent,
                      //           //                                           contentPadding:
                      //           //                                               EdgeInsets
                      //           //                                                   .zero,
                      //           //                                           elevation:
                      //           //                                               0.0,
                      //           //                                           // title: Center(child: Text("Evaluation our APP")),
                      //           //                                           content:
                      //           //                                               Column(
                      //           //                                             mainAxisAlignment:
                      //           //                                                 MainAxisAlignment.center,
                      //           //                                             children: [
                      //           //                                               Stack(
                      //           //                                                 children: [
                      //           //                                                   Padding(
                      //           //                                                     padding: const EdgeInsets.all(8.0),
                      //           //                                                     child: Container(
                      //           //                                                       decoration:
                      //           //                                                           BoxDecoration(
                      //           //                                                               // color: Colors.black.withOpacity(0.65),
                      //           //                                                               gradient:
                      //           //                                                                   LinearGradient(
                      //           //                                                                 begin: Alignment.centerLeft,
                      //           //                                                                 end: Alignment.centerRight,
                      //           //                                                                 // stops: [0.1, 0.5, 0.7, 0.9],
                      //           //                                                                 colors: [
                      //           //                                                                   HexColor("#020204").withOpacity(1),
                      //           //                                                                   HexColor("#36393E").withOpacity(1),
                      //           //                                                                 ],
                      //           //                                                               ),
                      //           //                                                               boxShadow: [
                      //           //                                                                 BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //           //                                                               ],
                      //           //                                                               borderRadius: BorderRadius.circular(15)),
                      //           //                                                       child: Align(
                      //           //                                                           alignment: Alignment.center,
                      //           //                                                           child: Padding(
                      //           //                                                             padding: const EdgeInsets.all(8.0),
                      //           //                                                             child: Column(
                      //           //                                                               children: [
                      //           //                                                                 SizedBox(
                      //           //                                                                   height: 0,
                      //           //                                                                 ),
                      //           //
                      //           //                                                                 Column(
                      //           //                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                      //           //                                                                   children: [
                      //           //                                                                     Container(
                      //           //                                                                       margin: EdgeInsets.only(left: 18),
                      //           //                                                                       child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                      //           //                                                                     ),
                      //           //                                                                     SizedBox(
                      //           //                                                                       height: 11,
                      //           //                                                                     ),
                      //           //                                                                     Container(
                      //           //                                                                       margin: EdgeInsets.symmetric(horizontal: 10),
                      //           //                                                                       // width: 300,
                      //           //                                                                       decoration: BoxDecoration(
                      //           //                                                                           // color: Colors.black.withOpacity(0.65),
                      //           //                                                                           gradient: LinearGradient(
                      //           //                                                                             begin: Alignment.centerLeft,
                      //           //                                                                             end: Alignment.centerRight,
                      //           //                                                                             // stops: [0.1, 0.5, 0.7, 0.9],
                      //           //                                                                             colors: [
                      //           //                                                                               HexColor("#36393E").withOpacity(1),
                      //           //                                                                               HexColor("#020204").withOpacity(1),
                      //           //                                                                             ],
                      //           //                                                                           ),
                      //           //                                                                           boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                      //           //                                                                           borderRadius: BorderRadius.circular(20)),
                      //           //
                      //           //                                                                       child: TextFormField(
                      //           //                                                                         maxLength: 150,
                      //           //                                                                         decoration: InputDecoration(
                      //           //                                                                           contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                      //           //                                                                           alignLabelWithHint: false,
                      //           //                                                                           isDense: true,
                      //           //                                                                           hintText: 'Add alarm title',
                      //           //                                                                           counterStyle: TextStyle(
                      //           //                                                                             height: double.minPositive,
                      //           //                                                                           ),
                      //           //                                                                           counterText: "",
                      //           //                                                                           filled: true,
                      //           //                                                                           border: InputBorder.none,
                      //           //                                                                           enabledBorder: const OutlineInputBorder(
                      //           //                                                                             borderSide: BorderSide(color: Colors.transparent, width: 1),
                      //           //                                                                             borderRadius: BorderRadius.all(Radius.circular(10)),
                      //           //                                                                           ),
                      //           //                                                                           hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                      //           //                                                                         ),
                      //           //                                                                         style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //           //                                                                         controller: Alarm_title,
                      //           //                                                                         keyboardType: TextInputType.text,
                      //           //                                                                       ),
                      //           //                                                                     ),
                      //           //                                                                   ],
                      //           //                                                                 ),
                      //           //                                                                 SizedBox(
                      //           //                                                                   height: 10,
                      //           //                                                                 ),
                      //           //                                                                 GestureDetector(
                      //           //                                                                   onTap: () {
                      //           //                                                                     setState(() {
                      //           //                                                                       Alarm_title_list.add(Alarm_title.text);
                      //           //                                                                       Navigator.pop(context);
                      //           //                                                                     });
                      //           //                                                                   },
                      //           //                                                                   child: Container(
                      //           //                                                                     alignment: Alignment.topRight,
                      //           //                                                                     child: Text(
                      //           //                                                                       'Add',
                      //           //                                                                       style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //           //                                                                     ),
                      //           //                                                                   ),
                      //           //                                                                 )
                      //           //                                                                 // common_button_gold(
                      //           //                                                                 //   onTap: () {
                      //           //                                                                 //     Get
                      //           //                                                                 //         .to(
                      //           //                                                                 //         DashboardScreen());
                      //           //                                                                 //   },
                      //           //                                                                 //   title_text: 'Go to Dashboard',
                      //           //                                                                 // ),
                      //           //                                                               ],
                      //           //                                                             ),
                      //           //                                                           )),
                      //           //                                                     ),
                      //           //                                                   ),
                      //           //                                                   GestureDetector(
                      //           //                                                     onTap: () {
                      //           //                                                       Navigator.pop(context);
                      //           //                                                     },
                      //           //                                                     child: Container(
                      //           //                                                       margin: EdgeInsets.only(right: 10),
                      //           //                                                       alignment: Alignment.topRight,
                      //           //                                                       child: Container(
                      //           //                                                           decoration: BoxDecoration(
                      //           //                                                               // color: Colors.black.withOpacity(0.65),
                      //           //                                                               gradient: LinearGradient(
                      //           //                                                                 begin: Alignment.centerLeft,
                      //           //                                                                 end: Alignment.centerRight,
                      //           //                                                                 // stops: [0.1, 0.5, 0.7, 0.9],
                      //           //                                                                 colors: [
                      //           //                                                                   HexColor("#36393E").withOpacity(1),
                      //           //                                                                   HexColor("#020204").withOpacity(1),
                      //           //                                                                 ],
                      //           //                                                               ),
                      //           //                                                               boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //           //                                                               borderRadius: BorderRadius.circular(20)),
                      //           //                                                           child: Padding(
                      //           //                                                             padding: const EdgeInsets.all(4.0),
                      //           //                                                             child: Icon(
                      //           //                                                               Icons.cancel_outlined,
                      //           //                                                               size: 13,
                      //           //                                                               color: ColorUtils.primary_grey,
                      //           //                                                             ),
                      //           //                                                           )),
                      //           //                                                     ),
                      //           //                                                   )
                      //           //                                                 ],
                      //           //                                               ),
                      //           //                                             ],
                      //           //                                           )),
                      //           //                                 );
                      //           //                               },
                      //           //                             );
                      //           //                           },
                      //           //                           title: Text('Title',
                      //           //                               style: FontStyleUtility.h14(
                      //           //                                   fontColor: ColorUtils
                      //           //                                       .primary_grey,
                      //           //                                   family: 'PR')),
                      //           //                           trailing: const Icon(
                      //           //                               Icons
                      //           //                                   .arrow_forward_ios,
                      //           //                               size: 15,
                      //           //                               color: Colors.white),
                      //           //                         ),
                      //           //                         ListTile(
                      //           //                           title: Text(
                      //           //                             'Repeat',
                      //           //                             style: FontStyleUtility.h14(
                      //           //                                 fontColor: ColorUtils
                      //           //                                     .primary_gold,
                      //           //                                 family: 'PR'),
                      //           //                           ),
                      //           //                           trailing: const Icon(
                      //           //                             Icons.arrow_forward_ios,
                      //           //                             size: 15,
                      //           //                             color: Colors.white,
                      //           //                           ),
                      //           //                         ),
                      //           //                         GestureDetector(
                      //           //                           onTap: () {
                      //           //                             print('object');
                      //           //
                      //           //                             showDialog(
                      //           //                               context: context,
                      //           //                               builder: (BuildContext
                      //           //                                   context) {
                      //           //                                 double width =
                      //           //                                     MediaQuery.of(
                      //           //                                             context)
                      //           //                                         .size
                      //           //                                         .width;
                      //           //                                 double height =
                      //           //                                     MediaQuery.of(
                      //           //                                             context)
                      //           //                                         .size
                      //           //                                         .height;
                      //           //                                 return AlertDialog(
                      //           //                                     backgroundColor:
                      //           //                                         Colors
                      //           //                                             .transparent,
                      //           //                                     contentPadding:
                      //           //                                         EdgeInsets
                      //           //                                             .zero,
                      //           //                                     elevation: 0.0,
                      //           //                                     // title: Center(child: Text("Evaluation our APP")),
                      //           //                                     content: Column(
                      //           //                                       mainAxisAlignment:
                      //           //                                           MainAxisAlignment
                      //           //                                               .center,
                      //           //                                       children: [
                      //           //                                         Stack(
                      //           //                                           children: [
                      //           //                                             Container(
                      //           //                                               // height: 150,
                      //           //                                               // height: double.maxFinite,
                      //           //                                               height:
                      //           //                                                   MediaQuery.of(context).size.height / 4,
                      //           //                                               width:
                      //           //                                                   double.maxFinite,
                      //           //                                               decoration:
                      //           //                                                   BoxDecoration(
                      //           //                                                       // color: Colors.black.withOpacity(0.65),
                      //           //                                                       gradient:
                      //           //                                                           LinearGradient(
                      //           //                                                         begin: Alignment.centerLeft,
                      //           //                                                         end: Alignment.centerRight,
                      //           //                                                         // stops: [0.1, 0.5, 0.7, 0.9],
                      //           //                                                         colors: [
                      //           //                                                           HexColor("#020204").withOpacity(1),
                      //           //                                                           HexColor("#36393E").withOpacity(1),
                      //           //                                                         ],
                      //           //                                                       ),
                      //           //                                                       boxShadow: [
                      //           //                                                         BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //           //                                                       ],
                      //           //                                                       borderRadius: BorderRadius.circular(20)),
                      //           //                                               margin: EdgeInsets.symmetric(
                      //           //                                                   horizontal: 10,
                      //           //                                                   vertical: 10),
                      //           //                                               // height: 122,
                      //           //                                               // width: 133,
                      //           //                                               // padding: const EdgeInsets.all(8.0),
                      //           //                                               child:
                      //           //                                                   Column(
                      //           //                                                 mainAxisAlignment:
                      //           //                                                     MainAxisAlignment.center,
                      //           //                                                 children: [
                      //           //                                                   Container(
                      //           //                                                     // color: Colors.white,
                      //           //                                                     alignment: Alignment.center,
                      //           //                                                     child: ListView.builder(
                      //           //                                                       padding: EdgeInsets.only(bottom: 0),
                      //           //
                      //           //                                                       // physics: NeverScrollableScrollPhysics(),
                      //           //                                                       itemCount: list_alarm.length,
                      //           //                                                       shrinkWrap: true,
                      //           //                                                       itemBuilder: (BuildContext context, int index) {
                      //           //                                                         return GestureDetector(
                      //           //                                                           onTap: () {
                      //           //                                                             setState(() {
                      //           //                                                               Selected_sound = list_alarm[index];
                      //           //                                                               print("method_selected $Selected_sound");
                      //           //                                                             });
                      //           //                                                             Navigator.pop(context);
                      //           //                                                           },
                      //           //                                                           child: Container(
                      //           //                                                             margin: EdgeInsets.symmetric(vertical: 8.5),
                      //           //                                                             alignment: Alignment.center,
                      //           //                                                             child: Text(
                      //           //                                                               list_alarm[index],
                      //           //                                                               style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                      //           //                                                             ),
                      //           //                                                           ),
                      //           //                                                         );
                      //           //                                                       },
                      //           //                                                     ),
                      //           //                                                   ),
                      //           //                                                 ],
                      //           //                                               ),
                      //           //                                             ),
                      //           //                                             GestureDetector(
                      //           //                                               onTap:
                      //           //                                                   () {
                      //           //                                                 Navigator.pop(context);
                      //           //                                               },
                      //           //                                               child:
                      //           //                                                   Container(
                      //           //                                                 margin:
                      //           //                                                     EdgeInsets.only(right: 0),
                      //           //                                                 alignment:
                      //           //                                                     Alignment.topRight,
                      //           //                                                 child: Container(
                      //           //                                                     decoration: BoxDecoration(
                      //           //                                                         // color: Colors.black.withOpacity(0.65),
                      //           //                                                         gradient: LinearGradient(
                      //           //                                                           begin: Alignment.centerLeft,
                      //           //                                                           end: Alignment.centerRight,
                      //           //                                                           // stops: [0.1, 0.5, 0.7, 0.9],
                      //           //                                                           colors: [
                      //           //                                                             HexColor("#36393E").withOpacity(1),
                      //           //                                                             HexColor("#020204").withOpacity(1),
                      //           //                                                           ],
                      //           //                                                         ),
                      //           //                                                         boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //           //                                                         borderRadius: BorderRadius.circular(20)),
                      //           //                                                     child: Padding(
                      //           //                                                       padding: const EdgeInsets.all(4.0),
                      //           //                                                       child: Icon(
                      //           //                                                         Icons.cancel_outlined,
                      //           //                                                         size: 20,
                      //           //                                                         color: ColorUtils.primary_grey,
                      //           //                                                       ),
                      //           //                                                     )),
                      //           //                                               ),
                      //           //                                             )
                      //           //                                           ],
                      //           //                                         ),
                      //           //                                       ],
                      //           //                                     ));
                      //           //                               },
                      //           //                             );
                      //           //                           },
                      //           //                           child: ListTile(
                      //           //                             title: Text('Sound',
                      //           //                                 style: FontStyleUtility.h14(
                      //           //                                     fontColor:
                      //           //                                         ColorUtils
                      //           //                                             .primary_gold,
                      //           //                                     family: 'PR')),
                      //           //                             trailing: const Icon(
                      //           //                                 Icons
                      //           //                                     .arrow_forward_ios,
                      //           //                                 size: 15,
                      //           //                                 color:
                      //           //                                     Colors.white),
                      //           //                           ),
                      //           //                         ),
                      //           //                         GestureDetector(
                      //           //                           onTap: () async {
                      //           //                             if (Alarm_title
                      //           //                                 .text.isEmpty) {
                      //           //                               CommonWidget()
                      //           //                                   .showErrorToaster(
                      //           //                                       msg:
                      //           //                                           "Enter Alarm title");
                      //           //                               return;
                      //           //                             } else {
                      //           //                               await onSaveAlarm();
                      //           //                             }
                      //           //                           },
                      //           //                           child: Container(
                      //           //                             width: MediaQuery.of(
                      //           //                                         context)
                      //           //                                     .size
                      //           //                                     .width /
                      //           //                                 3,
                      //           //                             decoration: BoxDecoration(
                      //           //                                 borderRadius:
                      //           //                                     BorderRadius
                      //           //                                         .circular(
                      //           //                                             30),
                      //           //                                 border: Border.all(
                      //           //                                     color: ColorUtils
                      //           //                                         .primary_grey,
                      //           //                                     width: 1)),
                      //           //                             child: Padding(
                      //           //                               padding:
                      //           //                                   const EdgeInsets
                      //           //                                           .symmetric(
                      //           //                                       vertical:
                      //           //                                           12.0,
                      //           //                                       horizontal:
                      //           //                                           8),
                      //           //                               child: Row(
                      //           //                                 mainAxisAlignment:
                      //           //                                     MainAxisAlignment
                      //           //                                         .center,
                      //           //                                 children: [
                      //           //                                   const Icon(
                      //           //                                     Icons.alarm,
                      //           //                                     color: Colors
                      //           //                                         .white,
                      //           //                                     size: 25,
                      //           //                                   ),
                      //           //                                   const SizedBox(
                      //           //                                     width: 10,
                      //           //                                   ),
                      //           //                                   Text(
                      //           //                                     'Save',
                      //           //                                     style: FontStyleUtility.h16(
                      //           //                                         fontColor:
                      //           //                                             ColorUtils
                      //           //                                                 .primary_gold,
                      //           //                                         family:
                      //           //                                             'PR'),
                      //           //                                   ),
                      //           //                                 ],
                      //           //                               ),
                      //           //                             ),
                      //           //                           ),
                      //           //                         )
                      //           //                       ],
                      //           //                     ),
                      //           //                   ),
                      //           //                 );
                      //           //               },
                      //           //             );
                      //           //           },
                      //           //         );
                      //           //         // scheduleAlarm();
                      //           //       },
                      //           //       child: Container(
                      //           //         decoration: BoxDecoration(
                      //           //             // color: Colors.black.withOpacity(0.65),
                      //           //             gradient: LinearGradient(
                      //           //               begin: Alignment.centerLeft,
                      //           //               end: Alignment.centerRight,
                      //           //               // stops: [0.1, 0.5, 0.7, 0.9],
                      //           //               colors: [
                      //           //                 HexColor("#36393E").withOpacity(1),
                      //           //                 HexColor("#020204").withOpacity(1),
                      //           //               ],
                      //           //             ),
                      //           //             boxShadow: [
                      //           //               BoxShadow(
                      //           //                   color: HexColor('#04060F'),
                      //           //                   offset: const Offset(10, 10),
                      //           //                   blurRadius: 20)
                      //           //             ],
                      //           //             borderRadius:
                      //           //                 BorderRadius.circular(20)),
                      //           //         child: Padding(
                      //           //           padding: const EdgeInsets.all(0.0),
                      //           //           child: Icon(
                      //           //             Icons.add_circle_outline,
                      //           //             color: ColorUtils.primary_grey,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           // ),
                      //         ),
                      //       ),
                      //       // Container(
                      //       //   padding: const EdgeInsets.symmetric(
                      //       //       horizontal: 16, vertical: 0),
                      //       //   child: Row(
                      //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       //     children: [
                      //       //       Container(
                      //       //         margin: EdgeInsets.only(left: 16),
                      //       //         child: Text(
                      //       //           "Add Alarm",
                      //       //           style: FontStyleUtility.h16(
                      //       //               fontColor: ColorUtils.primary_gold,
                      //       //               family: 'PM'),
                      //       //         ),
                      //       //       ),
                      //       //       FlatButton(
                      //       //           padding: const EdgeInsets.symmetric(
                      //       //               horizontal: 32, vertical: 10),
                      //       //           onPressed: () {
                      //       //             _alarmTimeString = DateFormat('HH:mm')
                      //       //                 .format(selectedDate);
                      //       //             showModalBottomSheet(
                      //       //               useRootNavigator: true,
                      //       //               context: context,
                      //       //               clipBehavior: Clip.antiAlias,
                      //       //               shape: const RoundedRectangleBorder(
                      //       //                 borderRadius: BorderRadius.vertical(
                      //       //                   top: Radius.circular(24),
                      //       //                 ),
                      //       //               ),
                      //       //               builder: (context) {
                      //       //                 return StatefulBuilder(
                      //       //                   builder: (context, setModalState) {
                      //       //                     return Container(
                      //       //                       decoration: BoxDecoration(
                      //       //                           // color: Colors.black.withOpacity(0.65),
                      //       //                           gradient: LinearGradient(
                      //       //                             begin:
                      //       //                                 Alignment.centerLeft,
                      //       //                             end:
                      //       //                                 Alignment.centerRight,
                      //       //                             // stops: [0.1, 0.5, 0.7, 0.9],
                      //       //                             colors: [
                      //       //                               HexColor("#020204")
                      //       //                                   .withOpacity(1),
                      //       //                               HexColor("#36393E")
                      //       //                                   .withOpacity(1),
                      //       //                             ],
                      //       //                           ),
                      //       //                           boxShadow: [
                      //       //                             BoxShadow(
                      //       //                                 color: HexColor(
                      //       //                                     '#04060F'),
                      //       //                                 offset: const Offset(
                      //       //                                     -10, 10),
                      //       //                                 blurRadius: 20)
                      //       //                           ],
                      //       //                           borderRadius:
                      //       //                               const BorderRadius.only(
                      //       //                                   topLeft:
                      //       //                                       Radius.circular(
                      //       //                                           20),
                      //       //                                   topRight:
                      //       //                                       Radius.circular(
                      //       //                                           20))),
                      //       //                       padding:
                      //       //                           const EdgeInsets.all(32),
                      //       //                       child: SingleChildScrollView(
                      //       //                         child: Column(
                      //       //                           children: [
                      //       //                             // FlatButton(
                      //       //                             //   onPressed:
                      //       //                             //       () async {
                      //       //                             //     // var selectedTime = await showTimePicker(
                      //       //                             //     //   context: context,
                      //       //                             //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                      //       //                             //     //   initialEntryMode: TimePickerEntryMode.dial,
                      //       //                             //     //   initialTime: TimeOfDay.now(),
                      //       //                             //     //   builder: (context, child) {
                      //       //                             //     //     return Theme(
                      //       //                             //     //       data: Theme.of(
                      //       //                             //     //               context)
                      //       //                             //     //           .copyWith(
                      //       //                             //     //         colorScheme:
                      //       //                             //     //             ColorScheme
                      //       //                             //     //                 .dark(
                      //       //                             //     //           primary:
                      //       //                             //     //               Colors.black,
                      //       //                             //     //           onPrimary:
                      //       //                             //     //               Colors.white,
                      //       //                             //     //           surface:
                      //       //                             //     //               ColorUtils.primary_gold,
                      //       //                             //     //           // onPrimary: Colors.black, // <-- SEE HERE
                      //       //                             //     //           onSurface:
                      //       //                             //     //               Colors.black,
                      //       //                             //     //         ),
                      //       //                             //     //         dialogBackgroundColor:
                      //       //                             //     //             ColorUtils
                      //       //                             //     //                 .primary_gold,
                      //       //                             //     //         textButtonTheme:
                      //       //                             //     //             TextButtonThemeData(
                      //       //                             //     //           style: TextButton
                      //       //                             //     //               .styleFrom(
                      //       //                             //     //             primary:
                      //       //                             //     //                 Colors.black, // button text color
                      //       //                             //     //           ),
                      //       //                             //     //         ),
                      //       //                             //     //       ),
                      //       //                             //     //       child:
                      //       //                             //     //           child!,
                      //       //                             //     //     );
                      //       //                             //     //   },
                      //       //                             //     // );
                      //       //                             //     // if (selectedTime !=
                      //       //                             //     //     null) {
                      //       //                             //     //   final now =
                      //       //                             //     //       DateTime
                      //       //                             //     //           .now();
                      //       //                             //     //   var selectedDateTime = DateTime(
                      //       //                             //     //       now.year,
                      //       //                             //     //       now.month,
                      //       //                             //     //       now.day,
                      //       //                             //     //       selectedTime
                      //       //                             //     //           .hour,
                      //       //                             //     //       selectedTime
                      //       //                             //     //           .minute);
                      //       //                             //     //   _alarmTime =
                      //       //                             //     //       selectedDateTime;
                      //       //                             //     //   setModalState(
                      //       //                             //     //       () {
                      //       //                             //     //     _alarmTimeString =
                      //       //                             //     //         DateFormat(
                      //       //                             //     //                 'HH:mm')
                      //       //                             //     //             .format(
                      //       //                             //     //                 selectedDateTime);
                      //       //                             //     //   });
                      //       //                             //     // }
                      //       //                             //   },
                      //       //                             //   child: Text(
                      //       //                             //       _alarmTimeString!,
                      //       //                             //       style: FontStyleUtility.h35(
                      //       //                             //           fontColor:
                      //       //                             //               ColorUtils
                      //       //                             //                   .primary_gold,
                      //       //                             //           family:
                      //       //                             //               'PM')),
                      //       //                             // ),
                      //       //                             Container(
                      //       //                               height: 150,
                      //       //                               decoration:
                      //       //                                   BoxDecoration(
                      //       //                                       borderRadius:
                      //       //                                           BorderRadius
                      //       //                                               .circular(
                      //       //                                                   15),
                      //       //                                       gradient: LinearGradient(
                      //       //                                         begin: Alignment
                      //       //                                             .topCenter,
                      //       //                                         end: Alignment
                      //       //                                             .bottomCenter,
                      //       //                                         colors: [
                      //       //                                           HexColor(
                      //       //                                                   "#000000")
                      //       //                                               .withOpacity(
                      //       //                                                   1),
                      //       //                                           HexColor(
                      //       //                                                   "#04060F")
                      //       //                                               .withOpacity(
                      //       //                                                   1),
                      //       //                                           HexColor(
                      //       //                                                   "#000000")
                      //       //                                               .withOpacity(
                      //       //                                                   1),
                      //       //                                         ],
                      //       //                                       ),
                      //       //                                       boxShadow: [
                      //       //                                     BoxShadow(
                      //       //                                         color: HexColor(
                      //       //                                             '#04060F'),
                      //       //                                         offset:
                      //       //                                             Offset(
                      //       //                                                 3, 3),
                      //       //                                         blurRadius:
                      //       //                                             10)
                      //       //                                   ]),
                      //       //                               child: Stack(
                      //       //                                 children: [
                      //       //                                   CupertinoTheme(
                      //       //                                     data:
                      //       //                                         CupertinoThemeData(
                      //       //                                       brightness:
                      //       //                                           Brightness
                      //       //                                               .dark,
                      //       //                                     ),
                      //       //                                     child:
                      //       //                                         CupertinoDatePicker(
                      //       //                                       // use24hFormat: true,
                      //       //                                       mode:
                      //       //                                           CupertinoDatePickerMode
                      //       //                                               .time,
                      //       //                                       onDateTimeChanged:
                      //       //                                           (DateTime
                      //       //                                               value) {
                      //       //                                         selected_time =
                      //       //                                             value;
                      //       //                                         print(
                      //       //                                             "${value.hour}:${value.minute}");
                      //       //
                      //       //                                         if (selected_time !=
                      //       //                                             null) {
                      //       //                                           final now =
                      //       //                                               DateTime
                      //       //                                                   .now();
                      //       //                                           var selectedDateTime = DateTime(
                      //       //                                               now
                      //       //                                                   .year,
                      //       //                                               now
                      //       //                                                   .month,
                      //       //                                               now.day,
                      //       //                                               selected_time
                      //       //                                                   .hour,
                      //       //                                               selected_time
                      //       //                                                   .minute);
                      //       //                                           _alarmTime =
                      //       //                                               selectedDateTime;
                      //       //                                           setModalState(
                      //       //                                               () {
                      //       //                                             _alarmTimeString = DateFormat(
                      //       //                                                     'HH:mm')
                      //       //                                                 .format(
                      //       //                                                     selectedDateTime);
                      //       //                                           });
                      //       //                                         }
                      //       //                                       },
                      //       //                                     ),
                      //       //                                   ),
                      //       //                                 ],
                      //       //                               ),
                      //       //                             ),
                      //       //
                      //       //                             ListTile(
                      //       //                               onTap: () {
                      //       //                                 showDialog(
                      //       //                                   context: context,
                      //       //                                   builder:
                      //       //                                       (BuildContext
                      //       //                                           context) {
                      //       //                                     double width =
                      //       //                                         MediaQuery.of(
                      //       //                                                 context)
                      //       //                                             .size
                      //       //                                             .width;
                      //       //                                     double height =
                      //       //                                         MediaQuery.of(
                      //       //                                                 context)
                      //       //                                             .size
                      //       //                                             .height;
                      //       //                                     return BackdropFilter(
                      //       //                                       filter: ImageFilter
                      //       //                                           .blur(
                      //       //                                               sigmaX:
                      //       //                                                   10,
                      //       //                                               sigmaY:
                      //       //                                                   10),
                      //       //                                       child:
                      //       //                                           AlertDialog(
                      //       //                                               backgroundColor:
                      //       //                                                   Colors
                      //       //                                                       .transparent,
                      //       //                                               contentPadding:
                      //       //                                                   EdgeInsets
                      //       //                                                       .zero,
                      //       //                                               elevation:
                      //       //                                                   0.0,
                      //       //                                               // title: Center(child: Text("Evaluation our APP")),
                      //       //                                               content:
                      //       //                                                   Column(
                      //       //                                                 mainAxisAlignment:
                      //       //                                                     MainAxisAlignment.center,
                      //       //                                                 children: [
                      //       //                                                   Stack(
                      //       //                                                     children: [
                      //       //                                                       Padding(
                      //       //                                                         padding: const EdgeInsets.all(8.0),
                      //       //                                                         child: Container(
                      //       //                                                           decoration:
                      //       //                                                               BoxDecoration(
                      //       //                                                                   // color: Colors.black.withOpacity(0.65),
                      //       //                                                                   gradient:
                      //       //                                                                       LinearGradient(
                      //       //                                                                     begin: Alignment.centerLeft,
                      //       //                                                                     end: Alignment.centerRight,
                      //       //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                      //       //                                                                     colors: [
                      //       //                                                                       HexColor("#020204").withOpacity(1),
                      //       //                                                                       HexColor("#36393E").withOpacity(1),
                      //       //                                                                     ],
                      //       //                                                                   ),
                      //       //                                                                   boxShadow: [
                      //       //                                                                     BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //       //                                                                   ],
                      //       //                                                                   borderRadius: BorderRadius.circular(15)),
                      //       //                                                           child: Align(
                      //       //                                                               alignment: Alignment.center,
                      //       //                                                               child: Padding(
                      //       //                                                                 padding: const EdgeInsets.all(8.0),
                      //       //                                                                 child: Column(
                      //       //                                                                   children: [
                      //       //                                                                     SizedBox(
                      //       //                                                                       height: 0,
                      //       //                                                                     ),
                      //       //
                      //       //                                                                     Column(
                      //       //                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                      //       //                                                                       children: [
                      //       //                                                                         Container(
                      //       //                                                                           margin: EdgeInsets.only(left: 18),
                      //       //                                                                           child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                      //       //                                                                         ),
                      //       //                                                                         SizedBox(
                      //       //                                                                           height: 11,
                      //       //                                                                         ),
                      //       //                                                                         Container(
                      //       //                                                                           margin: EdgeInsets.symmetric(horizontal: 10),
                      //       //                                                                           // width: 300,
                      //       //                                                                           decoration: BoxDecoration(
                      //       //                                                                               // color: Colors.black.withOpacity(0.65),
                      //       //                                                                               gradient: LinearGradient(
                      //       //                                                                                 begin: Alignment.centerLeft,
                      //       //                                                                                 end: Alignment.centerRight,
                      //       //                                                                                 // stops: [0.1, 0.5, 0.7, 0.9],
                      //       //                                                                                 colors: [
                      //       //                                                                                   HexColor("#36393E").withOpacity(1),
                      //       //                                                                                   HexColor("#020204").withOpacity(1),
                      //       //                                                                                 ],
                      //       //                                                                               ),
                      //       //                                                                               boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                      //       //                                                                               borderRadius: BorderRadius.circular(20)),
                      //       //
                      //       //                                                                           child: TextFormField(
                      //       //                                                                             maxLength: 150,
                      //       //                                                                             decoration: InputDecoration(
                      //       //                                                                               contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                      //       //                                                                               alignLabelWithHint: false,
                      //       //                                                                               isDense: true,
                      //       //                                                                               hintText: 'Add alarm title',
                      //       //                                                                               counterStyle: TextStyle(
                      //       //                                                                                 height: double.minPositive,
                      //       //                                                                               ),
                      //       //                                                                               counterText: "",
                      //       //                                                                               filled: true,
                      //       //                                                                               border: InputBorder.none,
                      //       //                                                                               enabledBorder: const OutlineInputBorder(
                      //       //                                                                                 borderSide: BorderSide(color: Colors.transparent, width: 1),
                      //       //                                                                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                      //       //                                                                               ),
                      //       //                                                                               hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                      //       //                                                                             ),
                      //       //                                                                             style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //       //                                                                             controller: Alarm_title,
                      //       //                                                                             keyboardType: TextInputType.text,
                      //       //                                                                           ),
                      //       //                                                                         ),
                      //       //                                                                       ],
                      //       //                                                                     ),
                      //       //                                                                     SizedBox(
                      //       //                                                                       height: 10,
                      //       //                                                                     ),
                      //       //                                                                     GestureDetector(
                      //       //                                                                       onTap: () {
                      //       //                                                                         setState(() {
                      //       //                                                                           Alarm_title_list.add(Alarm_title.text);
                      //       //                                                                           Navigator.pop(context);
                      //       //                                                                         });
                      //       //                                                                       },
                      //       //                                                                       child: Container(
                      //       //                                                                         alignment: Alignment.topRight,
                      //       //                                                                         child: Text(
                      //       //                                                                           'Add',
                      //       //                                                                           style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //       //                                                                         ),
                      //       //                                                                       ),
                      //       //                                                                     )
                      //       //                                                                     // common_button_gold(
                      //       //                                                                     //   onTap: () {
                      //       //                                                                     //     Get
                      //       //                                                                     //         .to(
                      //       //                                                                     //         DashboardScreen());
                      //       //                                                                     //   },
                      //       //                                                                     //   title_text: 'Go to Dashboard',
                      //       //                                                                     // ),
                      //       //                                                                   ],
                      //       //                                                                 ),
                      //       //                                                               )),
                      //       //                                                         ),
                      //       //                                                       ),
                      //       //                                                       GestureDetector(
                      //       //                                                         onTap: () {
                      //       //                                                           Navigator.pop(context);
                      //       //                                                         },
                      //       //                                                         child: Container(
                      //       //                                                           margin: EdgeInsets.only(right: 10),
                      //       //                                                           alignment: Alignment.topRight,
                      //       //                                                           child: Container(
                      //       //                                                               decoration: BoxDecoration(
                      //       //                                                                   // color: Colors.black.withOpacity(0.65),
                      //       //                                                                   gradient: LinearGradient(
                      //       //                                                                     begin: Alignment.centerLeft,
                      //       //                                                                     end: Alignment.centerRight,
                      //       //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                      //       //                                                                     colors: [
                      //       //                                                                       HexColor("#36393E").withOpacity(1),
                      //       //                                                                       HexColor("#020204").withOpacity(1),
                      //       //                                                                     ],
                      //       //                                                                   ),
                      //       //                                                                   boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //       //                                                                   borderRadius: BorderRadius.circular(20)),
                      //       //                                                               child: Padding(
                      //       //                                                                 padding: const EdgeInsets.all(4.0),
                      //       //                                                                 child: Icon(
                      //       //                                                                   Icons.cancel_outlined,
                      //       //                                                                   size: 13,
                      //       //                                                                   color: ColorUtils.primary_grey,
                      //       //                                                                 ),
                      //       //                                                               )),
                      //       //                                                         ),
                      //       //                                                       )
                      //       //                                                     ],
                      //       //                                                   ),
                      //       //                                                 ],
                      //       //                                               )),
                      //       //                                     );
                      //       //                                   },
                      //       //                                 );
                      //       //                               },
                      //       //                               title: Text('Title',
                      //       //                                   style: FontStyleUtility.h14(
                      //       //                                       fontColor:
                      //       //                                           ColorUtils
                      //       //                                               .primary_grey,
                      //       //                                       family: 'PR')),
                      //       //                               trailing: const Icon(
                      //       //                                   Icons
                      //       //                                       .arrow_forward_ios,
                      //       //                                   size: 15,
                      //       //                                   color:
                      //       //                                       Colors.white),
                      //       //                             ),
                      //       //                             ListTile(
                      //       //                               title: Text(
                      //       //                                 'Repeat',
                      //       //                                 style: FontStyleUtility.h14(
                      //       //                                     fontColor: ColorUtils
                      //       //                                         .primary_gold,
                      //       //                                     family: 'PR'),
                      //       //                               ),
                      //       //                               trailing: const Icon(
                      //       //                                 Icons
                      //       //                                     .arrow_forward_ios,
                      //       //                                 size: 15,
                      //       //                                 color: Colors.white,
                      //       //                               ),
                      //       //                             ),
                      //       //                             GestureDetector(
                      //       //                               onTap: () {
                      //       //                                 print('object');
                      //       //
                      //       //                                 showDialog(
                      //       //                                   context: context,
                      //       //                                   builder:
                      //       //                                       (BuildContext
                      //       //                                           context) {
                      //       //                                     double width =
                      //       //                                         MediaQuery.of(
                      //       //                                                 context)
                      //       //                                             .size
                      //       //                                             .width;
                      //       //                                     double height =
                      //       //                                         MediaQuery.of(
                      //       //                                                 context)
                      //       //                                             .size
                      //       //                                             .height;
                      //       //                                     return AlertDialog(
                      //       //                                         backgroundColor:
                      //       //                                             Colors
                      //       //                                                 .transparent,
                      //       //                                         contentPadding:
                      //       //                                             EdgeInsets
                      //       //                                                 .zero,
                      //       //                                         elevation:
                      //       //                                             0.0,
                      //       //                                         // title: Center(child: Text("Evaluation our APP")),
                      //       //                                         content:
                      //       //                                             Column(
                      //       //                                           mainAxisAlignment:
                      //       //                                               MainAxisAlignment
                      //       //                                                   .center,
                      //       //                                           children: [
                      //       //                                             Stack(
                      //       //                                               children: [
                      //       //                                                 Container(
                      //       //                                                   // height: 150,
                      //       //                                                   // height: double.maxFinite,
                      //       //                                                   height:
                      //       //                                                       MediaQuery.of(context).size.height / 4,
                      //       //                                                   width:
                      //       //                                                       double.maxFinite,
                      //       //                                                   decoration:
                      //       //                                                       BoxDecoration(
                      //       //                                                           // color: Colors.black.withOpacity(0.65),
                      //       //                                                           gradient:
                      //       //                                                               LinearGradient(
                      //       //                                                             begin: Alignment.centerLeft,
                      //       //                                                             end: Alignment.centerRight,
                      //       //                                                             // stops: [0.1, 0.5, 0.7, 0.9],
                      //       //                                                             colors: [
                      //       //                                                               HexColor("#020204").withOpacity(1),
                      //       //                                                               HexColor("#36393E").withOpacity(1),
                      //       //                                                             ],
                      //       //                                                           ),
                      //       //                                                           boxShadow: [
                      //       //                                                             BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //       //                                                           ],
                      //       //                                                           borderRadius: BorderRadius.circular(20)),
                      //       //                                                   margin:
                      //       //                                                       EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //       //                                                   // height: 122,
                      //       //                                                   // width: 133,
                      //       //                                                   // padding: const EdgeInsets.all(8.0),
                      //       //                                                   child:
                      //       //                                                       Column(
                      //       //                                                     mainAxisAlignment: MainAxisAlignment.center,
                      //       //                                                     children: [
                      //       //                                                       Container(
                      //       //                                                         // color: Colors.white,
                      //       //                                                         alignment: Alignment.center,
                      //       //                                                         child: ListView.builder(
                      //       //                                                           padding: EdgeInsets.only(bottom: 0),
                      //       //
                      //       //                                                           // physics: NeverScrollableScrollPhysics(),
                      //       //                                                           itemCount: list_alarm.length,
                      //       //                                                           shrinkWrap: true,
                      //       //                                                           itemBuilder: (BuildContext context, int index) {
                      //       //                                                             return GestureDetector(
                      //       //                                                               onTap: () {
                      //       //                                                                 setState(() {
                      //       //                                                                   Selected_sound = list_alarm[index];
                      //       //                                                                   print("method_selected $Selected_sound");
                      //       //                                                                 });
                      //       //                                                                 Navigator.pop(context);
                      //       //                                                               },
                      //       //                                                               child: Container(
                      //       //                                                                 margin: EdgeInsets.symmetric(vertical: 8.5),
                      //       //                                                                 alignment: Alignment.center,
                      //       //                                                                 child: Text(
                      //       //                                                                   list_alarm[index],
                      //       //                                                                   style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                      //       //                                                                 ),
                      //       //                                                               ),
                      //       //                                                             );
                      //       //                                                           },
                      //       //                                                         ),
                      //       //                                                       ),
                      //       //                                                     ],
                      //       //                                                   ),
                      //       //                                                 ),
                      //       //                                                 GestureDetector(
                      //       //                                                   onTap:
                      //       //                                                       () {
                      //       //                                                     Navigator.pop(context);
                      //       //                                                   },
                      //       //                                                   child:
                      //       //                                                       Container(
                      //       //                                                     margin: EdgeInsets.only(right: 0),
                      //       //                                                     alignment: Alignment.topRight,
                      //       //                                                     child: Container(
                      //       //                                                         decoration: BoxDecoration(
                      //       //                                                             // color: Colors.black.withOpacity(0.65),
                      //       //                                                             gradient: LinearGradient(
                      //       //                                                               begin: Alignment.centerLeft,
                      //       //                                                               end: Alignment.centerRight,
                      //       //                                                               // stops: [0.1, 0.5, 0.7, 0.9],
                      //       //                                                               colors: [
                      //       //                                                                 HexColor("#36393E").withOpacity(1),
                      //       //                                                                 HexColor("#020204").withOpacity(1),
                      //       //                                                               ],
                      //       //                                                             ),
                      //       //                                                             boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //       //                                                             borderRadius: BorderRadius.circular(20)),
                      //       //                                                         child: Padding(
                      //       //                                                           padding: const EdgeInsets.all(4.0),
                      //       //                                                           child: Icon(
                      //       //                                                             Icons.cancel_outlined,
                      //       //                                                             size: 20,
                      //       //                                                             color: ColorUtils.primary_grey,
                      //       //                                                           ),
                      //       //                                                         )),
                      //       //                                                   ),
                      //       //                                                 )
                      //       //                                               ],
                      //       //                                             ),
                      //       //                                           ],
                      //       //                                         ));
                      //       //                                   },
                      //       //                                 );
                      //       //                               },
                      //       //                               child: ListTile(
                      //       //                                 title: Text('Sound',
                      //       //                                     style: FontStyleUtility.h14(
                      //       //                                         fontColor:
                      //       //                                             ColorUtils
                      //       //                                                 .primary_gold,
                      //       //                                         family:
                      //       //                                             'PR')),
                      //       //                                 trailing: const Icon(
                      //       //                                     Icons
                      //       //                                         .arrow_forward_ios,
                      //       //                                     size: 15,
                      //       //                                     color:
                      //       //                                         Colors.white),
                      //       //                               ),
                      //       //                             ),
                      //       //                             GestureDetector(
                      //       //                               onTap: () async {
                      //       //                                 if (Alarm_title
                      //       //                                     .text.isEmpty) {
                      //       //                                   CommonWidget()
                      //       //                                       .showErrorToaster(
                      //       //                                           msg:
                      //       //                                               "Enter Alarm title");
                      //       //                                   return;
                      //       //                                 } else {
                      //       //                                   await onSaveAlarm();
                      //       //                                 }
                      //       //                               },
                      //       //                               child: Container(
                      //       //                                 width: MediaQuery.of(
                      //       //                                             context)
                      //       //                                         .size
                      //       //                                         .width /
                      //       //                                     3,
                      //       //                                 decoration: BoxDecoration(
                      //       //                                     borderRadius:
                      //       //                                         BorderRadius
                      //       //                                             .circular(
                      //       //                                                 30),
                      //       //                                     border: Border.all(
                      //       //                                         color: ColorUtils
                      //       //                                             .primary_grey,
                      //       //                                         width: 1)),
                      //       //                                 child: Padding(
                      //       //                                   padding:
                      //       //                                       const EdgeInsets
                      //       //                                               .symmetric(
                      //       //                                           vertical:
                      //       //                                               12.0,
                      //       //                                           horizontal:
                      //       //                                               8),
                      //       //                                   child: Row(
                      //       //                                     mainAxisAlignment:
                      //       //                                         MainAxisAlignment
                      //       //                                             .center,
                      //       //                                     children: [
                      //       //                                       const Icon(
                      //       //                                         Icons.alarm,
                      //       //                                         color: Colors
                      //       //                                             .white,
                      //       //                                         size: 25,
                      //       //                                       ),
                      //       //                                       const SizedBox(
                      //       //                                         width: 10,
                      //       //                                       ),
                      //       //                                       Text(
                      //       //                                         'Save',
                      //       //                                         style: FontStyleUtility.h16(
                      //       //                                             fontColor:
                      //       //                                                 ColorUtils
                      //       //                                                     .primary_gold,
                      //       //                                             family:
                      //       //                                                 'PR'),
                      //       //                                       ),
                      //       //                                     ],
                      //       //                                   ),
                      //       //                                 ),
                      //       //                               ),
                      //       //                             )
                      //       //                           ],
                      //       //                         ),
                      //       //                       ),
                      //       //                     );
                      //       //                   },
                      //       //                 );
                      //       //               },
                      //       //             );
                      //       //             // scheduleAlarm();
                      //       //           },
                      //       //           child: Container(
                      //       //             decoration: BoxDecoration(
                      //       //                 // color: Colors.black.withOpacity(0.65),
                      //       //                 gradient: LinearGradient(
                      //       //                   begin: Alignment.centerLeft,
                      //       //                   end: Alignment.centerRight,
                      //       //                   // stops: [0.1, 0.5, 0.7, 0.9],
                      //       //                   colors: [
                      //       //                     HexColor("#36393E")
                      //       //                         .withOpacity(1),
                      //       //                     HexColor("#020204")
                      //       //                         .withOpacity(1),
                      //       //                   ],
                      //       //                 ),
                      //       //                 boxShadow: [
                      //       //                   BoxShadow(
                      //       //                       color: HexColor('#04060F'),
                      //       //                       offset: const Offset(10, 10),
                      //       //                       blurRadius: 20)
                      //       //                 ],
                      //       //                 borderRadius:
                      //       //                     BorderRadius.circular(20)),
                      //       //             child: Padding(
                      //       //               padding: const EdgeInsets.all(8.0),
                      //       //               child: Icon(
                      //       //                 Icons.add_circle_outline,
                      //       //                 color: ColorUtils.primary_grey,
                      //       //               ),
                      //       //             ),
                      //       //           )),
                      //       //     ],
                      //       //   ),
                      //       // )
                      //       // else
                      //       //   const Center(
                      //       //       child: Text(
                      //       //     'Only 5 alarms allowed!',
                      //       //     style: const TextStyle(color: Colors.white),
                      //       //   )),
                      //       FutureBuilder<List<AlarmInfo>>(
                      //         future: _alarms,
                      //         builder: (context, snapshot) {
                      //           if (snapshot.hasData) {
                      //             _currentAlarms = snapshot.data;
                      //             return Container(
                      //               child: ListView(
                      //                 shrinkWrap: true,
                      //                 padding: EdgeInsets.zero,
                      //                 children: snapshot.data!.map<Widget>((alarm) {
                      //                   var alarmTime = DateFormat('hh:mm aa')
                      //                       .format(alarm.alarmDateTime!);
                      //                   var gradientColor = GradientTemplate
                      //                       .gradientTemplate[
                      //                           alarm.gradientColorIndex!]
                      //                       .colors;
                      //                   return Container(
                      //                     margin: const EdgeInsets.only(bottom: 0),
                      //                     padding: const EdgeInsets.symmetric(
                      //                         horizontal: 16, vertical: 0),
                      //                     child: Container(
                      //                       decoration: BoxDecoration(
                      //                         // color: Colors.black.withOpacity(0.65),
                      //                         // gradient: LinearGradient(
                      //                         //   begin: Alignment.centerLeft,
                      //                         //   end: Alignment.centerRight,
                      //                         //   // stops: [0.1, 0.5, 0.7, 0.9],
                      //                         //   colors: [
                      //                         //     HexColor("#020204").withOpacity(1),
                      //                         //     HexColor("#36393E").withOpacity(1),
                      //                         //   ],
                      //                         // ),
                      //                         // boxShadow: [
                      //                         //   BoxShadow(
                      //                         //       color: HexColor('#04060F'),
                      //                         //       offset: Offset(-10, 10),
                      //                         //       blurRadius: 20)
                      //                         // ],
                      //                         border: Border(
                      //                           bottom: BorderSide(
                      //                             //                   <--- left side
                      //                             color: HexColor('#1d1d1d'),
                      //                             width: 1.5,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.symmetric(
                      //                             vertical: 8.0),
                      //                         child: Column(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           children: <Widget>[
                      //                             ListTile(
                      //                               title: Text(
                      //                                 alarmTime,
                      //                                 style: FontStyleUtility.h16(
                      //                                     fontColor: Colors.white,
                      //                                     family: 'PR'),
                      //                               ),
                      //                               subtitle: Text(alarm.title!,
                      //                                   style: FontStyleUtility.h14(
                      //                                       fontColor:
                      //                                           HexColor('#8A8A8A'),
                      //                                       family: 'PR')),
                      //                               trailing: IconButton(
                      //                                   icon: const Icon(
                      //                                       Icons.delete),
                      //                                   color:
                      //                                       ColorUtils.primary_gold,
                      //                                   onPressed: () {
                      //                                     deleteAlarm(alarm.id!);
                      //                                   }),
                      //                               // Container(
                      //                               //   width: 20,
                      //                               //   child: Transform.scale(
                      //                               //     scale: 0.5,
                      //                               //     child: CupertinoSwitch(
                      //                               //       onChanged: (bool value) {},
                      //                               //       value: true,
                      //                               //       trackColor: HexColor('#717171'),
                      //                               //       thumbColor: Colors.black87,
                      //                               //       activeColor:
                      //                               //           ColorUtils.primary_gold,
                      //                               //     ),
                      //                               //   ),
                      //                               // ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 }).followedBy([
                      //                   // if (_currentAlarms!.length < 5)
                      //                   //   Container(
                      //                   //     child: FlatButton(
                      //                   //         padding: const EdgeInsets.symmetric(
                      //                   //             horizontal: 32, vertical: 10),
                      //                   //         onPressed: () {
                      //                   //           _alarmTimeString = DateFormat('HH:mm')
                      //                   //               .format(selectedDate);
                      //                   //           showModalBottomSheet(
                      //                   //             useRootNavigator: true,
                      //                   //             context: context,
                      //                   //             clipBehavior: Clip.antiAlias,
                      //                   //             shape: const RoundedRectangleBorder(
                      //                   //               borderRadius:
                      //                   //               BorderRadius.vertical(
                      //                   //                 top: Radius.circular(24),
                      //                   //               ),
                      //                   //             ),
                      //                   //             builder: (context) {
                      //                   //               return StatefulBuilder(
                      //                   //                 builder:
                      //                   //                     (context, setModalState) {
                      //                   //                   return Container(
                      //                   //                     decoration: BoxDecoration(
                      //                   //                       // color: Colors.black.withOpacity(0.65),
                      //                   //                         gradient:
                      //                   //                         LinearGradient(
                      //                   //                           begin: Alignment
                      //                   //                               .centerLeft,
                      //                   //                           end: Alignment
                      //                   //                               .centerRight,
                      //                   //                           // stops: [0.1, 0.5, 0.7, 0.9],
                      //                   //                           colors: [
                      //                   //                             HexColor("#020204")
                      //                   //                                 .withOpacity(1),
                      //                   //                             HexColor("#36393E")
                      //                   //                                 .withOpacity(1),
                      //                   //                           ],
                      //                   //                         ),
                      //                   //                         boxShadow: [
                      //                   //                           BoxShadow(
                      //                   //                               color: HexColor(
                      //                   //                                   '#04060F'),
                      //                   //                               offset:
                      //                   //                               const Offset(
                      //                   //                                   -10, 10),
                      //                   //                               blurRadius: 20)
                      //                   //                         ],
                      //                   //                         borderRadius:
                      //                   //                         const BorderRadius
                      //                   //                             .only(
                      //                   //                             topLeft: Radius
                      //                   //                                 .circular(
                      //                   //                                 20),
                      //                   //                             topRight: Radius
                      //                   //                                 .circular(
                      //                   //                                 20))),
                      //                   //                     padding:
                      //                   //                     const EdgeInsets.all(
                      //                   //                         32),
                      //                   //                     child:
                      //                   //                     SingleChildScrollView(
                      //                   //                       child: Column(
                      //                   //                         children: [
                      //                   //                           // FlatButton(
                      //                   //                           //   onPressed:
                      //                   //                           //       () async {
                      //                   //                           //     // var selectedTime = await showTimePicker(
                      //                   //                           //     //   context: context,
                      //                   //                           //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                      //                   //                           //     //   initialEntryMode: TimePickerEntryMode.dial,
                      //                   //                           //     //   initialTime: TimeOfDay.now(),
                      //                   //                           //     //   builder: (context, child) {
                      //                   //                           //     //     return Theme(
                      //                   //                           //     //       data: Theme.of(
                      //                   //                           //     //               context)
                      //                   //                           //     //           .copyWith(
                      //                   //                           //     //         colorScheme:
                      //                   //                           //     //             ColorScheme
                      //                   //                           //     //                 .dark(
                      //                   //                           //     //           primary:
                      //                   //                           //     //               Colors.black,
                      //                   //                           //     //           onPrimary:
                      //                   //                           //     //               Colors.white,
                      //                   //                           //     //           surface:
                      //                   //                           //     //               ColorUtils.primary_gold,
                      //                   //                           //     //           // onPrimary: Colors.black, // <-- SEE HERE
                      //                   //                           //     //           onSurface:
                      //                   //                           //     //               Colors.black,
                      //                   //                           //     //         ),
                      //                   //                           //     //         dialogBackgroundColor:
                      //                   //                           //     //             ColorUtils
                      //                   //                           //     //                 .primary_gold,
                      //                   //                           //     //         textButtonTheme:
                      //                   //                           //     //             TextButtonThemeData(
                      //                   //                           //     //           style: TextButton
                      //                   //                           //     //               .styleFrom(
                      //                   //                           //     //             primary:
                      //                   //                           //     //                 Colors.black, // button text color
                      //                   //                           //     //           ),
                      //                   //                           //     //         ),
                      //                   //                           //     //       ),
                      //                   //                           //     //       child:
                      //                   //                           //     //           child!,
                      //                   //                           //     //     );
                      //                   //                           //     //   },
                      //                   //                           //     // );
                      //                   //                           //     // if (selectedTime !=
                      //                   //                           //     //     null) {
                      //                   //                           //     //   final now =
                      //                   //                           //     //       DateTime
                      //                   //                           //     //           .now();
                      //                   //                           //     //   var selectedDateTime = DateTime(
                      //                   //                           //     //       now.year,
                      //                   //                           //     //       now.month,
                      //                   //                           //     //       now.day,
                      //                   //                           //     //       selectedTime
                      //                   //                           //     //           .hour,
                      //                   //                           //     //       selectedTime
                      //                   //                           //     //           .minute);
                      //                   //                           //     //   _alarmTime =
                      //                   //                           //     //       selectedDateTime;
                      //                   //                           //     //   setModalState(
                      //                   //                           //     //       () {
                      //                   //                           //     //     _alarmTimeString =
                      //                   //                           //     //         DateFormat(
                      //                   //                           //     //                 'HH:mm')
                      //                   //                           //     //             .format(
                      //                   //                           //     //                 selectedDateTime);
                      //                   //                           //     //   });
                      //                   //                           //     // }
                      //                   //                           //   },
                      //                   //                           //   child: Text(
                      //                   //                           //       _alarmTimeString!,
                      //                   //                           //       style: FontStyleUtility.h35(
                      //                   //                           //           fontColor:
                      //                   //                           //               ColorUtils
                      //                   //                           //                   .primary_gold,
                      //                   //                           //           family:
                      //                   //                           //               'PM')),
                      //                   //                           // ),
                      //                   //                           Container(
                      //                   //                             height: 150,
                      //                   //                             decoration: BoxDecoration(
                      //                   //                                 borderRadius: BorderRadius.circular(15),
                      //                   //                                 gradient: LinearGradient(
                      //                   //                                   begin: Alignment.topCenter,
                      //                   //                                   end: Alignment.bottomCenter,
                      //                   //                                   colors: [
                      //                   //                                     HexColor("#000000").withOpacity(1),
                      //                   //                                     HexColor("#04060F").withOpacity(1),
                      //                   //                                     HexColor("#000000").withOpacity(1),
                      //                   //
                      //                   //                                   ],
                      //                   //                                 ),
                      //                   //                                 boxShadow: [
                      //                   //                                   BoxShadow(
                      //                   //                                       color: HexColor('#04060F'),
                      //                   //                                       offset: Offset(3, 3),
                      //                   //                                       blurRadius: 10)
                      //                   //                                 ]),
                      //                   //                             child: Stack(
                      //                   //                               children: [
                      //                   //                                 CupertinoTheme(
                      //                   //                                   data: CupertinoThemeData(
                      //                   //                                     brightness: Brightness.dark,
                      //                   //                                   ),
                      //                   //                                   child: CupertinoDatePicker(
                      //                   //                                     // use24hFormat: true,
                      //                   //                                     mode: CupertinoDatePickerMode.time,
                      //                   //                                     onDateTimeChanged: (DateTime value) {
                      //                   //                                       selected_time= value;
                      //                   //                                       print("${value.hour}:${value.minute}");
                      //                   //
                      //                   //
                      //                   //                                       if (selected_time !=
                      //                   //                                           null) {
                      //                   //                                         final now =
                      //                   //                                         DateTime
                      //                   //                                             .now();
                      //                   //                                         var selectedDateTime = DateTime(
                      //                   //                                             now.year,
                      //                   //                                             now.month,
                      //                   //                                             now.day,
                      //                   //                                             selected_time
                      //                   //                                                 .hour,
                      //                   //                                             selected_time
                      //                   //                                                 .minute);
                      //                   //                                         _alarmTime =
                      //                   //                                             selectedDateTime;
                      //                   //                                         setModalState(
                      //                   //                                                 () {
                      //                   //                                               _alarmTimeString =
                      //                   //                                                   DateFormat(
                      //                   //                                                       'HH:mm')
                      //                   //                                                       .format(
                      //                   //                                                       selectedDateTime);
                      //                   //                                             });
                      //                   //                                       }
                      //                   //                                     },
                      //                   //                                   ),
                      //                   //                                 ),
                      //                   //                               ],
                      //                   //                             ),
                      //                   //                           ),
                      //                   //
                      //                   //                           ListTile(
                      //                   //                             onTap: () {
                      //                   //                               showDialog(
                      //                   //                                 context:
                      //                   //                                 context,
                      //                   //                                 builder:
                      //                   //                                     (BuildContext
                      //                   //                                 context) {
                      //                   //                                   double width =
                      //                   //                                       MediaQuery.of(
                      //                   //                                           context)
                      //                   //                                           .size
                      //                   //                                           .width;
                      //                   //                                   double
                      //                   //                                   height =
                      //                   //                                       MediaQuery.of(
                      //                   //                                           context)
                      //                   //                                           .size
                      //                   //                                           .height;
                      //                   //                                   return BackdropFilter(
                      //                   //                                     filter: ImageFilter.blur(
                      //                   //                                         sigmaX:
                      //                   //                                         10,
                      //                   //                                         sigmaY:
                      //                   //                                         10),
                      //                   //                                     child: AlertDialog(
                      //                   //                                         backgroundColor: Colors.transparent,
                      //                   //                                         contentPadding: EdgeInsets.zero,
                      //                   //                                         elevation: 0.0,
                      //                   //                                         // title: Center(child: Text("Evaluation our APP")),
                      //                   //                                         content: Column(
                      //                   //                                           mainAxisAlignment:
                      //                   //                                           MainAxisAlignment.center,
                      //                   //                                           children: [
                      //                   //                                             Stack(
                      //                   //                                               children: [
                      //                   //                                                 Padding(
                      //                   //                                                   padding: const EdgeInsets.all(8.0),
                      //                   //                                                   child: Container(
                      //                   //                                                     decoration:
                      //                   //                                                     BoxDecoration(
                      //                   //                                                       // color: Colors.black.withOpacity(0.65),
                      //                   //                                                         gradient:
                      //                   //                                                         LinearGradient(
                      //                   //                                                           begin: Alignment.centerLeft,
                      //                   //                                                           end: Alignment.centerRight,
                      //                   //                                                           // stops: [0.1, 0.5, 0.7, 0.9],
                      //                   //                                                           colors: [
                      //                   //                                                             HexColor("#020204").withOpacity(1),
                      //                   //                                                             HexColor("#36393E").withOpacity(1),
                      //                   //                                                           ],
                      //                   //                                                         ),
                      //                   //                                                         boxShadow: [
                      //                   //                                                           BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //                   //                                                         ],
                      //                   //                                                         borderRadius: BorderRadius.circular(15)),
                      //                   //                                                     child: Align(
                      //                   //                                                         alignment: Alignment.center,
                      //                   //                                                         child: Padding(
                      //                   //                                                           padding: const EdgeInsets.all(8.0),
                      //                   //                                                           child: Column(
                      //                   //                                                             children: [
                      //                   //                                                               SizedBox(
                      //                   //                                                                 height: 0,
                      //                   //                                                               ),
                      //                   //
                      //                   //                                                               Column(
                      //                   //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                   //                                                                 children: [
                      //                   //                                                                   Container(
                      //                   //                                                                     margin: EdgeInsets.only(left: 18),
                      //                   //                                                                     child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                      //                   //                                                                   ),
                      //                   //                                                                   SizedBox(
                      //                   //                                                                     height: 11,
                      //                   //                                                                   ),
                      //                   //                                                                   Container(
                      //                   //                                                                     margin: EdgeInsets.symmetric(horizontal: 10),
                      //                   //                                                                     // width: 300,
                      //                   //                                                                     decoration: BoxDecoration(
                      //                   //                                                                       // color: Colors.black.withOpacity(0.65),
                      //                   //                                                                         gradient: LinearGradient(
                      //                   //                                                                           begin: Alignment.centerLeft,
                      //                   //                                                                           end: Alignment.centerRight,
                      //                   //                                                                           // stops: [0.1, 0.5, 0.7, 0.9],
                      //                   //                                                                           colors: [
                      //                   //                                                                             HexColor("#36393E").withOpacity(1),
                      //                   //                                                                             HexColor("#020204").withOpacity(1),
                      //                   //                                                                           ],
                      //                   //                                                                         ),
                      //                   //                                                                         boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                      //                   //                                                                         borderRadius: BorderRadius.circular(20)),
                      //                   //
                      //                   //                                                                     child: TextFormField(
                      //                   //                                                                       maxLength: 150,
                      //                   //                                                                       decoration: InputDecoration(
                      //                   //                                                                         contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                      //                   //                                                                         alignLabelWithHint: false,
                      //                   //                                                                         isDense: true,
                      //                   //                                                                         hintText: 'Add alarm title',
                      //                   //                                                                         counterStyle: TextStyle(
                      //                   //                                                                           height: double.minPositive,
                      //                   //                                                                         ),
                      //                   //                                                                         counterText: "",
                      //                   //                                                                         filled: true,
                      //                   //                                                                         border: InputBorder.none,
                      //                   //                                                                         enabledBorder: const OutlineInputBorder(
                      //                   //                                                                           borderSide: BorderSide(color: Colors.transparent, width: 1),
                      //                   //                                                                           borderRadius: BorderRadius.all(Radius.circular(10)),
                      //                   //                                                                         ),
                      //                   //                                                                         hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                      //                   //                                                                       ),
                      //                   //                                                                       style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //                   //                                                                       controller: Alarm_title,
                      //                   //                                                                       keyboardType: TextInputType.text,
                      //                   //                                                                     ),
                      //                   //                                                                   ),
                      //                   //                                                                 ],
                      //                   //                                                               ),
                      //                   //                                                               SizedBox(
                      //                   //                                                                 height: 10,
                      //                   //                                                               ),
                      //                   //                                                               GestureDetector(
                      //                   //                                                                 onTap: () {
                      //                   //                                                                   setState(() {
                      //                   //                                                                     Alarm_title_list.add(Alarm_title.text);
                      //                   //                                                                     Navigator.pop(context);
                      //                   //                                                                   });
                      //                   //                                                                 },
                      //                   //                                                                 child: Container(
                      //                   //                                                                   alignment: Alignment.topRight,
                      //                   //                                                                   child: Text(
                      //                   //                                                                     'Add',
                      //                   //                                                                     style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                      //                   //                                                                   ),
                      //                   //                                                                 ),
                      //                   //                                                               )
                      //                   //                                                               // common_button_gold(
                      //                   //                                                               //   onTap: () {
                      //                   //                                                               //     Get
                      //                   //                                                               //         .to(
                      //                   //                                                               //         DashboardScreen());
                      //                   //                                                               //   },
                      //                   //                                                               //   title_text: 'Go to Dashboard',
                      //                   //                                                               // ),
                      //                   //                                                             ],
                      //                   //                                                           ),
                      //                   //                                                         )),
                      //                   //                                                   ),
                      //                   //                                                 ),
                      //                   //                                                 GestureDetector(
                      //                   //                                                   onTap: () {
                      //                   //                                                     Navigator.pop(context);
                      //                   //                                                   },
                      //                   //                                                   child: Container(
                      //                   //                                                     margin: EdgeInsets.only(right: 10),
                      //                   //                                                     alignment: Alignment.topRight,
                      //                   //                                                     child: Container(
                      //                   //                                                         decoration: BoxDecoration(
                      //                   //                                                           // color: Colors.black.withOpacity(0.65),
                      //                   //                                                             gradient: LinearGradient(
                      //                   //                                                               begin: Alignment.centerLeft,
                      //                   //                                                               end: Alignment.centerRight,
                      //                   //                                                               // stops: [0.1, 0.5, 0.7, 0.9],
                      //                   //                                                               colors: [
                      //                   //                                                                 HexColor("#36393E").withOpacity(1),
                      //                   //                                                                 HexColor("#020204").withOpacity(1),
                      //                   //                                                               ],
                      //                   //                                                             ),
                      //                   //                                                             boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //                   //                                                             borderRadius: BorderRadius.circular(20)),
                      //                   //                                                         child: Padding(
                      //                   //                                                           padding: const EdgeInsets.all(4.0),
                      //                   //                                                           child: Icon(
                      //                   //                                                             Icons.cancel_outlined,
                      //                   //                                                             size: 13,
                      //                   //                                                             color: ColorUtils.primary_grey,
                      //                   //                                                           ),
                      //                   //                                                         )),
                      //                   //                                                   ),
                      //                   //                                                 )
                      //                   //                                               ],
                      //                   //                                             ),
                      //                   //                                           ],
                      //                   //                                         )),
                      //                   //                                   );
                      //                   //                                 },
                      //                   //                               );
                      //                   //                             },
                      //                   //                             title: Text('Title',
                      //                   //                                 style: FontStyleUtility.h14(
                      //                   //                                     fontColor:
                      //                   //                                     ColorUtils
                      //                   //                                         .primary_grey,
                      //                   //                                     family:
                      //                   //                                     'PR')),
                      //                   //                             trailing: const Icon(
                      //                   //                                 Icons
                      //                   //                                     .arrow_forward_ios,
                      //                   //                                 size: 15,
                      //                   //                                 color: Colors
                      //                   //                                     .white),
                      //                   //                           ),
                      //                   //                           ListTile(
                      //                   //                             title: Text(
                      //                   //                               'Repeat',
                      //                   //                               style: FontStyleUtility.h14(
                      //                   //                                   fontColor:
                      //                   //                                   ColorUtils
                      //                   //                                       .primary_gold,
                      //                   //                                   family: 'PR'),
                      //                   //                             ),
                      //                   //                             trailing:
                      //                   //                             const Icon(
                      //                   //                               Icons
                      //                   //                                   .arrow_forward_ios,
                      //                   //                               size: 15,
                      //                   //                               color:
                      //                   //                               Colors.white,
                      //                   //                             ),
                      //                   //                           ),
                      //                   //                           GestureDetector(
                      //                   //                             onTap: () {
                      //                   //                               print('object');
                      //                   //
                      //                   //                               showDialog(
                      //                   //                                 context:
                      //                   //                                 context,
                      //                   //                                 builder:
                      //                   //                                     (BuildContext
                      //                   //                                 context) {
                      //                   //                                   double width =
                      //                   //                                       MediaQuery.of(
                      //                   //                                           context)
                      //                   //                                           .size
                      //                   //                                           .width;
                      //                   //                                   double
                      //                   //                                   height =
                      //                   //                                       MediaQuery.of(
                      //                   //                                           context)
                      //                   //                                           .size
                      //                   //                                           .height;
                      //                   //                                   return AlertDialog(
                      //                   //                                       backgroundColor:
                      //                   //                                       Colors
                      //                   //                                           .transparent,
                      //                   //                                       contentPadding:
                      //                   //                                       EdgeInsets
                      //                   //                                           .zero,
                      //                   //                                       elevation:
                      //                   //                                       0.0,
                      //                   //                                       // title: Center(child: Text("Evaluation our APP")),
                      //                   //                                       content:
                      //                   //                                       Column(
                      //                   //                                         mainAxisAlignment:
                      //                   //                                         MainAxisAlignment.center,
                      //                   //                                         children: [
                      //                   //                                           Stack(
                      //                   //                                             children: [
                      //                   //                                               Container(
                      //                   //                                                 // height: 150,
                      //                   //                                                 // height: double.maxFinite,
                      //                   //                                                 height: MediaQuery.of(context).size.height / 4,
                      //                   //                                                 width: double.maxFinite,
                      //                   //                                                 decoration:
                      //                   //                                                 BoxDecoration(
                      //                   //                                                   // color: Colors.black.withOpacity(0.65),
                      //                   //                                                     gradient:
                      //                   //                                                     LinearGradient(
                      //                   //                                                       begin: Alignment.centerLeft,
                      //                   //                                                       end: Alignment.centerRight,
                      //                   //                                                       // stops: [0.1, 0.5, 0.7, 0.9],
                      //                   //                                                       colors: [
                      //                   //                                                         HexColor("#020204").withOpacity(1),
                      //                   //                                                         HexColor("#36393E").withOpacity(1),
                      //                   //                                                       ],
                      //                   //                                                     ),
                      //                   //                                                     boxShadow: [
                      //                   //                                                       BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                      //                   //                                                     ],
                      //                   //                                                     borderRadius: BorderRadius.circular(20)),
                      //                   //                                                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //                   //                                                 // height: 122,
                      //                   //                                                 // width: 133,
                      //                   //                                                 // padding: const EdgeInsets.all(8.0),
                      //                   //                                                 child: Column(
                      //                   //                                                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   //                                                   children: [
                      //                   //                                                     Container(
                      //                   //                                                       // color: Colors.white,
                      //                   //                                                       alignment: Alignment.center,
                      //                   //                                                       child: ListView.builder(
                      //                   //                                                         padding: EdgeInsets.only(bottom: 0),
                      //                   //
                      //                   //                                                         // physics: NeverScrollableScrollPhysics(),
                      //                   //                                                         itemCount: list_alarm.length,
                      //                   //                                                         shrinkWrap: true,
                      //                   //                                                         itemBuilder: (BuildContext context, int index) {
                      //                   //                                                           return GestureDetector(
                      //                   //                                                             onTap: () {
                      //                   //                                                               setState(() {
                      //                   //                                                                 Selected_sound = list_alarm[index];
                      //                   //                                                                 print("method_selected $Selected_sound");
                      //                   //                                                               });
                      //                   //                                                               Navigator.pop(context);
                      //                   //                                                             },
                      //                   //                                                             child: Container(
                      //                   //                                                               margin: EdgeInsets.symmetric(vertical: 8.5),
                      //                   //                                                               alignment: Alignment.center,
                      //                   //                                                               child: Text(
                      //                   //                                                                 list_alarm[index],
                      //                   //                                                                 style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                      //                   //                                                               ),
                      //                   //                                                             ),
                      //                   //                                                           );
                      //                   //                                                         },
                      //                   //                                                       ),
                      //                   //                                                     ),
                      //                   //                                                   ],
                      //                   //                                                 ),
                      //                   //                                               ),
                      //                   //                                               GestureDetector(
                      //                   //                                                 onTap: () {
                      //                   //                                                   Navigator.pop(context);
                      //                   //                                                 },
                      //                   //                                                 child: Container(
                      //                   //                                                   margin: EdgeInsets.only(right: 0),
                      //                   //                                                   alignment: Alignment.topRight,
                      //                   //                                                   child: Container(
                      //                   //                                                       decoration: BoxDecoration(
                      //                   //                                                         // color: Colors.black.withOpacity(0.65),
                      //                   //                                                           gradient: LinearGradient(
                      //                   //                                                             begin: Alignment.centerLeft,
                      //                   //                                                             end: Alignment.centerRight,
                      //                   //                                                             // stops: [0.1, 0.5, 0.7, 0.9],
                      //                   //                                                             colors: [
                      //                   //                                                               HexColor("#36393E").withOpacity(1),
                      //                   //                                                               HexColor("#020204").withOpacity(1),
                      //                   //                                                             ],
                      //                   //                                                           ),
                      //                   //                                                           boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                      //                   //                                                           borderRadius: BorderRadius.circular(20)),
                      //                   //                                                       child: Padding(
                      //                   //                                                         padding: const EdgeInsets.all(4.0),
                      //                   //                                                         child: Icon(
                      //                   //                                                           Icons.cancel_outlined,
                      //                   //                                                           size: 20,
                      //                   //                                                           color: ColorUtils.primary_grey,
                      //                   //                                                         ),
                      //                   //                                                       )),
                      //                   //                                                 ),
                      //                   //                                               )
                      //                   //                                             ],
                      //                   //                                           ),
                      //                   //                                         ],
                      //                   //                                       ));
                      //                   //                                 },
                      //                   //                               );
                      //                   //                             },
                      //                   //                             child: ListTile(
                      //                   //                               title: Text(
                      //                   //                                   'Sound',
                      //                   //                                   style: FontStyleUtility.h14(
                      //                   //                                       fontColor:
                      //                   //                                       ColorUtils
                      //                   //                                           .primary_gold,
                      //                   //                                       family:
                      //                   //                                       'PR')),
                      //                   //                               trailing: const Icon(
                      //                   //                                   Icons
                      //                   //                                       .arrow_forward_ios,
                      //                   //                                   size: 15,
                      //                   //                                   color: Colors
                      //                   //                                       .white),
                      //                   //                             ),
                      //                   //                           ),
                      //                   //                           GestureDetector(
                      //                   //                             onTap: () async {
                      //                   //                               if (Alarm_title
                      //                   //                                   .text
                      //                   //                                   .isEmpty) {
                      //                   //                                 CommonWidget()
                      //                   //                                     .showErrorToaster(
                      //                   //                                     msg:
                      //                   //                                     "Enter Alarm title");
                      //                   //                                 return;
                      //                   //                               } else {
                      //                   //                                 await onSaveAlarm();
                      //                   //                               }
                      //                   //                             },
                      //                   //                             child: Container(
                      //                   //                               width: MediaQuery.of(
                      //                   //                                   context)
                      //                   //                                   .size
                      //                   //                                   .width /
                      //                   //                                   3,
                      //                   //                               decoration: BoxDecoration(
                      //                   //                                   borderRadius:
                      //                   //                                   BorderRadius
                      //                   //                                       .circular(
                      //                   //                                       30),
                      //                   //                                   border: Border.all(
                      //                   //                                       color: ColorUtils
                      //                   //                                           .primary_grey,
                      //                   //                                       width:
                      //                   //                                       1)),
                      //                   //                               child: Padding(
                      //                   //                                 padding: const EdgeInsets
                      //                   //                                     .symmetric(
                      //                   //                                     vertical:
                      //                   //                                     12.0,
                      //                   //                                     horizontal:
                      //                   //                                     8),
                      //                   //                                 child: Row(
                      //                   //                                   mainAxisAlignment:
                      //                   //                                   MainAxisAlignment
                      //                   //                                       .center,
                      //                   //                                   children: [
                      //                   //                                     const Icon(
                      //                   //                                       Icons
                      //                   //                                           .alarm,
                      //                   //                                       color: Colors
                      //                   //                                           .white,
                      //                   //                                       size: 25,
                      //                   //                                     ),
                      //                   //                                     const SizedBox(
                      //                   //                                       width: 10,
                      //                   //                                     ),
                      //                   //                                     Text(
                      //                   //                                       'Save',
                      //                   //                                       style: FontStyleUtility.h16(
                      //                   //                                           fontColor: ColorUtils
                      //                   //                                               .primary_gold,
                      //                   //                                           family:
                      //                   //                                           'PR'),
                      //                   //                                     ),
                      //                   //                                   ],
                      //                   //                                 ),
                      //                   //                               ),
                      //                   //                             ),
                      //                   //                           )
                      //                   //                         ],
                      //                   //                       ),
                      //                   //                     ),
                      //                   //                   );
                      //                   //                 },
                      //                   //               );
                      //                   //             },
                      //                   //           );
                      //                   //           // scheduleAlarm();
                      //                   //         },
                      //                   //         child: Container(
                      //                   //           decoration: BoxDecoration(
                      //                   //             // color: Colors.black.withOpacity(0.65),
                      //                   //               gradient: LinearGradient(
                      //                   //                 begin: Alignment.centerLeft,
                      //                   //                 end: Alignment.centerRight,
                      //                   //                 // stops: [0.1, 0.5, 0.7, 0.9],
                      //                   //                 colors: [
                      //                   //                   HexColor("#36393E")
                      //                   //                       .withOpacity(1),
                      //                   //                   HexColor("#020204")
                      //                   //                       .withOpacity(1),
                      //                   //                 ],
                      //                   //               ),
                      //                   //               boxShadow: [
                      //                   //                 BoxShadow(
                      //                   //                     color: HexColor('#04060F'),
                      //                   //                     offset:
                      //                   //                     const Offset(10, 10),
                      //                   //                     blurRadius: 20)
                      //                   //               ],
                      //                   //               borderRadius:
                      //                   //               BorderRadius.circular(20)),
                      //                   //           child: Padding(
                      //                   //             padding: const EdgeInsets.all(8.0),
                      //                   //             child: Icon(
                      //                   //               Icons.add_circle_outline,
                      //                   //               color: ColorUtils.primary_grey,
                      //                   //             ),
                      //                   //           ),
                      //                   //         )),
                      //                   //   )
                      //                   // else
                      //                   //   const Center(
                      //                   //       child: Text(
                      //                   //         'Only 5 alarms allowed!',
                      //                   //         style: const TextStyle(color: Colors.white),
                      //                   //       )),
                      //                 ]).toList(),
                      //               ),
                      //             );
                      //           }
                      //           return const Center(
                      //             child: const Text(
                      //               'Loading..',
                      //               style: TextStyle(color: Colors.white),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                                  offset: const Offset(10, 10),
                                  blurRadius: 20)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            // if (_currentAlarms!.length < 5)
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 0),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Add Alarm",
                                        style: FontStyleUtility.h16(
                                            fontColor: ColorUtils.primary_gold,
                                            family: 'PM'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10),
                                    child: GestureDetector(
                                        onTap: () {
                                          print(_currentAlarms!.length);
                                          _alarmTimeString = DateFormat('HH:mm')
                                              .format(selectedDate);
                                          Alarm_title.text =
                                              "Kegel ${(_currentAlarms!.length + 1)}";
                                          if (_currentAlarms!.length >= 3) {
                                            CommonWidget().showErrorToaster(
                                                msg: "Only 3 alarams/Day");
                                          } else {
                                            showModalBottomSheet(
                                              useRootNavigator: true,
                                              context: context,
                                              clipBehavior: Clip.antiAlias,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(24),
                                                ),
                                              ),
                                              builder: (context) {
                                                return StatefulBuilder(
                                                  builder:
                                                      (context, setModalState) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          // color: Colors.black.withOpacity(0.65),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                                            colors: [
                                                              HexColor(
                                                                      "#020204")
                                                                  .withOpacity(
                                                                      1),
                                                              HexColor(
                                                                      "#36393E")
                                                                  .withOpacity(
                                                                      1),
                                                            ],
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: HexColor(
                                                                    '#04060F'),
                                                                offset:
                                                                    const Offset(
                                                                        -10,
                                                                        10),
                                                                blurRadius: 20)
                                                          ],
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20))),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 32,
                                                          vertical: 10),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            // FlatButton(
                                                            //   onPressed:
                                                            //       () async {
                                                            //     // var selectedTime = await showTimePicker(
                                                            //     //   context: context,
                                                            //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                                                            //     //   initialEntryMode: TimePickerEntryMode.dial,
                                                            //     //   initialTime: TimeOfDay.now(),
                                                            //     //   builder: (context, child) {
                                                            //     //     return Theme(
                                                            //     //       data: Theme.of(
                                                            //     //               context)
                                                            //     //           .copyWith(
                                                            //     //         colorScheme:
                                                            //     //             ColorScheme
                                                            //     //                 .dark(
                                                            //     //           primary:
                                                            //     //               Colors.black,
                                                            //     //           onPrimary:
                                                            //     //               Colors.white,
                                                            //     //           surface:
                                                            //     //               ColorUtils.primary_gold,
                                                            //     //           // onPrimary: Colors.black, // <-- SEE HERE
                                                            //     //           onSurface:
                                                            //     //               Colors.black,
                                                            //     //         ),
                                                            //     //         dialogBackgroundColor:
                                                            //     //             ColorUtils
                                                            //     //                 .primary_gold,
                                                            //     //         textButtonTheme:
                                                            //     //             TextButtonThemeData(
                                                            //     //           style: TextButton
                                                            //     //               .styleFrom(
                                                            //     //             primary:
                                                            //     //                 Colors.black, // button text color
                                                            //     //           ),
                                                            //     //         ),
                                                            //     //       ),
                                                            //     //       child:
                                                            //     //           child!,
                                                            //     //     );
                                                            //     //   },
                                                            //     // );
                                                            //     // if (selectedTime !=
                                                            //     //     null) {
                                                            //     //   final now =
                                                            //     //       DateTime
                                                            //     //           .now();
                                                            //     //   var selectedDateTime = DateTime(
                                                            //     //       now.year,
                                                            //     //       now.month,
                                                            //     //       now.day,
                                                            //     //       selectedTime
                                                            //     //           .hour,
                                                            //     //       selectedTime
                                                            //     //           .minute);
                                                            //     //   _alarmTime =
                                                            //     //       selectedDateTime;
                                                            //     //   setModalState(
                                                            //     //       () {
                                                            //     //     _alarmTimeString =
                                                            //     //         DateFormat(
                                                            //     //                 'HH:mm')
                                                            //     //             .format(
                                                            //     //                 selectedDateTime);
                                                            //     //   });
                                                            //     // }
                                                            //   },
                                                            //   child: Text(
                                                            //       _alarmTimeString!,
                                                            //       style: FontStyleUtility.h35(
                                                            //           fontColor:
                                                            //               ColorUtils
                                                            //                   .primary_gold,
                                                            //           family:
                                                            //               'PM')),
                                                            // ),
                                                            Container(
                                                              height: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15),
                                                                      gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment
                                                                            .bottomCenter,
                                                                        colors: [
                                                                          HexColor("#000000")
                                                                              .withOpacity(1),
                                                                          HexColor("#04060F")
                                                                              .withOpacity(1),
                                                                          HexColor("#000000")
                                                                              .withOpacity(1),
                                                                        ],
                                                                      ),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                        color: HexColor(
                                                                            '#04060F'),
                                                                        offset: Offset(
                                                                            3,
                                                                            3),
                                                                        blurRadius:
                                                                            10)
                                                                  ]),
                                                              child: Stack(
                                                                children: [
                                                                  CupertinoTheme(
                                                                    data:
                                                                        CupertinoThemeData(
                                                                      brightness:
                                                                          Brightness
                                                                              .dark,
                                                                    ),
                                                                    child:
                                                                        CupertinoDatePicker(
                                                                      // use24hFormat: true,
                                                                      mode: CupertinoDatePickerMode
                                                                          .time,
                                                                      onDateTimeChanged:
                                                                          (DateTime
                                                                              value) {
                                                                        selected_time =
                                                                            value;
                                                                        print(
                                                                            "${value.hour}:${value.minute}");

                                                                        if (selected_time !=
                                                                            null) {
                                                                          final now =
                                                                              DateTime.now();
                                                                          var selectedDateTime = DateTime(
                                                                              now.year,
                                                                              now.month,
                                                                              now.day,
                                                                              selected_time.hour,
                                                                              selected_time.minute);
                                                                          _alarmTime =
                                                                              selectedDateTime;
                                                                          setModalState(
                                                                              () {
                                                                            _alarmTimeString =
                                                                                DateFormat('HH:mm').format(selectedDateTime);
                                                                          });
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            ListTile(
                                                              visualDensity:
                                                                  VisualDensity(
                                                                      vertical:
                                                                          -4),
                                                              onTap: () {
                                                                // showDialog(
                                                                //   context:
                                                                //       context,
                                                                //   builder:
                                                                //       (BuildContext
                                                                //           context) {
                                                                //     double
                                                                //         width =
                                                                //         MediaQuery.of(context)
                                                                //             .size
                                                                //             .width;
                                                                //     double
                                                                //         height =
                                                                //         MediaQuery.of(context)
                                                                //             .size
                                                                //             .height;
                                                                //     Alarm_title
                                                                //             .text =
                                                                //         "Kegel ${(_currentAlarms!.length + 1)}";
                                                                //     return BackdropFilter(
                                                                //       filter: ImageFilter.blur(
                                                                //           sigmaX:
                                                                //               10,
                                                                //           sigmaY:
                                                                //               10),
                                                                //       child: AlertDialog(
                                                                //           backgroundColor: Colors.transparent,
                                                                //           contentPadding: EdgeInsets.zero,
                                                                //           elevation: 0.0,
                                                                //           // title: Center(child: Text("Evaluation our APP")),
                                                                //           content: Column(
                                                                //             mainAxisAlignment:
                                                                //                 MainAxisAlignment.center,
                                                                //             children: [
                                                                //               Stack(
                                                                //                 children: [
                                                                //                   Padding(
                                                                //                     padding: const EdgeInsets.all(8.0),
                                                                //                     child: Container(
                                                                //                       decoration:
                                                                //                           BoxDecoration(
                                                                //                               // color: Colors.black.withOpacity(0.65),
                                                                //                               gradient:
                                                                //                                   LinearGradient(
                                                                //                                 begin: Alignment.centerLeft,
                                                                //                                 end: Alignment.centerRight,
                                                                //                                 // stops: [0.1, 0.5, 0.7, 0.9],
                                                                //                                 colors: [
                                                                //                                   HexColor("#020204").withOpacity(1),
                                                                //                                   HexColor("#36393E").withOpacity(1),
                                                                //                                 ],
                                                                //                               ),
                                                                //                               boxShadow: [
                                                                //                                 BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                                                //                               ],
                                                                //                               borderRadius: BorderRadius.circular(15)),
                                                                //                       child: Align(
                                                                //                           alignment: Alignment.center,
                                                                //                           child: Padding(
                                                                //                             padding: const EdgeInsets.all(8.0),
                                                                //                             child: Column(
                                                                //                               children: [
                                                                //                                 SizedBox(
                                                                //                                   height: 0,
                                                                //                                 ),
                                                                //
                                                                //                                 Column(
                                                                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                //                                   children: [
                                                                //                                     Container(
                                                                //                                       margin: EdgeInsets.only(left: 18),
                                                                //                                       child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                                                                //                                     ),
                                                                //                                     SizedBox(
                                                                //                                       height: 11,
                                                                //                                     ),
                                                                //                                     Container(
                                                                //                                       margin: EdgeInsets.symmetric(horizontal: 10),
                                                                //                                       // width: 300,
                                                                //                                       decoration: BoxDecoration(
                                                                //                                           // color: Colors.black.withOpacity(0.65),
                                                                //                                           gradient: LinearGradient(
                                                                //                                             begin: Alignment.centerLeft,
                                                                //                                             end: Alignment.centerRight,
                                                                //                                             // stops: [0.1, 0.5, 0.7, 0.9],
                                                                //                                             colors: [
                                                                //                                               HexColor("#36393E").withOpacity(1),
                                                                //                                               HexColor("#020204").withOpacity(1),
                                                                //                                             ],
                                                                //                                           ),
                                                                //                                           boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                                                                //                                           borderRadius: BorderRadius.circular(20)),
                                                                //
                                                                //                                       child: TextFormField(
                                                                //                                         maxLength: 150,
                                                                //                                         decoration: InputDecoration(
                                                                //                                           contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                                                                //                                           alignLabelWithHint: false,
                                                                //                                           isDense: true,
                                                                //                                           hintText: 'Add alarm title',
                                                                //                                           counterStyle: TextStyle(
                                                                //                                             height: double.minPositive,
                                                                //                                           ),
                                                                //                                           counterText: "",
                                                                //                                           filled: true,
                                                                //                                           border: InputBorder.none,
                                                                //                                           enabledBorder: const OutlineInputBorder(
                                                                //                                             borderSide: BorderSide(color: Colors.transparent, width: 1),
                                                                //                                             borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                //                                           ),
                                                                //                                           hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                                                                //                                         ),
                                                                //                                         style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                                                                //                                         controller: Alarm_title,
                                                                //                                         keyboardType: TextInputType.text,
                                                                //                                       ),
                                                                //                                     ),
                                                                //                                   ],
                                                                //                                 ),
                                                                //                                 SizedBox(
                                                                //                                   height: 10,
                                                                //                                 ),
                                                                //                                 GestureDetector(
                                                                //                                   onTap: () {
                                                                //                                     setState(() {
                                                                //                                       Alarm_title_list.add(Alarm_title.text);
                                                                //                                       Navigator.pop(context);
                                                                //                                     });
                                                                //                                   },
                                                                //                                   child: Container(
                                                                //                                     alignment: Alignment.topRight,
                                                                //                                     child: Text(
                                                                //                                       'Add',
                                                                //                                       style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                                                                //                                     ),
                                                                //                                   ),
                                                                //                                 )
                                                                //                                 // common_button_gold(
                                                                //                                 //   onTap: () {
                                                                //                                 //     Get
                                                                //                                 //         .to(
                                                                //                                 //         DashboardScreen());
                                                                //                                 //   },
                                                                //                                 //   title_text: 'Go to Dashboard',
                                                                //                                 // ),
                                                                //                               ],
                                                                //                             ),
                                                                //                           )),
                                                                //                     ),
                                                                //                   ),
                                                                //                   GestureDetector(
                                                                //                     onTap: () {
                                                                //                       Navigator.pop(context);
                                                                //                     },
                                                                //                     child: Container(
                                                                //                       margin: EdgeInsets.only(right: 10),
                                                                //                       alignment: Alignment.topRight,
                                                                //                       child: Container(
                                                                //                           decoration: BoxDecoration(
                                                                //                               // color: Colors.black.withOpacity(0.65),
                                                                //                               gradient: LinearGradient(
                                                                //                                 begin: Alignment.centerLeft,
                                                                //                                 end: Alignment.centerRight,
                                                                //                                 // stops: [0.1, 0.5, 0.7, 0.9],
                                                                //                                 colors: [
                                                                //                                   HexColor("#36393E").withOpacity(1),
                                                                //                                   HexColor("#020204").withOpacity(1),
                                                                //                                 ],
                                                                //                               ),
                                                                //                               boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                                                                //                               borderRadius: BorderRadius.circular(20)),
                                                                //                           child: Padding(
                                                                //                             padding: const EdgeInsets.all(4.0),
                                                                //                             child: Icon(
                                                                //                               Icons.cancel_outlined,
                                                                //                               size: 13,
                                                                //                               color: ColorUtils.primary_grey,
                                                                //                             ),
                                                                //                           )),
                                                                //                     ),
                                                                //                   )
                                                                //                 ],
                                                                //               ),
                                                                //             ],
                                                                //           )),
                                                                //     );
                                                                //   },
                                                                // );
                                                              },
                                                              title: Text(
                                                                  // 'Title',
                                                                  "Kegel ${(_currentAlarms!.length + 1)}",
                                                                  style: FontStyleUtility.h14(
                                                                      fontColor:
                                                                          ColorUtils
                                                                              .primary_grey,
                                                                      family:
                                                                          'PR')),
                                                              trailing: const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            ListTile(
                                                              visualDensity:
                                                                  VisualDensity(
                                                                      vertical:
                                                                          -4),
                                                              title: Text(
                                                                'Repeat',
                                                                style: FontStyleUtility.h14(
                                                                    fontColor:
                                                                        ColorUtils
                                                                            .primary_gold,
                                                                    family:
                                                                        'PR'),
                                                              ),
                                                              trailing:
                                                                  const Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 15,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     print('object');
                                                            //
                                                            //     showDialog(
                                                            //       context:
                                                            //           context,
                                                            //       builder:
                                                            //           (BuildContext
                                                            //               context) {
                                                            //         double
                                                            //             width =
                                                            //             MediaQuery.of(context)
                                                            //                 .size
                                                            //                 .width;
                                                            //         double
                                                            //             height =
                                                            //             MediaQuery.of(context)
                                                            //                 .size
                                                            //                 .height;
                                                            //         return AlertDialog(
                                                            //             backgroundColor:
                                                            //                 Colors
                                                            //                     .transparent,
                                                            //             contentPadding:
                                                            //                 EdgeInsets
                                                            //                     .zero,
                                                            //             elevation:
                                                            //                 0.0,
                                                            //             // title: Center(child: Text("Evaluation our APP")),
                                                            //             content:
                                                            //                 Column(
                                                            //               mainAxisAlignment:
                                                            //                   MainAxisAlignment.center,
                                                            //               children: [
                                                            //                 Stack(
                                                            //                   children: [
                                                            //                     Container(
                                                            //                       // height: 150,
                                                            //                       // height: double.maxFinite,
                                                            //                       height: MediaQuery.of(context).size.height / 4,
                                                            //                       width: double.maxFinite,
                                                            //                       decoration:
                                                            //                           BoxDecoration(
                                                            //                               // color: Colors.black.withOpacity(0.65),
                                                            //                               gradient:
                                                            //                                   LinearGradient(
                                                            //                                 begin: Alignment.centerLeft,
                                                            //                                 end: Alignment.centerRight,
                                                            //                                 // stops: [0.1, 0.5, 0.7, 0.9],
                                                            //                                 colors: [
                                                            //                                   HexColor("#020204").withOpacity(1),
                                                            //                                   HexColor("#36393E").withOpacity(1),
                                                            //                                 ],
                                                            //                               ),
                                                            //                               boxShadow: [
                                                            //                                 BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                                            //                               ],
                                                            //                               borderRadius: BorderRadius.circular(20)),
                                                            //                       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                            //                       // height: 122,
                                                            //                       // width: 133,
                                                            //                       // padding: const EdgeInsets.all(8.0),
                                                            //                       child: Column(
                                                            //                         mainAxisAlignment: MainAxisAlignment.center,
                                                            //                         crossAxisAlignment: CrossAxisAlignment.start,
                                                            //                         children: [
                                                            //                           Container(
                                                            //                             // color: Colors.white,
                                                            //                             child: ListView.builder(
                                                            //                               padding: EdgeInsets.only(left: 10),
                                                            //
                                                            //                               // physics: NeverScrollableScrollPhysics(),
                                                            //                               itemCount: list_alarm.length,
                                                            //                               shrinkWrap: true,
                                                            //                               itemBuilder: (BuildContext context, int index) {
                                                            //                                 return GestureDetector(
                                                            //                                   onTap: () {
                                                            //                                     setState(() {
                                                            //                                       Selected_sound = list_alarm[index];
                                                            //                                       print("method_selected $Selected_sound");
                                                            //                                     });
                                                            //                                     Navigator.pop(context);
                                                            //                                   },
                                                            //                                   child: Container(
                                                            //                                     margin: EdgeInsets.symmetric(vertical: 8.5),
                                                            //                                     alignment: Alignment.centerLeft,
                                                            //                                     child: Text(
                                                            //                                       list_alarm[index].capitalizeFirst!,
                                                            //                                       style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                                                            //                                     ),
                                                            //                                   ),
                                                            //                                 );
                                                            //                               },
                                                            //                             ),
                                                            //                           ),
                                                            //                         ],
                                                            //                       ),
                                                            //                     ),
                                                            //                     GestureDetector(
                                                            //                       onTap: () {
                                                            //                         Navigator.pop(context);
                                                            //                       },
                                                            //                       child: Container(
                                                            //                         margin: EdgeInsets.only(right: 0),
                                                            //                         alignment: Alignment.topRight,
                                                            //                         child: Container(
                                                            //                             decoration: BoxDecoration(
                                                            //                                 // color: Colors.black.withOpacity(0.65),
                                                            //                                 gradient: LinearGradient(
                                                            //                                   begin: Alignment.centerLeft,
                                                            //                                   end: Alignment.centerRight,
                                                            //                                   // stops: [0.1, 0.5, 0.7, 0.9],
                                                            //                                   colors: [
                                                            //                                     HexColor("#36393E").withOpacity(1),
                                                            //                                     HexColor("#020204").withOpacity(1),
                                                            //                                   ],
                                                            //                                 ),
                                                            //                                 boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                                                            //                                 borderRadius: BorderRadius.circular(20)),
                                                            //                             child: Padding(
                                                            //                               padding: const EdgeInsets.all(4.0),
                                                            //                               child: Icon(
                                                            //                                 Icons.cancel_outlined,
                                                            //                                 size: 20,
                                                            //                                 color: ColorUtils.primary_grey,
                                                            //                               ),
                                                            //                             )),
                                                            //                       ),
                                                            //                     )
                                                            //                   ],
                                                            //                 ),
                                                            //               ],
                                                            //             ));
                                                            //       },
                                                            //     );
                                                            //   },
                                                            //   child: ListTile(
                                                            //     visualDensity:
                                                            //         VisualDensity(
                                                            //             vertical:
                                                            //                 -4),
                                                            //     title: Text(
                                                            //         'Sound',
                                                            //         style: FontStyleUtility.h14(
                                                            //             fontColor:
                                                            //                 ColorUtils
                                                            //                     .primary_gold,
                                                            //             family:
                                                            //                 'PR')),
                                                            //     trailing: const Icon(
                                                            //         Icons
                                                            //             .arrow_forward_ios,
                                                            //         size: 15,
                                                            //         color: Colors
                                                            //             .white),
                                                            //   ),
                                                            // ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (Alarm_title
                                                                    .text
                                                                    .isEmpty) {
                                                                  CommonWidget()
                                                                      .showErrorToaster(
                                                                          msg:
                                                                              "Enter Alarm title");
                                                                  return;
                                                                } else {
                                                                  Alarm_title_list.add(
                                                                      Alarm_title
                                                                          .text);
                                                                  if (Platform
                                                                      .isAndroid) {
                                                                    FlutterAlarmClock.createAlarm(
                                                                        selected_time
                                                                            .hour,
                                                                        selected_time
                                                                            .minute,
                                                                        title:
                                                                            'Kegel ${(_currentAlarms!.length + 1)}');
                                                                  }
                                                                  await onSaveAlarm();
                                                                  await Alarm_post_API(context);
                                                                }
                                                              },
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    border: Border.all(
                                                                        color: ColorUtils
                                                                            .primary_grey,
                                                                        width:
                                                                            1)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          12.0,
                                                                      horizontal:
                                                                          8),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .alarm,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Save',
                                                                        style: FontStyleUtility.h16(
                                                                            fontColor:
                                                                                ColorUtils.primary_gold,
                                                                            family: 'PR'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          }
                                          // scheduleAlarm();
                                        },
                                        child: Container(
                                          // color: Colors.white60,
                                          // width: 10,
                                          height: 30,
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Icon(
                                                Icons.add_circle_outline,
                                                color: ColorUtils.primary_grey,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                )
                              ],
                            ),
                            // Container(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 16, vertical: 0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Container(
                            //         margin: EdgeInsets.only(left: 16),
                            //         child: Text(
                            //           "Add Alarm",
                            //           style: FontStyleUtility.h16(
                            //               fontColor: ColorUtils.primary_gold,
                            //               family: 'PM'),
                            //         ),
                            //       ),
                            //       FlatButton(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 32, vertical: 10),
                            //           onPressed: () {
                            //             _alarmTimeString = DateFormat('HH:mm')
                            //                 .format(selectedDate);
                            //             showModalBottomSheet(
                            //               useRootNavigator: true,
                            //               context: context,
                            //               clipBehavior: Clip.antiAlias,
                            //               shape: const RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.vertical(
                            //                   top: Radius.circular(24),
                            //                 ),
                            //               ),
                            //               builder: (context) {
                            //                 return StatefulBuilder(
                            //                   builder: (context, setModalState) {
                            //                     return Container(
                            //                       decoration: BoxDecoration(
                            //                           // color: Colors.black.withOpacity(0.65),
                            //                           gradient: LinearGradient(
                            //                             begin:
                            //                                 Alignment.centerLeft,
                            //                             end:
                            //                                 Alignment.centerRight,
                            //                             // stops: [0.1, 0.5, 0.7, 0.9],
                            //                             colors: [
                            //                               HexColor("#020204")
                            //                                   .withOpacity(1),
                            //                               HexColor("#36393E")
                            //                                   .withOpacity(1),
                            //                             ],
                            //                           ),
                            //                           boxShadow: [
                            //                             BoxShadow(
                            //                                 color: HexColor(
                            //                                     '#04060F'),
                            //                                 offset: const Offset(
                            //                                     -10, 10),
                            //                                 blurRadius: 20)
                            //                           ],
                            //                           borderRadius:
                            //                               const BorderRadius.only(
                            //                                   topLeft:
                            //                                       Radius.circular(
                            //                                           20),
                            //                                   topRight:
                            //                                       Radius.circular(
                            //                                           20))),
                            //                       padding:
                            //                           const EdgeInsets.all(32),
                            //                       child: SingleChildScrollView(
                            //                         child: Column(
                            //                           children: [
                            //                             // FlatButton(
                            //                             //   onPressed:
                            //                             //       () async {
                            //                             //     // var selectedTime = await showTimePicker(
                            //                             //     //   context: context,
                            //                             //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                            //                             //     //   initialEntryMode: TimePickerEntryMode.dial,
                            //                             //     //   initialTime: TimeOfDay.now(),
                            //                             //     //   builder: (context, child) {
                            //                             //     //     return Theme(
                            //                             //     //       data: Theme.of(
                            //                             //     //               context)
                            //                             //     //           .copyWith(
                            //                             //     //         colorScheme:
                            //                             //     //             ColorScheme
                            //                             //     //                 .dark(
                            //                             //     //           primary:
                            //                             //     //               Colors.black,
                            //                             //     //           onPrimary:
                            //                             //     //               Colors.white,
                            //                             //     //           surface:
                            //                             //     //               ColorUtils.primary_gold,
                            //                             //     //           // onPrimary: Colors.black, // <-- SEE HERE
                            //                             //     //           onSurface:
                            //                             //     //               Colors.black,
                            //                             //     //         ),
                            //                             //     //         dialogBackgroundColor:
                            //                             //     //             ColorUtils
                            //                             //     //                 .primary_gold,
                            //                             //     //         textButtonTheme:
                            //                             //     //             TextButtonThemeData(
                            //                             //     //           style: TextButton
                            //                             //     //               .styleFrom(
                            //                             //     //             primary:
                            //                             //     //                 Colors.black, // button text color
                            //                             //     //           ),
                            //                             //     //         ),
                            //                             //     //       ),
                            //                             //     //       child:
                            //                             //     //           child!,
                            //                             //     //     );
                            //                             //     //   },
                            //                             //     // );
                            //                             //     // if (selectedTime !=
                            //                             //     //     null) {
                            //                             //     //   final now =
                            //                             //     //       DateTime
                            //                             //     //           .now();
                            //                             //     //   var selectedDateTime = DateTime(
                            //                             //     //       now.year,
                            //                             //     //       now.month,
                            //                             //     //       now.day,
                            //                             //     //       selectedTime
                            //                             //     //           .hour,
                            //                             //     //       selectedTime
                            //                             //     //           .minute);
                            //                             //     //   _alarmTime =
                            //                             //     //       selectedDateTime;
                            //                             //     //   setModalState(
                            //                             //     //       () {
                            //                             //     //     _alarmTimeString =
                            //                             //     //         DateFormat(
                            //                             //     //                 'HH:mm')
                            //                             //     //             .format(
                            //                             //     //                 selectedDateTime);
                            //                             //     //   });
                            //                             //     // }
                            //                             //   },
                            //                             //   child: Text(
                            //                             //       _alarmTimeString!,
                            //                             //       style: FontStyleUtility.h35(
                            //                             //           fontColor:
                            //                             //               ColorUtils
                            //                             //                   .primary_gold,
                            //                             //           family:
                            //                             //               'PM')),
                            //                             // ),
                            //                             Container(
                            //                               height: 150,
                            //                               decoration:
                            //                                   BoxDecoration(
                            //                                       borderRadius:
                            //                                           BorderRadius
                            //                                               .circular(
                            //                                                   15),
                            //                                       gradient: LinearGradient(
                            //                                         begin: Alignment
                            //                                             .topCenter,
                            //                                         end: Alignment
                            //                                             .bottomCenter,
                            //                                         colors: [
                            //                                           HexColor(
                            //                                                   "#000000")
                            //                                               .withOpacity(
                            //                                                   1),
                            //                                           HexColor(
                            //                                                   "#04060F")
                            //                                               .withOpacity(
                            //                                                   1),
                            //                                           HexColor(
                            //                                                   "#000000")
                            //                                               .withOpacity(
                            //                                                   1),
                            //                                         ],
                            //                                       ),
                            //                                       boxShadow: [
                            //                                     BoxShadow(
                            //                                         color: HexColor(
                            //                                             '#04060F'),
                            //                                         offset:
                            //                                             Offset(
                            //                                                 3, 3),
                            //                                         blurRadius:
                            //                                             10)
                            //                                   ]),
                            //                               child: Stack(
                            //                                 children: [
                            //                                   CupertinoTheme(
                            //                                     data:
                            //                                         CupertinoThemeData(
                            //                                       brightness:
                            //                                           Brightness
                            //                                               .dark,
                            //                                     ),
                            //                                     child:
                            //                                         CupertinoDatePicker(
                            //                                       // use24hFormat: true,
                            //                                       mode:
                            //                                           CupertinoDatePickerMode
                            //                                               .time,
                            //                                       onDateTimeChanged:
                            //                                           (DateTime
                            //                                               value) {
                            //                                         selected_time =
                            //                                             value;
                            //                                         print(
                            //                                             "${value.hour}:${value.minute}");
                            //
                            //                                         if (selected_time !=
                            //                                             null) {
                            //                                           final now =
                            //                                               DateTime
                            //                                                   .now();
                            //                                           var selectedDateTime = DateTime(
                            //                                               now
                            //                                                   .year,
                            //                                               now
                            //                                                   .month,
                            //                                               now.day,
                            //                                               selected_time
                            //                                                   .hour,
                            //                                               selected_time
                            //                                                   .minute);
                            //                                           _alarmTime =
                            //                                               selectedDateTime;
                            //                                           setModalState(
                            //                                               () {
                            //                                             _alarmTimeString = DateFormat(
                            //                                                     'HH:mm')
                            //                                                 .format(
                            //                                                     selectedDateTime);
                            //                                           });
                            //                                         }
                            //                                       },
                            //                                     ),
                            //                                   ),
                            //                                 ],
                            //                               ),
                            //                             ),
                            //
                            //                             ListTile(
                            //                               onTap: () {
                            //                                 showDialog(
                            //                                   context: context,
                            //                                   builder:
                            //                                       (BuildContext
                            //                                           context) {
                            //                                     double width =
                            //                                         MediaQuery.of(
                            //                                                 context)
                            //                                             .size
                            //                                             .width;
                            //                                     double height =
                            //                                         MediaQuery.of(
                            //                                                 context)
                            //                                             .size
                            //                                             .height;
                            //                                     return BackdropFilter(
                            //                                       filter: ImageFilter
                            //                                           .blur(
                            //                                               sigmaX:
                            //                                                   10,
                            //                                               sigmaY:
                            //                                                   10),
                            //                                       child:
                            //                                           AlertDialog(
                            //                                               backgroundColor:
                            //                                                   Colors
                            //                                                       .transparent,
                            //                                               contentPadding:
                            //                                                   EdgeInsets
                            //                                                       .zero,
                            //                                               elevation:
                            //                                                   0.0,
                            //                                               // title: Center(child: Text("Evaluation our APP")),
                            //                                               content:
                            //                                                   Column(
                            //                                                 mainAxisAlignment:
                            //                                                     MainAxisAlignment.center,
                            //                                                 children: [
                            //                                                   Stack(
                            //                                                     children: [
                            //                                                       Padding(
                            //                                                         padding: const EdgeInsets.all(8.0),
                            //                                                         child: Container(
                            //                                                           decoration:
                            //                                                               BoxDecoration(
                            //                                                                   // color: Colors.black.withOpacity(0.65),
                            //                                                                   gradient:
                            //                                                                       LinearGradient(
                            //                                                                     begin: Alignment.centerLeft,
                            //                                                                     end: Alignment.centerRight,
                            //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                            //                                                                     colors: [
                            //                                                                       HexColor("#020204").withOpacity(1),
                            //                                                                       HexColor("#36393E").withOpacity(1),
                            //                                                                     ],
                            //                                                                   ),
                            //                                                                   boxShadow: [
                            //                                                                     BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                            //                                                                   ],
                            //                                                                   borderRadius: BorderRadius.circular(15)),
                            //                                                           child: Align(
                            //                                                               alignment: Alignment.center,
                            //                                                               child: Padding(
                            //                                                                 padding: const EdgeInsets.all(8.0),
                            //                                                                 child: Column(
                            //                                                                   children: [
                            //                                                                     SizedBox(
                            //                                                                       height: 0,
                            //                                                                     ),
                            //
                            //                                                                     Column(
                            //                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                            //                                                                       children: [
                            //                                                                         Container(
                            //                                                                           margin: EdgeInsets.only(left: 18),
                            //                                                                           child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                            //                                                                         ),
                            //                                                                         SizedBox(
                            //                                                                           height: 11,
                            //                                                                         ),
                            //                                                                         Container(
                            //                                                                           margin: EdgeInsets.symmetric(horizontal: 10),
                            //                                                                           // width: 300,
                            //                                                                           decoration: BoxDecoration(
                            //                                                                               // color: Colors.black.withOpacity(0.65),
                            //                                                                               gradient: LinearGradient(
                            //                                                                                 begin: Alignment.centerLeft,
                            //                                                                                 end: Alignment.centerRight,
                            //                                                                                 // stops: [0.1, 0.5, 0.7, 0.9],
                            //                                                                                 colors: [
                            //                                                                                   HexColor("#36393E").withOpacity(1),
                            //                                                                                   HexColor("#020204").withOpacity(1),
                            //                                                                                 ],
                            //                                                                               ),
                            //                                                                               boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                            //                                                                               borderRadius: BorderRadius.circular(20)),
                            //
                            //                                                                           child: TextFormField(
                            //                                                                             maxLength: 150,
                            //                                                                             decoration: InputDecoration(
                            //                                                                               contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                            //                                                                               alignLabelWithHint: false,
                            //                                                                               isDense: true,
                            //                                                                               hintText: 'Add alarm title',
                            //                                                                               counterStyle: TextStyle(
                            //                                                                                 height: double.minPositive,
                            //                                                                               ),
                            //                                                                               counterText: "",
                            //                                                                               filled: true,
                            //                                                                               border: InputBorder.none,
                            //                                                                               enabledBorder: const OutlineInputBorder(
                            //                                                                                 borderSide: BorderSide(color: Colors.transparent, width: 1),
                            //                                                                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                            //                                                                               ),
                            //                                                                               hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                            //                                                                             ),
                            //                                                                             style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                            //                                                                             controller: Alarm_title,
                            //                                                                             keyboardType: TextInputType.text,
                            //                                                                           ),
                            //                                                                         ),
                            //                                                                       ],
                            //                                                                     ),
                            //                                                                     SizedBox(
                            //                                                                       height: 10,
                            //                                                                     ),
                            //                                                                     GestureDetector(
                            //                                                                       onTap: () {
                            //                                                                         setState(() {
                            //                                                                           Alarm_title_list.add(Alarm_title.text);
                            //                                                                           Navigator.pop(context);
                            //                                                                         });
                            //                                                                       },
                            //                                                                       child: Container(
                            //                                                                         alignment: Alignment.topRight,
                            //                                                                         child: Text(
                            //                                                                           'Add',
                            //                                                                           style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                            //                                                                         ),
                            //                                                                       ),
                            //                                                                     )
                            //                                                                     // common_button_gold(
                            //                                                                     //   onTap: () {
                            //                                                                     //     Get
                            //                                                                     //         .to(
                            //                                                                     //         DashboardScreen());
                            //                                                                     //   },
                            //                                                                     //   title_text: 'Go to Dashboard',
                            //                                                                     // ),
                            //                                                                   ],
                            //                                                                 ),
                            //                                                               )),
                            //                                                         ),
                            //                                                       ),
                            //                                                       GestureDetector(
                            //                                                         onTap: () {
                            //                                                           Navigator.pop(context);
                            //                                                         },
                            //                                                         child: Container(
                            //                                                           margin: EdgeInsets.only(right: 10),
                            //                                                           alignment: Alignment.topRight,
                            //                                                           child: Container(
                            //                                                               decoration: BoxDecoration(
                            //                                                                   // color: Colors.black.withOpacity(0.65),
                            //                                                                   gradient: LinearGradient(
                            //                                                                     begin: Alignment.centerLeft,
                            //                                                                     end: Alignment.centerRight,
                            //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                            //                                                                     colors: [
                            //                                                                       HexColor("#36393E").withOpacity(1),
                            //                                                                       HexColor("#020204").withOpacity(1),
                            //                                                                     ],
                            //                                                                   ),
                            //                                                                   boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                            //                                                                   borderRadius: BorderRadius.circular(20)),
                            //                                                               child: Padding(
                            //                                                                 padding: const EdgeInsets.all(4.0),
                            //                                                                 child: Icon(
                            //                                                                   Icons.cancel_outlined,
                            //                                                                   size: 13,
                            //                                                                   color: ColorUtils.primary_grey,
                            //                                                                 ),
                            //                                                               )),
                            //                                                         ),
                            //                                                       )
                            //                                                     ],
                            //                                                   ),
                            //                                                 ],
                            //                                               )),
                            //                                     );
                            //                                   },
                            //                                 );
                            //                               },
                            //                               title: Text('Title',
                            //                                   style: FontStyleUtility.h14(
                            //                                       fontColor:
                            //                                           ColorUtils
                            //                                               .primary_grey,
                            //                                       family: 'PR')),
                            //                               trailing: const Icon(
                            //                                   Icons
                            //                                       .arrow_forward_ios,
                            //                                   size: 15,
                            //                                   color:
                            //                                       Colors.white),
                            //                             ),
                            //                             ListTile(
                            //                               title: Text(
                            //                                 'Repeat',
                            //                                 style: FontStyleUtility.h14(
                            //                                     fontColor: ColorUtils
                            //                                         .primary_gold,
                            //                                     family: 'PR'),
                            //                               ),
                            //                               trailing: const Icon(
                            //                                 Icons
                            //                                     .arrow_forward_ios,
                            //                                 size: 15,
                            //                                 color: Colors.white,
                            //                               ),
                            //                             ),
                            //                             GestureDetector(
                            //                               onTap: () {
                            //                                 print('object');
                            //
                            //                                 showDialog(
                            //                                   context: context,
                            //                                   builder:
                            //                                       (BuildContext
                            //                                           context) {
                            //                                     double width =
                            //                                         MediaQuery.of(
                            //                                                 context)
                            //                                             .size
                            //                                             .width;
                            //                                     double height =
                            //                                         MediaQuery.of(
                            //                                                 context)
                            //                                             .size
                            //                                             .height;
                            //                                     return AlertDialog(
                            //                                         backgroundColor:
                            //                                             Colors
                            //                                                 .transparent,
                            //                                         contentPadding:
                            //                                             EdgeInsets
                            //                                                 .zero,
                            //                                         elevation:
                            //                                             0.0,
                            //                                         // title: Center(child: Text("Evaluation our APP")),
                            //                                         content:
                            //                                             Column(
                            //                                           mainAxisAlignment:
                            //                                               MainAxisAlignment
                            //                                                   .center,
                            //                                           children: [
                            //                                             Stack(
                            //                                               children: [
                            //                                                 Container(
                            //                                                   // height: 150,
                            //                                                   // height: double.maxFinite,
                            //                                                   height:
                            //                                                       MediaQuery.of(context).size.height / 4,
                            //                                                   width:
                            //                                                       double.maxFinite,
                            //                                                   decoration:
                            //                                                       BoxDecoration(
                            //                                                           // color: Colors.black.withOpacity(0.65),
                            //                                                           gradient:
                            //                                                               LinearGradient(
                            //                                                             begin: Alignment.centerLeft,
                            //                                                             end: Alignment.centerRight,
                            //                                                             // stops: [0.1, 0.5, 0.7, 0.9],
                            //                                                             colors: [
                            //                                                               HexColor("#020204").withOpacity(1),
                            //                                                               HexColor("#36393E").withOpacity(1),
                            //                                                             ],
                            //                                                           ),
                            //                                                           boxShadow: [
                            //                                                             BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                            //                                                           ],
                            //                                                           borderRadius: BorderRadius.circular(20)),
                            //                                                   margin:
                            //                                                       EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //                                                   // height: 122,
                            //                                                   // width: 133,
                            //                                                   // padding: const EdgeInsets.all(8.0),
                            //                                                   child:
                            //                                                       Column(
                            //                                                     mainAxisAlignment: MainAxisAlignment.center,
                            //                                                     children: [
                            //                                                       Container(
                            //                                                         // color: Colors.white,
                            //                                                         alignment: Alignment.center,
                            //                                                         child: ListView.builder(
                            //                                                           padding: EdgeInsets.only(bottom: 0),
                            //
                            //                                                           // physics: NeverScrollableScrollPhysics(),
                            //                                                           itemCount: list_alarm.length,
                            //                                                           shrinkWrap: true,
                            //                                                           itemBuilder: (BuildContext context, int index) {
                            //                                                             return GestureDetector(
                            //                                                               onTap: () {
                            //                                                                 setState(() {
                            //                                                                   Selected_sound = list_alarm[index];
                            //                                                                   print("method_selected $Selected_sound");
                            //                                                                 });
                            //                                                                 Navigator.pop(context);
                            //                                                               },
                            //                                                               child: Container(
                            //                                                                 margin: EdgeInsets.symmetric(vertical: 8.5),
                            //                                                                 alignment: Alignment.center,
                            //                                                                 child: Text(
                            //                                                                   list_alarm[index],
                            //                                                                   style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                            //                                                                 ),
                            //                                                               ),
                            //                                                             );
                            //                                                           },
                            //                                                         ),
                            //                                                       ),
                            //                                                     ],
                            //                                                   ),
                            //                                                 ),
                            //                                                 GestureDetector(
                            //                                                   onTap:
                            //                                                       () {
                            //                                                     Navigator.pop(context);
                            //                                                   },
                            //                                                   child:
                            //                                                       Container(
                            //                                                     margin: EdgeInsets.only(right: 0),
                            //                                                     alignment: Alignment.topRight,
                            //                                                     child: Container(
                            //                                                         decoration: BoxDecoration(
                            //                                                             // color: Colors.black.withOpacity(0.65),
                            //                                                             gradient: LinearGradient(
                            //                                                               begin: Alignment.centerLeft,
                            //                                                               end: Alignment.centerRight,
                            //                                                               // stops: [0.1, 0.5, 0.7, 0.9],
                            //                                                               colors: [
                            //                                                                 HexColor("#36393E").withOpacity(1),
                            //                                                                 HexColor("#020204").withOpacity(1),
                            //                                                               ],
                            //                                                             ),
                            //                                                             boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                            //                                                             borderRadius: BorderRadius.circular(20)),
                            //                                                         child: Padding(
                            //                                                           padding: const EdgeInsets.all(4.0),
                            //                                                           child: Icon(
                            //                                                             Icons.cancel_outlined,
                            //                                                             size: 20,
                            //                                                             color: ColorUtils.primary_grey,
                            //                                                           ),
                            //                                                         )),
                            //                                                   ),
                            //                                                 )
                            //                                               ],
                            //                                             ),
                            //                                           ],
                            //                                         ));
                            //                                   },
                            //                                 );
                            //                               },
                            //                               child: ListTile(
                            //                                 title: Text('Sound',
                            //                                     style: FontStyleUtility.h14(
                            //                                         fontColor:
                            //                                             ColorUtils
                            //                                                 .primary_gold,
                            //                                         family:
                            //                                             'PR')),
                            //                                 trailing: const Icon(
                            //                                     Icons
                            //                                         .arrow_forward_ios,
                            //                                     size: 15,
                            //                                     color:
                            //                                         Colors.white),
                            //                               ),
                            //                             ),
                            //                             GestureDetector(
                            //                               onTap: () async {
                            //                                 if (Alarm_title
                            //                                     .text.isEmpty) {
                            //                                   CommonWidget()
                            //                                       .showErrorToaster(
                            //                                           msg:
                            //                                               "Enter Alarm title");
                            //                                   return;
                            //                                 } else {
                            //                                   await onSaveAlarm();
                            //                                 }
                            //                               },
                            //                               child: Container(
                            //                                 width: MediaQuery.of(
                            //                                             context)
                            //                                         .size
                            //                                         .width /
                            //                                     3,
                            //                                 decoration: BoxDecoration(
                            //                                     borderRadius:
                            //                                         BorderRadius
                            //                                             .circular(
                            //                                                 30),
                            //                                     border: Border.all(
                            //                                         color: ColorUtils
                            //                                             .primary_grey,
                            //                                         width: 1)),
                            //                                 child: Padding(
                            //                                   padding:
                            //                                       const EdgeInsets
                            //                                               .symmetric(
                            //                                           vertical:
                            //                                               12.0,
                            //                                           horizontal:
                            //                                               8),
                            //                                   child: Row(
                            //                                     mainAxisAlignment:
                            //                                         MainAxisAlignment
                            //                                             .center,
                            //                                     children: [
                            //                                       const Icon(
                            //                                         Icons.alarm,
                            //                                         color: Colors
                            //                                             .white,
                            //                                         size: 25,
                            //                                       ),
                            //                                       const SizedBox(
                            //                                         width: 10,
                            //                                       ),
                            //                                       Text(
                            //                                         'Save',
                            //                                         style: FontStyleUtility.h16(
                            //                                             fontColor:
                            //                                                 ColorUtils
                            //                                                     .primary_gold,
                            //                                             family:
                            //                                                 'PR'),
                            //                                       ),
                            //                                     ],
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             )
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     );
                            //                   },
                            //                 );
                            //               },
                            //             );
                            //             // scheduleAlarm();
                            //           },
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //                 // color: Colors.black.withOpacity(0.65),
                            //                 gradient: LinearGradient(
                            //                   begin: Alignment.centerLeft,
                            //                   end: Alignment.centerRight,
                            //                   // stops: [0.1, 0.5, 0.7, 0.9],
                            //                   colors: [
                            //                     HexColor("#36393E")
                            //                         .withOpacity(1),
                            //                     HexColor("#020204")
                            //                         .withOpacity(1),
                            //                   ],
                            //                 ),
                            //                 boxShadow: [
                            //                   BoxShadow(
                            //                       color: HexColor('#04060F'),
                            //                       offset: const Offset(10, 10),
                            //                       blurRadius: 20)
                            //                 ],
                            //                 borderRadius:
                            //                     BorderRadius.circular(20)),
                            //             child: Padding(
                            //               padding: const EdgeInsets.all(8.0),
                            //               child: Icon(
                            //                 Icons.add_circle_outline,
                            //                 color: ColorUtils.primary_grey,
                            //               ),
                            //             ),
                            //           )),
                            //     ],
                            //   ),
                            // )
                            // else
                            //   const Center(
                            //       child: Text(
                            //     'Only 5 alarms allowed!',
                            //     style: const TextStyle(color: Colors.white),
                            //   )),
                            FutureBuilder<List<AlarmInfo>>(
                              future: _alarms,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  _currentAlarms = snapshot.data;
                                  return Container(
                                    child: ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      children:
                                          snapshot.data!.map<Widget>((alarm) {
                                        var alarmTime = DateFormat('hh:mm aa')
                                            .format(alarm.alarmDateTime!);
                                        var gradientColor = GradientTemplate
                                            .gradientTemplate[
                                                alarm.gradientColorIndex!]
                                            .colors;
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.black.withOpacity(0.65),
                                              // gradient: LinearGradient(
                                              //   begin: Alignment.centerLeft,
                                              //   end: Alignment.centerRight,
                                              //   // stops: [0.1, 0.5, 0.7, 0.9],
                                              //   colors: [
                                              //     HexColor("#020204").withOpacity(1),
                                              //     HexColor("#36393E").withOpacity(1),
                                              //   ],
                                              // ),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //       color: HexColor('#04060F'),
                                              //       offset: Offset(-10, 10),
                                              //       blurRadius: 20)
                                              // ],
                                              border: Border(
                                                bottom: BorderSide(
                                                  //                   <--- left side
                                                  color: HexColor('#1d1d1d'),
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      alarmTime,
                                                      style:
                                                          FontStyleUtility.h16(
                                                              fontColor:
                                                                  Colors.white,
                                                              family: 'PR'),
                                                    ),
                                                    subtitle: Text(alarm.title!,
                                                        style: FontStyleUtility
                                                            .h14(
                                                                fontColor:
                                                                    HexColor(
                                                                        '#8A8A8A'),
                                                                family: 'PR')),
                                                    trailing: IconButton(
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        color: ColorUtils
                                                            .primary_gold,
                                                        onPressed: () {
                                                          deleteAlarm(
                                                              alarm.id!);
                                                        }),
                                                    // Container(
                                                    //   width: 20,
                                                    //   child: Transform.scale(
                                                    //     scale: 0.5,
                                                    //     child: CupertinoSwitch(
                                                    //       onChanged: (bool value) {},
                                                    //       value: true,
                                                    //       trackColor: HexColor('#717171'),
                                                    //       thumbColor: Colors.black87,
                                                    //       activeColor:
                                                    //           ColorUtils.primary_gold,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).followedBy([]).toList(),
                                    ),
                                  );
                                }
                                return const Center(
                                  child: const Text(
                                    'Loading..',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                                  offset: const Offset(10, 10),
                                  blurRadius: 20)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8, left: 27),
                              child: Text(
                                'Kegel Info',
                                style: FontStyleUtility.h16(
                                    fontColor: HexColor('#F2F2F2'),
                                    family: 'PR'),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, left: 27),
                              child: Text(
                                'Level : $levels',
                                style: FontStyleUtility.h16(
                                    fontColor: HexColor('#F2F2F2'),
                                    family: 'PR'),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, left: 27, right: 27),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      (levels == 'Easy'
                                          ? "Each exercise has a duration of 8 seconds and stop for 2 seconds (repeating the process 8 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                          : (levels == 'Normal'
                                              ? "Each exercise has a duration of 10 seconds and stop for 2 seconds (repeating the process 10 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                              : (levels == 'Super Easy'
                                                  ? (stages == '1'
                                                      ? "Each exercise has a duration of 2 seconds and stop for 2 seconds (repeating the process 4 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                                      : (stages == '2'
                                                          ? "Each exercise has a duration of 4 seconds and stop for 2 seconds (repeating the process 6 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                                          : (stages == '3'
                                                              ? "Each exercise has a duration of 6 seconds and stop for 2 seconds (repeating the process 8 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                                              : "Each exercise has a duration of 2 seconds and stop for 2 seconds (repeating the process 4 times is considered 1 set). \nUser needs to complete 3 sets per day")))
                                                  : (levels == 'Hard'
                                                      ? "Each exercise has a duration of 12 seconds and stop for 2 seconds (repeating the process 12 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                                      : (levels == 'Infinite'
                                                          ? "Each exercise has a duration of 12 seconds and stop for 2 seconds (repeating the process 12 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                                          : "kegel info"))))),
                                      textAlign: TextAlign.justify,
                                      style: FontStyleUtility.h16(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PR'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) => AlarmPage()));
                      //   },
                      //   child: Text('alarm page'),
                      // ),

                      const SizedBox(
                        height: 50,
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

  startWatch() {
    // start_animation();
    // vibration();
    setState(() {
      startStop = false;
      started = false;
      elapsedTime = "00";
      watch.start();
      timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (levels == 'Easy ? '
              ? updateTime_Easy
              : (levels == 'Normal'
                  ? updateTime_Normal
                  : (levels == 'Super Easy'
                      ? (stages == '1'
                          ? updateTime_Super_Easy_stage1
                          : (stages == '2'
                              ? updateTime_Super_Easy_stage2
                              : (stages == '3'
                                  ? updateTime_Super_Easy_stage3
                                  : updateTime_Easy)))
                      : (levels == 'Hard'
                          ? updateTime_Hard
                          : (levels == 'Infinite'
                              ? updateTime_Hard
                              : updateTime_Easy))))));
    });
  }

  startWatch2() {
    // start_animation();
    setState(() {
      // startStop = false;
      // started = false;
      elapsedTime = "00";
      watch.start();
      timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (levels == 'Easy ? '
              ? updateTime_Easy
              : (levels == 'Normal'
                  ? updateTime_Normal
                  : (levels == 'Super Easy'
                      ? (stages == '1'
                          ? updateTime_Super_Easy_stage1
                          : (stages == '2'
                              ? updateTime_Super_Easy_stage2
                              : (stages == '3'
                                  ? updateTime_Super_Easy_stage3
                                  : updateTime_Easy)))
                      : (levels == 'Hard'
                          ? updateTime_Hard
                          : (levels == 'Infinite'
                              ? updateTime_Hard
                              : updateTime_Easy))))));
    });
  }

  final Ledger_Setup_controller _swipe_setup_controller = Get.put(
      Ledger_Setup_controller(),
      tag: Ledger_Setup_controller().toString());

  startWatch3() {
    setState(() {
      _swipe_setup_controller.k_running = true;
      startStop = false;
      started = false;
      elapsedTime2 = "00";
      elapsedTime = "00";

      watch3.start();
      timer3 = Timer.periodic(const Duration(milliseconds: 100), updateTime3);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      started = false;
      watch.stop();
      setTime();
    });
  }

  stopWatch_finish() {
    Vibration.cancel();
    setState(() {
      four_started = false;
      startStop = true;
      _animationController!.stop();
      _animationController_button!.stop();
      // started = true;
      animation_started = false;
      watch.stop();
      watch3.stop();
      setTime_finish();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
    print("elapsedTime $elapsedTime");
  }

  setTime_finish() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
    // paused_time.add(elapsedTime);
    print("elapsedTime $elapsedTime");
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    // return "$hoursStr:$minutesStr:$secondsStr";
    return secondsStr;
  }

  bool _canVibrate = true;

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
        print("has support");
        if (Platform.isAndroid) {
          // Android-specific code

          Vibration.vibrate(
              // pattern: [100, 100,100, 100,100, 100,100, 100,],
              duration: (levels == 'Easy ? '
                  ? 3000
                  : (levels == 'Normal'
                      ? 4000
                      : (levels == 'Super Easy'
                          ? (stages == '1'
                              ? 2000
                              : (stages == '2'
                                  ? 4000
                                  : (stages == '3' ? 6000 : 2000)))
                          : 3000))),
              amplitude: 50
              // intensities: [1, 255]
              );
        } else if (Platform.isIOS) {
          // iOS-specific code
          for (var i = 0;
              i <=
                  (levels == 'Easy ? '
                      ? 3
                      : (levels == 'Normal'
                          ? 4
                          : (levels == 'Super Easy'
                              ? (stages == '1'
                                  ? 2
                                  : (stages == '2'
                                      ? 4
                                      : (stages == '3' ? 6 : 2)))
                              : 3)));
              i++) {
            await Future.delayed(const Duration(seconds: 1), () {
              Vibration.vibrate();
            });
          }
        }
      } else {
        print("haddddd support");
        // Vibration.vibrate();
        // await Future.delayed(const Duration(milliseconds: 500));
        var num_;

        for (var i = 0;
            i <=
                (levels == 'Easy ? '
                    ? 7
                    : (levels == 'Normal'
                        ? 14
                        : (levels == 'Super Easy'
                            ? (stages == '1'
                                ? 6
                                : (stages == '2'
                                    ? 8
                                    : (stages == '3' ? 10 : 6)))
                            : 7)));
            i++) {
          await Future.delayed(const Duration(milliseconds: 600), () {
            Vibration.vibrate();
          });
        }
        // Vibration.vibrate();
      }
      // Vibrate.defaultVibrationDuration;
      // Vibrate.defaultVibrationDuration;
      // Vibrate.vibrateWithPauses(pauses);
    } else {
      CommonWidget().showErrorToaster(msg: 'Device Cannot vibrate');
    }
  }

  _PatternVibrate() {
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 500),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 500),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 500),
    );
    HapticFeedback.heavyImpact();
    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.heavyImpact();
  }

  List<String> list_alarm = [
    'clock_alarm_8761',
    'alarm_car_or_home_62554',
    'military_alarm_6380'
  ];
  String Selected_sound = '';

  Future<void> scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      // 'Channel for Alarm notification',
      icon: 'app_icon',
      enableVibration: true,
      fullScreenIntent: true,
      ledOffMs: 10,
      ledOnMs: 10,
      ledColor: Colors.pinkAccent,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        sound: "alarm.mp3",
        presentAlert: true,
        presentBadge: true,
        threadIdentifier: 'thread_id',
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Klench Exercise',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Klench Exercise',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: KegelRoute);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  Future<dynamic> KegelRoute(String? payload) async {
    print("inside navigationn");
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => KegelScreen()),
    // );
    Get.to(KegelScreen());
  }

  Future<dynamic> BreathingRoute(String? payload) async {
    print("indise navigationn");
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => KegelScreen()),
    // );
    Get.to(BreathingScreen());
  }

  Future<void> onSaveAlarm() async {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime!;
    } else {
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
      title: Alarm_title.text,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    await scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Alarm_title.clear();
    Navigator.pop(context);
    loadAlarms();
  }

  Future<void> click_alarm() async {
    _alarmTime = DateTime.now();
    DateTime arch = DateTime.parse("2022-08-15 00:25:24");
    print(DateFormat('EEEE').format(arch)); // Sunday

    DateTime scheduleAlarmDateTime;
    // if (_alarmTime!.isAfter(DateTime.now())) {
    scheduleAlarmDateTime = DateTime.now().add(Duration(seconds: 5));
    // } else {
    //   scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    // }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
      title: "It's Breathing time",
    );
    // _alarmHelper.insertAlarm(alarmInfo);
    await scheduleAlarm2(scheduleAlarmDateTime, alarmInfo);
    // Alarm_title.clear();
    // Navigator.pop(context);
    // loadAlarms();
  }

  Future<void> scheduleAlarm2(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      // 'Channel for Alarm notification',
      icon: 'app_icon',
      enableVibration: true,
      fullScreenIntent: true,
      ledOffMs: 10,
      ledOnMs: 10,
      ledColor: Colors.pinkAccent,
      playSound: true,
      sound: RawResourceAndroidNotificationSound("alarm"),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: "alarm.mp3",
        presentAlert: true,
        presentBadge: true,
        threadIdentifier: 'thread_id',
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Klench Exercise',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Klench Exercise',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: BreathingRoute);
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }


  AlarmPostModel? alarmPostModel;
  Future<dynamic> Alarm_post_API(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // try {
    //
    // } catch (e) {
    //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // }
    // isLoading(true);
    print("${_alarmTime!.hour}:${_alarmTime!.minute}");
    showLoader(context);
    String idUser = await PreferenceManager().getPref(URLConstants.id);

    Map data = {
      'userId': idUser,
      'alarmTime' : "${_alarmTime!.hour}:${_alarmTime!.minute}",
      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.kegel_alarm_post);
    print("url : $url");
    print("body : $data");

    var response = await http.post(
      Uri.parse(url),
      body: data,
    );
    print(response.body);
    print(response.request);
    print(response.statusCode);
    // var final_data = jsonDecode(response.body);

    // print('final data $final_data');
    if (response.statusCode == 200) {
      // isLoading(false);
      var data = jsonDecode(response.body);
      alarmPostModel = AlarmPostModel.fromJson(data);
      if (alarmPostModel!.error == false) {
        // CommonWidget().showToaster(msg: peePostModel!.message!);
        hideLoader(context);
      } else {
        hideLoader(context);
        // CommonWidget().showErrorToaster(msg: peePostModel!.message!);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }


}
