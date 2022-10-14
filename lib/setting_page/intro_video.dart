import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../front_page/FrontpageScreen.dart';
import '../utils/TextStyle_utils.dart';

class Intro_videoScreen extends StatefulWidget {
  const Intro_videoScreen({Key? key}) : super(key: key);

  @override
  State<Intro_videoScreen> createState() => _Intro_videoScreenState();
}

class _Intro_videoScreenState extends State<Intro_videoScreen> {
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
          "Intro Video",
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
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          child: Text(
                            'Intro Video title - 1',
                            style: FontStyleUtility.h12(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PM'),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              // color: Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: screenHeight / 4,
                                        width: screenWidth,
                                        child:
                                            Image.asset(AssetUtils.video_img),
                                      ),
                                      Container(
                                        width: screenWidth,
                                        height: screenHeight / 4,
                                        color: HexColor('#000000')
                                            .withOpacity(0.65),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        alignment: FractionalOffset.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.black),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.play_arrow,
                                            color: ColorUtils.primary_gold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(12),
                                //   child: AspectRatio(
                                //     aspectRatio: 16 / 9,
                                //     child: BetterPlayer(
                                //         controller: _betterPlayerController!),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 14, bottom: 0),
                          child: Text(
                            'Duration: 3 min 20 sec',
                            style: FontStyleUtility.h12(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PM'),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: HexColor('#0F0F0F'),
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
