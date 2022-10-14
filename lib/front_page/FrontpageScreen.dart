import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SignUp/SignUp_screen.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/Common_container_color.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../Authentication/ask_signUp.dart';
import '../utils/Common_buttons.dart';
import '../utils/UrlConstrant.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          margin: EdgeInsets.only(top: 200),
          // decoration: BoxDecoration(
          //
          //   image: DecorationImage(
          //     image: AssetImage(AssetUtils.backgroundImage), // <-- BACKGROUND IMAGE
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
                  Colors.black.withOpacity(0.5), BlendMode.dst),
              image: AssetImage(
                AssetUtils.front_back,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(),
          // appBar: AppBar(
          //   title: Text("font page"),
          //   backgroundColor: Colors.black,
          // ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    child: Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                            left: 85, right: 85, bottom: 0, top: 65),
                        child: Image.asset(AssetUtils.Logo_white_icon)),
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

                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 35),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 17, horizontal: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 154,
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
                                    color: HexColor('#2E2E2D'),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                  BoxShadow(
                                    color: HexColor('#04060F'),
                                    offset: Offset(10, 10),
                                    blurRadius: 20,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 41,
                                    width: 41,
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
                                        borderRadius: BorderRadius.circular(50)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '6',
                                        style: FontStyleUtility.h22(
                                            fontColor: HexColor('#606060'),family: 'PR'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Months',
                                    style: FontStyleUtility.h16(
                                        fontColor: HexColor('#777777')),
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
                                        borderRadius: BorderRadius.circular(50)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 18),
                                    child: Text(
                                      "\$20/month",
                                      style: FontStyleUtility.h16(
                                          fontColor: HexColor('#9B9B9B'),
                                          family: 'PSB'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          Container(
                            height: 154,
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
                              //   ),'
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  // stops: [0.1, 0.5, 0.7, 0.9],
                                  colors: [
                                    HexColor("#ECDD8F"),
                                    HexColor("#E5CC79"),
                                    HexColor("#CE952F"),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: HexColor('#2E2E2D'),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                  BoxShadow(
                                    color: HexColor('#04060F'),
                                    offset: Offset(10, 10),
                                    blurRadius: 20,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 41,
                                          width: 41,
                                          margin: EdgeInsets.only(
                                              left: 0, right: 0, bottom: 0),
                                          child: Container(
                                            // decoration: BoxDecoration(
                                            //     color: Colors.red.withOpacity(0.65),
                                            //     gradient: LinearGradient(
                                            //       begin: Alignment.centerLeft,
                                            //       end: Alignment.centerRight,
                                            //       // stops: [0.1, 0.5, 0.7, 0.9],
                                            //       colors: [
                                            //         HexColor("#020204")
                                            //             .withOpacity(1),
                                            //         HexColor("#36393E")
                                            //             .withOpacity(1),
                                            //       ],
                                            //     ),
                                            //     boxShadow: [
                                            //       BoxShadow(
                                            //         color: HexColor('#04060F'),
                                            //         offset: Offset(5, 5),
                                            //         blurRadius: 20,
                                            //       ),
                                            //     ],
                                            //     borderRadius:
                                            //     BorderRadius.circular(50)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(9.0),
                                              child: Image.asset(
                                                AssetUtils.Diamond_icon,
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          )),
                                      Container(
                                        child: Text(
                                          '6',
                                          style: FontStyleUtility.h22(
                                              fontColor: Colors.black,family: 'PR'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Months',
                                    style: FontStyleUtility.h16(
                                        fontColor: Colors.black),
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
                                              color: HexColor("#04060F"),
                                              offset: Offset(5, 5),
                                              blurRadius: 10)
                                        ],
                                        borderRadius: BorderRadius.circular(50)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 18),
                                    child: Text(
                                      "\$100(In Full)",
                                      style: FontStyleUtility.h16(
                                          fontColor: ColorUtils.primary_grey,
                                          family: 'PSB'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Save \$20',
                                    style: FontStyleUtility.h12(
                                        fontColor: Colors.black,
                                        family: 'PR'),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Container(
                          //   height: 154,
                          //   decoration: BoxDecoration(
                          //     // color: Colors.black.withOpacity(0.65),
                          //       gradient: LinearGradient(
                          //         begin: Alignment.centerLeft,
                          //         end: Alignment.centerRight,
                          //         // stops: [0.1, 0.5, 0.7, 0.9],
                          //         colors: [
                          //           HexColor("#020204").withOpacity(1),
                          //           HexColor("#36393E").withOpacity(1),
                          //         ],
                          //       ),
                          //       boxShadow: [
                          //
                          //         BoxShadow(
                          //           color: HexColor('#2E2E2D'),
                          //           offset: Offset(0,3),
                          //           blurRadius: 6,
                          //         ),
                          //         BoxShadow(
                          //           color: HexColor('#04060F'),
                          //           offset: Offset(10,10),
                          //           blurRadius: 20,
                          //         ),
                          //       ],
                          //       borderRadius: BorderRadius.circular(20)),
                          //   child: Container(
                          //     margin:
                          //         EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          //     child: Column(
                          //       children: [
                          //         Row(
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //                 margin: EdgeInsets.only(
                          //                     left: 0, right: 9, bottom: 0),
                          //                 child: Image.asset(
                          //                   AssetUtils.Diamond_icon,
                          //                   height: 30,
                          //                   width: 30,
                          //                 )),
                          //             Text(
                          //               '6',
                          //               style: FontStyleUtility.h35(
                          //                   fontColor: Colors.black),
                          //             ),
                          //           ],
                          //         ),
                          //         Text(
                          //           'Months',
                          //           style: FontStyleUtility.h22(
                          //               fontColor: Colors.black),
                          //         ),
                          //         Container(
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(18),
                          //               border: Border.all(
                          //                   color: Colors.black, width: 1)),
                          //           padding: EdgeInsets.symmetric(
                          //               vertical: 6, horizontal: 18),
                          //           child: Text(
                          //             "\$100(In Full)",
                          //             style: FontStyleUtility.h16(
                          //                 family: 'PR', fontColor: Colors.black),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: 4,
                          //         ),
                          //         Text(
                          //           'Save \$20',
                          //           style: FontStyleUtility.h12(
                          //               fontColor: Colors.white),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding:EdgeInsets.symmetric(vertical: 0,horizontal: 19),

                    child: Column(
                      children: [
                        common_button_gold(
                          title_text: '12 days free trial',
                          onTap: () async {
                            // Get.to(SignUpScreen());
                            await PreferenceManager()
                                .setPref(URLConstants.trial, 'true');

                            Get.to(AskSignUp());

                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 14,
                                color: HexColor('#AAAAAA'),
                                fontFamily: 'PR'),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            // Get.to(SignUpScreen());
                            await PreferenceManager()
                                .setPref(URLConstants.trial, 'true');

                            Get.to(AskSignUp());

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                                border: Border.all(color: ColorUtils.primary_gold,width: 1),
                                borderRadius: BorderRadius.circular(10)),

                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  '3 weeks free trial (Referral)',
                                  style: FontStyleUtility.h15(
                                      fontColor: ColorUtils.primary_gold, family: 'PM'),
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 23.5),
                          height: 1,
                          color: Colors.white,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 17.5),
                          child: Text(
                            '\$2/month after the 6 month subscription',
                            style: FontStyleUtility.h14(
                                fontColor: Colors.white,
                                family: 'PM'
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 23.5),
                          height: 1,
                          color: Colors.white,
                        ),
                        common_button_gold(
                          onTap: () {
                            Get.to(SignInScreen());
                          },
                          title_text: 'Sign In',
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        GestureDetector(
                          onTap: (){
                            // Get.to(SignUpScreen());
                            Get.to(AskSignUp());

                          },
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
                                    offset: Offset(10,10),
                                    blurRadius: 20,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10)),

                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: FontStyleUtility.h15(
                                      fontColor: HexColor('#E1C26B'), family: 'PM'),
                                )),
                          ),
                        ),

                        SizedBox(
                          height: 27,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 0);
    path.quadraticBezierTo(width / 4, height / 2, width / 2, height - 40);
    path.quadraticBezierTo(width - (width / 4), height, width, height - 70);

    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
