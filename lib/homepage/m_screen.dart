import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Dashboard/dashboard_screen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

//
// class M_Screen extends StatefulWidget {
//   const M_Screen({Key? key}) : super(key: key);
//
//   @override
//   State<M_Screen> createState() => _M_ScreenState();
// }

// class _M_ScreenState extends State<M_Screen> {
//   Stopwatch watch = Stopwatch();
//   Timer? timer;
//   bool startStop = true;
//
//   String elapsedTime = '00:00:00';
//   List method_list = ['Hand', 'Flashlight'];
//   String method_selected = '';
//   List<ListMethodClass> method_time = [];
//
//   updateTime(Timer timer) {
//     if (watch.isRunning) {
//       if (mounted) {
//         setState(() {
//           print("startstop Inside=$startStop");
//           elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
//         });
//       }
//     }
//   }
//
//   final List<ChartData> chartData = [
//     ChartData("M", 10, 5, 12),
//     ChartData("T", 5, 4, 4),
//     ChartData("W", 2, 12, 4),
//     ChartData("T", 20, 11, 4),
//     ChartData("F", 10, 5, 4),
//     ChartData("S", 15, 7, 4),
//     ChartData("S", 10, 8, 4),
//   ];
//   TooltipBehavior? _tooltipBehavior;
//
//   selectdate(BuildContext context) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2010),
//       lastDate: DateTime(2025),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.dark(
//               primary: Colors.black,
//               onPrimary: Colors.white,
//               surface: ColorUtils.primary_grey,
//               // onPrimary: Colors.black, // <-- SEE HERE
//               onSurface: Colors.black,
//             ),
//             dialogBackgroundColor: ColorUtils.primary_gold,
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 primary: Colors.black, // button text color
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (selected != null && selected != selectedDate) {
//       setState(() {
//         showInvoiceDate = DateFormat('MM-dd-yyyy').format(selected).toString();
//       });
//     }
//   }
//
//   DateTime selectedDate = DateTime.now();
//   String showInvoiceDate = '';
//
//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(
//         enable: true,
//         borderWidth: 5,
//         color: Colors.transparent
//     );
//     super.initState();
//   }
//
//   bool show_details_graph = false;
//   TextEditingController method_new = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: ColorUtils.primary_gold,
//           ),
//         ),
//         title: Text(
//           Textutils.Masturbation,
//           style: FontStyleUtility.h16(
//               fontColor: ColorUtils.primary_gold, family: 'PM'),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.notifications_none_rounded,
//                 color: ColorUtils.primary_gold,
//               ))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(top: 15, left: 23, right: 23),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                   margin: EdgeInsets.all(0),
//                   alignment: Alignment.topCenter,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Image.asset(
//                         AssetUtils.star_icon,
//                         height: 22,
//                         width: 22,
//                       ),
//                       SizedBox(
//                         width: 7,
//                       ),
//                       Image.asset(
//                         AssetUtils.star_icon,
//                         height: 22,
//                         width: 22,
//                       ),
//                       SizedBox(
//                         width: 7,
//                       ),
//                       Image.asset(
//                         AssetUtils.star_icon,
//                         height: 22,
//                         width: 22,
//                       ),
//                     ],
//                   )),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: HexColor('#DD3931'), width: 5),
//                     borderRadius: BorderRadius.circular(100)),
//                 child: Container(
//                   height: 125,
//                   width: 125,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: ColorUtils.color3, width: 10),
//                       borderRadius: BorderRadius.circular(100)),
//                   child: Stack(
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           'K',
//                           style: TextStyle(
//                               color: HexColor('#DD3931').withOpacity(0.2),
//                               fontSize: 70,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Container(
//                         alignment: Alignment.center,
//                         child: Text(
//                           elapsedTime,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 25,
//                               fontWeight: FontWeight.w900),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 28,
//               ),
//               common_button_black(
//                 // height_: 75,
//                 onTap: () {
//                   print('object');
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       double width = MediaQuery
//                           .of(context)
//                           .size
//                           .width;
//                       double height = MediaQuery
//                           .of(context)
//                           .size
//                           .height;
//                       return BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                         child: AlertDialog(
//                             backgroundColor: Colors.transparent,
//                             contentPadding: EdgeInsets.zero,
//                             elevation: 0.0,
//                             // title: Center(child: Text("Evaluation our APP")),
//                             content: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 0),
//                                   // height: 122,
//                                   // width: 133,
//                                   // padding: const EdgeInsets.all(8.0),
//                                   decoration: BoxDecoration(
//                                       color: Colors.black,
//                                       border: Border.all(
//                                           color: ColorUtils.primary_gold,
//                                           width: 1),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0))),
//                                   alignment: Alignment.center,
//                                   child: Stack(
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.center,
//                                         child: ListView.builder(
//                                           padding: EdgeInsets.zero,
//                                           itemCount: method_list.length,
//                                           shrinkWrap: true,
//                                           itemBuilder:
//                                               (BuildContext context,
//                                               int index) {
//                                             return Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       method_selected =
//                                                       method_list[index];
//                                                       print(
//                                                           "method_selected $method_selected");
//                                                     });
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     child: Text(
//                                                       method_list[index],
//                                                       style: FontStyleUtility
//                                                           .h16(
//                                                           fontColor:
//                                                           ColorUtils
//                                                               .primary_gold,
//                                                           family: 'PM'),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       Align(
//                                         alignment: Alignment.topRight,
//                                         child: IconButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           icon: Icon(Icons.clear,
//                                             color: ColorUtils.primary_gold,),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       );
//                     },
//                   );
//                   // Get.to(DashboardScreen());
//                 },
//                 title_text: (method_selected.isNotEmpty
//                     ? method_selected
//                     : "Select Method"),
//               ),
//               SizedBox(
//                 height: 28,
//               ),
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         await stopWatch();
//                         print("paused_time.length.toString()${paused_time.length.toString()}");
//                         method_time.add(ListMethodClass(
//                             method_name: method_selected,
//                             pauses: paused_time.length.toString(),
//                             total_time: elapsedTime));
//                         setState(() {
//                           elapsedTime = '00:00:00';
//                           paused_time.clear();
//                         });
//                         print('method_time : ${method_time[0].total_time}');
//                         print('method_name : ${method_time[0].method_name}');
//                       },
//                       child: Container(
//                         height: 87,
//                         width: 87,
//                         decoration: BoxDecoration(
//                             color: Colors.black,
//                             border: Border.all(
//                                 color: ColorUtils.primary_gold, width: 1),
//                             borderRadius: BorderRadius.circular(100)),
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text(
//                             'Finish',
//                             style: FontStyleUtility.h16(
//                                 fontColor: ColorUtils.primary_gold,
//                                 family: 'PR'),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         startOrStop();
//                       },
//                       child: Container(
//                         height: 87,
//                         width: 87,
//                         decoration: BoxDecoration(
//                             color: ColorUtils.primary_gold,
//                             border: Border.all(
//                                 color: ColorUtils.primary_gold, width: 1),
//                             borderRadius: BorderRadius.circular(100)),
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text(
//                             (startStop ? 'Start' : 'Pause'),
//                             style: FontStyleUtility.h16(
//                                 fontColor: Colors.black, family: 'PR'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 28,
//               ),
//               Container(
//                   child: (paused_time.length > 0
//                       ? Column(
//                     children: [
//                       Container(
//                         margin:
//                         EdgeInsets.only(bottom: 0, right: 0, left: 0),
//                         height: 1,
//                         color: ColorUtils.primary_gold,
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(bottom: 0, top: 17.5),
//                         child: ListView.builder(
//                           itemCount: paused_time.length,
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemBuilder: (BuildContext context, int index) {
//                             return Container(
//                               margin: EdgeInsets.only(bottom: 20),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Pause ${index + 1}",
//                                     style: FontStyleUtility.h15(
//                                         fontColor:
//                                         ColorUtils.primary_gold,
//                                         family: 'PR'),
//                                   ),
//                                   Text(
//                                     paused_time[index],
//                                     style: FontStyleUtility.h15(
//                                         fontColor:
//                                         ColorUtils.primary_gold_light,
//                                         family: 'PR'),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Container(
//                         margin:
//                         EdgeInsets.only(bottom: 0, right: 0, left: 0),
//                         height: 1,
//                         color: ColorUtils.primary_gold,
//                       ),
//                     ],
//                   )
//                       : SizedBox.shrink())),
//               SizedBox(
//                 height: 21,
//               ),
//
//               Container(
//                 child: (method_time.length > 0
//                     ? Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Progress Tracker',
//                         style: FontStyleUtility.h14(
//                             fontColor: HexColor('#AAAAAA'), family: 'PR'),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 29,
//                     ),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(010),
//                             color: Colors.black,
//                             border: Border.all(
//                                 color: ColorUtils.primary_gold,
//                                 width: 1)),
//                         child: Column(
//                           children: [
//                             Container(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color:
//                                               ColorUtils.primary_gold,
//                                               width: 0.5)),
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.symmetric(
//                                             vertical: 12.0),
//                                         child: Text(
//                                           'Method Used',
//                                           style: FontStyleUtility.h14(
//                                               fontColor:
//                                               ColorUtils.primary_gold,
//                                               family: 'PR'),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color:
//                                               ColorUtils.primary_gold,
//                                               width: 0.5)),
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.symmetric(
//                                             vertical: 12.0),
//                                         child: Text(
//                                           'Pause',
//                                           style: FontStyleUtility.h14(
//                                               fontColor:
//                                               ColorUtils.primary_gold,
//                                               family: 'PR'),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color:
//                                               ColorUtils.primary_gold,
//                                               width: 0.5)),
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.symmetric(
//                                             vertical: 12.0),
//                                         child: Text(
//                                           'Current time',
//                                           style: FontStyleUtility.h14(
//                                               fontColor:
//                                               ColorUtils.primary_gold,
//                                               family: 'PR'),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: method_time.length,
//                               itemBuilder:
//                                   (BuildContext context, int index) {
//                                 return Container(
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: ColorUtils
//                                                       .primary_gold,
//                                                   width: 0.5)),
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.all(4.5),
//                                             child: Text(
//                                               '${method_time[index]
//                                                   .method_name}',
//                                               style: FontStyleUtility.h14(
//                                                   fontColor: ColorUtils
//                                                       .primary_gold,
//                                                   family: 'PR'),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: ColorUtils
//                                                       .primary_gold,
//                                                   width: 0.5)),
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.all(4.5),
//                                             child: Text(
//                                               '${method_time[index]
//                                                   .pauses}',
//                                               style: FontStyleUtility.h14(
//                                                   fontColor: Colors.white,
//                                                   family: 'PR'),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: ColorUtils
//                                                       .primary_gold,
//                                                   width: 0.5)),
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.all(4.5),
//                                             child: Text(
//                                               '${method_time[index]
//                                                   .total_time}',
//                                               style: FontStyleUtility.h14(
//                                                   fontColor: Colors.white,
//                                                   family: 'PR'),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                             Container(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             double width = MediaQuery
//                                                 .of(context)
//                                                 .size
//                                                 .width;
//                                             double height = MediaQuery
//                                                 .of(context)
//                                                 .size
//                                                 .height;
//                                             return BackdropFilter(
//                                               filter: ImageFilter.blur(
//                                                   sigmaX: 10, sigmaY: 10),
//                                               child: AlertDialog(
//                                                   backgroundColor: Colors
//                                                       .transparent,
//                                                   contentPadding: EdgeInsets
//                                                       .zero,
//                                                   elevation: 0.0,
//                                                   // title: Center(child: Text("Evaluation our APP")),
//                                                   content: Container(
//                                                     width: MediaQuery.of(context).size.width,
//
//                                                     child: Container(
//                                                       height: MediaQuery.of(context).size.height/4.5,
//                                                       width : MediaQuery.of(context).size.width,
//                                                       margin: EdgeInsets
//                                                           .symmetric(
//                                                           horizontal: 10,
//                                                           vertical: 0),
//                                                       // padding: const EdgeInsets.all(8.0),
//                                                       decoration: BoxDecoration(
//                                                           color: Colors.black,
//                                                           border: Border.all(
//                                                               color: ColorUtils
//                                                                   .primary_gold,
//                                                               width: 1),
//                                                           borderRadius: BorderRadius
//                                                               .all(
//                                                               Radius.circular(
//                                                                   10.0))),
//                                                       alignment: Alignment
//                                                           .center,
//                                                       child: Padding(
//                                                         padding: const EdgeInsets
//                                                             .all(8.0),
//                                                         child: Stack(
//                                                           children: [
//                                                             Align(
//                                                                 alignment: Alignment
//                                                                     .center,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     SizedBox(
//                                                                       height: 0,
//                                                                     ),
//                                                                     Container(
//                                                                       child: CommonTextFormField_text(
//                                                                         controller: method_new,
//                                                                         labelText: 'Add more method',
//                                                                         title: 'Add more method',
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height: 10,
//                                                                     ),
//                                                                     GestureDetector(
//                                                                       onTap: (){
//                                                                         setState(() {
//                                                                           method_list.add(method_new.text);
//                                                                           method_new.clear();
//                                                                           Navigator.pop(context);
//
//                                                                         });
//                                                                       },
//                                                                       child: Container(
//                                                                         alignment: Alignment.topRight,
//                                                                         child: Text(
//                                                                           'Add',
//                                                                           style: FontStyleUtility
//                                                                               .h12(
//                                                                               fontColor: ColorUtils
//                                                                                   .primary_grey,
//                                                                               family: 'PR'),),
//                                                                       ),
//                                                                     )
//                                                                     // common_button_gold(
//                                                                     //   onTap: () {
//                                                                     //     Get
//                                                                     //         .to(
//                                                                     //         DashboardScreen());
//                                                                     //   },
//                                                                     //   title_text: 'Go to Dashboard',
//                                                                     // ),
//                                                                   ],
//                                                                 )
//                                                             ),
//                                                             // Align(
//                                                             //   alignment: Alignment
//                                                             //       .topRight,
//                                                             //   child: IconButton(
//                                                             //     onPressed: () {
//                                                             //       Navigator
//                                                             //           .pop(
//                                                             //           context);
//                                                             //     },
//                                                             //     icon: Icon(
//                                                             //       Icons.clear,
//                                                             //       color: ColorUtils
//                                                             //           .primary_gold,),
//                                                             //   ),
//                                                             // )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             );
//                                           },
//                                         );
//                                       },
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color:
//                                                 ColorUtils.primary_gold,
//                                                 width: 0.5)),
//                                         child: Padding(
//                                           padding:
//                                           const EdgeInsets.symmetric(
//                                               vertical: 4.5),
//                                           child: Image.asset(
//                                             AssetUtils.plus_big, height: 23,
//                                             width: 10,),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color:
//                                               ColorUtils.primary_gold,
//                                               width: 0.5)),
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.all(4.5),
//
//                                         child: Text(
//                                           ' ',
//                                           style: FontStyleUtility.h14(
//                                               fontColor:
//                                               ColorUtils.primary_gold,
//                                               family: 'PR'),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color:
//                                               ColorUtils.primary_gold,
//                                               width: 0.5)),
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.all(5),
//                                         child: Text(
//                                           ' ',
//                                           style: FontStyleUtility.h14(
//                                               fontColor:
//                                               ColorUtils.primary_gold,
//                                               family: 'PR'),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'History',
//                             style: FontStyleUtility.h14(
//                                 fontColor: ColorUtils.primary_gold,
//                                 family: 'PR'),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: ColorUtils.primary_gold,
//                                 borderRadius: BorderRadius.circular(50)
//                             ),
//                             child: IconButton(
//                               visualDensity: VisualDensity(
//                                   vertical: -4, horizontal: -4),
//                               onPressed: () {
//                                 selectdate(context);
//                               },
//                               iconSize: 15,
//                               icon: Icon(
//                                 Icons.calendar_today, color: Colors.black,),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                         height: 250,
//                         child: SfCartesianChart(
//                             plotAreaBorderColor:
//                             ColorUtils.primary_gold,
//                             primaryXAxis: CategoryAxis(
//                                 majorGridLines:
//                                 MajorGridLines(width: 0),
//                                 //Hide the axis line of y-axis
//                                 axisLine: AxisLine(width: 0)),
//                             primaryYAxis: NumericAxis(
//                               //Hide the gridlines of y-axis
//                                 majorGridLines:
//                                 MajorGridLines(width: 0),
//                                 //Hide the axis line of y-axis
//                                 axisLine: AxisLine(width: 0)),
//                             series: <ChartSeries<ChartData, String>>[
//                               // Renders column chart
//
//                               ColumnSeries<ChartData, String>(
//                                   dataSource: chartData,
//                                   width: 0.5,
//                                   spacing: 0.6,
//                                   color: HexColor('#DD3931'),
//                                   xValueMapper: (ChartData data, _) =>
//                                   data.x,
//                                   yValueMapper: (ChartData data, _) =>
//                                   data.y),
//                               ColumnSeries<ChartData, String>(
//                                   width: 0.5,
//                                   spacing: 0.6,
//
//                                   color: HexColor('#75C043'),
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) =>
//                                   data.x,
//                                   yValueMapper: (ChartData data, _) =>
//                                   data.y1),
//                               ColumnSeries<ChartData, String>(
//                                   width: 0.5,
//                                   spacing: 0.6,
//
//                                   color: HexColor('#1880C3'),
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) =>
//                                   data.x,
//                                   yValueMapper: (ChartData data, _) =>
//                                   data.y2),
//                             ])),
//                     Text(
//                       'April 7, 2022',
//                       style: FontStyleUtility.h16(
//                           fontColor: ColorUtils.primary_grey,
//                           family: 'PR'),
//                     ),
//                     Container(
//                         height: 250,
//                         child: SfCartesianChart(
//                             plotAreaBorderColor:
//                             ColorUtils.primary_gold,
//                             primaryXAxis: CategoryAxis(
//                                 majorGridLines:
//                                 MajorGridLines(width: 0),
//                                 //Hide the axis line of y-axis
//                                 axisLine: AxisLine(width: 0)),
//                             primaryYAxis: NumericAxis(
//                               //Hide the gridlines of y-axis
//                                 majorGridLines:
//                                 MajorGridLines(width: 0),
//                                 //Hide the axis line of y-axis
//                                 axisLine: AxisLine(width: 0)),
//                             series: <ChartSeries<ChartData, String>>[
//                               // Renders column chart
//
//                               ColumnSeries<ChartData, String>(
//                                   dataSource: chartData,
//                                   width: 0.5,
//                                   spacing: 0.6,
//                                   color: HexColor('#DD3931'),
//                                   xValueMapper: (ChartData data, _) =>
//                                   data.x,
//                                   yValueMapper: (ChartData data, _) =>
//                                   data.y),
//                               ColumnSeries<ChartData, String>(
//                                   width: 0.5,
//                                   spacing: 0.6,
//
//                                   color: HexColor('#75C043'),
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) =>
//                                   data.x,
//                                   yValueMapper: (ChartData data, _) =>
//                                   data.y1),
//                               ColumnSeries<ChartData, String>(
//                                   width: 0.5,
//                                   spacing: 0.6,
//
//                                   color: HexColor('#1880C3'),
//                                   dataSource: chartData,
//                                   xValueMapper: (ChartData data, _) =>
//                                   data.x,
//                                   yValueMapper: (ChartData data, _) =>
//                                   data.y2),
//                             ])),
//                     Container(
//                       child: Text(
//                         'Life time',
//                         style: FontStyleUtility.h16(
//                             fontColor: ColorUtils.primary_grey,
//                             family: 'PR'),
//                       ),
//                     ),
//                     Container(
//                         height: 250,
//                         child: SfCartesianChart(
//                             plotAreaBorderColor: ColorUtils.primary_gold,
//                             tooltipBehavior: _tooltipBehavior,
//                             primaryXAxis: CategoryAxis(
//                                 majorGridLines: MajorGridLines(width: 0),
//                                 axisLine: AxisLine(width: 0)),
//                             primaryYAxis: NumericAxis(
//                                 majorGridLines: MajorGridLines(width: 0),
//                                 axisLine: AxisLine(width: 0)),
//                             series: <ChartSeries>[
//                               LineSeries<ChartData2, String>(
//                                   dataSource: [
//                                     ChartData2(
//                                         'Jan', 4, HexColor('#75C043')),
//                                     ChartData2(
//                                         'Feb', 8, HexColor('#75C043')),
//                                     ChartData2(
//                                         'Mar', 4, HexColor('#75C043')),
//                                     ChartData2(
//                                         'Apr', 2, HexColor('#75C043')),
//                                     ChartData2(
//                                         'May', 4, HexColor('#75C043'))
//                                   ],
//                                   // Bind the color for all the data points from the data source
//                                   pointColorMapper:
//                                       (ChartData2 data, _) => data.color,
//                                   xValueMapper: (ChartData2 data, _) =>
//                                   data.x,
//                                   yValueMapper: (ChartData2 data, _) =>
//                                   data.y)
//                             ]))
//                   ],
//                 )
//                     : SizedBox.shrink()),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   startOrStop() {
//     if (startStop) {
//       startWatch();
//     } else {
//       stopWatch();
//     }
//   }
//
//   startWatch() {
//     setState(() {
//       startStop = false;
//       watch.start();
//       timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
//     });
//   }
//
//   stopWatch() {
//     setState(() {
//       startStop = true;
//       watch.stop();
//       setTime();
//     });
//   }
//
//   List paused_time = [];
//
//   setTime() {
//     var timeSoFar = watch.elapsedMilliseconds;
//     setState(() {
//       elapsedTime = transformMilliSeconds(timeSoFar);
//     });
//     paused_time.add(elapsedTime);
//     print("elapsedTime $elapsedTime");
//     print("elapsedTime Listtttttt $paused_time");
//   }
//
//   transformMilliSeconds(int milliseconds) {
//     int hundreds = (milliseconds / 10).truncate();
//     int seconds = (hundreds / 100).truncate();
//     int minutes = (seconds / 60).truncate();
//     int hours = (minutes / 60).truncate();
//
//     String hoursStr = (hours % 60).toString().padLeft(2, '0');
//     String minutesStr = (minutes % 60).toString().padLeft(2, '0');
//     String secondsStr = (seconds % 60).toString().padLeft(2, '0');
//
//     return "$hoursStr:$minutesStr:$secondsStr";
//   }
// }
// class methods_list {
//   final String? method_name;
//   final String? color;
//
//   methods_list({ this.method_name,  this.color});
//
//   factory methods_list.fromJson(Map<String, dynamic> jsonData) {
//     return methods_list(
//       method_name: jsonData['method_name'],
//       color: jsonData['color'],
//     );
//   }
//
//   static Map<String, dynamic> toMap(methods_list music) => {
//     'method_name': music.method_name,
//     'color': music.color,
//
//   };
//
//   static String encode(List<methods_list> musics) => json.encode(
//     musics
//         .map<Map<String, dynamic>>((music) => methods_list.toMap(music))
//         .toList(),
//   );
//
//   static List<methods_list> decode(String musics) =>
//       (json.decode(musics) as List<dynamic>)
//           .map<methods_list>((item) => methods_list.fromJson(item))
//           .toList();
// }
class methods_list {
  final String? method_name;
  final String? method_id;
  final String? color;

  methods_list({ this.method_name,this.method_id,  this.color});
}
// class methods_list {
//   String? method_name;
//   String? color;
//
// // added '?'
//   methods_list(
//       {this.method_name, this.color});
// // can also add 'required' keyword
// }


class ListMethodClass {
  String? method_name;
  String? method_id;
  String? pauses;
  String? total_time;
  String? color;
  List? pause_time;
  String? id;

// added '?'
  ListMethodClass(
      {this.method_name,this.method_id, this.pauses, this.total_time,this.pause_time, this.color, this.id});
// can also add 'required' keyword
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);

  final String x;
  final double y;
  final double y1;
  final double y2;
}


class ChartData2 {
  ChartData2(this.x, this.x1, this.y, this.color, this.pause_time);
  final double pause_time;
  final String x;
  final String x1;
  final double y;
  final String color;
}


class ChartData3 {
  ChartData3(this.x, this.x1, this.y, this.color, this.pause_time);
 final double pause_time;
  final String x;
  final String x1;
  final DateTime y;
  final String color;
}


class ChartData0 {
  ChartData0(this.x, this.x1, this.y, this.color);

  final String x;
  final String x1;
  final double y;
  final String color;
}


