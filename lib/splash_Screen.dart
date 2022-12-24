import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/front_page/FrontpageScreen.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/UrlConstrant.dart';
import 'package:klench_/utils/colorUtils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/SignUp/local_auth_api.dart';
import 'Authentication/SingIn/SigIn_screen.dart';
import 'Authentication/SingIn/controller/SignIn_controller.dart';
import 'homepage/controller/kegel_excercise_controller.dart';
import 'homepage/swipe_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? fltNotification;

  @override
  void initState() {
    super.initState();
    initMessaging();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // navigateToLastPage();
      // Future.delayed(const Duration(seconds: 5), () {

// Here you can write your code
        init();

      // });
    });

  }

  void navigateToLastPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastRoute = prefs.getString('last_route');
    print("lastRoute - $lastRoute");
    if (lastRoute == '/warmpup' ||
        lastRoute == '/kegel' ||
        lastRoute == '/masturbation' ||
        lastRoute == '/profile' ||
        lastRoute == '/homepage' ||
        lastRoute == '/breathing' ||
        lastRoute == '/settings' ||
        lastRoute == '/pee') {
      if (lastRoute == '/warmpup') {
        final int page_no = 3;
        Get.to(SwipeScreen(
          PageNo: page_no,
        ));
      } else if (lastRoute == '/kegel') {
        final int page_no = 0;
        // Navigator.of(context).pushNamed('/kegel');
        await Get.to(SwipeScreen(
          PageNo: page_no,
        ));
      } else if (lastRoute == '/masturbation') {
        final int page_no = 1;
        Get.to(SwipeScreen(
          PageNo: page_no,
        ));
      } else if (lastRoute == '/pee') {
        final int page_no = 2;
        Get.to(SwipeScreen(
          PageNo: page_no,
        ));
      } else if (lastRoute == '/profile') {
        Get.to(DashboardScreen(page: 0));
      } else if (lastRoute == '/homepage') {
        Get.to(DashboardScreen(page: 1));
      } else if (lastRoute == '/breathing') {
        Get.to(DashboardScreen(page: 2));
      } else if (lastRoute == '/settings') {
        Get.to(DashboardScreen(page: 3));
      }
    }
    // if (lastRoute!.isNotEmpty && lastRoute != '/') {
    //   print("Data insd navigation");
    //   // Navigator.of(context).pushNamed(lastRoute);
    //   // await Get.toNamed(lastRoute);
    //   final int page_no = 0;
    //   // Navigator.of(context).pushNamed('/kegel');
    //   await Get.to(SwipeScreen(
    //     PageNo: page_no,
    //   ));
    // }
    else {
      init();
    }
  }

  final SignInScreenController _signInScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

  init() async {
    String idUser = await PreferenceManager().getPref(URLConstants.id);
    print("idUser $idUser");
    // await _signInScreenController.GetUserInfo(context);
    // if (_signInScreenController.userInfoModel!.error == true) {
    //   print("nno user founddddd");
    //   await Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (BuildContext context) => SignInScreen()));
    // }
    (idUser == 'id' || idUser.isEmpty) ? Get.to(FrontScreen()) : method();
  }

  method() async {
    bool auth =
        await PreferenceManager().getbool(URLConstants.authentication_enable);
    print(auth);

    if (auth == true) {
      final isAuthenticated = await LocalAuthApi.authenticate();

      if (isAuthenticated) {
        await _kegel_controller.alarm_notifications(context);
        await _signInScreenController.GetUserInfo(context);
        if (_signInScreenController.userInfoModel!.error == true) {
          print("nno user founddddd");
          // if(_signInScreenController.userInfoModel.data[0].freeTrial = '')
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SignInScreen()));
        } else {
          await _signInScreenController.Add_token_API(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => DashboardScreen(
                      page: 1,
                    )),
          );
        }
      } else {
        SystemNavigator.pop();
      }
    } else {
      await _kegel_controller.alarm_notifications(context);
      await _signInScreenController.GetUserInfo(context);
      if (_signInScreenController.userInfoModel!.error == true) {
        print("nno user founddddd");
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SignInScreen()));
      } else {
        await _signInScreenController.Add_token_API(context);
        await Get.to(DashboardScreen(
          page: 1,
        ));
      }
    }
  }

  void initMessaging() {
    var androiInit = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification!.initialize(initSetting);
    var androidDetails = const AndroidNotificationDetails('1', 'channelName',
        enableVibration: true, playSound: true);
    var iosDetails =
        const IOSNotificationDetails(presentSound: true, presentBadge: true,presentAlert: true);
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AppleNotification? android = message.notification?.apple;

      if (notification != null && android != null) {
        fltNotification!.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          alignment: Alignment.center,
          // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 80,
                width: 200,
                // color: ColorUtils.primary_grey,
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
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: ColorUtils.primary_gold,
                      ),
                      Container(
                        child: Text(
                          "Loading..",
                          style: FontStyleUtility.h16(
                              fontColor: ColorUtils.primary_gold, family: 'PB'),
                        ),
                      ),

                      // Container(
                      //   color: Colors.transparent,
                      //   height: 60,
                      //   width: 80,
                      //   child:
                      //   Material(
                      //     color: Colors.transparent,
                      //     child: LoadingIndicator(
                      //       backgroundColor: Colors.transparent,
                      //       indicatorType: Indicator.ballScale,
                      //       colors: _kDefaultRainbowColors,
                      //       strokeWidth: 3.0,
                      //       pathBackgroundColor: Colors.yellow,
                      //       // showPathBackground ? Colors.black45 : null,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
    ///
    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   body: Center(
    //     child: Container(
    //         margin: EdgeInsets.symmetric(horizontal: 86),
    //         child: Image.asset(AssetUtils.Logo_white_icon)),
    //   ),
    // );
  }

  final Kegel_controller _kegel_controller =
      Get.put(Kegel_controller(), tag: Kegel_controller().toString());

  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }
}
