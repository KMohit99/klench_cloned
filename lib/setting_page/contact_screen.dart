import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Authentication/SingIn/controller/SignIn_controller.dart';
import '../Dashboard/dashboard_screen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';
import 'contact_screen_controller.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ConactScreenController _conactScreenController = Get.put(
      ConactScreenController(),
      tag: ConactScreenController().toString());

  final SignInScreenController _signInScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
    super.initState();
  }

  init() async {
    await _signInScreenController.GetUserInfo(context);
    if (_signInScreenController.userInfoModel!.error == false) {
      setState(() {
        _conactScreenController.usernameController.text =
            _signInScreenController.userInfoModel!.data![0].username!;
        _conactScreenController.emailController.text =
            _signInScreenController.userInfoModel!.data![0].email!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
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
            "Contact us",
            style: FontStyleUtility.h16(
                fontColor: ColorUtils.primary_grey, family: 'PM'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      HexColor("#36393E").withOpacity(1),
                      HexColor("#020204").withOpacity(1),
                    ],
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: HexColor('#2A2A29'),
                  //     offset: Offset(10, 10),
                  //     blurRadius: 20,
                  //   ),
                  // ],
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.only(bottom: 20, right: 8, left: 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 14, left: 14),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(AssetUtils.user_icon3),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: 14, left: 14, top: 20, bottom: 20),
                      child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
                        textAlign: TextAlign.justify,
                        style: FontStyleUtility.h14(
                            fontColor: Colors.white, family: 'PR'),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
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
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(bottom: 20, right: 8, left: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 22),
                        child: Column(
                          children: [
                            Container(
                              child: CommonTextFormField_text(
                                title: 'Username',
                                labelText: 'Enter Username',
                                controller:
                                    _conactScreenController.usernameController,
                                iconData: IconButton(
                                  visualDensity:
                                      VisualDensity(horizontal: -4, vertical: -4),
                                  icon: Icon(
                                    Icons.person_outline,
                                    size: 20,
                                    color: ColorUtils.primary_grey,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: CommonTextFormField_text(
                                title: 'Email',
                                labelText: 'Enter Email',
                                controller:
                                    _conactScreenController.emailController,
                                iconData: IconButton(
                                  visualDensity:
                                      VisualDensity(horizontal: -4, vertical: -4),
                                  icon: Image.asset(
                                    AssetUtils.message_icons,
                                    height: 17,
                                    width: 15,
                                    color: ColorUtils.primary_grey,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Container(
                            //   child: CommonTextFormField_text(
                            //     title: 'Reason',
                            //     labelText: 'Enter Details',
                            //     maxLines: 5,
                            //     iconData: IconButton(
                            //
                            //       icon: Icon(
                            //         Icons.face_unlock_sharp,
                            //         size: 20,
                            //         color: ColorUtils.primary_gold,
                            //       ),
                            //       onPressed: () {},
                            //     ),
                            //   ),
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 18),
                                  child: Text('Reason',
                                      style: FontStyleUtility.h15(
                                          fontColor: HexColor('#9F9F9F'),
                                          family: 'PM')),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  // width: 300,
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
                                  child: TextFormField(
                                    maxLength: 150,
                                    maxLines: 5,
                                    controller:
                                        _conactScreenController.reasonsController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 20, top: 14, bottom: 14),
                                      alignLabelWithHint: false,
                                      isDense: true,
                                      hintText: 'Enter Details',
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent, width: 1),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      hintStyle: FontStyleUtility.h15(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PM'),
                                    ),
                                    style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.primary_gold,
                                        family: 'PM'),
                                    // controller: controller,
                                    // keyboardType: keyboardType ?? TextInputType.multiline,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 10, left: 22, right: 22),
                        child: common_button_gold(
                          onTap: () async {
                           await _conactScreenController.ContactUsPostApi(context: context);
                            if(_conactScreenController.contactPostModel!.error== false){
                              selectTowerBottomSheet(context);

                            }
                            // Get.to(DashboardScreen());
                          },
                          title_text: 'Submit',
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  selectTowerBottomSheet(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
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
                            'You have successfully submitted your enquiry',
                            style: FontStyleUtility.h15(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR')),
                      ),
                      common_button_gold(
                        onTap: () {
                          Get.to(DashboardScreen(page: 1,));
                        },
                        title_text: 'Go to Dashboard',
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
