import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

List<BoxShadow>? ContainerShadow = [
  BoxShadow(
    color: HexColor('#2A2A29'),
    offset: Offset(10, 10),
    blurRadius: 20,
  ),
];

Common_decoration() => BoxDecoration(
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
        offset: Offset(10, 10),
        blurRadius: 20,
      ),
    ],
    borderRadius: BorderRadius.circular(20));

Common_reverse_decoration() => BoxDecoration(
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
    borderRadius: BorderRadius.circular(10));
