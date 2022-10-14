import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

class common_button_gold extends StatelessWidget {
  final String title_text;
  final GestureTapCallback? onTap;

  const common_button_gold({Key? key, required this.title_text, this.onTap, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width:(width ?? 300) ,
        decoration: BoxDecoration(
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
                color: HexColor('#000000'),
                offset: Offset(0,10),
                blurRadius: 10
              )
            ],
            color: ColorUtils.primary_gold,
            borderRadius: BorderRadius.circular(10)),
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              title_text,
              style:
                  FontStyleUtility.h16(fontColor: Colors.black, family: 'PM'),
            )),
      ),
    );
  }
}

class common_button_black extends StatelessWidget {
  final String title_text;
  final GestureTapCallback? onTap;

  const common_button_black({Key? key, required this.title_text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 45,
        // width:(width ?? 300) ,
        decoration: BoxDecoration(
            border: Border.all(color: ColorUtils.primary_gold, width: 1),
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)),
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              title_text,
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_gold, family: 'PM'),
            )),
      ),
    );
  }
}
