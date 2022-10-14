import 'dart:io';
import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../Authentication/SingIn/controller/SignIn_controller.dart';
import '../front_page/FrontpageScreen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_container_color.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';
import 'controller/profile_page_controller.dart';
import 'model/userInfoModel.dart';

import 'package:http/http.dart' as http;
import 'package:klench_/utils/page_loader.dart';
import 'dart:convert' as convert;

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  int infin = 0x221E;

  List difficulty = ['Super Easy', 'Easy', 'Normal', 'Hard', 'ထ'];
  List<String> gender_list = <String>['Male', 'Female', 'Prefer not say'];
  String? selected_gender;

  DateTime selectedDate = DateTime.now();
  String showInvoiceDate = '';

  selectDoB(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: ColorUtils.primary_grey,
              // onPrimary: Colors.black, // <-- SEE HERE
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: ColorUtils.primary_gold,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        showInvoiceDate = DateFormat('MM-dd-yyyy').format(selected).toString();
        _profile_page_controller.dateOfbirthController.text =
            showInvoiceDate.toString();
      });
    }
  }

  select_gender(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              elevation: 0.0,
              // title: Center(child: Text("Evaluation our APP")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 180,
                            width: 220,
                            decoration: BoxDecoration(
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            // height: 122,
                            // width: 133,
                            // padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Selece Gender",
                                      style: FontStyleUtility.h15(
                                          fontColor: Colors.white,
                                          family: 'PM'),
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 0),
                                      itemCount: gender_list.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selected_gender =
                                                  gender_list[index];
                                              _profile_page_controller
                                                  .genderController
                                                  .text = selected_gender!;
                                              print(
                                                  "method_selected $selected_gender");
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.5),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  gender_list[index],
                                                  style: FontStyleUtility.h15(
                                                      fontColor: ColorUtils
                                                          .primary_grey,
                                                      family: 'PM'),
                                                ),
                                              ),
                                              Radio(
                                                visualDensity: VisualDensity(
                                                    vertical: -4,
                                                    horizontal: -4),
                                                value: gender_list[index],
                                                groupValue: selected_gender,
                                                activeColor:
                                                    ColorUtils.primary_gold,
                                                onChanged: (val) {
                                                  print("Radio $val");
                                                  setState(() {
                                                    selected_gender =
                                                        val as String?;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          alignment: Alignment.topRight,
                          child: Container(
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
                                        offset: Offset(0, 3),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 13,
                                  color: ColorUtils.primary_grey,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  final Profile_page_controller _profile_page_controller = Get.put(
      Profile_page_controller(),
      tag: Profile_page_controller().toString());

  final SignInScreenController _signInScreenController = Get.put(
      SignInScreenController(),
      tag: SignInScreenController().toString());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      init();
    });
    super.initState();
  }


  init() async {
    await _signInScreenController.GetUserInfo(context);
    // print("LEvelsssssssssssssssss $levels");
    if (_signInScreenController.userInfoModel!.error == true) {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => SignInScreen()));
    } else {
      _profile_page_controller.selected_difficulty =
          _signInScreenController.userInfoModel!.data![0].levels!;
      print(
          "_profile_page_controller.selected_difficulty ${_profile_page_controller.selected_difficulty}");
    }
    bool auth =
        await PreferenceManager().getbool(URLConstants.authentication_enable);
    print(auth);
  }

  List<Color> _kDefaultRainbowColors = [ColorUtils.primary_gold];
  bool editable = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.center,
        child: Obx(() => (_signInScreenController.isuserinfoLoading.value ==
                true
            ? GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Profile',
                    // _signInScreenController
                    //     .userInfoModel!.data![0].username!,
                    style: FontStyleUtility.h16(
                        fontColor: ColorUtils.primary_gold, family: 'PM'),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
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
                  margin: EdgeInsets.only(top: 0, right: 8, left: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 13),
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   editable =
                                      //   (editable ? false : true);
                                      // });
                                    },
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          gradient: LinearGradient(
                                            colors: [
                                              HexColor('#36393E'),
                                              HexColor('#020204'),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: HexColor('#04060F'),
                                                offset: Offset(10, 10),
                                                blurRadius: 20)
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 9.0, horizontal: 18),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            _signInScreenController
                                                .userInfoModel!
                                                .data![0]
                                                .username!,
                                            overflow: TextOverflow.ellipsis,
                                            style: FontStyleUtility.h12(
                                                fontColor:
                                                ColorUtils.primary_gold,
                                                family: 'PM'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.white60,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(50),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: ColorUtils
                                                      .light_black,
                                                  offset: Offset(5, 5),
                                                  blurRadius: 6)
                                            ]),
                                        child: (_signInScreenController
                                            .userInfoModel!
                                            .data![0]
                                            .image!
                                            .isEmpty
                                            ? Image.asset(
                                          AssetUtils.user_icon45,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        )
                                            : (_profile_page_controller
                                            .imgFile ==
                                            null
                                            ?
                                        // Image.network(
                                        //             'https://foxyserver.com/klench/images/${_signInScreenController.userInfoModel!.data![0].image}',
                                        //             fit: BoxFit.fill,
                                        //             height: 100,
                                        //             width: 100,
                                        //           )
                                        Container(
                                          color: Colors.black,
                                          child: FadeInImage(
                                            image: NetworkImage(
                                                "http://foxyserver.com/klench/images/${_signInScreenController.userInfoModel!.data![0].image}"),
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 100,
                                            placeholder:
                                            AssetImage(
                                              AssetUtils
                                                  .user_icon45,
                                            ),
                                            imageErrorBuilder:
                                                (context, error,
                                                stackTrace) {
                                              print(error);
                                              return Image.asset(
                                                AssetUtils
                                                    .user_icon45,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                              );
                                            },
                                          ),
                                        )
                                            : Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.file(
                                            _profile_page_controller
                                                .imgFile!,
                                            fit: BoxFit.cover,
                                          ),
                                        ))),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 2,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          (editable
                                              ? null
                                              : showDialog(
                                              context: context,
                                              builder:
                                                  (ctx) => AlertDialog(
                                                title: Text(
                                                    "Pick Image from"),
                                                actions: <
                                                    Widget>[
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom:
                                                          10),
                                                      child:
                                                      GestureDetector(
                                                        onTap:
                                                            () {
                                                          Navigator.pop(
                                                              context);
                                                          openCamera();
                                                        },
                                                        child:
                                                        Container(
                                                          margin:
                                                          const EdgeInsets.symmetric(horizontal: 30),
                                                          // height: 45,
                                                          // width:(width ?? 300) ,
                                                          decoration: BoxDecoration(
                                                              color: Colors.black,
                                                              borderRadius: BorderRadius.circular(25)),
                                                          child: Container(
                                                              alignment: Alignment.center,
                                                              margin: EdgeInsets.symmetric(
                                                                vertical: 12,
                                                              ),
                                                              child: Text(
                                                                'Camera',
                                                                style: TextStyle(color: Colors.white, fontFamily: 'PR', fontSize: 16),
                                                              )),
                                                        ),
                                                      )),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom:
                                                          10),
                                                      child:
                                                      GestureDetector(
                                                        onTap:
                                                            () {
                                                          Navigator.pop(
                                                              context);

                                                          openGallery();
                                                        },
                                                        child:
                                                        Container(
                                                          margin:
                                                          const EdgeInsets.symmetric(horizontal: 30),
                                                          // height: 45,
                                                          // width:(width ?? 300) ,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.black, width: 1),
                                                              borderRadius: BorderRadius.circular(25)),
                                                          child: Container(
                                                              alignment: Alignment.center,
                                                              margin: EdgeInsets.symmetric(
                                                                vertical: 12,
                                                              ),
                                                              child: Text(
                                                                'Gallery',
                                                                style: TextStyle(color: Colors.black, fontFamily: 'PR', fontSize: 16),
                                                              )),
                                                        ),
                                                      )),
                                                ],
                                              )));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(50),
                                            gradient: LinearGradient(
                                              colors: [
                                                HexColor('#36393E'),
                                                HexColor('#020204'),
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.camera_alt,
                                              color:
                                              ColorUtils.primary_gold,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        editable =
                                        (editable ? false : true);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          gradient: LinearGradient(
                                            colors: [
                                              HexColor('#36393E'),
                                              HexColor('#020204'),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          border: (editable
                                              ? Border.all(
                                              color: Colors.transparent,
                                              width: 0)
                                              : Border.all(
                                              color: ColorUtils
                                                  .primary_gold,
                                              width: 1)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: HexColor('#04060F'),
                                                offset: Offset(10, 10),
                                                blurRadius: 20)
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 9.0, horizontal: 18),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(
                                                'Edit',
                                                style: FontStyleUtility.h12(
                                                    fontColor: ColorUtils
                                                        .primary_gold,
                                                    family: 'PM'),
                                              ),
                                            ),
                                            Container(
                                              child: Icon(
                                                Icons.edit,
                                                size: 16,
                                                color:
                                                ColorUtils.primary_gold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  HexColor("#36393E").withOpacity(1),
                                  HexColor("#020204").withOpacity(1),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#2A2A29'),
                                  offset: Offset(10, 10),
                                  blurRadius: 20,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Container(
                                  child: CommonTextFormField(
                                    controller: _profile_page_controller
                                        .FullnameController,
                                    readOnly: editable,
                                    labelText: Textutils.name_,
                                    iconData: IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Image.asset(
                                        AssetUtils.signIN_user_icon,
                                        height: 17,
                                        width: 15,
                                        color: HexColor("#606060"),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.black.withOpacity(0.65),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              // stops: [0.1, 0.5, 0.7, 0.9],
                                              colors: [
                                                HexColor("#36393E")
                                                    .withOpacity(1),
                                                HexColor("#020204")
                                                    .withOpacity(1),
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
                                        child: CountryCodePicker(
                                          onChanged: (country) {
                                            setState(() {
                                              _profile_page_controller
                                                  .dialCodedigits =
                                              country.dialCode!;
                                              print(_profile_page_controller
                                                  .dialCodedigits);
                                            });
                                          },
                                          initialSelection:
                                          _profile_page_controller
                                              .dialCodedigits,
                                          textStyle: FontStyleUtility.h15(
                                              fontColor:
                                              ColorUtils.primary_gold,
                                              family: 'PM'),
                                          showCountryOnly: false,
                                          showFlagMain: false,
                                          padding: EdgeInsets.zero,
                                          showFlag: true,
                                          showOnlyCountryWhenClosed: false,
                                          favorite: [
                                            "+1",
                                            "US",
                                            "+91",
                                            "IN"
                                          ],
                                          barrierColor: Colors.white,
                                          backgroundColor: Colors.black,
                                          dialogSize: Size.fromHeight(
                                              screenHeight / 2),
                                        ),
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CommonTextFormField(
                                          controller:
                                          _profile_page_controller
                                              .phoneNumberController,
                                          labelText: Textutils.phone_,
                                          keyboardType: TextInputType.phone,
                                          readOnly: editable,
                                          iconData: IconButton(
                                            visualDensity: VisualDensity(
                                                horizontal: -4,
                                                vertical: -4),
                                            icon: Image.asset(
                                              AssetUtils.mobile_icons,
                                              height: 17,
                                              color: HexColor("#606060"),
                                              width: 15,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: CommonTextFormField(
                                    controller: _profile_page_controller
                                        .emailAddressController,
                                    labelText: Textutils.email_,
                                    readOnly: editable,
                                    maxLines: 1,
                                    iconData: IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Image.asset(
                                        AssetUtils.message_icons,
                                        color: HexColor("#606060"),
                                        height: 17,
                                        width: 15,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: CommonTextFormField(
                                    labelText: Textutils.dob_,
                                    readOnly: true,
                                    controller: _profile_page_controller
                                        .dateOfbirthController,
                                    tap: () {
                                      // selectDoB(context);
                                    },
                                    iconData: IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Image.asset(
                                        AssetUtils.date_icons,
                                        color: HexColor("#606060"),
                                        height: 17,
                                        width: 15,
                                      ),
                                      onPressed: () {
                                        // selectDoB(context);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // Container(
                                //   width: screenWidth,
                                //   decoration: BoxDecoration(
                                //     // color: Colors.black.withOpacity(0.65),
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
                                //           color: HexColor('#04060F'),
                                //           offset: Offset(10, 10),
                                //           blurRadius: 20,
                                //         ),
                                //       ],
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: FormField<String>(
                                //     builder: (FormFieldState<String> state) {
                                //       return DropdownButtonHideUnderline(
                                //         child: DropdownButton2(
                                //           isExpanded: true,
                                //           hint: Row(
                                //             children: [
                                //               SizedBox(
                                //                 width: 4,
                                //               ),
                                //               Expanded(
                                //                 child: Text(
                                //                   'Select gender',
                                //                   style: FontStyleUtility.h15(
                                //                       fontColor: ColorUtils.primary_grey,
                                //                       family: 'PM'),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //           items: data
                                //               .map((item) => DropdownMenuItem<String>(
                                //             value: item,
                                //             child: Text(
                                //               item,
                                //               textAlign: TextAlign.center,
                                //               style: FontStyleUtility.h15(
                                //                   fontColor:
                                //                   ColorUtils.primary_grey,
                                //                   family: 'PM'),
                                //               overflow: TextOverflow.ellipsis,
                                //             ),
                                //           ))
                                //               .toList(),
                                //           value: selected_gender,
                                //           onChanged: (value) {
                                //             setState(() {
                                //               selected_gender = value as String;
                                //             });
                                //             // print(contactdetailsController
                                //             //     .selectedValue);
                                //           },
                                //           iconSize: 25,
                                //           isDense: true,
                                //
                                //           icon: Image.asset(
                                //             AssetUtils.arrow_down_icons,
                                //             color: HexColor("#606060"),
                                //             height: 13,
                                //             width: 13,
                                //           ),
                                //
                                //           iconEnabledColor: Color(0xff007DEF),
                                //           iconDisabledColor: Color(0xff007DEF),
                                //           buttonHeight: 50,
                                //           buttonWidth: 160,
                                //           style: FontStyleUtility.h16(
                                //               fontColor: ColorUtils.primary_gold,
                                //               family: 'PM'),
                                //           buttonPadding:
                                //           const EdgeInsets.only(left: 15, right: 15),
                                //           buttonDecoration: BoxDecoration(
                                //               borderRadius: BorderRadius.circular(10),
                                //               color: Colors.transparent),
                                //           buttonElevation: 0,
                                //           itemHeight: 40,
                                //           itemPadding:
                                //           const EdgeInsets.only(left: 14, right: 14),
                                //           dropdownMaxHeight: 200,
                                //           // dropdownWidth: 200,
                                //           dropdownPadding: null,
                                //           dropdownDecoration: BoxDecoration(
                                //             // color: Colors.black.withOpacity(0.65),
                                //               gradient: LinearGradient(
                                //                 begin: Alignment.centerLeft,
                                //                 end: Alignment.centerRight,
                                //                 // stops: [0.1, 0.5, 0.7, 0.9],
                                //                 colors: [
                                //                   HexColor("#020204").withOpacity(1),
                                //                   HexColor("#36393E").withOpacity(1),
                                //                 ],
                                //               ),
                                //               boxShadow: [
                                //                 BoxShadow(
                                //                   color: HexColor('#04060F'),
                                //                   offset: Offset(10,10),
                                //                   blurRadius: 20,
                                //                 ),
                                //               ],
                                //               borderRadius: BorderRadius.circular(10)),
                                //           dropdownElevation: 20,
                                //           scrollbarRadius: const Radius.circular(40),
                                //           scrollbarThickness: 6,
                                //           scrollbarAlwaysShow: true,
                                //           offset: const Offset(0, -5),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
                                Container(
                                  child: CommonTextFormField(
                                    labelText: 'Gender',
                                    controller: _profile_page_controller
                                        .genderController,
                                    tap: () {
                                      // select_gender(context);
                                    },
                                    readOnly: true,
                                    iconData: IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Image.asset(
                                        AssetUtils.arrow_down_icons,
                                        color: HexColor("#606060"),
                                        height: 13,
                                        width: 13,
                                      ),
                                      onPressed: () {
                                        // select_gender(context);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 17),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  HexColor("#36393E").withOpacity(1),
                                  HexColor("#020204").withOpacity(1),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#2A2A29'),
                                  offset: Offset(10, 10),
                                  blurRadius: 20,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 0, left: 32),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Level',
                                    style: FontStyleUtility.h15(
                                        fontColor: Colors.white,
                                        family: 'PM'),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: screenWidth,
                                  height: 120,
                                  child: GridView.builder(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 0),
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio:
                                          (MediaQuery.of(context)
                                              .size
                                              .width /
                                              0.8) /
                                              (MediaQuery.of(
                                                  context)
                                                  .size
                                                  .height /
                                                  4),
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 10),
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: difficulty.length,
                                      itemBuilder:
                                          (BuildContext ctx, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (editable == false) {
                                              setState(() {
                                                // ontap of each card, set the defined int to the grid view index
                                                _profile_page_controller
                                                    .selected_difficulty =
                                                difficulty[index];
                                                _signInScreenController
                                                    .selectedCard = index;
                                              });
                                              if (_profile_page_controller
                                                  .selected_difficulty ==
                                                  "ထ") {
                                                _profile_page_controller
                                                    .selected_difficulty =
                                                "Infinite";
                                              }
                                              print(_profile_page_controller
                                                  .selected_difficulty);
                                            }
                                          },
                                          child: SizedBox(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              // decoration: BoxDecoration(
                                              //     color: (selectedCard == index
                                              //         ? ColorUtils.primary_gold
                                              //         : Colors.black),
                                              //     borderRadius: BorderRadius.circular(10),
                                              //     border: Border.all(
                                              //         color: ColorUtils.primary_gold, width: 1)),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment
                                                        .centerLeft,
                                                    end: Alignment
                                                        .centerRight,
                                                    colors: [
                                                      HexColor("#36393E")
                                                          .withOpacity(1),
                                                      HexColor("#020204")
                                                          .withOpacity(1),
                                                    ],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: HexColor(
                                                          '#04060F'),
                                                      offset:
                                                      Offset(10, 10),
                                                      blurRadius: 10,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  difficulty[index],
                                                  style: FontStyleUtility.h15(
                                                      fontColor: (_signInScreenController
                                                          .selectedCard ==
                                                          index
                                                          ? ColorUtils
                                                          .primary_gold
                                                          : ColorUtils
                                                          .primary_grey),
                                                      family: 'PM'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    (_profile_page_controller.selected_difficulty == 'Easy'
                                        ? "Hold 8 seconds, push 2 seconds, set of 8"
                                        : (_profile_page_controller.selected_difficulty == 'Normal'
                                        ? "Hold 10 seconds, push 2 seconds, set of 10"
                                        : (_profile_page_controller.selected_difficulty == 'Super Easy'
                                        ? "stage 1 : Hold 2 seconds, push 2 seconds, set of 4 \nstage 2 : Hold 4 seconds, push 2 seconds, set of 6 \nstage 3 : Hold 6 seconds, push 2 seconds, set of 8"
                                        : (_profile_page_controller.selected_difficulty == 'Hard'
                                        ? "Hold 12 seconds, push 2 seconds, set of 12"
                                        : (_profile_page_controller.selected_difficulty == 'Infinite'
                                        ? "Hold 12 seconds, push 2 seconds, set of 12"
                                        : "kegel info"))))),
                                    textAlign: TextAlign.justify,
                                    style: FontStyleUtility.h15(
                                        fontColor: Colors.white,
                                        family: 'PM'),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        (editable
                            ? SizedBox.shrink()
                            : common_button_gold(
                          onTap: () async {
                            await _profile_page_controller
                                .Editprofile(context: context);
                            // if (_profile_page_controller
                            //         .editProfile!.error ==
                            //     false) {
                            //  await _signInScreenController.GetUserInfo(
                            //       context);
                            // }
                          },
                          title_text: 'Save Details',
                        )),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                )))
        // Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Container(
        //             height: 80,
        //             width: 200,
        //             // color: ColorUtils.primary_grey,
        //             decoration: BoxDecoration(
        //                 // color: Colors.black.withOpacity(0.65),
        //                 gradient: LinearGradient(
        //                   begin: Alignment.centerLeft,
        //                   end: Alignment.centerRight,
        //                   // stops: [0.1, 0.5, 0.7, 0.9],
        //                   colors: [
        //                     HexColor("#020204").withOpacity(1),
        //                     HexColor("#36393E").withOpacity(1),
        //                   ],
        //                 ),
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   CircularProgressIndicator(
        //                     color: ColorUtils.primary_gold,
        //                   ),
        //                   Container(
        //                     child: Text(
        //                       "Loading..",
        //                       style: FontStyleUtility.h16(
        //                           fontColor: ColorUtils.primary_gold,
        //                           family: 'PB'),
        //                     ),
        //                   ),
        //
        //                   // Container(
        //                   //   color: Colors.transparent,
        //                   //   height: 60,
        //                   //   width: 80,
        //                   //   child:
        //                   //   Material(
        //                   //     color: Colors.transparent,
        //                   //     child: LoadingIndicator(
        //                   //       backgroundColor: Colors.transparent,
        //                   //       indicatorType: Indicator.ballScale,
        //                   //       colors: _kDefaultRainbowColors,
        //                   //       strokeWidth: 3.0,
        //                   //       pathBackgroundColor: Colors.yellow,
        //                   //       // showPathBackground ? Colors.black45 : null,
        //                   //     ),
        //                   //   ),
        //                   // ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       )
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      title: Text(
                        'Profile',
                        // _signInScreenController
                        //     .userInfoModel!.data![0].username!,
                        style: FontStyleUtility.h16(
                            fontColor: ColorUtils.primary_gold, family: 'PM'),
                      ),
                      centerTitle: true,
                    ),
                    body: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
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
                      margin: EdgeInsets.only(top: 0, right: 8, left: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 13),
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   editable =
                                          //   (editable ? false : true);
                                          // });
                                        },
                                        child: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              gradient: LinearGradient(
                                                colors: [
                                                  HexColor('#36393E'),
                                                  HexColor('#020204'),
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: HexColor('#04060F'),
                                                    offset: Offset(10, 10),
                                                    blurRadius: 20)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 9.0, horizontal: 18),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(
                                                _signInScreenController
                                                    .userInfoModel!
                                                    .data![0]
                                                    .username!,
                                                overflow: TextOverflow.ellipsis,
                                                style: FontStyleUtility.h12(
                                                    fontColor:
                                                        ColorUtils.primary_gold,
                                                    family: 'PM'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    // color: Colors.white60,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: ColorUtils
                                                          .light_black,
                                                      offset: Offset(5, 5),
                                                      blurRadius: 6)
                                                ]),
                                            child: (_signInScreenController
                                                    .userInfoModel!
                                                    .data![0]
                                                    .image!
                                                    .isEmpty
                                                ? Image.asset(
                                                    AssetUtils.user_icon45,
                                                    fit: BoxFit.cover,
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : (_profile_page_controller
                                                            .imgFile ==
                                                        null
                                                    ?
                                                    // Image.network(
                                                    //             'https://foxyserver.com/klench/images/${_signInScreenController.userInfoModel!.data![0].image}',
                                                    //             fit: BoxFit.fill,
                                                    //             height: 100,
                                                    //             width: 100,
                                                    //           )
                                                    Container(
                                                        color: Colors.black,
                                                        child: FadeInImage(
                                                          image: NetworkImage(
                                                              "http://foxyserver.com/klench/images/${_signInScreenController.userInfoModel!.data![0].image}"),
                                                          fit: BoxFit.cover,
                                                          height: 100,
                                                          width: 100,
                                                          placeholder:
                                                              AssetImage(
                                                            AssetUtils
                                                                .user_icon45,
                                                          ),
                                                          imageErrorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            print(error);
                                                            return Image.asset(
                                                              AssetUtils
                                                                  .user_icon45,
                                                              fit: BoxFit.cover,
                                                              height: 100,
                                                              width: 100,
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: Image.file(
                                                          _profile_page_controller
                                                              .imgFile!,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ))),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 2,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              (editable
                                                  ? null
                                                  : showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                title: Text(
                                                                    "Pick Image from"),
                                                                actions: <
                                                                    Widget>[
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          openCamera();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              const EdgeInsets.symmetric(horizontal: 30),
                                                                          // height: 45,
                                                                          // width:(width ?? 300) ,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.black,
                                                                              borderRadius: BorderRadius.circular(25)),
                                                                          child: Container(
                                                                              alignment: Alignment.center,
                                                                              margin: EdgeInsets.symmetric(
                                                                                vertical: 12,
                                                                              ),
                                                                              child: Text(
                                                                                'Camera',
                                                                                style: TextStyle(color: Colors.white, fontFamily: 'PR', fontSize: 16),
                                                                              )),
                                                                        ),
                                                                      )),
                                                                  Container(
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);

                                                                          openGallery();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              const EdgeInsets.symmetric(horizontal: 30),
                                                                          // height: 45,
                                                                          // width:(width ?? 300) ,
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.black, width: 1),
                                                                              borderRadius: BorderRadius.circular(25)),
                                                                          child: Container(
                                                                              alignment: Alignment.center,
                                                                              margin: EdgeInsets.symmetric(
                                                                                vertical: 12,
                                                                              ),
                                                                              child: Text(
                                                                                'Gallery',
                                                                                style: TextStyle(color: Colors.black, fontFamily: 'PR', fontSize: 16),
                                                                              )),
                                                                        ),
                                                                      )),
                                                                ],
                                                              )));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    HexColor('#36393E'),
                                                    HexColor('#020204'),
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color:
                                                      ColorUtils.primary_gold,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            editable =
                                                (editable ? false : true);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              gradient: LinearGradient(
                                                colors: [
                                                  HexColor('#36393E'),
                                                  HexColor('#020204'),
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              border: (editable
                                                  ? Border.all(
                                                      color: Colors.transparent,
                                                      width: 0)
                                                  : Border.all(
                                                      color: ColorUtils
                                                          .primary_gold,
                                                      width: 1)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: HexColor('#04060F'),
                                                    offset: Offset(10, 10),
                                                    blurRadius: 20)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 9.0, horizontal: 18),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: Text(
                                                    'Edit',
                                                    style: FontStyleUtility.h12(
                                                        fontColor: ColorUtils
                                                            .primary_gold,
                                                        family: 'PM'),
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 16,
                                                    color:
                                                        ColorUtils.primary_gold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      HexColor("#36393E").withOpacity(1),
                                      HexColor("#020204").withOpacity(1),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor('#2A2A29'),
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: CommonTextFormField(
                                        controller: _profile_page_controller
                                            .FullnameController,
                                        readOnly: editable,
                                        labelText: Textutils.name_,
                                        iconData: IconButton(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          icon: Image.asset(
                                            AssetUtils.signIN_user_icon,
                                            height: 17,
                                            width: 15,
                                            color: HexColor("#606060"),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.black.withOpacity(0.65),
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  // stops: [0.1, 0.5, 0.7, 0.9],
                                                  colors: [
                                                    HexColor("#36393E")
                                                        .withOpacity(1),
                                                    HexColor("#020204")
                                                        .withOpacity(1),
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
                                            child: CountryCodePicker(
                                              onChanged: (country) {
                                                setState(() {
                                                  _profile_page_controller
                                                          .dialCodedigits =
                                                      country.dialCode!;
                                                  print(_profile_page_controller
                                                      .dialCodedigits);
                                                });
                                              },
                                              initialSelection:
                                                  _profile_page_controller
                                                      .dialCodedigits,
                                              textStyle: FontStyleUtility.h15(
                                                  fontColor:
                                                      ColorUtils.primary_gold,
                                                  family: 'PM'),
                                              showCountryOnly: false,
                                              showFlagMain: false,
                                              padding: EdgeInsets.zero,
                                              showFlag: true,
                                              showOnlyCountryWhenClosed: false,
                                              favorite: [
                                                "+1",
                                                "US",
                                                "+91",
                                                "IN"
                                              ],
                                              barrierColor: Colors.white,
                                              backgroundColor: Colors.black,
                                              dialogSize: Size.fromHeight(
                                                  screenHeight / 2),
                                            ),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: CommonTextFormField(
                                              controller:
                                                  _profile_page_controller
                                                      .phoneNumberController,
                                              labelText: Textutils.phone_,
                                              keyboardType: TextInputType.phone,
                                              readOnly: editable,
                                              iconData: IconButton(
                                                visualDensity: VisualDensity(
                                                    horizontal: -4,
                                                    vertical: -4),
                                                icon: Image.asset(
                                                  AssetUtils.mobile_icons,
                                                  height: 17,
                                                  color: HexColor("#606060"),
                                                  width: 15,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: CommonTextFormField(
                                        controller: _profile_page_controller
                                            .emailAddressController,
                                        labelText: Textutils.email_,
                                        readOnly: editable,
                                        maxLines: 1,
                                        iconData: IconButton(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          icon: Image.asset(
                                            AssetUtils.message_icons,
                                            color: HexColor("#606060"),
                                            height: 17,
                                            width: 15,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: CommonTextFormField(
                                        labelText: Textutils.dob_,
                                        readOnly: true,
                                        controller: _profile_page_controller
                                            .dateOfbirthController,
                                        tap: () {
                                          // selectDoB(context);
                                        },
                                        iconData: IconButton(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          icon: Image.asset(
                                            AssetUtils.date_icons,
                                            color: HexColor("#606060"),
                                            height: 17,
                                            width: 15,
                                          ),
                                          onPressed: () {
                                            // selectDoB(context);
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Container(
                                    //   width: screenWidth,
                                    //   decoration: BoxDecoration(
                                    //     // color: Colors.black.withOpacity(0.65),
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
                                    //           color: HexColor('#04060F'),
                                    //           offset: Offset(10, 10),
                                    //           blurRadius: 20,
                                    //         ),
                                    //       ],
                                    //       borderRadius: BorderRadius.circular(10)),
                                    //   child: FormField<String>(
                                    //     builder: (FormFieldState<String> state) {
                                    //       return DropdownButtonHideUnderline(
                                    //         child: DropdownButton2(
                                    //           isExpanded: true,
                                    //           hint: Row(
                                    //             children: [
                                    //               SizedBox(
                                    //                 width: 4,
                                    //               ),
                                    //               Expanded(
                                    //                 child: Text(
                                    //                   'Select gender',
                                    //                   style: FontStyleUtility.h15(
                                    //                       fontColor: ColorUtils.primary_grey,
                                    //                       family: 'PM'),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           items: data
                                    //               .map((item) => DropdownMenuItem<String>(
                                    //             value: item,
                                    //             child: Text(
                                    //               item,
                                    //               textAlign: TextAlign.center,
                                    //               style: FontStyleUtility.h15(
                                    //                   fontColor:
                                    //                   ColorUtils.primary_grey,
                                    //                   family: 'PM'),
                                    //               overflow: TextOverflow.ellipsis,
                                    //             ),
                                    //           ))
                                    //               .toList(),
                                    //           value: selected_gender,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               selected_gender = value as String;
                                    //             });
                                    //             // print(contactdetailsController
                                    //             //     .selectedValue);
                                    //           },
                                    //           iconSize: 25,
                                    //           isDense: true,
                                    //
                                    //           icon: Image.asset(
                                    //             AssetUtils.arrow_down_icons,
                                    //             color: HexColor("#606060"),
                                    //             height: 13,
                                    //             width: 13,
                                    //           ),
                                    //
                                    //           iconEnabledColor: Color(0xff007DEF),
                                    //           iconDisabledColor: Color(0xff007DEF),
                                    //           buttonHeight: 50,
                                    //           buttonWidth: 160,
                                    //           style: FontStyleUtility.h16(
                                    //               fontColor: ColorUtils.primary_gold,
                                    //               family: 'PM'),
                                    //           buttonPadding:
                                    //           const EdgeInsets.only(left: 15, right: 15),
                                    //           buttonDecoration: BoxDecoration(
                                    //               borderRadius: BorderRadius.circular(10),
                                    //               color: Colors.transparent),
                                    //           buttonElevation: 0,
                                    //           itemHeight: 40,
                                    //           itemPadding:
                                    //           const EdgeInsets.only(left: 14, right: 14),
                                    //           dropdownMaxHeight: 200,
                                    //           // dropdownWidth: 200,
                                    //           dropdownPadding: null,
                                    //           dropdownDecoration: BoxDecoration(
                                    //             // color: Colors.black.withOpacity(0.65),
                                    //               gradient: LinearGradient(
                                    //                 begin: Alignment.centerLeft,
                                    //                 end: Alignment.centerRight,
                                    //                 // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                 colors: [
                                    //                   HexColor("#020204").withOpacity(1),
                                    //                   HexColor("#36393E").withOpacity(1),
                                    //                 ],
                                    //               ),
                                    //               boxShadow: [
                                    //                 BoxShadow(
                                    //                   color: HexColor('#04060F'),
                                    //                   offset: Offset(10,10),
                                    //                   blurRadius: 20,
                                    //                 ),
                                    //               ],
                                    //               borderRadius: BorderRadius.circular(10)),
                                    //           dropdownElevation: 20,
                                    //           scrollbarRadius: const Radius.circular(40),
                                    //           scrollbarThickness: 6,
                                    //           scrollbarAlwaysShow: true,
                                    //           offset: const Offset(0, -5),
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                    Container(
                                      child: CommonTextFormField(
                                        labelText: 'Gender',
                                        controller: _profile_page_controller
                                            .genderController,
                                        tap: () {
                                          // select_gender(context);
                                        },
                                        readOnly: true,
                                        iconData: IconButton(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          icon: Image.asset(
                                            AssetUtils.arrow_down_icons,
                                            color: HexColor("#606060"),
                                            height: 13,
                                            width: 13,
                                          ),
                                          onPressed: () {
                                            // select_gender(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 17),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      HexColor("#36393E").withOpacity(1),
                                      HexColor("#020204").withOpacity(1),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor('#2A2A29'),
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0, left: 32),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Level',
                                        style: FontStyleUtility.h15(
                                            fontColor: Colors.white,
                                            family: 'PM'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: screenWidth,
                                      height: 120,
                                      child: GridView.builder(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              0.8) /
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              4),
                                                  crossAxisSpacing: 0,
                                                  mainAxisSpacing: 10),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: difficulty.length,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (editable == false) {
                                                  setState(() {
                                                    // ontap of each card, set the defined int to the grid view index
                                                    _profile_page_controller
                                                            .selected_difficulty =
                                                        difficulty[index];
                                                    _signInScreenController
                                                        .selectedCard = index;
                                                  });
                                                  if (_profile_page_controller
                                                          .selected_difficulty ==
                                                      "ထ") {
                                                    _profile_page_controller
                                                            .selected_difficulty =
                                                        "Infinite";
                                                  }
                                                  print(_profile_page_controller
                                                      .selected_difficulty);
                                                }
                                              },
                                              child: SizedBox(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  // decoration: BoxDecoration(
                                                  //     color: (selectedCard == index
                                                  //         ? ColorUtils.primary_gold
                                                  //         : Colors.black),
                                                  //     borderRadius: BorderRadius.circular(10),
                                                  //     border: Border.all(
                                                  //         color: ColorUtils.primary_gold, width: 1)),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          HexColor("#36393E")
                                                              .withOpacity(1),
                                                          HexColor("#020204")
                                                              .withOpacity(1),
                                                        ],
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: HexColor(
                                                              '#04060F'),
                                                          offset:
                                                              Offset(10, 10),
                                                          blurRadius: 10,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      difficulty[index],
                                                      style: FontStyleUtility.h15(
                                                          fontColor: (_signInScreenController
                                                                      .selectedCard ==
                                                                  index
                                                              ? ColorUtils
                                                                  .primary_gold
                                                              : ColorUtils
                                                                  .primary_grey),
                                                          family: 'PM'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        (_profile_page_controller.selected_difficulty == 'Easy'
                                            ? "Hold 8 seconds, push 2 seconds, set of 8"
                                            : (_profile_page_controller.selected_difficulty == 'Normal'
                                                ? "Hold 10 seconds, push 2 seconds, set of 10"
                                                : (_profile_page_controller.selected_difficulty == 'Super Easy'
                                                    ? "stage 1 : Hold 2 seconds, push 2 seconds, set of 4 \nstage 2 : Hold 4 seconds, push 2 seconds, set of 6 \nstage 3 : Hold 6 seconds, push 2 seconds, set of 8"
                                                    : (_profile_page_controller.selected_difficulty == 'Hard'
                                                        ? "Hold 12 seconds, push 2 seconds, set of 12"
                                                        : (_profile_page_controller.selected_difficulty == 'Infinite'
                                                            ? "Hold 12 seconds, push 2 seconds, set of 12"
                                                            : "kegel info"))))),
                                        textAlign: TextAlign.justify,
                                        style: FontStyleUtility.h15(
                                            fontColor: Colors.white,
                                            family: 'PM'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            (editable
                                ? SizedBox.shrink()
                                : common_button_gold(
                                    onTap: () async {
                                      await _profile_page_controller
                                          .Editprofile(context: context);
                                      // if (_profile_page_controller
                                      //         .editProfile!.error ==
                                      //     false) {
                                      //  await _signInScreenController.GetUserInfo(
                                      //       context);
                                      // }
                                    },
                                    title_text: 'Save Details',
                                  )),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    ))))));
  }

  final imgPicker = ImagePicker();

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profile_page_controller.imgFile = File(imgGallery!.path);
    });
  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      _profile_page_controller.imgFile = File(imgCamera!.path);
    });
  }
}
