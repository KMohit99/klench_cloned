import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/homepage/alarm_info.dart';
import 'package:klench_/homepage/controller/pee_screen_controller.dart';
import 'package:klench_/homepage/swipe_controller.dart';
import 'package:klench_/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibration/vibration.dart';

import '../Authentication/SingIn/controller/SignIn_controller.dart';
import '../Dashboard/dashboard_screen.dart';
import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';

class PeeScreen extends StatefulWidget {
  const PeeScreen({Key? key}) : super(key: key);

  @override
  State<PeeScreen> createState() => _PeeScreenState();
}

class _PeeScreenState extends State<PeeScreen> with TickerProviderStateMixin {
  final PeeScreenController _peeScreenController =
      Get.put(PeeScreenController(), tag: PeeScreenController().toString());

  List urine_test_text = [
    "Doing ok. You’re probably well hydrated. Drink water as normal.",
    "You’re just fine. You could stand to drink a little water now, maybe a small glass of water.",
    "Drink about 1⁄2 bottle of water (1/4 liter) right now, or drink a whole bottle (1/2 liter) of water if you’re outside and/or sweating.",
    "Drink about 1⁄2 bottle of water (1/4 liter) within the hour, or drink a whole bottle (1/2 liter) of water if you’re outside and/or sweating.",
    "Drink 2 bottles of water right now (1 liter). If your urine is darker than this and/or red or brown, then dehydration may not be your problem. See a doctor.",
  ];
  List urint_test_color = [
    HexColor('#EEF1AC'),
    HexColor('#E4E247'),
    HexColor('#E5DF2B'),
    HexColor('#CC9D2C'),
    HexColor('#B7752A'),
  ];

  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;
  bool started = true;

  String elapsedTime = '00';
  String? levels;
  int counter = 0;
  int sets = 0;
  bool four_started = false;

