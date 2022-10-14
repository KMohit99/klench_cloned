import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Dashboard/dashboard_screen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/Common_textfeild.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/colorUtils.dart';

class PaymentScreen extends StatefulWidget {
  final String payment;

  const PaymentScreen({Key? key, required this.payment}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: Common_reverse_decoration(),
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          // appBar: AppBar(
          //   backgroundColor: Colors.black,
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: ColorUtils.primary_gold,
          //     ),
          //   ),
          //   title: Text(
          //     'Payment',
          //     style: FontStyleUtility.h16(
          //         fontColor: ColorUtils.primary_gold, family: 'PM'),
          //   ),
          //   centerTitle: true,
          // ),
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
              'Payment',
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
            ),
            // Text(
            //   Textutils.appName,
            //   style: FontStyleUtility.h16(
            //       fontColor: ColorUtils.primary_grey, family: 'PM'),
            // ),
            centerTitle: true,
            actions: [],
          ),
          body: SingleChildScrollView(
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
                      offset: Offset(10, 10),
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: 154,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: HexColor('#2E2E2D'),
                                  offset: Offset(0, 3),
                                  blurRadius: 6),
                              BoxShadow(
                                  color: HexColor('#04060F'),
                                  blurRadius: 20,
                                  offset: Offset(10, 10))
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              // stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                HexColor("#020204").withOpacity(1),
                                HexColor("#36393E").withOpacity(1),
                              ],
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(12),
                              padding: EdgeInsets.all(6),
                              color: HexColor('#818181'),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: HexColor('#2E2E2D'),
                                        offset: Offset(0, 3),
                                        blurRadius: 6),
                                    BoxShadow(
                                        color: HexColor('#04060F'),
                                        blurRadius: 20,
                                        offset: Offset(10, 10))
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#36393E").withOpacity(1),
                                      HexColor("#020204").withOpacity(1),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: ColorUtils.primary_gold,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Text(
                                            '6',
                                            style: FontStyleUtility.h18(
                                                family: 'PM',
                                                fontColor: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          (widget.payment != 'normal'
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      right: 12),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.65),
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
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
                                                          color: HexColor(
                                                              '#04060F'),
                                                          offset: Offset(5, 5),
                                                          blurRadius: 20,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: Image.asset(
                                                      AssetUtils.Diamond_icon,
                                                      height: 31,
                                                      width: 31,
                                                    ),
                                                  ))
                                              : SizedBox.shrink()),
                                          Text(
                                            'Months',
                                            style: FontStyleUtility.h35(
                                              family: 'PB',
                                              fontColor: HexColor('#B1B1B1'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        (widget.payment != 'normal'
                                            ? "\$100(In Full)"
                                            : '\$20/month'),
                                        style: FontStyleUtility.h16(
                                            fontColor: ColorUtils.primary_grey,
                                            family: 'PR'),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      (widget.payment != 'normal'
                                          ? Text(
                                              'Save \$20',
                                              style: FontStyleUtility.h12(
                                                  fontColor:
                                                      ColorUtils.primary_gold,
                                                  family: 'PR'),
                                            )
                                          : SizedBox.shrink()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 27),
                          child: Text('Enter card details',
                              style: FontStyleUtility.h15(
                                  fontColor: HexColor('#DBDBDB'),
                                  family: 'PR')),
                        ),
                        Container(
                          child: CommonTextFormField_noicon(
                            labelText: 'Credit or debit card number',
                            // style_color: ColorUtils.primary_gold,
                            // background_color: Colors.black,
                            // hint_color: ColorUtils.primary_gold,
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                          child: CommonTextFormField_noicon(
                            labelText: 'Full name on card',
                            // style_color: ColorUtils.primary_gold,
                            // background_color: Colors.black,
                            // hint_color: ColorUtils.primary_gold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Text('Expiry date',
                              style: FontStyleUtility.h15(
                                  fontColor: HexColor('#DBDBDB'),
                                  family: 'PR')),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: 100,
                                child: CommonTextFormField_noicon(
                                  labelText: 'MONTH',
                                  // style_color: ColorUtils.primary_gold,
                                  // background_color: Colors.black,
                                  // hint_color: ColorUtils.primary_gold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 27,
                            ),
                            Flexible(
                              child: Container(
                                width: 100,
                                child: CommonTextFormField_noicon(
                                  labelText: 'YEAR',
                                  // style_color: ColorUtils.primary_gold,
                                  // background_color: Colors.black,
                                  // hint_color: ColorUtils.primary_gold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Text('CVV/CVC',
                              style: FontStyleUtility.h15(
                                  fontColor: HexColor('#DBDBDB'),
                                  family: 'PR')),
                        ),
                        Container(
                          width: 100,
                          child: CommonTextFormField_noicon(
                            // style_color: Colors.black,
                            labelText: 'CVV',
                            // background_color: ColorUtils.primary_gold,
                            // hint_color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text('Amount prefilled',
                                    style: FontStyleUtility.h15(
                                        fontColor: HexColor('#DBDBDB'),
                                        family: 'PR')),
                              ),
                            ),
                            SizedBox(
                              width: 27,
                            ),
                            Flexible(
                              child: Container(
                                width: 100,
                                child: CommonTextFormField_noicon(
                                  readOnly: true,
                                  labelText: (widget.payment != 'normal'
                                      ? "\$100 USD"
                                      : '\$20 USD'),
                                  // style_color: ColorUtils.primary_gold,
                                  // background_color: Colors.black,
                                  // hint_color: ColorUtils.primary_gold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        common_button_gold(
                          onTap: () {
                            selectTowerBottomSheet(context);
                            Future.delayed(const Duration(seconds: 5), () async {
                              Navigator.pop(context);
                              Get.to(DashboardScreen(page: 1,));
                              setState(() {
                              });
                            });
                          },
                          title_text: 'Pay',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(33.9),
                  child: SingleChildScrollView(
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
                          margin: EdgeInsets.symmetric(vertical: 35),
                          child: Column(
                            children: [
                              Container(
                                child: Text('Thank You!',
                                    textAlign: TextAlign.center,
                                    style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.primary_grey,
                                        family: 'PR')),
                              ),
                              Container(
                                child: Text(
                                    'You have successfully paid for plan 6 month',
                                    textAlign: TextAlign.center,
                                    style: FontStyleUtility.h15(
                                        fontColor: ColorUtils.primary_grey,
                                        family: 'PR')),
                              ),
                            ],
                          ),
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}
