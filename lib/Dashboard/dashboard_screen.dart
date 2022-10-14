import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/homepage/homepage_screen.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';

import '../Authentication/SignUp/local_auth_api.dart';
import '../Authentication/SingIn/SigIn_screen.dart';
import '../Authentication/SingIn/controller/SignIn_controller.dart';
import '../front_page/FrontpageScreen.dart';
import '../homepage/Breathing_screen.dart';
import '../homepage/controller/kegel_excercise_controller.dart';
import '../homepage/swipe_screen.dart';
import '../profile_page/profilePage_screen.dart';
import '../setting_page/setting_screen.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';

class DashboardScreen extends StatefulWidget {
   int page;
   DashboardScreen({Key? key, required this.page,}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late double screenHeight, screenWidth;
  // int _page = 1;

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    )) ??
        false;
  }

  Widget? get getPage {
    if (widget.page == 0) {
      return const ProfilePageScreen();
    } else if (widget.page== 1) {
      return const HomepageScreen();
      // return const SwipeScreen();
    } else if (widget.page == 2) {
      return const BreathingScreen();
    } else if (widget.page == 3) {
      return const SettingScreen();
    }
  }

  GlobalKey<ScaffoldState>? _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      // Add Your Code here.
      // init();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      key: _globalKey,
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        shape: CircularNotchedRectangle(),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 19),
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
                    blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(20)),
          // color: Colors.black,
          height: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: EdgeInsets.only(top: 0.5, right: 25, left: 25),
              //   height: 1,
              //   color: ColorUtils.dark_grey.withOpacity(0.5),
              // ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                              offset: Offset(3, 3),
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          IconButton(
                            iconSize: 30.0,
                            visualDensity:
                            VisualDensity(vertical: -4, horizontal: -4),
                            padding: EdgeInsets.only(left: 0.0),
                            icon: Image.asset(AssetUtils.profile_icon,
                                color: (widget.page == 0
                                    ? ColorUtils.primary_gold
                                    : ColorUtils.primary_grey),
                                height: 20, width: 20),
                            onPressed: () {
                              setState(() {
                                widget.page = 0;
                                // _myPage.jumpToPage(2);
                              });
                            },
                          ),

                        ],
                      ),
                    ),
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
                              offset: Offset(3, 3),
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          IconButton(
                            iconSize: 30.0,
                            visualDensity:
                            VisualDensity(vertical: -4, horizontal: -4),
                            padding: EdgeInsets.only(left: 0.0),
                            icon: Image.asset(AssetUtils.home_icon,
                                color: (widget.page == 1
                                    ? ColorUtils.primary_gold
                                    : ColorUtils.primary_grey),
                                height: 20, width: 20),
                            onPressed: () {
                              setState(() {
                                widget.page = 1;
                                // _myPage.jumpToPage(2);
                              });
                            },
                          ),
                          // Text(
                          //   'Home',
                          //   style: FontStyleUtility.h10(
                          //       fontColor: (_page == 1
                          //           ? ColorUtils.primary_gold
                          //           : ColorUtils.primary_grey),family: 'PM'),
                          // )
                        ],
                      ),
                    ),
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
                              offset: Offset(3, 3),
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          IconButton(
                            iconSize: 30.0,
                            visualDensity:
                            VisualDensity(vertical: -4, horizontal: -4),
                            padding: EdgeInsets.only(left: 0.0),
                            icon: Image.asset(AssetUtils.breathe_icon,
                                color: (widget.page == 2
                                    ? ColorUtils.primary_gold
                                    : ColorUtils.primary_grey),
                                height: 20, width: 20),
                            onPressed: () {
                              setState(() {
                                widget.page = 2;
                                // _myPage.jumpToPage(2);
                              });
                            },
                          ),
                          // Text(
                          //   'Breathing',
                          //   style: FontStyleUtility.h10(
                          //       fontColor: (_page == 2
                          //           ? ColorUtils.primary_gold
                          //           : ColorUtils.primary_grey) , family: 'PM'),
                          // )
                        ],
                      ),
                    ),
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
                              offset: Offset(3, 3),
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          IconButton(
                            iconSize: 30.0,
                            visualDensity:
                            VisualDensity(vertical: -4, horizontal: -4),
                            padding: EdgeInsets.only(left: 0.0),
                            icon: Image.asset(AssetUtils.settings_icon,
                                color: (widget.page == 3
                                    ? ColorUtils.primary_gold
                                    : ColorUtils.primary_grey),
                                height: 20, width: 20),
                            onPressed: () {
                              setState(() {
                                widget.page = 3;
                                // _myPage.jumpToPage(2);
                              });
                            },
                          ),
                          // Text(
                          //   'Settings',
                          //   style: FontStyleUtility.h10(
                          //       fontColor: (_page == 3
                          //           ? ColorUtils.primary_gold
                          //           : ColorUtils.primary_grey), family: 'PM'),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.only(bottom: 5, right: 25, left: 25),
              //   height: 1,
              //   color: ColorUtils.dark_grey.withOpacity(0.5),
              // ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: [
              Expanded(
                child: getPage!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