  updateTime_hard(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // if ( Vibration.hasCustomVibrationsSupport() ==true) {
          // Vibration.vibrate(duration: 1000);
          // } else {
          // Future.delayed(Duration(microseconds: 500),(){
          // HapticFeedback.heavyImpact();
          (four_started ? Vibration.cancel() : Vibration.vibrate());
          //
          // Vibration.vibrate();
          // Vibration.vibrate();
          // Vibration.vibrate();
          // });
          // }
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          if (elapsedTime == '06') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = 'PUSH';
              percent = 0.0;
              watch.reset();
              // CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              four_started = true;

              // print(counter);
              // paused_time.clear();
            });            startWatch2();
            Future.delayed(const Duration(seconds: 4), () {
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              setState(() {
                elapsedTime = '00';
                four_started = false;
                watch.reset();
              });
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              _animationController!.reverse();
              _animationController_button!.reverse();
              startWatch();
              // }
            });
          }
        });
      }
    }
  }

  updateTime_normal(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // if ( Vibration.hasCustomVibrationsSupport() ==true) {
          // Vibration.vibrate(duration: 1000);
          // } else {
          // Future.delayed(Duration(microseconds: 500),(){
          (four_started ? Vibration.cancel() : Vibration.vibrate());
          // });
          // }
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          if (elapsedTime == '05') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = 'PUSH';
              percent = 0.0;
              watch.reset();
              // CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              four_started = true;
              // print(counter);
              // paused_time.clear();
            });
            startWatch2();
            Future.delayed(const Duration(seconds: 3), () {
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              setState(() {
                elapsedTime = '00';
                four_started = false;
                watch.reset();
              });
              _animationController!.reverse();
              _animationController_button!.reverse();
              startWatch();
              // }
            });
          }
        });
      }
    }
  }

  updateTime_easy(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // Future.delayed(Duration(seconds: 1), () {
          Vibration.vibrate();
          // });

          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          if (elapsedTime == '04') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = 'PUSH';
              percent = 0.0;
              watch.reset();
              // CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              four_started = true;

              // print(counter);
              // paused_time.clear();
            });
            startWatch2();
            Future.delayed(const Duration(seconds: 4), () {
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              setState(() {
                elapsedTime = '00';
                four_started = false;
                watch.reset();
              });
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              _animationController!.reverse();
              _animationController_button!.reverse();
              startWatch();
              // }
            });
          }
        });
      }
    }
  }

  updateTime_super_easy(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // Future.delayed(Duration(microseconds: 500), () {
          Vibration.vibrate();
          // });

          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          if (elapsedTime == '03') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = 'PUSH';
              percent = 0.0;
              watch.reset();
              // CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              four_started = true;

              // print(counter);
              // paused_time.clear();
            });
            startWatch2();
            Future.delayed(const Duration(seconds: 5), () {
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              setState(() {
                elapsedTime = '00';
                four_started = false;
                watch.reset();
              });
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              _animationController!.reverse();
              _animationController_button!.reverse();
              startWatch();
              // }
            });
          }
        });
      }
    }
  }

  String? selected_date_sets = '';
  String? selected_date = '';
  double percent = 0.0;

  bool back_wallpaper = true;

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 3);

  AnimationController? _animationController;
  Animation? _animation;

  AnimationController? _animationController_button;
  Animation? _animation_button;

  // AnimationController? _animationController_textK;
  Animation? _animation_textK;

  // AnimationController? _animationController_textTime;
  Animation? _animation_textTime;

  bool animation_started = false;
  double button_height = 200;
  double text_k_size = 70;
  double text_time_size = 40;
  int _counter = 0;

  // _incrementCounter() async {
  //   for (var i = 0; i < 65; i++) {
  //     //Loop 100 times
  //     await Future.delayed(const Duration(milliseconds: 100), () {
  //       // Delay 500 milliseconds
  //       setState(() {
  //         _counter++; //Increment Counter
  //         print("Counter $_counter");
  //       });
  //     });
  //   }
  // }

  bool shadow_animation1_completed = false;
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
        Tween(begin: 70.0, end: 50.0).animate(_animationController_button!)
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

  // start_animation() {
  //   setState(() {
  //     animation_started = true;
  //     print(animation_started);
  //   });
  //   // _incrementCounter();
  //   // vibration();
  //   _animationController =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 1));
  //   _animationController!.repeat(reverse: true);
  //   _animation = Tween(begin: 0.0, end: 65.0).animate(_animationController!)
  //     ..addStatusListener((status) {
  //       if (status == AnimationStatus.completed) {}
  //       // print(_animation!.value);
  //     });
  //
  //   _animationController_button =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 5));
  //   _animationController_button!.forward();
  //   _animation_button =
  //   Tween(begin: 200.0, end: 150.0).animate(_animationController_button!)
  //     ..addStatusListener((status) {
  //       // print(status);
  //       // if (status == AnimationStatus.completed) {
  //       //   setState(() {});
  //       //   _animationController_button!.reverse();
  //       // } else if (status == AnimationStatus.dismissed) {
  //       //   setState(() {});
  //       //   _animationController_button!.forward();
  //       // }
  //     });
  //
  //   // _animationController_textK =
  //   //     AnimationController(vsync: this, duration: Duration(seconds: 5));
  //   // _animationController_textK!.forward();
  //   _animation_textK =
  //   Tween(begin: 100.0, end: 70.0).animate(_animationController_button!)
  //     ..addStatusListener((status) {
  //       // print(status);
  //       // if (status == AnimationStatus.completed) {
  //       //   setState(() {});
  //       //   _animationController_button!.reverse();
  //       // } else if (status == AnimationStatus.dismissed) {
  //       //   setState(() {});
  //       //   _animationController_button!.forward();
  //       // }
  //     });
  //
  //   // _animationController_textTime =
  //   //     AnimationController(vsync: this, duration: Duration(seconds: 5));
  //   // _animationController_textTime!.forward();
  //   _animation_textTime =
  //   Tween(begin: 40.0, end: 25.0).animate(_animationController_button!)
  //     ..addStatusListener((status) {
  //       // print(status);
  //       // if (status == AnimationStatus.completed) {
  //       //   setState(() {});
  //       //   _animationController_button!.reverse();
  //       // } else if (status == AnimationStatus.dismissed) {
  //       //   setState(() {});
  //       //   _animationController_button!.forward();
  //       // }
  //     });
  // }

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
        Tween(begin: 15.0, end: 50.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            // print(status);
            // shadow_animation1_completed = true;
          });
    _animation_middle2 =
        Tween(begin: 15.0, end: 80.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            // print(status);
            // shadow_animation1_completed = true;
          });
    _animation_middle3 =
        Tween(begin: 15.0, end: 180.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            // print(status);
            // shadow_animation1_completed = true;
          });
    _animation_middle4 =
        Tween(begin: 15.0, end: 140.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            // print(status);
            // shadow_animation1_completed = true;
          });
  }

  @override
  dispose() {
    if (animation_started == true) {
      _animationController!.dispose();
    } // y
    if (animation_started_middle == true) {
      _animationController_middle!.dispose();
    } // ou need this
    super.dispose();
  }

  @override
  void initState() {
    // get_saved_data();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      getdata();
    });
    super.initState();
  }

  final SignInScreenController _signInScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

  getdata() async {
    await _signInScreenController.GetUserInfo(context);

    // await _masturbation_screen_controller.MasturbationData_get_API(context);
    levels = await PreferenceManager().getPref(URLConstants.levels);
    print('Inside');
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _peeScreenController.Pee_get_API(context);
    });
  }

  get_saved_data() async {
    levels = await PreferenceManager().getPref(URLConstants.levels);
    print("Levels $levels");
    setState(() {});
  }

  pop() {
    print("no data found");
  }

  // Future _sendMessage() async {
  //   var func = FirebaseFunctions.instance.httpsCallable("notifySubscribers");
  //   var res = await func.call(<String, dynamic>{
  //     "targetDevices": [_msgService.token],
  //     "messageTitle": "Test title",
  //     "messageBody": ctrl.text
  //   });
  //
  //   print("message was ${res.data as bool ? "sent!" : "not sent!"}");
  // }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  DateTime? final_time;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await Datepick.showDateTimePicker(context, showTitleActions: true);
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //   }
  // }
  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  // select date time picker
  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH: ss a').format(dateTime);
    }
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);

    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      final_time = dateTime;
    });
    print(DateFormat('yyyy-MM-dd HH: mm').format(dateTime));
  }

  @override
  Widget build(BuildContext context) {
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
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AssetUtils.p_screen_back,
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
            //           : CommonWidget().showErrorToaster(msg: "Please finish the method"));
            //       },
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
            //     Textutils.pee,
            //     style: FontStyleUtility.h16(
            //         fontColor: ColorUtils.primary_grey, family: 'PM'),
            //   ),
            //   centerTitle: true,
            //   actions: [
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
                    //   Textutils.pee,
                    //   style: FontStyleUtility.h16(
                    //       fontColor: ColorUtils.primary_grey, family: 'PM'),
                    // ),
                    centerTitle: true,
                    actions: [
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.notifications_none_rounded,
                      //       color: ColorUtils.primary_gold,
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
                    children: [
                      // SizedBox(
                      //   height: (animation_started_middle ? _animation_middle!.value : 15),
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
                        endRadius: 175.0,
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
                          child:
                              // CircularPercentIndicator(
                              //   circularStrokeCap: CircularStrokeCap.round,
                              //   percent: percent / 100,
                              //   animation: true,
                              //   animateFromLastPercent: true,
                              //   radius: 61,
                              //   lineWidth: 0,
                              //   progressColor: Colors.transparent,
                              //   backgroundColor: Colors.transparent,
                              //   center:
                              Stack(
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
                                          ? HexColor('#F5C921')
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
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 6],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 340,
                              //     width: 340,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 8.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 330,
                              //     width: 330,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 7.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 320,
                              //     width: 320,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 7.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 310,
                              //     width: 310,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 8],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 300,
                              //     width: 300,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 8.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 290,
                              //     width: 290,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 9],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 280,
                              //     width: 280,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Circle,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 8.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 270,
                              //     width: 270,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 10],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 260,
                              //     width: 260,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 9.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 250,
                              //     width: 250,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 9],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 240,
                              //     width: 240,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 8.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 230,
                              //     width: 230,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 7],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 220,
                              //     width: 220,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 7.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 210,
                              //     width: 210,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 7],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 200,
                              //     width: 200,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 6.5],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 190,
                              //     width: 190,
                              //   ),
                              // )
                              //     : SizedBox.shrink()),
                              // (animation_started
                              //     ? DottedBorder(
                              //   borderType: BorderType.Oval,
                              //   strokeWidth: 3,
                              //   dashPattern: [0, 6],
                              //   strokeCap: StrokeCap.round,
                              //   radius: Radius.circular(100),
                              //   padding: EdgeInsets.all(0),
                              //   color: Colors.red,
                              //   child: Container(
                              //     height: 180,
                              //     width: 180,
                              //   ),
                              // )
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

                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  height: (animation_started
                                      ? _animation_button!.value
                                      : button_height),
                                  width: (animation_started
                                      ? _animation_button!.value
                                      : button_height),
                                  // decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     image: const DecorationImage(
                                  //         alignment: Alignment.center,
                                  //         image: const AssetImage(
                                  //             AssetUtils.home_button)),
                                  //     // boxShadow: [
                                  //     //   BoxShadow(
                                  //     //     color: (animation_started
                                  //     //         ? HexColor('#F5C921')
                                  //     //         : Colors.transparent),
                                  //     //     blurRadius: (animation_started
                                  //     //         ? _animation!.value
                                  //     //         : 0),
                                  //     //     spreadRadius: (animation_started
                                  //     //         ? _animation!.value
                                  //     //         : 0),
                                  //     //   )
                                  //     // ]
                                  // ),
                                  decoration: (animation_started
                                      ? BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Color(0xFFFCF483),
                                              width: 2.5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor(
                                                  '#F5C921'), // darker color
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
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text('Pee',
                                            style: GoogleFonts.sourceSerifPro(
                                              textStyle: TextStyle(
                                                  color: (timer_started
                                                      ? HexColor('#F5C921')
                                                          .withOpacity(0.4)
                                                      : HexColor('#F5C921')),
                                                  fontSize: (animation_started
                                                      ? _animation_textK!.value
                                                      : text_k_size),
                                                  fontWeight: FontWeight.w600),
                                            )),
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
                                                    ? elapsedTime
                                                    : ''),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: (animation_started
                                                        ? _animation_textTime!
                                                            .value
                                                        : text_time_size),
                                                    fontWeight:
                                                        FontWeight.w900),
                                              )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ),
                        ),
                        glowColor: Colors.white,
                      ),
                      // PimpedButton(
                      //   particle: DemoParticle(),
                      //   pimpedWidgetBuilder: (context, controller) {
                      //     return FloatingActionButton(onPressed: () {
                      //       controller.forward(from: 0.0);
                      //     },);
                      //   },
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

                      GestureDetector(
                        onTap: () async {
                          if (started) {
                            back_wallpaper = false;
                            startWatch();
                            middle_animation();
                          } else {
                            await stopWatch();
                            await click_alarm();
                            await Vibration.cancel();
                            _animationController_middle!.reverse();
                            // middle_animation2();
                            _animationController!.dispose();

                            _peeScreenController.sets++;
                            await _peeScreenController.Pee_post_API(context);
                            await _peeScreenController.Pee_get_API(context);

                            setState(() {
                              timer_started = false;
                              started = true;
                              num = 0;
                              elapsedTime = '00';
                              _swipe_setup_controller.p_running = false;
                              percent = 0.0;
                              back_wallpaper = true;
                              button_height = 150;
                              text_k_size = 50;
                              text_time_size = 25;
                              watch.reset();
                              // paused_time.clear();
                            });
                            // print('method_time : ${method_time[0].total_time}');
                            // print('method_name : ${method_time[0].method_name}');
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
                                // stops: [0` .1, 0.5, 0.7, 0.9],
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
                      // ElevatedButton(
                      //   child: Text("Change Date"),
                      //   onPressed: () {
                      //     _selectDateTime(context);
                      //     },
                      // ),
                      //
                      // Container(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Duration offset = final_time!.timeZoneOffset;
                      //
                      //       // ----------
                      //       String dateTime = final_time!.toIso8601String();
                      //       // - or -
                      //       // String dateTime = intl.DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(now);
                      //       // ----------
                      //       String utcHourOffset = (offset.isNegative ? '-' : '+') +
                      //           offset.inHours.abs().toString().padLeft(2, '0');
                      //       String utcMinuteOffset = (offset.inMinutes - offset.inHours * 60)
                      //           .toString().padLeft(2, '0');
                      //
                      //       String dateTimeWithOffset = '$dateTime$utcHourOffset:$utcMinuteOffset';
                      //       print(dateTimeWithOffset);
                      //
                      //       Database().createNotification(whenToNotify: dateTimeWithOffset);
                      //     },
                      //     child: Text('Notification button'),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 28,
                      ),
                      Obx(() => _peeScreenController.isLoading.value == false
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
                                  // initialCalendarFormat: CalendarFormat.week,
                                  availableGestures: AvailableGestures.none,
                                  calendarStyle: CalendarStyle(
                                    defaultTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    todayTextStyle: const TextStyle(
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
                                        // fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        fontFamily: 'PM',
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
                                          fontSize: 14.0,
                                          color: Colors.white),
                                      weekendStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
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

                                  calendarBuilders: CalendarBuilders(
                                    markerBuilder:
                                        (BuildContext context, date, events) {
                                      for (var i = 0;
                                          i <
                                              _peeScreenController
                                                  .peeGetModel!.data!.length;
                                          i++) {
                                        if (DateFormat('yyyy-MM-dd')
                                                .format(date) ==
                                            _peeScreenController.peeGetModel!
                                                .data![i].createdDate) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selected_date_sets =
                                                    _peeScreenController
                                                        .peeGetModel!
                                                        .data![i]
                                                        .sets!;
                                                selected_date =
                                                    _peeScreenController
                                                        .peeGetModel!
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
                                                    EdgeInsets.only(bottom: 5),
                                                // margin: EdgeInsets.only(bottom: 7),
                                                // decoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(100),
                                                //   border: Border.all(
                                                //       color:
                                                //           ColorUtils.primary_gold,
                                                //       width: 2),
                                                // ),
                                                child: Image.asset(
                                                  "assets/images/white-star (1).png",
                                                  color: ColorUtils.primary_gold
                                                      .withOpacity(0.8),
                                                  height: 40,
                                                )),
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
                          : Container(
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
                                  // initialCalendarFormat: CalendarFormat.week,
                                  calendarStyle: CalendarStyle(
                                    defaultTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        color: Colors.white),
                                    todayTextStyle: const TextStyle(
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
                                        // fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        fontFamily: 'PM',
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
                                          fontSize: 14.0,
                                          color: Colors.white),
                                      weekendStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
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

                                  // calendarBuilders: CalendarBuilders(
                                  //   markerBuilder:
                                  //       (BuildContext context, date, events) {
                                  //     for (var i = 0;
                                  //     i <
                                  //         _peeScreenController
                                  //             .peeGetModel!.data!.length;
                                  //     i++) {
                                  //       if (DateFormat('yyyy-MM-dd')
                                  //           .format(date) ==
                                  //           _peeScreenController.peeGetModel!
                                  //               .data![i].createdDate) {
                                  //         return GestureDetector(
                                  //           onTap: () {
                                  //             setState(() {
                                  //               selected_date_sets =
                                  //               _peeScreenController
                                  //                   .peeGetModel!
                                  //                   .data![i]
                                  //                   .sets!;
                                  //               selected_date =
                                  //               _peeScreenController
                                  //                   .peeGetModel!
                                  //                   .data![i]
                                  //                   .createdDate!;
                                  //             });
                                  //             print(selected_date_sets);
                                  //             print(selected_date);
                                  //           },
                                  //           child: Container(
                                  //             // color: Colors.white60,
                                  //               alignment: Alignment.center,
                                  //               padding:
                                  //               EdgeInsets.only(bottom: 5),
                                  //               // margin: EdgeInsets.only(bottom: 7),
                                  //               // decoration: BoxDecoration(
                                  //               //   borderRadius:
                                  //               //       BorderRadius.circular(100),
                                  //               //   border: Border.all(
                                  //               //       color:
                                  //               //           ColorUtils.primary_gold,
                                  //               //       width: 2),
                                  //               // ),
                                  //               child: Image.asset(
                                  //                 "assets/images/white-star (1).png",
                                  //                 color: ColorUtils.primary_gold
                                  //                     .withOpacity(0.8),
                                  //                 height: 40,
                                  //               )),
                                  //         );
                                  //       }
                                  //     }
                                  //
                                  //     // return ListView.builder(
                                  //     //     shrinkWrap: true,
                                  //     //     scrollDirection: Axis.horizontal,
                                  //     //     itemCount: events.length,
                                  //     //     itemBuilder: (context, index) {
                                  //     //       return Container(
                                  //     //         margin: const EdgeInsets.only(top: 20),
                                  //     //         padding: const EdgeInsets.all(1),
                                  //     //         child: Container(
                                  //     //           // height: 7,
                                  //     //           width: 5,
                                  //     //           decoration: BoxDecoration(
                                  //     //               shape: BoxShape.circle,
                                  //     //               color: Colors.primaries[Random()
                                  //     //                   .nextInt(Colors.primaries.length)]),
                                  //     //         ),
                                  //     //       );
                                  //     //     });
                                  //   },
                                  // ),

                                  calendarFormat: CalendarFormat.month,
                                  // calendarController: _controller,
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: DateTime.now(),
                                ),
                              ),
                            )),
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
                                  'User peed ${selected_date_sets} time on ${selected_date}',
                                  style: FontStyleUtility.h16(
                                      fontColor: HexColor('#FFFFFF'),
                                      family: 'PM'),
                                ),
                              ),
                            )),
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   padding: EdgeInsets.all(20.0),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text(elapsedTime, style: TextStyle(fontSize: 25.0,color: Colors.white)),
                      //       SizedBox(height: 20.0),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: <Widget>[
                      //           FloatingActionButton(
                      //               heroTag: "btn1",
                      //               backgroundColor: Colors.red,
                      //               onPressed: () => startOrStop(),
                      //               child: Icon(Icons.pause)),
                      //           SizedBox(width: 20.0),
                      //           FloatingActionButton(
                      //               heroTag: "btn2",
                      //               backgroundColor: Colors.green,
                      //               onPressed: null, //resetWatch,
                      //               child: Icon(Icons.check)),
                      //         ],
                      //       )
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8, left: 27),
                              child: Text(
                                'Pee Info',
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
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, left: 27, right: 27),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      (levels == 'Easy'
                                          ? "The device will vibrate for 3 seconds and stop for 4 seconds, \ncontinuing the same process until the user presses the finish button."
                                          : (levels == 'Normal'
                                              ? "The device will vibrate for 4 seconds and stop for 3 seconds, \ncontinuing the same process until the user presses the finish button."
                                              : (levels == 'Super Easy'
                                                  ? "The device will vibrate for 2 seconds and stop for 5 seconds, \ncontinuing the same process until the user presses the finish button."
                                                  : (levels == 'Hard'
                                                      ? "The device will vibrate for 5 seconds and stop for 2 seconds, \ncontinuing the same process until the user presses the finish button."
                                                      : (levels == 'Infinite'
                                                          ? "The device will vibrate for 5 seconds and stop for 2 seconds, \ncontinuing the same process until the user presses the finish button."
                                                          : "Pee info"))))),
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
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 15, left: 15, top: 15, bottom: 20),
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
                                        offset: const Offset(10, 10),
                                        blurRadius: 20)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 24, top: 14),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Dehydration urine color chart',
                                      style: FontStyleUtility.h16(
                                          fontColor: HexColor('#DFDFDF'),
                                          family: 'PR'),
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                          top: 25, bottom: 15),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: urint_test_color.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.black.withOpacity(0.65),
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                // stops: [0.1, 0.5, 0.7, 0.9],
                                                colors: [
                                                  HexColor("#020204")
                                                      .withOpacity(1),
                                                  HexColor("#36393E")
                                                      .withOpacity(1),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: HexColor('#04060F'),
                                                    offset:
                                                        const Offset(10, 10),
                                                    blurRadius: 20)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 76,
                                                  decoration: BoxDecoration(
                                                      color: urint_test_color[
                                                          index],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                const SizedBox(
                                                  width: 9,
                                                ),
                                                Container(
                                                  child: Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 5),
                                                      child: Text(
                                                        urine_test_text[index],
                                                        maxLines: 3,
                                                        textAlign:
                                                            TextAlign.left,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: FontStyleUtility
                                                            .h13(
                                                                fontColor:
                                                                    Colors
                                                                        .white,
                                                                family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 15, left: 15, top: 15, bottom: 20),
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
                                        offset: const Offset(10, 10),
                                        blurRadius: 20)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 24, top: 14),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Results',
                                      style: FontStyleUtility.h16(
                                          fontColor: HexColor('#DFDFDF'),
                                          family: 'PR'),
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                          top: 25, bottom: 15),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: urint_test_color.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.black.withOpacity(0.65),
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                // stops: [0.1, 0.5, 0.7, 0.9],
                                                colors: [
                                                  HexColor("#020204")
                                                      .withOpacity(1),
                                                  HexColor("#36393E")
                                                      .withOpacity(1),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: HexColor('#04060F'),
                                                    offset:
                                                        const Offset(10, 10),
                                                    blurRadius: 20)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 76,
                                                  decoration: BoxDecoration(
                                                      color: urint_test_color[
                                                          index],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                ),
                                                const SizedBox(
                                                  width: 9,
                                                ),
                                                Container(
                                                  child: Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 5),
                                                      child: Text(
                                                        urine_test_text[index],
                                                        maxLines: 3,
                                                        textAlign:
                                                            TextAlign.left,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: FontStyleUtility
                                                            .h13(
                                                                fontColor:
                                                                    Colors
                                                                        .white,
                                                                family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ))
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

  final Ledger_Setup_controller _swipe_setup_controller = Get.put(
      Ledger_Setup_controller(),
      tag: Ledger_Setup_controller().toString());
  bool timer_started = false;

  startWatch() {
    start_animation();
    // vibration();
    setState(() {
      timer_started = true;

      num = 7;
      _swipe_setup_controller.p_running = true;
      elapsedTime = "00";
      startStop = false;
      started = false;
      watch.start();
      timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (levels == 'Easy ?'
              ? updateTime_easy
              : (levels == 'Normal'
                  ? updateTime_normal
                  : (levels == 'Super Easy'
                      ? updateTime_super_easy
                      : (levels == 'Hard'
                          ? updateTime_hard
                          : (levels == 'Infinite'
                              ? updateTime_hard
                              : updateTime_easy))))));
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
          (levels == 'Easy ?'
              ? updateTime_easy
              : (levels == 'Normal'
                  ? updateTime_normal
                  : (levels == 'Super Easy'
                      ? updateTime_super_easy
                      : (levels == 'Hard'
                          ? updateTime_hard
                          : (levels == 'Infinite'
                              ? updateTime_hard
                              : updateTime_easy))))));
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      // started = true;
      animation_started = false;
      watch.stop();
      setTime_finish();
    });
    Fluttertoast.showToast(
      msg: "Plese review Performance",
      textColor: Colors.white,
      backgroundColor: Colors.black87,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  stopWatch_finish() {
    setState(() {
      startStop = true;
      // started = true;
      animation_started = false;
      watch.stop();
      setTime_finish();
    });
    Fluttertoast.showToast(
      msg: "Plese review Performance",
      textColor: Colors.white,
      backgroundColor: Colors.black87,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
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

  var num;

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
              duration: (levels == 'Easy'
                  ? 3000
                  : (levels == 'Normal'
                      ? 4000
                      : (levels == 'Super Easy' ? 2000 : 3000))),
              amplitude: 50
              // intensities: [1, 255]
              );
        } else if (Platform.isIOS) {
          // iOS-specific code
          for (var i = 0;
              i <=
                  (levels == 'Easy'
                      ? 5
                      : (levels == 'Normal'
                          ? 6
                          : (levels == 'Super Easy' ? 4 : 5)));
              i++) {
            await Future.delayed(const Duration(milliseconds: 600), () {
              Vibration.vibrate();
            });
          }
        }
      } else {
        print("haddddd support");
        Vibration.vibrate();
        // await Future.delayed(const Duration(milliseconds: 500));
        var num_;

        for (var i = 0;
            i <=
                (levels == 'Easy'
                    ? 5
                    : (levels == 'Normal'
                        ? 6
                        : (levels == 'Super Easy' ? 4 : 5)));
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

    return secondsStr;
  }

  DateTime? _alarmTime;

  Future<void> click_alarm() async {
    _alarmTime = DateTime.now();
    DateTime arch = DateTime.parse("2022-08-15 00:25:24");
    print(DateFormat('EEEE').format(arch)); // Sunday

    DateTime scheduleAlarmDateTime;
    // if (_alarmTime!.isAfter(DateTime.now())) {
    scheduleAlarmDateTime = DateTime.now().add(Duration(seconds: 3));
    // } else {
    //   scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    // }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: 1,
      title: "Would you like to do breathing exercises ?",
    );
    // _alarmHelper.insertAlarm(alarmInfo);
    await scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    // Alarm_title.clear();
    // Navigator.pop(context);
    // loadAlarms();
  }

  Future<void> scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      // 'Channel for Alarm notification',
      icon: 'app_icon',
      enableVibration: true,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound("alarm"),
      largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        // sound: "alarm.mp3",
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
    print("indise navigationn");
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => KegelScreen()),
    // );
    // Get.to(h)
    Get.to(DashboardScreen(page: 2));
    // Get.to(const BreathingScreen());
  }
}
