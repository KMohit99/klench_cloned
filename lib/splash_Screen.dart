import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/front_page/FrontpageScreen.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/UrlConstrant.dart';
import 'package:klench_/utils/colorUtils.dart';
import 'package:local_auth/local_auth.dart';

import 'Authentication/SignUp/local_auth_api.dart';
import 'Authentication/SingIn/SigIn_screen.dart';
import 'Authentication/SingIn/controller/SignIn_controller.dart';
import 'getx_pagination/binding_utils.dart';
import 'homepage/alarm_info.dart';
import 'homepage/controller/kegel_excercise_controller.dart';
import 'homepage/kegel_screen.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () {
      // Get.to(FrontScreen());
      init();
    // FlutterNativeSplash.remove();

    });
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
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SignInScreen()));
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashboardScreen(page: 1,)),
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
        await Get.to(DashboardScreen(page: 1,));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:Column(
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
                      child: Text("Loading..", style: FontStyleUtility.h16(
                          fontColor: ColorUtils.primary_gold, family: 'PB'),),
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
        ),
      ),
    );
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
