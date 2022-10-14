import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderPage extends StatefulWidget {
  @override
  AddPromptPageState createState() => AddPromptPageState();
}

class AddPromptPageState extends State<LoaderPage> {
  TextEditingController nameAlbumController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<Color> _kDefaultRainbowColors = [
    ColorUtils.primary_gold
  ];

  @override
  Widget build(BuildContext context) {
    return animatedDialogueWithTextFieldAndButton(context);
  }

  animatedDialogueWithTextFieldAndButton(context) {
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        color: Color(0x66DD4D4),
        child: Column(
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
}
