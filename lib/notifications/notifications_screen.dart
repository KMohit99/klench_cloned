import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/Asset_utils.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          Textutils.notification,
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.primary_gold, family: 'PM'),
        ),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Clear all",
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
            ),
          )
        ],
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
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Let's start your Kegal Morning exercise",
                        style: FontStyleUtility.h14(
                            fontColor: ColorUtils.primary_grey, family: 'PR'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 1,
                      color: HexColor('#1D1D1D'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
