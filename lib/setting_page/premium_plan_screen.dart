import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/subscription_plan/payment_screen.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../utils/Common_buttons.dart';
import '../../utils/Common_textfeild.dart';

class PremiumPlanScreen extends StatefulWidget {
  const PremiumPlanScreen({Key? key}) : super(key: key);

  @override
  State<PremiumPlanScreen> createState() => _PremiumPlanScreenState();
}

class _PremiumPlanScreenState extends State<PremiumPlanScreen> {
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
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
              "Subscription plan",
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                      height: 49,
                      width: 170,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Image.asset(AssetUtils.Logo_white_icon)),
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
                            color: HexColor('#2A2A29'),
                            offset: Offset(5, 5),
                            blurRadius: 20,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 17, horizontal: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(PaymentScreen(
                                payment: 'normal',
                              ));
                            },
                            child: Container(
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
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
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
                                              HexColor("#020204")
                                                  .withOpacity(1),
                                              HexColor("#36393E")
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
                                          BorderRadius.circular(50)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '6',
                                          style: FontStyleUtility.h22(
                                              fontColor: HexColor('#606060'),
                                              family: 'PR'),
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
                                              HexColor("#36393E")
                                                  .withOpacity(1),
                                              HexColor("#020204")
                                                  .withOpacity(1),
                                            ],
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(50)),
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
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(PaymentScreen(
                                payment: 'premium',
                              ));
                            },
                            child:Container(
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
                            //         BoxShadow(
                            //           color: HexColor('#2E2E2D'),
                            //           offset: Offset(0, 3),
                            //           blurRadius: 6,
                            //         ),
                            //         BoxShadow(
                            //           color: HexColor('#04060F'),
                            //           offset: Offset(10, 10),
                            //           blurRadius: 20,
                            //         ),
                            //       ],
                            //       borderRadius: BorderRadius.circular(20)),
                            //   child: Container(
                            //     margin: EdgeInsets.symmetric(
                            //         vertical: 0, horizontal: 5),
                            //     child: Column(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.spaceEvenly,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             Container(
                            //                 height: 41,
                            //                 width: 41,
                            //                 margin: EdgeInsets.only(
                            //                     left: 0, right: 9, bottom: 0),
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                       color: Colors.red
                            //                           .withOpacity(0.65),
                            //                       gradient: LinearGradient(
                            //                         begin: Alignment.centerLeft,
                            //                         end: Alignment.centerRight,
                            //                         // stops: [0.1, 0.5, 0.7, 0.9],
                            //                         colors: [
                            //                           HexColor("#020204")
                            //                               .withOpacity(1),
                            //                           HexColor("#36393E")
                            //                               .withOpacity(1),
                            //                         ],
                            //                       ),
                            //                       boxShadow: [
                            //                         BoxShadow(
                            //                           color:
                            //                           HexColor('#04060F'),
                            //                           offset: Offset(5, 5),
                            //                           blurRadius: 20,
                            //                         ),
                            //                       ],
                            //                       borderRadius:
                            //                       BorderRadius.circular(
                            //                           50)),
                            //                   child: Padding(
                            //                     padding:
                            //                     const EdgeInsets.all(9.0),
                            //                     child: Image.asset(
                            //                       AssetUtils.Diamond_icon,
                            //                       height: 20,
                            //                       width: 20,
                            //                     ),
                            //                   ),
                            //                 )),
                            //             Container(
                            //               child: Text(
                            //                 '6',
                            //                 style: FontStyleUtility.h22(
                            //                     fontColor: HexColor('#CB8325'),
                            //                     family: 'PR'),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         Text(
                            //           'Months',
                            //           style: FontStyleUtility.h16(
                            //               fontColor: HexColor('#777777')),
                            //         ),
                            //         Container(
                            //           decoration: BoxDecoration(
                            //             // color: Colors.black.withOpacity(0.65),
                            //               gradient: LinearGradient(
                            //                 begin: Alignment.centerLeft,
                            //                 end: Alignment.centerRight,
                            //                 // stops: [0.1, 0.5, 0.7, 0.9],
                            //                 colors: [
                            //                   HexColor("#36393E")
                            //                       .withOpacity(1),
                            //                   HexColor("#020204")
                            //                       .withOpacity(1),
                            //                 ],
                            //               ),
                            //               boxShadow: [
                            //                 BoxShadow(
                            //                     color: HexColor("#04060F"),
                            //                     offset: Offset(5, 5),
                            //                     blurRadius: 10)
                            //               ],
                            //               borderRadius:
                            //               BorderRadius.circular(50)),
                            //           padding: EdgeInsets.symmetric(
                            //               vertical: 6, horizontal: 18),
                            //           child: Text(
                            //             "\$100(In Full)",
                            //             style: FontStyleUtility.h16(
                            //                 fontColor: HexColor('#CB8325'),
                            //                 family: 'PR'),
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: 2,
                            //         ),
                            //         Text(
                            //           'Save \$20',
                            //           style: FontStyleUtility.h12(
                            //               fontColor: HexColor('#A5A5A5'),
                            //               family: 'PR'),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
//                     decoration: BoxDecoration(
// // color: Colors.black.withOpacity(0.65),
//                         gradient: LinearGradient(
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
// // stops: [0.1, 0.5, 0.7, 0.9],
//                           colors: [
//                             HexColor("#020204").withOpacity(1),
//                             HexColor("#28292B").withOpacity(1),
//                           ],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: HexColor('#2A2A29'),
//                             offset: Offset(5, 5),
//                             blurRadius: 20,
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 24, horizontal: 19),
                      child: Column(
                        children: [
                          // common_button_gold(
                          //   title_text: '12 days free trial',
                          //   onTap: () {
                          //     Get.to(DashboardScreen());
                          //   },
                          // ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 16),
                          //   child: Text(
                          //     'OR',
                          //     style: TextStyle(
                          //         color: HexColor('#AAAAAA'), fontFamily: 'PR'),
                          //   ),
                          // ),
                          //
                          // GestureDetector(
                          //   onTap: () {
                          //     selectTowerBottomSheet(context);
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         color: Colors.transparent,
                          //         border: Border.all(
                          //             color: ColorUtils.primary_gold, width: 1),
                          //         borderRadius: BorderRadius.circular(10)),
                          //     child: Container(
                          //         alignment: Alignment.center,
                          //         margin: EdgeInsets.symmetric(
                          //           vertical: 12,
                          //         ),
                          //         child: Text(
                          //           '3 weeks free trial (Referral)',
                          //           style: FontStyleUtility.h15(
                          //               fontColor: ColorUtils.primary_gold,
                          //               family: 'PM'),
                          //         )),
                          //   ),
                          // ),

                          // Container(
                          //   margin: EdgeInsets.only(top: 43.5),
                          //   height: 1,
                          //   color: ColorUtils.primary_grey,
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 20.5),
                            height: 1,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 17.5),
                            child: Text(
                              '\$2/month after the 6 month subscription',
                              style: FontStyleUtility.h14(
                                  fontColor: Colors.white, family: 'PM'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20.5),
                            height: 1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 43.5),
                  //   height: 1,
                  //   color: ColorUtils.primary_grey,
                  // ),
                  // common_button_gold(
                  //   onTap: () {
                  //     // Get.to(SignInScreen());
                  //   },
                  //   title_text: 'Sign In',
                  // ),
                  // SizedBox(
                  //   height: 13,
                  // ),
                  // common_button_black(
                  //   onTap: () {
                  //     // Get.to(SignUpScreen());
                  //   },
                  //   title_text: 'Go to Dashboard',
                  // ),
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

  selectTowerBottomSheet(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: ColorUtils.primary_gold, width: 1, style: BorderStyle.solid),
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
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(33.9),
                  child: Column(
                    children: [
                      Container(
                        child: CommonTextFormField_text(
                          title: 'Referral',
                          labelText: 'Enter Referral',
                          iconData: IconButton(
                            icon: Image.asset(
                              AssetUtils.key_icons,
                              color: ColorUtils.primary_gold,
                              height: 17,
                              width: 15,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
