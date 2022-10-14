import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../front_page/FrontpageScreen.dart';

class AboutUs_Screen extends StatefulWidget {
  const AboutUs_Screen({Key? key}) : super(key: key);

  @override
  State<AboutUs_Screen> createState() => _AboutUs_ScreenState();
}

class _AboutUs_ScreenState extends State<AboutUs_Screen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
          "About us",
          style: FontStyleUtility.h16(fontColor: ColorUtils.primary_grey, family: 'PM'),
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
          margin: EdgeInsets.only(bottom: 20, right: 8, left:8  ),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 49,
                    width: 170,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 20, bottom: 0),
                    child: Image.asset(AssetUtils.Logo_white_icon)),
                SizedBox(height: 18,),
                // SizedBox(height: 18,),
                Container(
                  child: Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. ",
                    textAlign: TextAlign.justify,
                    style: FontStyleUtility.h14(
                        fontColor: Colors.white, family: 'PR'),
                  ),
                ), 
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child:Image.asset(AssetUtils.user_icon5),
                  ),
                ),
                Container(
                  child: Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. ",
                    textAlign: TextAlign.justify,
                    style: FontStyleUtility.h14(
                        fontColor: Colors.white, family: 'PR'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
