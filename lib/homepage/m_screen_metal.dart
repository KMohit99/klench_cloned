import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/homepage/controller/m_screen_controller.dart';
import 'package:klench_/homepage/m_screen_metal.dart';
import 'package:klench_/homepage/swipe_controller.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Dashboard/dashboard_screen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';
import '../utils/page_loader.dart';
import 'controller/kegel_excercise_controller.dart';
import 'm_screen.dart';
import 'm_screen_metal.dart';
import 'model/WeeklyData.dart';
import 'model/getTechniqueModel.dart';
import 'model/m_screen_dailyData_model.dart';
import 'model/m_screen_get_method_model.dart';
import 'model/m_screen_lifetimeData_model.dart';
import 'model/m_screen_post_method_moel.dart';
import 'model/m_screen_weekly_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class M_ScreenMetal extends StatefulWidget {
  const M_ScreenMetal({Key? key}) : super(key: key);

  @override
  State<M_ScreenMetal> createState() => M_ScreenMetalState();
}

class M_ScreenMetalState extends State<M_ScreenMetal>
    with TickerProviderStateMixin {
  final Masturbation_screen_controller _masturbation_screen_controller =
  Get.put(Masturbation_screen_controller(),
      tag: Masturbation_screen_controller().toString());

  Stopwatch watch = Stopwatch();
  Timer? timer;

  Stopwatch watch2 = Stopwatch();
  Timer? timer2;

  bool startStop = true;
  bool started = true;
  bool button_keep = true;
  Color? method_color;

  String elapsedTime = '00:00';
  String elapsedTime2 = '00:00';

  // List<methods_list> _masturbation_screen_controller.method_list = <methods_list>[
  //   'Hand',
  //   'Dildo',
  //   'Sex',
  //   'Fleshlight'
  // ];
  String method_selected = '';
  String method_selected_id = '';
  String method_selected_color = '';
  List<ListMethodClass> method_time = [];
  List<ListMethodClass> method_data = [];
  bool timer_started = false;

  List list = [
    'FF005AFF',
    'FFFFFFFF',
    'FFFFDE00',
    'FFBBFF00',
    'FFD96BE8',
    'FFFF6000',
    'FF349400',
    'FF8C0D37',
  ];

  List List_content = [
    "premature ejaculation is when a person ejaculates under 2 – 3 minutes. If you don’t ejaculate in 2-3 minutes you do not have premature ejaculation.",
    "Make sure you edge 4 times.",
    "Do not watch porn. Unless you know how to control your arousal level and you know how to edge.",
    "Schedule when you masturbate that way there is no interruptions.",
    "Figure out what muscles in your body tense up and the next time you masturbate try not to tense them up",
    "Average penis size is between 4 1⁄2 and 6 inches.",
    "When you are masturbating do not think that your main goal is to ejaculate. Your main goal is pleasure",
    "When you are edging and you are not stimulating your penis try stimulating other parts of your body",
    "Prostate stimulation can help you last longer in bed and have even greater orgasms.",
    "It is a myth that women want bigger and stronger penises. If its too big it can be very painful for them.",
    "Try to relax your butt when having sex.",
    "Breathing technique: Breath with your stomach not with your chest. If you don’t know how are you breathing, put one hand on your stomach and one on your chest then take a deep breath and feel which hand moves first.",
    "Breathing technique: inhale with your nose four times and exhale four times with your mouth.",
    "Do not insert anything in your anus if is not created for anal play. Link for anal play below.",
    "Masturbate using a flashlight or something that is soft and not rough.",
    "Do not smoke.",
    "If you have a delay ejaculation try masturbating 3-4 time per week.",
    "Do not use Viagra. And if so, read the label.",
    "Taking testosterone when not necessary can make you infertile.",
    "You are the only one in charge of making yourself orgasm.",
    "Try listening to music and masturbating to the rhythm of the music.",
    "If you’re not used to condoms. You should masturbate with condoms to get used to the sensation.",
    "Every time you ejaculate make sure you celebrate and smile.",
    "If your insecure of your body, masturbate in front of a mirror.",
    "Try not to eat any meat or dairy especially red meat. It thickens your blood vessels and has a lot of toxics.",
    "If your penis is too sensitive. Try to desensitize it by stimulating the parts where is very sensitive very often while you’re masturbating.",
    "Desensitize your visualization by visualizing the hottest girl you can. And watch porn but ONLY when you control your arousal level.",
    "When you are masturbating do not be afraid of getting dirty/ messy, you’ll clean it after you are done.",
    "Invest in rechargeable batteries, extension cord and or portable charger to be prepared when you’re about to masturbate.",
    "Do not use Vaseline or vapor rub to masturbate, use lubricant or other options like coconut oil and olive oil.",
    "If you last less than 10 minutes, set your goal to surpass 10 minutes followed by 15 and 20 minute goals.",
    "After hitting the 20 minute mark, ejaculate.",
    "Always use lubricant to masturbate.",
    "If these don’t help see a doctor. If you are depressed or thinking of harming yourself in anyway seek help links are below.",
  ];

  final _random = Random();

  bool four_min = false;
  bool ten_min = false;
  bool thirty_min = false;

  updateTime(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);

          print(elapsedTime);

          if (elapsedTime == '04:00') {
            four_min = true;
            ten_min = false;
          } else if (elapsedTime == '10:00') {
            four_min = false;
            ten_min = true;
          }
          percent += 1;
          if (percent >= 100) {
            percent = 0.0;
          }
        });
      }
    }
  }

  updateTime2(Timer timer) {
    if (watch2.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime2 = transformMilliSeconds(watch2.elapsedMilliseconds);

          print("elapsedTime2 $elapsedTime2");

          if (elapsedTime2 == '30:00') {
            watch2.stop();
            watch2.reset();
            timer_started = false;
            elapsedTime = '00:00';
            percent = 0.0;
            // method_selected = '';
            watch.reset();
            paused_time.clear();
            _scaleDialog2(context: context, message: '');
            thirty_min = true;
            print("GreetingsPopUpButton");
          }
        });
      }
    }
  }

  static List<ChartData> chartData = [
    ChartData("M", 1, 5, 1),
    ChartData("T", 5, 4, 4),
    ChartData("W", 5, 2, 4),
    ChartData("T", 2, 3, 4),
    ChartData("F", 2, 5, 4),
    ChartData("S", 1, 3, 4),
    ChartData("S", 1, 2, 4),
  ];
  static List<ChartData> chartData2 = [
    ChartData("M", 10, 8, 10),
    ChartData("T", 8, 10, 7),
    ChartData("W", 8, 2, 1),
    ChartData("T", 20, 5, 9),
    ChartData("F", 15, 9, 8),
    ChartData("S", 16, 7, 9),
    ChartData("S", 10, 10, 6),
  ];
  static List<ChartData> chartData3 = [
    ChartData("M", 1, 5, 1),
    ChartData("T", 5, 4, 4),
    ChartData("W", 5, 2, 4),
    ChartData("T", 2, 3, 4),
    ChartData("F", 2, 5, 4),
    ChartData("S", 1, 3, 4),
    ChartData("S", 1, 2, 4),
  ];
  static List<ChartData> chartData4 = [
    ChartData("M", 1, 5, 1),
    ChartData("T", 5, 4, 4),
    ChartData("W", 5, 2, 4),
    ChartData("T", 2, 3, 4),
    ChartData("F", 2, 5, 4),
    ChartData("S", 1, 3, 4),
    ChartData("S", 1, 2, 4),
  ];

  // static List<ChartData2> chartData_life = [
  //   ChartData2('12 AM', 'sex', 2, HexColor('#75C043')),
  //   ChartData2('1 AM', 'sex', 1, HexColor('#75C043')),
  //   ChartData2('2 AM', 'sex', 3, HexColor('#75C043')),
  //   ChartData2('2:30 AM', 'sex', 5, HexColor('#75C043')),
  //   ChartData2('2:45 AM', 'sex', 7, HexColor('#75C043')),
  //   ChartData2('3 AM', 'sex', 9, HexColor('#75C043')),
  //   ChartData2('3:15 AM', 'sex', 5, HexColor('#75C043')),
  //   ChartData2('4 AM', 'sex', 8, HexColor('#75C043')),
  //   ChartData2('5 AM', 'sex', 9, HexColor('#75C043')),
  //   ChartData2('6 AM', 'sex', 4, HexColor('#75C043')),
  //   ChartData2('7 AM', 'sex', 3, HexColor('#75C043')),
  //   ChartData2('7:15 AM', 'sex', 2, HexColor('#75C043')),
  //   ChartData2('7:30 AM', 'sex', 9, HexColor('#75C043')),
  //   ChartData2('8 AM', 'sex', 4, HexColor('#75C043')),
  //   ChartData2('8:05 AM', 'sex', 2, HexColor('#75C043')),
  //   ChartData2('8:30 AM', 'sex', 5, HexColor('#75C043')),
  //   ChartData2('8:40 AM', 'sex', 8, HexColor('#75C043')),
  //   ChartData2('9 AM', 'sex', 6, HexColor('#75C043')),
  //   ChartData2('10 AM', 'sex', 8, HexColor('#75C043')),
  //   ChartData2('11 AM', 'sex', 4, HexColor('#75C043')),
  //   ChartData2('12 PM', 'sex', 5, HexColor('#75C043')),
  //   ChartData2('6 PM', 'sex', 2, HexColor('#75C043')),
  //   ChartData2('7 PM', 'sex', 2, HexColor('#75C043')),
  //   ChartData2('8 PM', 'sex', 1, HexColor('#75C043')),
  //   ChartData2('8:15 PM', 'sex', 3, HexColor('#75C043')),
  //   ChartData2('8:30 PM', 'sex', 5, HexColor('#75C043')),
  //   ChartData2('8:45 PM', 'sex', 7, HexColor('#75C043')),
  //   ChartData2('9 PM', 'sex', 9, HexColor('#75C043')),
  //   ChartData2('9:15 PM', 'sex', 5, HexColor('#75C043')),
  //   ChartData2('10 PM', 'sex', 8, HexColor('#75C043')),
  //   ChartData2('10:15 PM', 'sex', 9, HexColor('#75C043')),
  //   ChartData2('10:20 PM', 'sex', 4, HexColor('#75C043')),
  //   ChartData2('11 PM', 'sex', 3, HexColor('#75C043')),
  //   ChartData2('11:30 PM', 'sex', 2, HexColor('#75C043')),
  //   ChartData2('11:35 PM', 'sex', 6, HexColor('#75C043')),
  //   ChartData2('11:40 PM', 'sex', 8, HexColor('#75C043')),
  //   ChartData2('11:45 PM', 'sex', 4, HexColor('#75C043')),
  //   ChartData2('11:50 PM', 'sex', 5, HexColor('#75C043')),
  //   ChartData2('11:55 PM', 'sex', 2, HexColor('#75C043')),
  // ];
  // static List<ChartData2> chartData_life2 = [
  //   ChartData2('M', 'sex', 10, HexColor('#75C043')),
  //   ChartData2('T', 'sex', 14, HexColor('#75C043')),
  //   ChartData2('W', 'sex', 10, HexColor('#75C043')),
  //   ChartData2('T', 'sex', 8, HexColor('#75C043')),
  //   ChartData2('F', 'sex', 12, HexColor('#75C043')),
  //   ChartData2('S', 'sex', 9, HexColor('#75C043')),
  //   ChartData2('S', 'sex', 14, HexColor('#75C043'))
  // ];
  // static List<ChartData2> chartData_life3 = [
  //   ChartData2('Jan', 'sex', 10, HexColor('#75C043')),
  //   ChartData2('Feb', 'sex', 18, HexColor('#75C043')),
  //   ChartData2('Mar', 'sex', 40, HexColor('#75C043')),
  //   ChartData2('Apr', 'sex', 20, HexColor('#75C043')),
  //   ChartData2('May', 'sex', 24, HexColor('#75C043')),
  //   ChartData2('May', 'sex', 14, HexColor('#75C043'))
  // ];

  List data_graph = [
    chartData,
    chartData2,
    chartData3,
    chartData4,
  ];
  List data_graph2 = [
    // chartData_life,
    // chartData_life2,
    // chartData_life3,
  ];

  var graph_;
  var graph_life;

  TooltipBehavior? _tooltipBehavior;
  TooltipBehavior? _tooltipBehavior2;
  TrackballBehavior? _trackballBehavior;
  ZoomPanBehavior? _zoomPanBehavior;

  SelectionBehavior? _selectionBehavior;
  CrosshairBehavior? _crosshairBehavior;
  String? selected_date =
  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  bool addnewTap = false;

  addmethod_popup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              elevation: 0.0,
              // title: Center(child: Text("Evaluation our APP")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                    offset: Offset(10, 10),
                                    blurRadius: 10)
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //         color: ColorUtils.primary_gold, width: 1),
                          //     // color: Colors.black.withOpacity(0.65),
                          //     gradient: LinearGradient(
                          //       begin: Alignment.topLeft,
                          //       end: Alignment.bottomRight,
                          //       // stops: [0.1, 0.5, 0.7, 0.9],
                          //       colors: [
                          //         // HexColor("#000000").withOpacity(1),
                          //         // HexColor("#000000").withOpacity(1),
                          //         HexColor("#ce942f").withOpacity(1),
                          //
                          //         HexColor("#ecdc8f").withOpacity(1),
                          //         HexColor("#e5cc79").withOpacity(1),
                          //         HexColor("#ce942f").withOpacity(1),
                          //         // HexColor("#37393D").withOpacity(1),
                          //         // ColorUtils.primary_gold.withOpacity(1),
                          //
                          //         // HexColor("#000000").withOpacity(1),
                          //         // ColorUtils.primary_gold.withOpacity(1),
                          //       ],
                          //     ),
                          //     boxShadow: [
                          //       BoxShadow(
                          //           color: HexColor('#04060F'),
                          //           offset: Offset(10, 10),
                          //           blurRadius: 10)
                          //     ],
                          //     borderRadius: BorderRadius.circular(15)),

                          child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 0,
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //   margin: EdgeInsets.only(left: 18),
                                        //   child: Text('Add more method',
                                        //       style: FontStyleUtility.h14(
                                        //           fontColor:
                                        //               ColorUtils.primary_grey,
                                        //           family: 'Pr')),
                                        // ),
                                        SizedBox(
                                          height: 11,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          // width: 300,
                                          // decoration: BoxDecoration(
                                          //     // color: Colors.black.withOpacity(0.65),
                                          //     gradient: LinearGradient(
                                          //       begin: Alignment.centerLeft,
                                          //       end: Alignment.centerRight,
                                          //       // stops: [0.1, 0.5, 0.7, 0.9],
                                          //       colors: [
                                          //         HexColor("#36393E")
                                          //             .withOpacity(1),
                                          //         HexColor("#020204")
                                          //             .withOpacity(1),
                                          //       ],
                                          //     ),
                                          //     // boxShadow: [
                                          //     //   BoxShadow(
                                          //     //       color: HexColor('#04060F'),
                                          //     //       offset: Offset(10, 10),
                                          //     //       blurRadius: 10)
                                          //     // ],
                                          //     borderRadius:
                                          //         BorderRadius.circular(20)),
                                          child: TextFormField(
                                            maxLength: 150,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 14,
                                                  bottom: 14),
                                              alignLabelWithHint: false,
                                              isDense: true,
                                              hintText: 'Add more method',
                                              counterStyle: TextStyle(
                                                height: double.minPositive,
                                              ),
                                              counterText: "",
                                              filled: true,
                                              border: InputBorder.none,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    ColorUtils.primary_gold,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    ColorUtils.primary_grey,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              // disabledBorder:  OutlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //       color: ColorUtils.primary_grey,
                                              //       width: 1),
                                              //   borderRadius: BorderRadius.all(
                                              //       Radius.circular(10)),
                                              // ),
                                              hintStyle: FontStyleUtility.h14(
                                                  fontColor:
                                                  HexColor('#CBCBCB'),
                                                  family: 'PR'),
                                            ),
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                ColorUtils.primary_grey,
                                                family: 'PR'),
                                            controller: method_new,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (method_new.text.isNotEmpty) {
                                          // setState(() {
                                          //   _masturbation_screen_controller
                                          //       .method_list
                                          //       .add(methods_list(
                                          //           method_name:
                                          //               method_new.text,
                                          //           color: list[random.nextInt(
                                          //               list.length)]));
                                          //   // method_new.clear();
                                          // });
                                          setState(() {
                                            addnewTap = true;
                                          });
                                          await Masturbation_Post_Method(
                                              method_name: method_new.text,
                                              method_color: list[
                                              random.nextInt(list.length)]);

                                          setState(() {
                                            method_new.clear();
                                          });

                                          setState(() {
                                            method_selected =
                                            _masturbation_screen_controller
                                                .method_list
                                                .last
                                                .method_name!;
                                            method_selected_color =
                                            _masturbation_screen_controller
                                                .method_list.last.color!;
                                            method_selected_id =
                                            _masturbation_screen_controller
                                                .method_list
                                                .last
                                                .method_id!;
                                          });

                                          print(
                                              "method_selected $method_selected");
                                          print(
                                              "method_selected ${_masturbation_screen_controller.method_list[index].color!.toString()}");
                                          started = true;
                                          // final String encodedData =
                                          // methods_list.encode(
                                          //     _masturbation_screen_controller
                                          //         .method_list);
                                          // await PreferenceManager().setList(
                                          //     URLConstants.method_list,
                                          //     encodedData);

                                          // await PreferenceManager()
                                          //     .setList(
                                          //     URLConstants
                                          //         .method_list,
                                          //     _masturbation_screen_controller
                                          //         .method_list);
                                          setState(() {
                                            addnewTap = false;
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            4,
                                        margin: EdgeInsets.all(0),
                                        // width: 300,
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
                                            border: Border.all(
                                                color: addnewTap
                                                    ? ColorUtils.primary_gold
                                                    : Colors.transparent,
                                                width: 1),
                                            borderRadius:
                                            BorderRadius.circular(10)),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 15),
                                          child: Text(
                                            'Add',
                                            textAlign: TextAlign.center,
                                            style: FontStyleUtility.h16(
                                                fontColor:
                                                ColorUtils.primary_grey,
                                                family: 'PM'),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // GestureDetector(
                                    //   onTap: () async {
                                    //     if (method_new.text.isNotEmpty) {
                                    //       // setState(() {
                                    //       //   _masturbation_screen_controller
                                    //       //       .method_list
                                    //       //       .add(methods_list(
                                    //       //           method_name:
                                    //       //               method_new.text,
                                    //       //           color: list[random.nextInt(
                                    //       //               list.length)]));
                                    //       //   // method_new.clear();
                                    //       // });
                                    //
                                    //       await Masturbation_Post_Method(
                                    //           method_name: method_new.text,
                                    //           method_color: list[
                                    //               random.nextInt(list.length)]);
                                    //       setState(() {
                                    //         method_new.clear();
                                    //       });
                                    //
                                    //       setState(() {
                                    //         method_selected =
                                    //             _masturbation_screen_controller
                                    //                 .method_list
                                    //                 .last
                                    //                 .method_name!;
                                    //         method_selected_color =
                                    //             _masturbation_screen_controller
                                    //                 .method_list.last.color!;
                                    //         method_selected_id =
                                    //             _masturbation_screen_controller
                                    //                 .method_list
                                    //                 .last
                                    //                 .method_id!;
                                    //       });
                                    //
                                    //       print(
                                    //           "method_selected $method_selected");
                                    //       print(
                                    //           "method_selected ${_masturbation_screen_controller.method_list[index].color!.toString()}");
                                    //       started = true;
                                    //       // final String encodedData =
                                    //       // methods_list.encode(
                                    //       //     _masturbation_screen_controller
                                    //       //         .method_list);
                                    //       // await PreferenceManager().setList(
                                    //       //     URLConstants.method_list,
                                    //       //     encodedData);
                                    //
                                    //       // await PreferenceManager()
                                    //       //     .setList(
                                    //       //     URLConstants
                                    //       //         .method_list,
                                    //       //     _masturbation_screen_controller
                                    //       //         .method_list);
                                    //       Navigator.pop(context);
                                    //     }
                                    //   },
                                    //   child: Container(
                                    //     alignment: Alignment.topRight,
                                    //     child: Text(
                                    //       'Add',
                                    //       style: FontStyleUtility.h12(
                                    //           fontColor:
                                    //               ColorUtils.primary_grey,
                                    //           family: 'PR'),
                                    //     ),
                                    //   ),
                                    // )
                                    // common_button_gold(
                                    //   onTap: () {
                                    //     Get
                                    //         .to(
                                    //         DashboardScreen());
                                    //   },
                                    //   title_text: 'Go to Dashboard',
                                    // ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 3, bottom: 3),
                          alignment: Alignment.topRight,
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
                                    // BoxShadow(
                                    //     color: HexColor('#04060F'),
                                    //     offset: Offset(0, 3),
                                    //     blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 20,
                                  color: ColorUtils.primary_grey,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  selectdate(BuildContext context) async {
    DateTime? selected;
    // await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime(1930),
    //   lastDate: DateTime(2025),
    //   builder: (context, child) {
    //     return Theme(
    //       data: Theme.of(context).copyWith(
    //         colorScheme: ColorScheme.dark(
    //           primary: Colors.black,
    //           onPrimary: Colors.white,
    //           surface: ColorUtils.primary_grey,
    //           // onPrimary: Colors.black, // <-- SEE HERE
    //           onSurface: Colors.black,
    //         ),
    //         dialogBackgroundColor: ColorUtils.primary_gold,
    //         textButtonTheme: TextButtonThemeData(
    //           style: TextButton.styleFrom(
    //             primary: Colors.black, // button text color
    //           ),
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    // );
    // return Container(
    //   height: 200,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(15),
    //       gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [
    //           HexColor("#000000").withOpacity(1),
    //           HexColor("#04060F").withOpacity(1),
    //           HexColor("#000000").withOpacity(1),
    //
    //         ],
    //       ),
    //       boxShadow: [
    //         BoxShadow(
    //             color: HexColor('#04060F'),
    //             offset: Offset(3, 3),
    //             blurRadius: 10)
    //       ]),
    //   child: Stack(
    //     children: [
    //       CupertinoTheme(
    //         data: CupertinoThemeData(
    //           brightness: Brightness.dark,
    //         ),
    //         child: CupertinoDatePicker(
    //           mode: CupertinoDatePickerMode.time,
    //           onDateTimeChanged: (DateTime value) {
    //             selected= value;
    //             print("${value.hour}:${value.minute}");
    //
    //             duration = AgeCalculator.age(selected!);
    //             print('Your age is $duration');

    //             setState(() {
    //               (duration!.years <= 50
    //                   ? _signUpScreenController.level = 'Normal'
    //                   : _signUpScreenController.level = 'Easy');
    //             });
    //
    //             print(_signUpScreenController.level);
    //
    //             if (selected != selectedDate) {
    //               setState(() {
    //                 _signUpScreenController.date_birth =
    //                     DateFormat('MM-dd-yyyy').format(selected!).toString();
    //                 _signUpScreenController.DoBController.text =
    //                     _signUpScreenController.date_birth.toString();
    //               });
    //             }
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
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
                        offset: const Offset(-10, 10),
                        blurRadius: 20)
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              HexColor("#000000").withOpacity(1),
                              HexColor("#04060F").withOpacity(1),
                              HexColor("#000000").withOpacity(1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor('#04060F'),
                                offset: Offset(3, 3),
                                blurRadius: 10)
                          ]),
                      child: Stack(
                        children: [
                          CupertinoTheme(
                            data: CupertinoThemeData(
                              brightness: Brightness.dark,
                            ),
                            child: CupertinoDatePicker(
                              // use24hFormat: true,
                              mode: CupertinoDatePickerMode.date,
                              maximumDate: DateTime.now(),
                              initialDateTime:
                              DateTime.now().subtract(Duration(hours: 1)),
                              onDateTimeChanged: (DateTime value) async {
                                // print(value);
                                print(DateFormat('yyyy-MM-dd')
                                    .format(value)
                                    .toString());
                                setState(() {
                                  selected_date = DateFormat('yyyy-MM-dd')
                                      .format(value)
                                      .toString();
                                  print("selected_date $selected_date");
                                });
                                method_time.clear();
                                // m_screenDailyDataModel = null;

                                await Masturbation_Daily_Data_get_API();
                                // selected = value;
                                // print("${value.hour}:${value.minute}");
                                // var randomItem = (graph_..shuffle()).first;
                                // print("graph_[randomIndex]");
                                // // print(randomItem);
                                // print(randomItem);
                                // print(
                                //     "---------------------------------------");
                                // int randomIndex =
                                //     Random().nextInt(graph_.length);
                                // print("graph_[randomIndex]");
                                // print(randomIndex);
                                // print(graph_[randomIndex]);
                                //
                                // setState(() {
                                //   graph_ = data_graph[randomIndex];
                                // });

                                if (selected != null) {
                                  final now = DateTime.now();
                                  var selectedDateTime = DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                      selected.hour,
                                      selected.minute);

                                  if (selected != selectedDate) {
                                    setModalState(() {
                                      print(DateFormat('MM-dd-yyyy')
                                          .format(selected)
                                          .toString());
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  methodPopUp(
      {required BuildContext context,
        required String method_id,
        required String method_old}) async {
    DateTime? selected;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              elevation: 0.0,
              // title: Center(child: Text("Evaluation our APP")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                    offset: Offset(10, 10),
                                    blurRadius: 10)
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        print('Hellooo');
                                        await EditPopUp(
                                            context: context,
                                            method_name: method_old,
                                            method_id: method_id);
                                      },
                                      child: Container(
                                        width: 100,
                                        margin: EdgeInsets.all(10),
                                        // width: 300,
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
                                            boxShadow: [
                                              BoxShadow(
                                                  color: HexColor('#04060F'),
                                                  offset: Offset(10, 10),
                                                  blurRadius: 10)
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(10)),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 15),
                                          child: Text(
                                            'Edit',
                                            textAlign: TextAlign.center,
                                            style: FontStyleUtility.h16(
                                                fontColor:
                                                ColorUtils.primary_grey,
                                                family: 'PM'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        if (method_old == "Hand" ||
                                            method_old == "Dildo" ||
                                            method_old == "Sex" ||
                                            method_old == "Fleshlight") {
                                        } else {
                                          await _masturbation_screen_controller
                                              .MasturbationData_delete_API(
                                              context: context,
                                              methodId: method_id,
                                              method_name: method_old);
                                          if (_masturbation_screen_controller
                                              .m_screenDeleteModel!.error ==
                                              false) {
                                            method_time.clear();
                                            setState(() {
                                              method_selected = '';
                                            });
                                            await Masturbation_Get_Method();
                                            await Masturbation_LifeTime_Data_get_API();
                                            await Masturbation_Daily_Data_get_API();
                                            await MasturbationWeekly_Data_get_API();
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: 100,
                                        margin: EdgeInsets.all(10),
                                        // width: 300,
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
                                            boxShadow: [
                                              BoxShadow(
                                                  color: HexColor('#04060F'),
                                                  offset: Offset(10, 10),
                                                  blurRadius: 10)
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(10)),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 15),
                                          child: Text(
                                            'Delete',
                                            textAlign: TextAlign.center,
                                            style: FontStyleUtility.h16(
                                                fontColor:
                                                ColorUtils.primary_grey,
                                                family: 'PM'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.topRight,
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
                                        offset: Offset(0, 3),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 18,
                                  color: ColorUtils.primary_grey,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget GreetingsPopUp({
    required BuildContext context,
    required String message,
  }) {
    DateTime? selected;
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        // title: Center(child: Text("Evaluation our APP")),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorUtils.primary_gold, width: 1),
                        // color: Colors.black.withOpacity(0.65),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          // stops: [0.1, 0.5, 0.7, 0.9],
                          colors: [
                            // HexColor("#000000").withOpacity(1),
                            // HexColor("#000000").withOpacity(1),
                            HexColor("#ce942f").withOpacity(1),

                            HexColor("#ecdc8f").withOpacity(1),
                            HexColor("#e5cc79").withOpacity(1),
                            HexColor("#ce942f").withOpacity(1),
                            // HexColor("#37393D").withOpacity(1),
                            // ColorUtils.primary_gold.withOpacity(1),

                            // HexColor("#000000").withOpacity(1),
                            // ColorUtils.primary_gold.withOpacity(1),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: HexColor('#04060F'),
                              offset: Offset(10, 10),
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            // width: 300,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5),
                              child: Text(
                                message,
                                textAlign: TextAlign.center,
                                style: FontStyleUtility.h16(
                                    fontColor: Colors.black, family: 'PM'),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 3, bottom: 3),
                    alignment: Alignment.topRight,
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
                              // BoxShadow(
                              //     color: HexColor('#04060F'),
                              //     offset: Offset(0, 3),
                              //     blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 20,
                            color: ColorUtils.primary_grey,
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget GreetingsPopUpButton({
    required BuildContext context,
  }) {
    DateTime? selected;
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        // title: Center(child: Text("Evaluation our APP")),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    border:
                    Border.all(color: ColorUtils.primary_gold, width: 1),
                    // color: Colors.black.withOpacity(0.65),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        // HexColor("#000000").withOpacity(1),
                        // HexColor("#000000").withOpacity(1),
                        HexColor("#ce942f").withOpacity(1),

                        HexColor("#ecdc8f").withOpacity(1),
                        HexColor("#e5cc79").withOpacity(1),
                        HexColor("#ce942f").withOpacity(1),
                        // HexColor("#37393D").withOpacity(1),
                        // ColorUtils.primary_gold.withOpacity(1),

                        // HexColor("#000000").withOpacity(1),
                        // ColorUtils.primary_gold.withOpacity(1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: HexColor('#04060F'),
                          offset: Offset(10, 10),
                          blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        // width: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5),
                              child: Text(
                                "You have pused for too long please start again",
                                textAlign: TextAlign.center,
                                style: FontStyleUtility.h16(
                                    fontColor: Colors.black, family: 'PM'),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(DashboardScreen(page: 1));
                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width / 5,
                                    margin: EdgeInsets.all(10),
                                    // width: 300,
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
                                        borderRadius:
                                        BorderRadius.circular(10)),

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        'Ok',
                                        textAlign: TextAlign.center,
                                        style: FontStyleUtility.h16(
                                            fontColor: ColorUtils.primary_grey,
                                            family: 'PM'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ));
  }

  Future<void> _scaleDialog({
    required BuildContext context,
    required String message,
  }) async {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: GreetingsPopUp(context: ctx, message: message),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Future<void> _scaleDialog2({
    required BuildContext context,
    required String message,
  }) async {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: GreetingsPopUpButton(
            context: ctx,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  EditPopUp(
      {required BuildContext context,
        required String method_id,
        required String method_name}) async {
    DateTime? selected;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              elevation: 0.0,
              // title: Center(child: Text("Evaluation our APP")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                    offset: Offset(10, 10),
                                    blurRadius: 10)
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 11,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          // width: 300,
                                          // decoration: BoxDecoration(
                                          //     // color: Colors.black.withOpacity(0.65),
                                          //     gradient: LinearGradient(
                                          //       begin: Alignment.centerLeft,
                                          //       end: Alignment.centerRight,
                                          //       // stops: [0.1, 0.5, 0.7, 0.9],
                                          //       colors: [
                                          //         HexColor("#36393E")
                                          //             .withOpacity(1),
                                          //         HexColor("#020204")
                                          //             .withOpacity(1),
                                          //       ],
                                          //     ),
                                          //     boxShadow: [
                                          //       BoxShadow(
                                          //           color: HexColor('#04060F'),
                                          //           offset: Offset(10, 10),
                                          //           blurRadius: 10)
                                          //     ],
                                          //     borderRadius:
                                          //         BorderRadius.circular(20)),

                                          child: TextFormField(
                                            maxLength: 150,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 14,
                                                  bottom: 14),
                                              alignLabelWithHint: false,
                                              isDense: true,
                                              hintText: '$method_name',
                                              counterStyle: TextStyle(
                                                height: double.minPositive,
                                              ),
                                              counterText: "",
                                              filled: true,
                                              border: InputBorder.none,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    ColorUtils.primary_gold,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    ColorUtils.primary_grey,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hintStyle: FontStyleUtility.h14(
                                                  fontColor:
                                                  HexColor('#CBCBCB'),
                                                  family: 'PR'),
                                            ),
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                ColorUtils.primary_grey,
                                                family: 'PR'),
                                            controller:
                                            _masturbation_screen_controller
                                                .method_new_name,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);

                                        if (_masturbation_screen_controller
                                            .method_new_name.text.isNotEmpty) {
                                          await _masturbation_screen_controller
                                              .MasturbationData_edit_API(
                                            context: context,
                                            methodId: method_id,
                                          );
                                          if (_masturbation_screen_controller
                                              .m_screenEditModel!.error ==
                                              false) {
                                            method_time.clear();
                                            // await Masturbation_Daily_Data_get_API();

                                            await Masturbation_Get_Method();
                                            await Masturbation_LifeTime_Data_get_API();
                                            await Masturbation_Daily_Data_get_API();
                                            await MasturbationWeekly_Data_get_API();
                                          }
                                        }
                                      },
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            4,
                                        margin: EdgeInsets.all(0),
                                        // width: 300,
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
                                            BorderRadius.circular(10)),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 15),
                                          child: Text(
                                            'Add',
                                            textAlign: TextAlign.center,
                                            style: FontStyleUtility.h16(
                                                fontColor:
                                                ColorUtils.primary_grey,
                                                family: 'PM'),
                                          ),
                                        ),
                                      ),
                                    )
                                    // common_button_gold(
                                    //   onTap: () {
                                    //     Get
                                    //         .to(
                                    //         DashboardScreen());
                                    //   },
                                    //   title_text: 'Go to Dashboard',
                                    // ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.topRight,
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
                                        offset: Offset(0, 3),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 18,
                                  color: ColorUtils.primary_grey,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  DateTime selectedDate = DateTime.now();
  String showInvoiceDate = '';

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 3);

  @override
  void initState() {
    getdata().then((value) => print("Success"));
    graph_ = data_graph[0];
    graph_life = lifetime_data_list;

    // _tooltipBehavior = TooltipBehavior(
    //     enable: true, borderWidth: 5, color: Colors.transparent);
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        header: "Hold at",
        // Formatting the tooltip text
        // builder: (dynamic data, dynamic point, dynamic series,
        //     int pointIndex, int seriesIndex) {
        //   return Container(
        //       child: Text(
        //           '$seriesIndex : ${pointIndex.toString()}',style: TextStyle(color: Colors.white),
        //       )
        //   );
        // },
        format: 'point.high second');
    _tooltipBehavior2 = TooltipBehavior(
        enable: true,
        header: "total",
        // Formatting the tooltip text
        // builder: (dynamic data, dynamic point, dynamic series,
        //     int pointIndex, int seriesIndex) {
        //   return Container(
        //       child: Text(
        //           '$seriesIndex : ${pointIndex.toString()}',style: TextStyle(color: Colors.white),
        //       )
        //   );
        // },
        format: 'point.x : point.y min');
    _trackballBehavior = TrackballBehavior(
        enable: true,
        // lineDashArray: <double>[5,5],
        lineWidth: 3,
        markerSettings: TrackballMarkerSettings(color: Colors.yellow),
        // lineColor: Colors.white,
        lineType: TrackballLineType.vertical,
        tooltipAlignment: ChartAlignment.far,
        // builder: (BuildContext ,TrackballDetails) {
        //   return Container(
        //     child: Text('data'),
        //   );
        // },
        tooltipSettings: const InteractiveTooltip(
          // Formatting trackball tooltip text
            format: 'point.x : point.y minute'),
        // Display mode of trackball tooltip
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        activationMode: ActivationMode.longPress);
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      // zoomMode: ZoomMode.x,
      // zoomMode: ZoomMode.x,

      maximumZoomLevel: 0.5,
      enablePanning: true,
    );
    _selectionBehavior = SelectionBehavior(enable: true);
    _crosshairBehavior = CrosshairBehavior(
        enable: true,
        lineColor: Colors.red,
        activationMode: ActivationMode.singleTap,
        lineDashArray: <double>[5, 5],
        lineWidth: 2,
        lineType: CrosshairLineType.vertical);
    super.initState();
  }

  getdata() async {
    print("insssiiiiiii");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    // await _masturbation_screen_controller.MasturbationData_get_API(context);
    // await PreferenceManager()
    //     .setList(URLConstants.method_list, list);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_route', "/masturbation");
    String? lastRoute = prefs.getString('last_route');
    print("lastRoute ${lastRoute}");

    await Masturbation_Get_Method();
    await masturbation_technique_API(
        context: context, method: URLConstants.masturbation_technique);

    await Masturbation_LifeTime_Data_get_API();
    await Masturbation_Daily_Data_get_API();
    await MasturbationWeekly_Data_get_API();
    // List<dynamic> id_user =
    // await PreferenceManager().getList(URLConstants.method_list);

    // final String encodedData =
    //     methods_list.encode(_masturbation_screen_controller.method_list);
    // await PreferenceManager().setList(URLConstants.method_list, encodedData);

    final String? id_user = prefs.getString(URLConstants.method_list);

    // setState(() {
    //   if(id_user!.isNotEmpty){
    //     _masturbation_screen_controller.method_list =
    //         methods_list.decode(id_user);
    //   }
    // });
    print(
        "_masturbation_screen_controller : ${_masturbation_screen_controller.method_list}");
    // await prefs.setString('musics_key', encodedData);

    // print("id_user${id_user}");
    // print("id_user${id_user}");
    // setState(() {
    //   _masturbation_screen_controller.method_list = id_user;
    // });
    // });
  }

  bool show_details_graph = false;
  TextEditingController method_new = new TextEditingController();

  double percent = 0.0;
  AnimationController? _animationController;
  Animation? _animation;
  bool animation_started = false;

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 15.0).animate(_animationController!)
      ..addStatusListener((status) {
        print(status);
      });
  }

  @override
  dispose() {
    if (animation_started == true) {
      _animationController!.dispose();
    } // you need this
    print('    stopWatch_finish()');
    super.dispose();
  }

  final Kegel_controller _kegel_controller =
  Get.put(Kegel_controller(), tag: Kegel_controller().toString());

  @override
  Widget build(BuildContext context) {
    final TextSpan textSpan = HTML.toTextSpan(
      context,
      (isinfoLoading == true
          ? ''
          : MasturbationTechniqueModel!.data!.technique!),
      linksCallback: (dynamic link) {
        debugPrint('You clicked on ${link.toString()}');
      },
      // as name suggests, optionally set the default text style
      defaultTextStyle: TextStyle(
        color: Colors.grey[700],
      ),

      overrideStyle: <String, TextStyle>{
        'p': TextStyle(
            fontSize: 14,
            color: ColorUtils.primary_grey,
            fontFamily: 'PR',
            fontWeight: FontWeight.w200,
            decoration: TextDecoration.none),
        // FontStyleUtility.h16(
        //     fontColor: ColorUtils.primary_grey,
        //     family: 'PR'),
        'a': const TextStyle(wordSpacing: 2),
        // specify any tag not just the supported ones,
        // and apply TextStyles to them and/override them
      },
    );

    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
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
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dst),
              image: const AssetImage(
                AssetUtils.m_screen_back,
              ),
            ),
          ),
        ),
        WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: AppBar(
              //   backgroundColor: Colors.transparent,
              //   automaticallyImplyLeading: false,
              //   leading: GestureDetector(
              //     onTap: () {
              //       (started
              //           ? Navigator.pop(context)
              //           : CommonWidget()
              //               .showErrorToaster(msg: "Please finish the method"));
              //       // Navigator.pop(context);
              //     },
              //     child: Container(
              //         width: 41,
              //         margin: EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(100),
              //             gradient: LinearGradient(
              //                 begin: Alignment(-1.0, -4.0),
              //                 end: Alignment(1.0, 4.0),
              //                 colors: [HexColor('#020204'), HexColor('#36393E')])),
              //         child: Padding(
              //           padding: const EdgeInsets.all(10.0),
              //           child: Image.asset(
              //             AssetUtils.arrow_back,
              //             height: 14,
              //             width: 15,
              //           ),
              //         )),
              //   ),
              //   title: Text(
              //     Textutils.Masturbation,
              //     style: FontStyleUtility.h16(
              //         fontColor: ColorUtils.primary_grey, family: 'PM'),
              //   ),
              //   centerTitle: true,
              //   actions: [
              //     // Container(
              //     //     width: 41,
              //     //     margin: EdgeInsets.all(8),
              //     //     decoration: BoxDecoration(
              //     //         color: Colors.white,
              //     //         borderRadius: BorderRadius.circular(100),
              //     //         gradient: LinearGradient(
              //     //             begin: Alignment(-1.0, -4.0),
              //     //             end: Alignment(1.0, 4.0),
              //     //             colors: [HexColor('#020204'), HexColor('#36393E')])),
              //     //     child: Padding(
              //     //       padding: const EdgeInsets.all(10.0),
              //     //       child: Image.asset(
              //     //         AssetUtils.notification_icon,
              //     //         color: ColorUtils.primary_gold,
              //     //         height: 14,
              //     //         width: 15,
              //     //       ),
              //     //     ))
              //   ],
              // ),
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      snap: false,
                      pinned: false,
                      stretch: false,
                      floating: false,

                      leading: GestureDetector(
                        onTap: () {
                          (started
                              ? Navigator.pop(context)
                          // Navigator.of(context).pushReplacement(
                          //         MaterialPageRoute(
                          //             builder: (context) => DashboardScreen(
                          //                   page: 1,
                          //                 )),
                          //       )
                              : CommonWidget().showErrorToaster(
                              msg: "Please finish the method"));
                          // Navigator.pop(context);
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
                                    colors: [
                                      HexColor('#020204'),
                                      HexColor('#36393E')
                                    ])),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                AssetUtils.arrow_back,
                                height: 14,
                                width: 15,
                              ),
                            )),
                      ),
                      // title: Text(
                      //   Textutils.Masturbation,
                      //   style: FontStyleUtility.h16(
                      //       fontColor: ColorUtils.primary_grey, family: 'PM'),
                      // ),
                      centerTitle: true,
                      actions: [
                        // Container(
                        //     width: 41,
                        //     margin: EdgeInsets.all(8),
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(100),
                        //         gradient: LinearGradient(
                        //             begin: Alignment(-1.0, -4.0),
                        //             end: Alignment(1.0, 4.0),
                        //             colors: [HexColor('#020204'), HexColor('#36393E')])),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(10.0),
                        //       child: Image.asset(
                        //         AssetUtils.notification_icon,
                        //         color: ColorUtils.primary_gold,
                        //         height: 14,
                        //         width: 15,
                        //       ),
                        //     ))
                      ],
                      // TabBar(
                      //   labelPadding: EdgeInsets.zero,
                      //   indicatorColor: Colors.black,
                      //   controller: _tabController,
                      //   tabs: <Widget>[
                      //     Container(
                      //       margin: EdgeInsets.only(bottom: 0),
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           color: Colors.black,
                      //           borderRadius: BorderRadius.circular(50),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: HexColor(CommonColor.blue),
                      //               // spreadRadius: 5,
                      //               blurRadius: 6,
                      //               offset:
                      //                   Offset(0, 3), // changes position of shadow
                      //             ),
                      //           ],
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topLeft,
                      //             end: Alignment.bottomRight,
                      //             // stops: [0.1, 0.5, 0.7, 0.9],
                      //             colors: [
                      //               HexColor("#000000"),
                      //               HexColor("#C12265"),
                      //               // HexColor("#FFFFFF").withOpacity(0.67),
                      //             ],
                      //           ),
                      //           border: Border.all(
                      //               color: HexColor(CommonColor.blue), width: 1.5)),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             index == 0;
                      //           });
                      //           print(index);
                      //         },
                      //         icon: Image.asset(
                      //           AssetUtils.story1,
                      //           height: 25,
                      //           width: 25,
                      //           color: HexColor(CommonColor.blue),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.all(0),
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(50),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: HexColor(CommonColor.green),
                      //               // spreadRadius: 5,
                      //               blurRadius: 6,
                      //               offset:
                      //                   Offset(0, 3), // changes position of shadow
                      //             ),
                      //           ],
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topLeft,
                      //             end: Alignment.bottomRight,
                      //             // stops: [0.1, 0.5, 0.7, 0.9],
                      //             colors: [
                      //               HexColor("#000000"),
                      //               HexColor("#C12265"),
                      //               // HexColor("#FFFFFF").withOpacity(0.67),
                      //             ],
                      //           ),
                      //           border: Border.all(
                      //               color: HexColor(CommonColor.green), width: 1.5)),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             index == 1;
                      //           });
                      //           print(index);
                      //         },
                      //         icon: Image.asset(
                      //           AssetUtils.story2,
                      //           height: 25,
                      //           width: 25,
                      //           color: HexColor(CommonColor.green),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.all(0),
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: HexColor(CommonColor.tile),
                      //               // spreadRadius: 5,
                      //               blurRadius: 6,
                      //               offset:
                      //                   Offset(0, 3), // changes position of shadow
                      //             ),
                      //           ],
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topLeft,
                      //             end: Alignment.bottomRight,
                      //             // stops: [0.1, 0.5, 0.7, 0.9],
                      //             colors: [
                      //               HexColor("#000000"),
                      //               HexColor("#C12265"),
                      //               // HexColor("#FFFFFF").withOpacity(0.67),
                      //             ],
                      //           ),
                      //           borderRadius: BorderRadius.circular(50),
                      //           border: Border.all(
                      //               color: HexColor(CommonColor.tile), width: 1.5)),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             index == 2;
                      //           });
                      //           print(index);
                      //         },
                      //         icon: Image.asset(
                      //           AssetUtils.story3,
                      //           height: 25,
                      //           width: 25,
                      //           color: HexColor(CommonColor.tile),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.all(0),
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: HexColor(CommonColor.orange),
                      //               // spreadRadius: 5,
                      //               blurRadius: 6,
                      //               offset:
                      //                   Offset(0, 3), // changes position of shadow
                      //             ),
                      //           ],
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topLeft,
                      //             end: Alignment.bottomRight,
                      //             // stops: [0.1, 0.5, 0.7, 0.9],
                      //             colors: [
                      //               HexColor("#000000"),
                      //               HexColor("#C12265"),
                      //               // HexColor("#FFFFFF").withOpacity(0.67),
                      //             ],
                      //           ),
                      //           borderRadius: BorderRadius.circular(50),
                      //           border: Border.all(
                      //               color: HexColor(CommonColor.orange), width: 1.5)),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             index == 3;
                      //           });
                      //           print(index);
                      //         },
                      //         icon: Image.asset(
                      //           AssetUtils.story4,
                      //           height: 25,
                      //           width: 25,
                      //           color: HexColor(CommonColor.orange),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.all(0),
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.white,
                      //               // spreadRadius: 5,
                      //               blurRadius: 6,
                      //               offset:
                      //                   Offset(0, 3), // changes position of shadow
                      //             ),
                      //           ],
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topLeft,
                      //             end: Alignment.bottomRight,
                      //             // stops: [0.1, 0.5, 0.7, 0.9],
                      //             colors: [
                      //               HexColor("#000000"),
                      //               HexColor("#C12265"),
                      //               // HexColor("#FFFFFF").withOpacity(0.67),
                      //             ],
                      //           ),
                      //           borderRadius: BorderRadius.circular(50),
                      //           border: Border.all(color: Colors.white, width: 1.5)),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             index == 4;
                      //           });
                      //           print(index);
                      //         },
                      //         icon: Image.asset(
                      //           AssetUtils.story5,
                      //           height: 25,
                      //           width: 25,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(top: 15, left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: (paused_time.length >= 4
                                      ? LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#DD3931").withOpacity(1),
                                      HexColor("#DD3931").withOpacity(1),
                                    ],
                                  )
                                      : LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#34343E").withOpacity(1),
                                      HexColor("#8A8B8D").withOpacity(1),
                                    ],
                                  )),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.pause,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: (paused_time.length >= 3
                                      ? LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#DD3931").withOpacity(1),
                                      HexColor("#DD3931").withOpacity(1),
                                    ],
                                  )
                                      : LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#34343E").withOpacity(1),
                                      HexColor("#8A8B8D").withOpacity(1),
                                    ],
                                  )),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.pause,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: (paused_time.length >= 2
                                      ? LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#DD3931").withOpacity(1),
                                      HexColor("#DD3931").withOpacity(1),
                                    ],
                                  )
                                      : LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#34343E").withOpacity(1),
                                      HexColor("#8A8B8D").withOpacity(1),
                                    ],
                                  )),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.pause,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: (paused_time.isNotEmpty
                                      ? LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#DD3931").withOpacity(1),
                                      HexColor("#DD3931").withOpacity(1),
                                    ],
                                  )
                                      : LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#34343E").withOpacity(1),
                                      HexColor("#8A8B8D").withOpacity(1),
                                    ],
                                  )),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.pause,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        AvatarGlow(
                          endRadius: 100.0,
                          showTwoGlows: true,
                          animate: false,
                          // (startStop ? false : true),
                          duration: Duration(milliseconds: 900),
                          repeat: true,
                          child: GestureDetector(
                            onTap: () {
                              print('helllllllooooooooooooooo');
                              // startOrStop();
                            },
                            child: CircularPercentIndicator(
                              circularStrokeCap: CircularStrokeCap.round,
                              percent: percent / 100,
                              animation: true,
                              animateFromLastPercent: true,
                              radius: 61,
                              lineWidth: 0,
                              progressColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              center: Container(
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        alignment: Alignment.center,
                                        image:
                                        AssetImage(AssetUtils.home_button)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (animation_started
                                            ? HexColor('#DD3931')
                                            : Colors.transparent),
                                        blurRadius: (animation_started
                                            ? _animation!.value
                                            : 0),
                                        spreadRadius: (animation_started
                                            ? _animation!.value
                                            : 0),
                                      )
                                    ]),
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text('Masturbate',
                                          style: GoogleFonts.sourceSerifPro(
                                            textStyle: TextStyle(
                                                color: (timer_started
                                                    ? HexColor('#DD3931')
                                                    .withOpacity(0.4)
                                                    : HexColor('#DD3931')),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        (timer_started ? elapsedTime : ''),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          glowColor: Colors.white,
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('object');
                            if (started == false) {
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  double width =
                                      MediaQuery.of(context).size.width;
                                  double height =
                                      MediaQuery.of(context).size.height;
                                  return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      contentPadding: EdgeInsets.zero,
                                      elevation: 0.0,
                                      // title: Center(child: Text("Evaluation our APP")),
                                      content: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                // height: 150,
                                                // height: double.maxFinite,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                    4,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                  // color: Colors.black.withOpacity(0.65),
                                                    gradient: LinearGradient(
                                                      begin:
                                                      Alignment.centerLeft,
                                                      end:
                                                      Alignment.centerRight,
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
                                                          offset:
                                                          Offset(10, 10),
                                                          blurRadius: 10)
                                                    ],
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20)),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                // height: 122,
                                                // width: 133,
                                                // padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        // color: Colors.white,
                                                        alignment:
                                                        Alignment.center,
                                                        child: ListView.builder(
                                                          padding:
                                                          EdgeInsets.only(
                                                              bottom: 0),

                                                          // physics: NeverScrollableScrollPhysics(),
                                                          itemCount:
                                                          _masturbation_screen_controller
                                                              .method_list
                                                              .length,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (BuildContext
                                                          context,
                                                              int index) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  method_selected = _masturbation_screen_controller
                                                                      .method_list[
                                                                  index]
                                                                      .method_name!;
                                                                  method_selected_color =
                                                                  _masturbation_screen_controller
                                                                      .method_list[
                                                                  index]
                                                                      .color!;
                                                                  method_selected_id = _masturbation_screen_controller
                                                                      .method_list[
                                                                  index]
                                                                      .method_id!;

                                                                  print(
                                                                      "method_selected $method_selected");
                                                                  print(
                                                                      "method_selected ${_masturbation_screen_controller.method_list[index].color!.toString()}");
                                                                  started =
                                                                  true;
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              // onLongPress: () {
                                                              //   if (index > 3) {
                                                              //     // print(
                                                              //     //     "Method ID : ${method_time[index].id}");
                                                              //     methodPopUp(
                                                              //         context:
                                                              //             context,
                                                              //         method_old: _masturbation_screen_controller
                                                              //             .method_list[
                                                              //                 index]
                                                              //             .method_name!,
                                                              //         method_id: _masturbation_screen_controller
                                                              //             .method_list[
                                                              //                 index]
                                                              //             .method_id!);
                                                              //   }
                                                              // },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                    8.5),
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                child: (index >
                                                                    3
                                                                    ? Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Expanded(
                                                                      // flex: 3,
                                                                      child:
                                                                      Container(
                                                                        // color: Colors.white,
                                                                        alignment: Alignment.centerRight,
                                                                        child: Text(
                                                                          _masturbation_screen_controller.method_list[index].method_name!,
                                                                          style: FontStyleUtility.h15(
                                                                              fontColor: HexColor(_masturbation_screen_controller.method_list[index].color!),
                                                                              // fontColor: (_masturbation_screen_controller.method_list[index] == 'Hand'
                                                                              //     ? Colors.red
                                                                              //     : (_masturbation_screen_controller.method_list[index] == 'Dildo'
                                                                              //         ? Colors.blue
                                                                              //         : (_masturbation_screen_controller.method_list[index] == 'Sex'
                                                                              //             ? Colors.green
                                                                              //             // : (_masturbation_screen_controller.method_list[index] == 'Fleshlight' ? Colors.purple : Colors.primaries[_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100])))),
                                                                              //             : (_masturbation_screen_controller.method_list[index] == 'Fleshlight' ? Colors.purple : list[random.nextInt(list.length)])))),
                                                                              family: 'PM'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // flex: 2,
                                                                        child: GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            methodPopUp(context: context, method_old: _masturbation_screen_controller.method_list[index].method_name!, method_id: _masturbation_screen_controller.method_list[index].method_id!);
                                                                          },
                                                                          child:
                                                                          Container(
                                                                            margin: EdgeInsets.only(left: 20),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Icon(
                                                                              Icons.delete,
                                                                              size: 20,
                                                                              color: ColorUtils.primary_gold,
                                                                            ),
                                                                          ),
                                                                        ))
                                                                  ],
                                                                )
                                                                    : Container(
                                                                  // color: Colors.white,
                                                                  alignment:
                                                                  Alignment.center,
                                                                  child:
                                                                  Text(
                                                                    _masturbation_screen_controller
                                                                        .method_list[index]
                                                                        .method_name!,
                                                                    style: FontStyleUtility.h15(
                                                                        fontColor: HexColor(_masturbation_screen_controller.method_list[index].color!),
                                                                        // fontColor: (_masturbation_screen_controller.method_list[index] == 'Hand'
                                                                        //     ? Colors.red
                                                                        //     : (_masturbation_screen_controller.method_list[index] == 'Dildo'
                                                                        //         ? Colors.blue
                                                                        //         : (_masturbation_screen_controller.method_list[index] == 'Sex'
                                                                        //             ? Colors.green
                                                                        //             // : (_masturbation_screen_controller.method_list[index] == 'Fleshlight' ? Colors.purple : Colors.primaries[_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100])))),
                                                                        //             : (_masturbation_screen_controller.method_list[index] == 'Fleshlight' ? Colors.purple : list[random.nextInt(list.length)])))),
                                                                        family: 'PM'),
                                                                  ),
                                                                )),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10, top: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          addmethod_popup(
                                                              context);
                                                        },
                                                        child: Container(
                                                          alignment:
                                                          Alignment.center,
                                                          decoration:
                                                          BoxDecoration(
                                                              border:
                                                              Border(
                                                                right: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1),
                                                              )),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                4.5),
                                                            child: Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.circular(500),
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
                                                                        offset: Offset(
                                                                            3,
                                                                            3),
                                                                        blurRadius:
                                                                        10)
                                                                  ]),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    6),
                                                                child:
                                                                Image.asset(
                                                                  AssetUtils
                                                                      .plus_big,
                                                                  height: 30,
                                                                  width: 20,
                                                                  color: HexColor(
                                                                      '#606060'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin:
                                                  EdgeInsets.only(right: 0),
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        // color: Colors.black.withOpacity(0.65),
                                                          gradient:
                                                          LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                                            colors: [
                                                              HexColor(
                                                                  "#36393E")
                                                                  .withOpacity(
                                                                  1),
                                                              HexColor(
                                                                  "#020204")
                                                                  .withOpacity(
                                                                  1),
                                                            ],
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: HexColor(
                                                                    '#04060F'),
                                                                offset: Offset(
                                                                    0, 3),
                                                                blurRadius: 5)
                                                          ],
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              20)),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(4.0),
                                                        child: Icon(
                                                          Icons.cancel_outlined,
                                                          size: 25,
                                                          color: ColorUtils
                                                              .primary_grey,
                                                        ),
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ));
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            // height: 45,
                            // width:(width ?? 300) ,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.65),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  // stops: [0.1, 0.5, 0.7, 0.9],
                                  colors: [
                                    HexColor("#020204").withOpacity(0.65),
                                    HexColor("#151619").withOpacity(0.65),
                                    HexColor("#36393E").withOpacity(0.65),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  (method_selected.isNotEmpty
                                      ? method_selected
                                      : "Select Method"),
                                  style: FontStyleUtility.h16(
                                      fontColor: ColorUtils.primary_metal,
                                      family: 'PM'),
                                )),
                          ),
                        ),
                        // common_button_black(
                        //   // height_: 75,
                        //   onTap: () {
                        //     print('object');
                        //     showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         double width = MediaQuery.of(context).size.width;
                        //         double height = MediaQuery.of(context).size.height;
                        //         return BackdropFilter(
                        //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        //           child: AlertDialog(
                        //               backgroundColor: Colors.transparent,
                        //               contentPadding: EdgeInsets.zero,
                        //               elevation: 0.0,
                        //               // title: Center(child: Text("Evaluation our APP")),
                        //               content: Column(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   Container(
                        //                     margin: EdgeInsets.symmetric(
                        //                         horizontal: 10, vertical: 0),
                        //                     // height: 122,
                        //                     // width: 133,
                        //                     // padding: const EdgeInsets.all(8.0),
                        //                     decoration: BoxDecoration(
                        //                         color: Colors.black,
                        //                         border: Border.all(
                        //                             color: ColorUtils.primary_gold,
                        //                             width: 1),
                        //                         borderRadius: BorderRadius.all(
                        //                             Radius.circular(10.0))),
                        //                     alignment: Alignment.center,
                        //                     child: Stack(
                        //                       children: [
                        //                         Align(
                        //                           alignment: Alignment.center,
                        //                           child: ListView.builder(
                        //                             padding: EdgeInsets.zero,
                        //                             itemCount: _masturbation_screen_controller.method_list.length,
                        //                             shrinkWrap: true,
                        //                             itemBuilder: (BuildContext context,
                        //                                 int index) {
                        //                               return Column(
                        //                                 mainAxisSize: MainAxisSize.min,
                        //                                 children: [
                        //                                   SizedBox(
                        //                                     height: 5,
                        //                                   ),
                        //                                   GestureDetector(
                        //                                     onTap: () {
                        //                                       setState(() {
                        //                                         method_selected =
                        //                                         _masturbation_screen_controller.method_list[index];
                        //                                         print(
                        //                                             "method_selected $method_selected");
                        //                                       });
                        //                                       Navigator.pop(context);
                        //                                     },
                        //                                     child: Container(
                        //                                       alignment: Alignment.center,
                        //                                       child: Text(
                        //                                         _masturbation_screen_controller.method_list[index],
                        //                                         style: FontStyleUtility.h16(
                        //                                             fontColor: ColorUtils
                        //                                                 .primary_gold,
                        //                                             family: 'PM'),
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   SizedBox(
                        //                                     height: 5,
                        //                                   ),
                        //                                 ],
                        //                               );
                        //                             },
                        //                           ),
                        //                         ),
                        //                         Align(
                        //                           alignment: Alignment.topRight,
                        //                           child: IconButton(
                        //                             onPressed: () {
                        //                               Navigator.pop(context);
                        //                             },
                        //                             icon: Icon(
                        //                               Icons.clear,
                        //                               color: ColorUtils.primary_gold,
                        //                             ),
                        //                           ),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )),
                        //         );
                        //       },
                        //     );
                        //     // Get.to(DashboardScreen());
                        //   },
                        //   title_text: (method_selected.isNotEmpty
                        //       ? method_selected
                        //       : "Select Method"),
                        // ),
                        const SizedBox(
                          height: 28,
                        ),
                        // Container(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () async {
                        //           await stopWatch();
                        //           method_time.add(ListMethodClass(
                        //               method_name: method_selected,
                        //               total_time: elapsedTime));
                        //           setState(() {
                        //             elapsedTime = '00:00:00';
                        //             // paused_time.clear();
                        //           });
                        //           print('method_time : ${method_time[0].total_time}');
                        //           print(
                        //               'method_name : ${method_time[0].method_name}');
                        //         },
                        //         child: Container(
                        //           height: 87,
                        //           width: 87,
                        //           decoration: BoxDecoration(
                        //               color: Colors.black,
                        //               border: Border.all(
                        //                   color: ColorUtils.primary_gold, width: 1),
                        //               borderRadius: BorderRadius.circular(100)),
                        //           child: Container(
                        //             alignment: Alignment.center,
                        //             child: Text(
                        //               'Finish',
                        //               style: FontStyleUtility.h16(
                        //                   fontColor: ColorUtils.primary_gold,
                        //                   family: 'PR'),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           startOrStop();
                        //         },
                        //         child: Container(
                        //           height: 87,
                        //           width: 87,
                        //           decoration: BoxDecoration(
                        //               color: ColorUtils.primary_gold,
                        //               border: Border.all(
                        //                   color: ColorUtils.primary_gold, width: 1),
                        //               borderRadius: BorderRadius.circular(100)),
                        //           child: Container(
                        //             alignment: Alignment.center,
                        //             child: Text(
                        //               (startStop ? 'Start' : 'Pause'),
                        //               style: FontStyleUtility.h16(
                        //                   fontColor: Colors.black, family: 'PR'),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (started == false ||
                                    elapsedTime == "30:00") {
                                  // if (paused) {

                                  // if(paused_time.length == 4){
                                  await _kegel_controller
                                      .update_notified_status(
                                      context: context, status: 'false');
                                  await stopWatch_finish();
                                  await changeIndex();
                                  print(
                                      "paused_time.length}} ${paused_time.length}");
                                  if (paused_time.length < 4) {
                                    print(
                                        "Remember you need to pause during masturbation 4 times per session");
                                    showGeneralDialog(
                                      context: context,
                                      pageBuilder: (ctx, a1, a2) {
                                        return Container();
                                      },
                                      transitionBuilder: (ctx, a1, a2, child) {
                                        var curve = Curves.easeInOut
                                            .transform(a1.value);
                                        return Transform.scale(
                                          scale: curve,
                                          child: AlertDialog(
                                              backgroundColor:
                                              Colors.transparent,
                                              contentPadding: EdgeInsets.zero,
                                              elevation: 0.0,
                                              // title: Center(child: Text("Evaluation our APP")),
                                              content: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        10.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: ColorUtils
                                                                  .primary_gold,
                                                              width: 1),
                                                          // color: Colors.black.withOpacity(0.65),
                                                          gradient:
                                                          LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                                            colors: [
                                                              // HexColor("#000000").withOpacity(1),
                                                              // HexColor("#000000").withOpacity(1),
                                                              HexColor(
                                                                  "#ce942f")
                                                                  .withOpacity(
                                                                  1),

                                                              HexColor(
                                                                  "#ecdc8f")
                                                                  .withOpacity(
                                                                  1),
                                                              HexColor(
                                                                  "#e5cc79")
                                                                  .withOpacity(
                                                                  1),
                                                              HexColor(
                                                                  "#ce942f")
                                                                  .withOpacity(
                                                                  1),
                                                              // HexColor("#37393D").withOpacity(1),
                                                              // ColorUtils.primary_gold.withOpacity(1),

                                                              // HexColor("#000000").withOpacity(1),
                                                              // ColorUtils.primary_gold.withOpacity(1),
                                                            ],
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: HexColor(
                                                                    '#04060F'),
                                                                offset: Offset(
                                                                    10, 10),
                                                                blurRadius: 10)
                                                          ],
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              15)),
                                                      child: Align(
                                                          alignment:
                                                          Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              // width: 300,
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                        8.0,
                                                                        horizontal:
                                                                        5),
                                                                    child: Text(
                                                                      "Remember you need to pause during masturbation 4 times per session",
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                      style: FontStyleUtility.h16(
                                                                          fontColor: Colors
                                                                              .black,
                                                                          family:
                                                                          'PM'),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                        Container(
                                                                          width:
                                                                          MediaQuery.of(context).size.width / 5,
                                                                          margin:
                                                                          EdgeInsets.all(10),
                                                                          // width: 300,
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
                                                                              borderRadius: BorderRadius.circular(10)),

                                                                          child:
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                                                            child:
                                                                            Text(
                                                                              'Ok',
                                                                              textAlign: TextAlign.center,
                                                                              style: FontStyleUtility.h16(fontColor: ColorUtils.primary_grey, family: 'PM'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        );
                                      },
                                      transitionDuration:
                                      const Duration(milliseconds: 300),
                                    );
                                    // _scaleDialog(
                                    //     context: context,
                                    //     message:
                                    //     "Remember you need to pause during masturbation 4 times per session");
                                  }
                                  // setState(() {
                                  //   method_color = (method_selected == 'Hand'
                                  //       ? Colors.red
                                  //       : (method_selected == 'Dildo'
                                  //           ? Colors.blue
                                  //           : (method_selected == 'Sex'
                                  //               ? Colors.green
                                  //               : (method_selected == 'Fleshlight'
                                  //                   ? Colors.purple
                                  //                   : list[random.nextInt(
                                  //                       list.length)]))));
                                  // });
                                  //
                                  // print('Method  : $method_color');
                                  // print(
                                  //     'Method colorrr : ${method_color!.value.toRadixString(16)}');
                                  method_data.add(ListMethodClass(
                                      method_name: method_selected,
                                      method_id: method_selected_id,
                                      pauses: paused_time.length.toString(),
                                      total_time: elapsedTime,
                                      pause_time: paused_time,
                                      color: HexColor(method_selected_color)
                                          .value
                                          .toRadixString(16)));
                                  print("paused_time : $paused_time");
                                  List mohit = [];

                                  for (var i = 0; i < paused_time.length; i++) {
                                    // x_axis = data_sales[i]["month"];
                                    print("timee : $paused_time");

                                    DateTime tempDate_ = new DateFormat("mm:ss")
                                        .parse(paused_time[i]);
                                    print(
                                        "TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");

                                    var totalTime = (tempDate_.minute * 60) +
                                        tempDate_.second;
                                    print("TOTAL TIMEEE : $totalTime");
                                    mohit.add(totalTime);
                                    print("totaL : $mohit");
                                  }
                                  print(
                                      "PP : ${paused_time.toString().replaceAll('[', '').replaceAll(']', '')}");

                                  print(
                                      "paused_time : ${method_data[method_data.length - 1].pause_time}");

                                  ///
                                  await _masturbation_screen_controller
                                      .m_method_post_API(
                                      context: context,
                                      pauses: mohit
                                          .toString()
                                          .replaceAll('[', '')
                                          .replaceAll(']', ''),
                                      method_data: method_data);
                                  setState(() {
                                    timer_started = false;
                                    elapsedTime = '00:00';
                                    percent = 0.0;
                                    // method_selected = '';
                                    watch.reset();
                                    paused_time.clear();
                                  });
                                  method_time.clear();
                                  coloring2.clear();
                                  coloring.clear();
                                  methoddd2.clear();
                                  methoddd.clear();

                                  if (four_min) {
                                    _scaleDialog(
                                        context: context,
                                        message:
                                        "Congratulations! You lasted over 3 minutes! Start saying to goodbye to Premature ejaculation!");
                                  } else if (ten_min) {
                                    _scaleDialog(
                                        context: context,
                                        message:
                                        "Congratulations! You are halfway there to the 20-minute mark!");
                                  }

                                  ///
                                  await Masturbation_LifeTime_Data_get_API();
                                  await Masturbation_Daily_Data_get_API();
                                  await MasturbationWeekly_Data_get_API();
                                  // print('method_time : ${method_time[0].total_time}');
                                  // print('method_name : ${method_time[0].method_name}');
                                  // }
                                  // else{
                                  //   _scaleDialog(
                                  //       context: context,
                                  //       message:
                                  //       "Remember you need to pause during masturbation 4 times per session");
                                  // }

                                }
                                // }
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                // width: MediaQuery.of(context).size.width / 3,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                // height: 45,
                                // width:(width ?? 300),
                                decoration: (started
                                    ? BoxDecoration(
                                    border: Border.all(
                                        color: ColorUtils.primary_gold,
                                        width: 1),
                                    borderRadius:
                                    BorderRadius.circular(100))
                                // : (paused
                                //     ? BoxDecoration(
                                //         gradient: LinearGradient(
                                //           begin: Alignment.centerLeft,
                                //           end: Alignment.centerRight,
                                //           // stops: [0.1, 0.5, 0.7, 0.9],
                                //           colors: [
                                //             HexColor("#ECDD8F")
                                //                 .withOpacity(0.90),
                                //             HexColor("#E5CC79")
                                //                 .withOpacity(0.90),
                                //             HexColor("#CE952F")
                                //                 .withOpacity(0.90),
                                //           ],
                                //         ),
                                //         borderRadius:
                                //             BorderRadius.circular(100))
                                    : BoxDecoration(
                                    border: Border.all(
                                        color: ColorUtils.primary_gold,
                                        width: 1),
                                    borderRadius:
                                    BorderRadius.circular(100))),
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      ('Finish'),
                                      style: FontStyleUtility.h16(
                                          fontColor: (started
                                              ? Colors.white
                                          // : (paused
                                          //     ? Colors.black
                                              : Colors.white),
                                          family: 'PM'),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // _scaleDialog(
                                //     context: context,
                                //     message:
                                //     "Congratulations! You lasted over 3 minutes! Start saying to goodbye to Premature ejaculation!”");

                                ///
                                if (paused_time.length >= 4) {
                                  await _kegel_controller
                                      .update_notified_status(
                                      context: context, status: 'true');
                                  startWatch();
                                  CommonWidget().showToaster(
                                      msg: "Only 4 pauses are available");
                                  // start_animation();
                                } else {
                                  if (method_selected.isNotEmpty) {
                                    // if (started) {
                                    //   // start_animation();
                                    //   startWatch();
                                    // } else {
                                    //   setState(() {
                                    //     startStop = true;
                                    //     started = false;
                                    //     watch.stop();
                                    //     setTime();
                                    //   });
                                    // }
                                    if (startStop) {
                                      if (thirty_min) {
                                        GreetingsPopUpButton(
                                          context: context,
                                        );
                                      } else {
                                        await _kegel_controller
                                            .update_notified_status(
                                            context: context,
                                            status: 'true');
                                        startWatch();
                                        watch2.stop();
                                        watch2.reset();
                                        start_animation();
                                      }
                                    } else {
                                      await _kegel_controller
                                          .update_notified_status(
                                          context: context,
                                          status: 'false');
                                      stopWatch();
                                      watch2.reset();
                                      startWatch2();
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please select method first",
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                }

                                ///
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                // width: MediaQuery.of(context).size.width / 3,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                // height: 45,
                                // width:(width ?? 300) ,
                                decoration: (paused_time.length == 4
                                    ? BoxDecoration(
                                    border: Border.all(
                                        color: ColorUtils.primary_gold,
                                        width: 1),
                                    borderRadius:
                                    BorderRadius.circular(100))
                                    : BoxDecoration(
                                  // color: ColorUtils.primary_gold,
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // stops: [0.1, 0.5, 0.7, 0.9],
                                      colors: [
                                        HexColor("#ECDD8F")
                                            .withOpacity(0.6),
                                        HexColor("#E5CC79")
                                            .withOpacity(0.60),
                                        HexColor("#CE952F")
                                            .withOpacity(0.60),
                                      ],
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(100))),
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      (startStop
                                          ? (paused ? 'Resume' : 'Start')
                                          : 'Pause'),
                                      style: FontStyleUtility.h16(
                                          fontColor: paused_time.length == 4
                                              ? Colors.white
                                              : Colors.black,
                                          family: 'PM'),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 28,
                        // ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     if (method_selected.isNotEmpty) {
                        //       if (started) {
                        //         start_animation();
                        //         startWatch();
                        //       } else {
                        //         await stopWatch_finish();
                        //         method_time.add(ListMethodClass(
                        //             method_name: method_selected,
                        //             pauses: paused_time.length.toString(),
                        //             total_time: elapsedTime));
                        //         setState(() {
                        //           elapsedTime = '00:00';
                        //           percent = 0.0;
                        //           method_selected = '';
                        //           watch.reset();
                        //           paused_time.clear();
                        //         });
                        //         print(method_time.length);
                        //
                        //         await _masturbation_screen_controller
                        //             .m_method_post_API(
                        //                 context: context, method_data: method_time);
                        //         // print('method_time : ${method_time[0].total_time}');
                        //         // print('method_name : ${method_time[0].method_name}');
                        //       }
                        //     } else {
                        //       await Fluttertoast.showToast(
                        //         msg: "Please select method first",
                        //         textColor: Colors.white,
                        //         backgroundColor: Colors.red,
                        //         toastLength: Toast.LENGTH_LONG,
                        //         gravity: ToastGravity.BOTTOM,
                        //       );
                        //     }
                        //   },
                        //   child: Container(
                        //     height: 65,
                        //     margin: EdgeInsets.symmetric(horizontal: 15),
                        //     // height: 45,
                        //     // width:(width ?? 300) ,
                        //     decoration: BoxDecoration(
                        //         color: ColorUtils.primary_gold,
                        //         gradient: LinearGradient(
                        //           begin: Alignment.centerLeft,
                        //           end: Alignment.centerRight,
                        //           // stops: [0.1, 0.5, 0.7, 0.9],
                        //           colors: [
                        //             HexColor("#ECDD8F").withOpacity(0.90),
                        //             HexColor("#E5CC79").withOpacity(0.90),
                        //             HexColor("#CE952F").withOpacity(0.90),
                        //           ],
                        //         ),
                        //         borderRadius: BorderRadius.circular(15)),
                        //     child: Container(
                        //         alignment: Alignment.center,
                        //         margin: EdgeInsets.symmetric(
                        //           vertical: 12,
                        //         ),
                        //         child: Text(
                        //           (started ? 'Start' : 'Finish'),
                        //           style: FontStyleUtility.h16(
                        //               fontColor: Colors.black, family: 'PM'),
                        //         )),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     await _masturbation_screen_controller
                        //         .m_method_post_API(
                        //             context: context, method_data: method_time);
                        //   },
                        //   child: Container(
                        //     height: 65,
                        //     margin: EdgeInsets.symmetric(horizontal: 15),
                        //     // height: 45,
                        //     // width:(width ?? 300) ,
                        //     decoration: BoxDecoration(
                        //         color: ColorUtils.primary_gold,
                        //         gradient: LinearGradient(
                        //           begin: Alignment.centerLeft,
                        //           end: Alignment.centerRight,
                        //           // stops: [0.1, 0.5, 0.7, 0.9],
                        //           colors: [
                        //             HexColor("#ECDD8F").withOpacity(0.90),
                        //             HexColor("#E5CC79").withOpacity(0.90),
                        //             HexColor("#CE952F").withOpacity(0.90),
                        //           ],
                        //         ),
                        //         borderRadius: BorderRadius.circular(15)),
                        //     child: Container(
                        //         alignment: Alignment.center,
                        //         margin: EdgeInsets.symmetric(
                        //           vertical: 12,
                        //         ),
                        //         child: Text(
                        //           'Add',
                        //           style: FontStyleUtility.h16(
                        //               fontColor: Colors.black, family: 'PM'),
                        //         )),
                        //   ),
                        // ),
                        SizedBox(
                          height: 21,
                        ),

                        ///
                        Container(
                            child: (paused_time.isNotEmpty
                                ? Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 0,
                                      top: 0,
                                      left: 15,
                                      right: 15),
                                  decoration: BoxDecoration(
                                      color:
                                      Colors.black.withOpacity(0.65),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        // stops: [0.1, 0.5, 0.7, 0.9],
                                        colors: [
                                          HexColor("#020204")
                                              .withOpacity(0.63),
                                          // HexColor("#151619").withOpacity(0.63),
                                          HexColor("#36393E")
                                              .withOpacity(0.63),
                                        ],
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, top: 20),
                                    child: ListView.builder(
                                      itemCount: paused_time.length,
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "Pause ${index + 1}",
                                                style: FontStyleUtility.h15(
                                                    fontColor: ColorUtils
                                                        .primary_grey,
                                                    family: 'PR'),
                                              ),
                                              Text(
                                                paused_time[index],
                                                style:
                                                FontStyleUtility.h15(
                                                    fontColor:
                                                    HexColor(
                                                        '#6E6E6E'),
                                                    family: 'PR'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : SizedBox.shrink())),
                        SizedBox(
                          height: 21,
                        ),
                        (method_time.isNotEmpty
                            ? Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  HexColor("#36393E").withOpacity(0.45),
                                  HexColor("#020204").withOpacity(0.45),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(left: 30, top: 8.5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Progress Tracker',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_gold,
                                      family: 'PMB'),
                                ),
                              ),
                              // SizedBox(
                              //   height: 29,
                              // ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 15,
                                      left: 15,
                                      top: 15,
                                      bottom: 20),
                                  decoration: BoxDecoration(
                                    // color: Colors.black.withOpacity(0.65),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        // stops: [0.1, 0.5, 0.7, 0.9],
                                        colors: [
                                          HexColor("#020204")
                                              .withOpacity(0.65),
                                          HexColor("#36393E")
                                              .withOpacity(0.65),
                                        ],
                                      ),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: HexColor('#04060F'),
                                      //       offset: Offset(10, 10),
                                      //       blurRadius: 10)
                                      // ],
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment:
                                                Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color:
                                                        Colors.black,
                                                        width: 1),
                                                    bottom: BorderSide(
                                                        color:
                                                        Colors.black,
                                                        width: 1),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Method Used',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_grey,
                                                        family: 'PR'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color:
                                                        Colors.black,
                                                        width: 1),
                                                    bottom: BorderSide(
                                                        color:
                                                        Colors.black,
                                                        width: 1),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Pause',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_grey,
                                                        family: 'PR'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment:
                                                Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.black,
                                                          width: 1),
                                                    )),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Current time',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_grey,
                                                        family: 'PR'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: method_time.length,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder:
                                            (BuildContext context,
                                            int index) {
                                          return GestureDetector(
                                            onLongPress: () {
                                              print(
                                                  "Method ID : ${method_time[index].id}");
                                              methodPopUp(
                                                  context: context,
                                                  method_old:
                                                  method_time[index]
                                                      .method_name!,
                                                  method_id:
                                                  method_time[index]
                                                      .id!);
                                            },
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    BoxDecoration(
                                                        border:
                                                        Border(
                                                          right: BorderSide(
                                                              color: Colors
                                                                  .black,
                                                              width: 1),
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .black,
                                                              width: 1),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.5),
                                                      child: Text(
                                                        '${method_time[index].method_name}',
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        style: FontStyleUtility.h14(
                                                            fontColor: HexColor(method_time[index].color!),
                                                            // (method_time[index]
                                                            //     .method_name ==!
                                                            //     'Hand'
                                                            //     ? Colors
                                                            //     .red
                                                            //     : (method_time[index]
                                                            //     .method_name ==
                                                            //     'Dildo'
                                                            //     ? Colors
                                                            //     .blue
                                                            //     : (method_time[index]
                                                            //     .method_name ==
                                                            //     'Sex'
                                                            //     ? Colors.green
                                                            //     : (method_time[index]
                                                            //     .method_name ==
                                                            //     'Fleshlight'
                                                            //     ? Colors.purple
                                                            //     : Colors
                                                            //     .primaries[_random
                                                            //     .nextInt(
                                                            //     Colors
                                                            //         .primaries
                                                            //         .length)][_random
                                                            //     .nextInt(
                                                            //     9) *
                                                            //     100])))),
                                                            // (index <=
                                                            //         3
                                                            //     ? colors[
                                                            //         index]
                                                            //     : Colors
                                                            //         .white),
                                                            family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    const BoxDecoration(
                                                        border:
                                                        Border(
                                                          right: BorderSide(
                                                              color: Colors
                                                                  .black,
                                                              width: 1),
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .black,
                                                              width: 1),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.5),
                                                      child: Text(
                                                        '${method_time[index].pauses}',
                                                        style: FontStyleUtility.h14(
                                                            fontColor:
                                                            ColorUtils
                                                                .primary_grey,
                                                            family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    decoration:
                                                    const BoxDecoration(
                                                        border:
                                                        Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .black,
                                                              width: 1),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(4.5),
                                                      child: Text(
                                                        '${method_time[index].total_time}',
                                                        style: FontStyleUtility.h14(
                                                            fontColor:
                                                            HexColor(
                                                                '#7A7A7A'),
                                                            family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      // Container(
                                      //   child: Row(
                                      //     children: [
                                      //       Expanded(
                                      //         flex: 2,
                                      //         child: GestureDetector(
                                      //           onTap: () {
                                      //             addmethod_popup(
                                      //                 context);
                                      //           },
                                      //           child: Container(
                                      //             alignment:
                                      //                 Alignment.center,
                                      //             decoration:
                                      //                 BoxDecoration(
                                      //                     border: Border(
                                      //               right: BorderSide(
                                      //                   color:
                                      //                       Colors.black,
                                      //                   width: 1),
                                      //             )),
                                      //             child: Padding(
                                      //               padding:
                                      //                   const EdgeInsets
                                      //                           .symmetric(
                                      //                       vertical:
                                      //                           4.5),
                                      //               child: Container(
                                      //                 decoration:
                                      //                     BoxDecoration(
                                      //                         borderRadius:
                                      //                             BorderRadius.circular(500),
                                      //                         gradient: LinearGradient(
                                      //                           begin: Alignment
                                      //                               .centerLeft,
                                      //                           end: Alignment
                                      //                               .centerRight,
                                      //                           // stops: [0.1, 0.5, 0.7, 0.9],
                                      //                           colors: [
                                      //                             HexColor("#020204")
                                      //                                 .withOpacity(1),
                                      //                             HexColor("#36393E")
                                      //                                 .withOpacity(1),
                                      //                           ],
                                      //                         ),
                                      //                         boxShadow: [
                                      //                       BoxShadow(
                                      //                           color: HexColor(
                                      //                               '#04060F'),
                                      //                           offset:
                                      //                               Offset(
                                      //                                   3,
                                      //                                   3),
                                      //                           blurRadius:
                                      //                               10)
                                      //                     ]),
                                      //                 child: Padding(
                                      //                   padding: const EdgeInsets
                                      //                           .symmetric(
                                      //                       horizontal:
                                      //                           6),
                                      //                   child:
                                      //                       Image.asset(
                                      //                     AssetUtils
                                      //                         .plus_big,
                                      //                     height: 23,
                                      //                     width: 10,
                                      //                     color: HexColor(
                                      //                         '#606060'),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       Expanded(
                                      //         child: Container(
                                      //           alignment:
                                      //               Alignment.center,
                                      //           decoration: BoxDecoration(
                                      //               border: Border(
                                      //             right: BorderSide(
                                      //                 color: Colors.black,
                                      //                 width: 1),
                                      //           )),
                                      //           child: Padding(
                                      //             padding:
                                      //                 const EdgeInsets
                                      //                     .all(4.5),
                                      //             child: Text(
                                      //               '-',
                                      //               style: FontStyleUtility.h14(
                                      //                   fontColor: ColorUtils
                                      //                       .primary_gold,
                                      //                   family: 'PR'),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       Expanded(
                                      //         flex: 2,
                                      //         child: Container(
                                      //           alignment:
                                      //               Alignment.center,
                                      //           decoration: BoxDecoration(
                                      //               border: Border()),
                                      //           child: Padding(
                                      //             padding:
                                      //                 const EdgeInsets
                                      //                     .all(5),
                                      //             child: Text(
                                      //               '-',
                                      //               style: FontStyleUtility.h14(
                                      //                   fontColor: ColorUtils
                                      //                       .primary_gold,
                                      //                   family: 'PR'),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                            : SizedBox.shrink()),

                        const SizedBox(
                          height: 21,
                        ),

                        ///
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  HexColor("#36393E").withOpacity(0.45),
                                  HexColor("#020204").withOpacity(0.45),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                // decoration: BoxDecoration(
                                //     // color: Colors.black.withOpacity(0.65),
                                //     gradient: LinearGradient(
                                //       begin: Alignment.centerLeft,
                                //       end: Alignment.centerRight,
                                //       // stops: [0.1, 0.5, 0.7, 0.9],
                                //       colors: [
                                //         HexColor("#020204").withOpacity(0.65),
                                //         HexColor("#36393E").withOpacity(0.65),
                                //       ],
                                //     ),
                                //     // boxShadow: [
                                //     //   BoxShadow(
                                //     //       color: HexColor('#04060F'),
                                //     //       offset: Offset(10, 10),
                                //     //       blurRadius: 10)
                                //     // ],
                                //     borderRadius: BorderRadius.circular(20)),
                                decoration: BoxDecoration(
                                    color:
                                    HexColor('#181A1F').withOpacity(0.65),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   margin: EdgeInsets.all(15),
                                    //   child: Row(
                                    //     children: [
                                    //       Expanded(
                                    //         child: Container(
                                    //           alignment: Alignment.center,
                                    //           child: Image.asset(
                                    //             AssetUtils.m_screen_trophy,
                                    //             height: 25,
                                    //             width: 20,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       SizedBox(
                                    //         width: 5,
                                    //       ),
                                    //       Expanded(
                                    //         flex: 2,
                                    //         child: Container(
                                    //           child: Column(
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text('Best result',
                                    //                   style: FontStyleUtility.h14(
                                    //                       fontColor:
                                    //                           HexColor('#A2A2A2'),
                                    //                       family: 'PR')),
                                    //               Text('72 sec',
                                    //                   style: FontStyleUtility.h14(
                                    //                       fontColor: Colors.white,
                                    //                       family: 'PR')),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 2,
                                    //         child: Container(
                                    //           child: Column(
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text('Last measurement',
                                    //                   style: FontStyleUtility.h14(
                                    //                       fontColor:
                                    //                           HexColor('#A2A2A2'),
                                    //                       family: 'PR')),
                                    //               Text('26 days ago',
                                    //                   style: FontStyleUtility.h14(
                                    //                       fontColor: Colors.white,
                                    //                       family: 'PR')),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      // decoration: BoxDecoration(
                                      //     color: HexColor('#181A1F')
                                      //         .withOpacity(0.65),
                                      //     borderRadius: BorderRadius.only(
                                      //         bottomRight: Radius.circular(20),
                                      //         bottomLeft: Radius.circular(20))),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(13),
                                          // border: Border.all(
                                          //     color: HexColor('#383E46'),
                                          //     width: 1)
                                        ),
                                        // margin: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        'Daily Graph',
                                                        style: FontStyleUtility.h14(
                                                            fontColor: ColorUtils
                                                                .primary_gold,
                                                            family: 'PR'),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      (loading
                                                          ? CircularProgressIndicator(
                                                        color:
                                                        Colors.green,
                                                      )
                                                          : (m_screenDailyDataModel!
                                                          .data!
                                                          .isEmpty ||
                                                          m_screenDailyDataModel!
                                                              .data![0]
                                                              .days!
                                                              .isEmpty
                                                          ? SizedBox
                                                          .shrink()
                                                          : Text(
                                                        DateFormat("MM-dd-yyyy").format(DateFormat(
                                                            "yyyy-MM-dd hh:mm:ss")
                                                            .parse(m_screenDailyDataModel!
                                                            .data![
                                                        0]
                                                            .days![
                                                        0]
                                                            .createdDate!)),
                                                        style: FontStyleUtility.h14(
                                                            fontColor:
                                                            HexColor(
                                                                '#D5D5D5'),
                                                            family:
                                                            'PR'),
                                                      ))),
                                                      // Text(
                                                      //   'Top result: 40 sec',
                                                      //   style:
                                                      //       FontStyleUtility.h14(
                                                      //           fontColor:
                                                      //               HexColor(
                                                      //                   "#66686B"),
                                                      //           family: 'PR'),
                                                      // ),
                                                    ],
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(50),
                                                        gradient:
                                                        LinearGradient(
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
                                                              offset:
                                                              Offset(3, 3),
                                                              blurRadius: 10)
                                                        ]),
                                                    child: IconButton(
                                                      visualDensity:
                                                      VisualDensity(
                                                          vertical: -2,
                                                          horizontal: -2),
                                                      onPressed: () {
                                                        selectdate(context);
                                                      },
                                                      iconSize: 15,
                                                      icon: Icon(
                                                        Icons.calendar_today,
                                                        color: ColorUtils
                                                            .primary_grey,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                                height: 250,
                                                child: SfCartesianChart(
                                                    plotAreaBorderWidth: 0,
                                                    plotAreaBorderColor:
                                                    ColorUtils.primary_grey,
                                                    tooltipBehavior:
                                                    _tooltipBehavior,
                                                    // zoomPanBehavior:
                                                    //     _zoomPanBehavior,

                                                    // legend: Legend(
                                                    //     isVisible: true,
                                                    //     position:
                                                    //         LegendPosition.bottom,
                                                    //     textStyle:
                                                    //         FontStyleUtility.h12(
                                                    //             fontColor:
                                                    //                 Colors.white,
                                                    //             family: "PM")),
                                                    primaryXAxis: CategoryAxis(
                                                        majorGridLines:
                                                        MajorGridLines(
                                                            width: 0),
                                                        // isInversed: true,

                                                        //Hide the axis line of y-axis
                                                        axisLine:
                                                        AxisLine(width: 0)),
                                                    primaryYAxis: NumericAxis(
                                                      //Hide the gridlines of y-axis
                                                      // opposedPosition: true,
                                                      // rangePadding: ChartRangePadding.none,
                                                        title: AxisTitle(
                                                            text: 'minutes'),
                                                        minimum: 0,
                                                        // maximum: 30,
                                                        interval: 5,
                                                        //Axis label customization.
                                                        labelStyle:
                                                        const TextStyle(
                                                            color: Colors
                                                                .blueGrey,
                                                            fontSize: 10),
                                                        // numberFormat: NumberFormat
                                                        //     .compact(),
                                                        majorGridLines:
                                                        MajorGridLines(
                                                            width: 1,
                                                            color: HexColor(
                                                                '#383E46')),
                                                        //Hide the axis line of y-axis
                                                        axisLine: AxisLine(
                                                            width: 1,
                                                            color: HexColor(
                                                                '#383E46'))),
                                                    // tooltipBehavior:
                                                    //     _tooltipBehavior,
                                                    enableSideBySideSeriesPlacement:
                                                    false,
                                                    series: <
                                                        ChartSeries<ChartData2,
                                                            String>>[
                                                      // Renders column chart
                                                      ColumnSeries<ChartData2,
                                                          String>(
                                                          dataSource:
                                                          daily_data_list,
                                                          enableTooltip: false,
                                                          width: 0.5,
                                                          // spacing: 0.6,
                                                          color: HexColor(
                                                              '#F92824'),
                                                          borderRadius:
                                                          BorderRadius.only(
                                                            topRight:
                                                            Radius.circular(
                                                                5),
                                                            topLeft:
                                                            Radius.circular(
                                                                5),
                                                          ),
                                                          // spacing: 0.5,
                                                          pointColorMapper:
                                                              (ChartData2 data,
                                                              _) =>
                                                              HexColor(data
                                                                  .color),
                                                          xValueMapper:
                                                              (ChartData2 data,
                                                              _) =>
                                                          data.x,
                                                          yValueMapper:
                                                              (ChartData2 data,
                                                              _) =>
                                                          data.y),

                                                      RangeColumnSeries<
                                                          ChartData2, String>(
                                                        dataSource:
                                                        daily_data_list,
                                                        width: 0.5,
                                                        color: Colors.black45,
                                                        xValueMapper:
                                                            (ChartData2 data,
                                                            _) =>
                                                        data.x,
                                                        lowValueMapper:
                                                            (ChartData2 data,
                                                            _) =>
                                                        data.pause_time -
                                                            0.3,
                                                        highValueMapper:
                                                            (ChartData2 data,
                                                            _) =>
                                                        data.pause_time,
                                                      )
                                                      // ScatterSeries<ChartData2,
                                                      //     String>(
                                                      //   dataSource:
                                                      //       daily_data_list,
                                                      //   // width: 0.5,
                                                      //
                                                      //   markerSettings:
                                                      //       MarkerSettings(
                                                      //     height: 20,
                                                      //     color: Colors.red,
                                                      //     width: 10,
                                                      //     // Scatter will render in diamond shape
                                                      //     shape: DataMarkerType
                                                      //         .rectangle,
                                                      //   ),
                                                      //   color: Colors.white,
                                                      //   xValueMapper:
                                                      //       (ChartData2 data,
                                                      //               _) =>
                                                      //           data.x,
                                                      //   yValueMapper:
                                                      //       (ChartData2 data,
                                                      //               _) =>
                                                      //           data.y,
                                                      //   // lowValueMapper: (ChartData2 data, _) => data.y-0.1,
                                                      //   // highValueMapper: (ChartData2 data, _) => data.y,
                                                      // )
                                                    ])),
                                            (loading
                                                ? SizedBox.shrink()
                                                : (m_screenDailyDataModel!
                                                .data!.isEmpty
                                                ? SizedBox.shrink()
                                                : Container(
                                              margin: EdgeInsets
                                                  .symmetric(
                                                  vertical: 0,
                                                  horizontal: 20),
                                              width: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .width,
                                              // width: 100,
                                              height: 50,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemCount:
                                                methoddd.length,
                                                itemBuilder:
                                                    (BuildContext
                                                context,
                                                    int index) {
                                                  return Row(
                                                    children: [
                                                      Container(
                                                        child: Icon(
                                                          Icons
                                                              .bar_chart,
                                                          color: HexColor(
                                                              coloring[
                                                              index]),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          methoddd[
                                                          index],
                                                          style: FontStyleUtility.h12(
                                                              fontColor:
                                                              Colors
                                                                  .white,
                                                              family:
                                                              "PM"),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            )))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // stops: [0.1, 0.5, 0.7, 0.9],
                                      colors: [
                                        HexColor("#020204").withOpacity(0.65),
                                        HexColor("#36393E").withOpacity(0.65),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Weekly Graph',
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                ColorUtils.primary_gold,
                                                family: 'PR'),
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //       borderRadius:
                                          //           BorderRadius.circular(50),
                                          //       gradient: LinearGradient(
                                          //         begin: Alignment.centerLeft,
                                          //         end: Alignment.centerRight,
                                          //         // stops: [0.1, 0.5, 0.7, 0.9],
                                          //         colors: [
                                          //           HexColor("#020204")
                                          //               .withOpacity(1),
                                          //           HexColor("#36393E")
                                          //               .withOpacity(1),
                                          //         ],
                                          //       ),
                                          //       boxShadow: [
                                          //         BoxShadow(
                                          //             color: HexColor('#04060F'),
                                          //             offset: Offset(3, 3),
                                          //             blurRadius: 10)
                                          //       ]),
                                          //   child: IconButton(
                                          //     visualDensity: VisualDensity(
                                          //         vertical: -2, horizontal: -2),
                                          //     onPressed: () {
                                          //       selectdate(context);
                                          //     },
                                          //     iconSize: 15,
                                          //     icon: Icon(
                                          //       Icons.calendar_today,
                                          //       color: ColorUtils.primary_grey,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 250,
                                        child: SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            plotAreaBorderColor:
                                            ColorUtils.primary_grey,
                                            tooltipBehavior: _tooltipBehavior2,
                                            // zoomPanBehavior: _zoomPanBehavior,
                                            legend: Legend(
                                                isVisible: false,
                                                position: LegendPosition.bottom,
                                                textStyle: FontStyleUtility.h12(
                                                    fontColor: Colors.white,
                                                    family: "PM")),
                                            primaryXAxis: CategoryAxis(
                                                majorGridLines:
                                                MajorGridLines(width: 0),
                                                autoScrollingMode:
                                                AutoScrollingMode.start,
                                                // zoomFactor: 0.6,

                                                // zoomFactor:2 ,
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(width: 0)),
                                            primaryYAxis: NumericAxis(
                                              //Hide the gridlines of y-axis
                                                title:
                                                AxisTitle(text: 'minutes'),
                                                // minimum: 1,
                                                // maximum: 30,
                                                interval: 5,
                                                labelStyle: const TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 10),
                                                // numberFormat: NumberFormat
                                                //     .compact(),
                                                majorGridLines: MajorGridLines(
                                                    width: 1,
                                                    color: HexColor('#383E46')),
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(
                                                    width: 1,
                                                    color:
                                                    HexColor('#383E46'))),
                                            series: mohit
                                          // <ChartSeries<ChartData0, String>>[
                                          //   // Renders column chart
                                          //   ColumnSeries<ChartData0, String>(
                                          //       // dataSource: _masturbation_screen_controller.gst_payable_list,
                                          //       dataSource: weekly_data,
                                          //       enableTooltip: true,
                                          //       legendItemText: 'Hand',
                                          //       width: 0.5,
                                          //       spacing: 0.3,
                                          //       color: HexColor('#DD3931'),
                                          //       pointColorMapper: (ChartData0
                                          //                   data,
                                          //               _) =>
                                          //           (data
                                          //                       .x1 ==
                                          //                   'Hand'
                                          //               ? Colors.red
                                          //               : (data
                                          //                           .x1 ==
                                          //                       'Dildo'
                                          //                   ? Colors.blue
                                          //                   : (data
                                          //                               .x1 ==
                                          //                           'Sex'
                                          //                       ? Colors.green
                                          //                       : (data.x1 ==
                                          //                               'Fleshlight'
                                          //                           ? Colors
                                          //                               .purple
                                          //                           : HexColor(data
                                          //                               .color))))),
                                          //       xValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.x,
                                          //       yValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.y),
                                          //   ColumnSeries<ChartData0, String>(
                                          //       // dataSource: _masturbation_screen_controller.gst_payable_list,
                                          //       dataSource: weekly_data2,
                                          //       enableTooltip: true,
                                          //       legendItemText: 'Dildo',
                                          //       width: 0.5,
                                          //       spacing: 0.3,
                                          //       color: Colors.blue,
                                          //       pointColorMapper: (ChartData0
                                          //                   data,
                                          //               _) =>
                                          //           (data
                                          //                       .x1 ==
                                          //                   'Hand'
                                          //               ? Colors.red
                                          //               : (data
                                          //                           .x1 ==
                                          //                       'Dildo'
                                          //                   ? Colors.blue
                                          //                   : (data
                                          //                               .x1 ==
                                          //                           'Sex'
                                          //                       ? Colors.green
                                          //                       : (data.x1 ==
                                          //                               'Fleshlight'
                                          //                           ? Colors
                                          //                               .purple
                                          //                           : HexColor(data
                                          //                               .color))))),
                                          //       xValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.x,
                                          //       yValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.y),
                                          //   ColumnSeries<ChartData0, String>(
                                          //       // dataSource: _masturbation_screen_controller.gst_payable_list,
                                          //       dataSource: weekly_data3,
                                          //       enableTooltip: true,
                                          //       legendItemText: 'Sex',
                                          //       width: 0.5,
                                          //       spacing: 0.3,
                                          //       color: Colors.green,
                                          //       pointColorMapper: (ChartData0
                                          //                   data,
                                          //               _) =>
                                          //           (data
                                          //                       .x1 ==
                                          //                   'Hand'
                                          //               ? Colors.red
                                          //               : (data
                                          //                           .x1 ==
                                          //                       'Dildo'
                                          //                   ? Colors.blue
                                          //                   : (data
                                          //                               .x1 ==
                                          //                           'Sex'
                                          //                       ? Colors.green
                                          //                       : (data.x1 ==
                                          //                               'Fleshlight'
                                          //                           ? Colors
                                          //                               .purple
                                          //                           : HexColor(data
                                          //                               .color))))),
                                          //       xValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.x,
                                          //       yValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.y),
                                          //   ColumnSeries<ChartData0, String>(
                                          //       // dataSource: _masturbation_screen_controller.gst_payable_list,
                                          //       dataSource: weekly_data4,
                                          //       enableTooltip: true,
                                          //       legendItemText: 'Fleshlight',
                                          //       width: 0.5,
                                          //       spacing: 0.3,
                                          //       color: Colors.purple,
                                          //       pointColorMapper:
                                          //           (ChartData0 data, _) => (data
                                          //                       .x1 ==
                                          //                   'Hand'
                                          //               ? Colors.red
                                          //               : (data.x1 == 'Dildo'
                                          //                   ? Colors.blue
                                          //                   : (data.x1 == 'Sex'
                                          //                       ? Colors.green
                                          //                       : (data.x1 ==
                                          //                               'Fleshlight'
                                          //                           ? Colors
                                          //                               .purple
                                          //                           : HexColor(
                                          //                               "${data.color.substring(2)}"))))),
                                          //       xValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.x,
                                          //       yValueMapper:
                                          //           (ChartData0 data, _) =>
                                          //               data.y),
                                          //   // ColumnSeries<ChartData2, String>(
                                          //   //     width: 0.5,
                                          //   //     spacing: 0.6,
                                          //   //     color: HexColor('#75C043'),
                                          //   //     legendItemText: 'Sex',
                                          //   //
                                          //   //     // dataSource: _masturbation_screen_controller.gst_payable_list,
                                          //   //     dataSource: weekly_data_listM,
                                          //   //     xValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.x,
                                          //   //     yValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.y),
                                          //   // ColumnSeries<ChartData2, String>(
                                          //   //     width: 0.5,
                                          //   //     spacing: 0.6,
                                          //   //     color: HexColor('#1880C3'),
                                          //   //     legendItemText: 'Dildo',
                                          //   //     dataSource: weekly_data_listT,
                                          //   //     xValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.x,
                                          //   //     yValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.y),
                                          //   // ColumnSeries<ChartData2, String>(
                                          //   //     width: 0.5,
                                          //   //     spacing: 0.6,
                                          //   //     color: HexColor('#1880C3'),
                                          //   //     legendItemText: 'Dildo',
                                          //   //     dataSource: weekly_data_listW,
                                          //   //     xValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.x,
                                          //   //     yValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.y),
                                          //   // ColumnSeries<ChartData2, String>(
                                          //   //     width: 0.5,
                                          //   //     spacing: 0.6,
                                          //   //     color: HexColor('#1880C3'),
                                          //   //     legendItemText: 'Dildo',
                                          //   //     dataSource: weekly_data_listTU,
                                          //   //     xValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.x,
                                          //   //     yValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.y),
                                          //   // ColumnSeries<ChartData2, String>(
                                          //   //     width: 0.5,
                                          //   //     spacing: 0.6,
                                          //   //     color: HexColor('#1880C3'),
                                          //   //     legendItemText: 'Dildo',
                                          //   //     dataSource: weekly_data_listF,
                                          //   //     xValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.x,
                                          //   //     yValueMapper:
                                          //   //         (ChartData2 data, _) =>
                                          //   //     data.y),
                                          // ]
                                        )),
                                    (loader
                                        ? SizedBox.shrink()
                                        : (m_screenWeeklyDataModel!
                                        .data!.isEmpty
                                        ? SizedBox.shrink()
                                        : Container(
                                      // color: Colors.pink,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: 20),
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      // width: 100,
                                      height: 50,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection:
                                        Axis.horizontal,
                                        itemCount: methoddd2.length,
                                        itemBuilder:
                                            (BuildContext context,
                                            int index) {
                                          return Row(
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.bar_chart,
                                                  color: HexColor(
                                                      coloring2[
                                                      index]),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  methoddd2[index],
                                                  style: FontStyleUtility
                                                      .h12(
                                                      fontColor:
                                                      Colors
                                                          .white,
                                                      family:
                                                      "PM"),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )))
                                  ],
                                ),
                              ),
                              // Container(
                              //   width: 250,
                              //   decoration: BoxDecoration(
                              //       color: HexColor('#181B23').withOpacity(0.65),
                              //       // boxShadow: [
                              //       //   BoxShadow(
                              //       //       color: HexColor('#000000'),
                              //       //       offset: Offset(0, 6),
                              //       //       blurRadius: 6)
                              //       // ],
                              //       borderRadius: BorderRadius.circular(100)),
                              //   margin: EdgeInsets.symmetric(vertical: 7),
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(vertical: 10.0),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       children: [
                              //         GestureDetector(
                              //           onTap: () {
                              //             setState(() {
                              //               selected_time = 'days';
                              //               graph_life = daily_data_list;
                              //             });
                              //           },
                              //           child: Container(
                              //             decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(100),
                              //               color: (selected_time == 'days'
                              //                   ? HexColor('#21252E')
                              //                   : Colors.transparent),
                              //             ),
                              //             child: Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 5, horizontal: 14),
                              //               child: Text('Days',
                              //                   style: FontStyleUtility.h13(
                              //                       fontColor: (selected_time ==
                              //                               'days'
                              //                           ? Colors.white
                              //                           : HexColor('#656565')),
                              //                       family: 'PM')),
                              //             ),
                              //           ),
                              //         ),
                              //         GestureDetector(
                              //           onTap: () {
                              //             setState(() {
                              //               selected_time = 'weeks';
                              //               graph_life = weekly_data5;
                              //             });
                              //           },
                              //           child: Container(
                              //             decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(100),
                              //                 color: (selected_time == 'weeks'
                              //                     ? HexColor('#21252E')
                              //                     : Colors.transparent)),
                              //             child: Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 5, horizontal: 14),
                              //               child: Text('Weeks',
                              //                   style: FontStyleUtility.h13(
                              //                       fontColor: (selected_time ==
                              //                               'weeks'
                              //                           ? Colors.white
                              //                           : HexColor('#656565')),
                              //                       family: 'PM')),
                              //             ),
                              //           ),
                              //         ),
                              //         GestureDetector(
                              //           onTap: () {
                              //             setState(() {
                              //               selected_time = 'months';
                              //               graph_life = lifetime_data_list;
                              //             });
                              //           },
                              //           child: Container(
                              //             decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(100),
                              //                 color: (selected_time == 'months'
                              //                     ? HexColor('#21252E')
                              //                     : Colors.transparent)),
                              //             child: Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 5, horizontal: 14),
                              //               child: Text('Months',
                              //                   style: FontStyleUtility.h13(
                              //                       fontColor: (selected_time ==
                              //                               'months'
                              //                           ? Colors.white
                              //                           : HexColor('#656565')),
                              //                       family: 'PM')),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.65),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // stops: [0.1, 0.5, 0.7, 0.9],
                                      colors: [
                                        HexColor("#020204").withOpacity(0.65),
                                        HexColor("#36393E").withOpacity(0.65),
                                      ],
                                    ),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: HexColor('#04060F'),
                                    //       offset: Offset(10, 10),
                                    //       blurRadius: 10)
                                    // ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 13, left: 31, bottom: 25),
                                      child: Text('Life time',
                                          style: FontStyleUtility.h14(
                                              fontColor:
                                              ColorUtils.primary_gold,
                                              family: 'PR')),
                                    ),
                                    Container(
                                        height: 250,
                                        child: SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            plotAreaBorderColor:
                                            ColorUtils.primary_grey,

                                            // tooltipBehavior: _tooltipBehavior,
                                            // crosshairBehavior: _crosshairBehavior,
                                            trackballBehavior:
                                            _trackballBehavior,
                                            // zoomPanBehavior: _zoomPanBehavior,
                                            primaryXAxis: CategoryAxis(
                                                rangePadding:
                                                ChartRangePadding.auto,
                                                majorGridLines:
                                                MajorGridLines(width: 0),
                                                // arrangeByIndex: true,
                                                // zoomFactor: 0.2,
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(width: 0)),
                                            primaryYAxis: NumericAxis(
                                              //Hide the gridlines of y-axis
                                              // opposedPosition: true,
                                              // rangePadding: ChartRangePadding.none,
                                                title:
                                                AxisTitle(text: 'minutes'),
                                                // minimum: 1,
                                                // maximum: 30,
                                                interval: 5,
                                                //Axis label ustomization.
                                                labelStyle: const TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 10),
                                                // numberFormat: NumberFormat
                                                //     .compact(),
                                                majorGridLines: MajorGridLines(
                                                    width: 1,
                                                    color: HexColor('#383E46')),
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(
                                                    width: 1,
                                                    color:
                                                    HexColor('#383E46'))),
                                            // primaryYAxis: NumericAxis(
                                            //     //Hide the gridlines of y-axis
                                            //     majorGridLines:
                                            //         MajorGridLines(width: 0),
                                            //     //Hide the axis line of y-axis
                                            //     axisLine: AxisLine(width: 3)),
                                            series: <ChartSeries>[
                                              SplineSeries<ChartData2, String>(
                                                  markerSettings:
                                                  const MarkerSettings(
                                                      isVisible: true,
                                                      borderWidth: 1,
                                                      height: 6,
                                                      width: 6),
                                                  dataSource: graph_life,
                                                  // gst_payable_list,
                                                  // Bind the color for all the data points from the data source
                                                  // color: Colors.purple,
                                                  // selectionBehavior:_selectionBehavior ,
                                                  pointColorMapper:
                                                      (ChartData2 data, _) =>
                                                  Colors.green,
                                                  xValueMapper:
                                                      (ChartData2 data, _) =>
                                                  data.x,
                                                  yValueMapper:
                                                      (ChartData2 data, _) =>
                                                  data.y)
                                            ])),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.65),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // stops: [0.1, 0.5, 0.7, 0.9],
                                      colors: [
                                        HexColor("#020204").withOpacity(0.65),
                                        HexColor("#36393E").withOpacity(0.65),
                                      ],
                                    ),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: HexColor('#04060F'),
                                    //       offset: Offset(10, 10),
                                    //       blurRadius: 10)
                                    // ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: ExpansionTile(
                                  iconColor: ColorUtils.primary_gold,
                                  title: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          top: 15,
                                          right: 15,
                                          bottom: 15),
                                      child: Text(
                                        "Technique",
                                        textAlign: TextAlign.left,
                                        style: FontStyleUtility.h15(
                                            fontColor: ColorUtils.primary_grey,
                                            family: 'PM'),
                                      ),
                                    ),
                                  ),
                                  children: <Widget>[

                                    isinfoLoading
                                        ? SizedBox()
                                        : Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 19.0),
                                      child: RichText(text: textSpan),
                                    ),
                                    // Html(
                                    //   anchorKey: GlobalKey(),
                                    //   data: _kegel_controller
                                    //       .getTechniqueModel!
                                    //       .data!
                                    //       .technique,
                                    //   // data: "<h5>check 1<\/p>\r\n",
                                    //   style: {
                                    //     "body": Style(
                                    //       // backgroundColor: const Color.fromARGB(
                                    //       //     0x50, 0xee, 0xee, 0xee),
                                    //       backgroundColor:
                                    //       Colors.transparent,
                                    //     ),
                                    //     "tr": Style(
                                    //       border: const Border(
                                    //           bottom: BorderSide(
                                    //               color: Colors.grey)),
                                    //     ),
                                    //     "th": Style(
                                    //       padding:
                                    //       const EdgeInsets.all(6),
                                    //       backgroundColor: Colors.grey,
                                    //     ),
                                    //     "td": Style(
                                    //       padding:
                                    //       const EdgeInsets.all(6),
                                    //       alignment: Alignment.topLeft,
                                    //     ),
                                    //     'h5': Style(
                                    //         maxLines: 2,
                                    //         color: Colors.red,
                                    //         textOverflow:
                                    //         TextOverflow.ellipsis),
                                    //   },
                                    // )

                                    // ListView.builder(
                                    //   itemCount: List_content.length,
                                    //   shrinkWrap: true,
                                    //   padding:
                                    //       EdgeInsets.symmetric(horizontal: 15),
                                    //   physics: ClampingScrollPhysics(),
                                    //   itemBuilder:
                                    //       (BuildContext context, int index) {
                                    //     return Row(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Text(
                                    //           "${index + 1}. ",
                                    //           textAlign: TextAlign.justify,
                                    //           style: FontStyleUtility.h15(
                                    //               fontColor:
                                    //                   ColorUtils.primary_grey,
                                    //               family: 'PM'),
                                    //         ),
                                    //         Expanded(
                                    //           child: Text(
                                    //             List_content[index],
                                    //             textAlign: TextAlign.left,
                                    //             style: FontStyleUtility.h15(
                                    //                 fontColor:
                                    //                     ColorUtils.primary_grey,
                                    //                 family: 'PM'),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     );
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                              // Container(
                              //     margin: EdgeInsets.all(15),
                              //     decoration: BoxDecoration(
                              //         // color: Colors.black.withOpacity(0.65),
                              //         gradient: LinearGradient(
                              //           begin: Alignment.centerLeft,
                              //           end: Alignment.centerRight,
                              //           // stops: [0.1, 0.5, 0.7, 0.9],
                              //           colors: [
                              //             HexColor("#020204").withOpacity(0.65),
                              //             HexColor("#36393E").withOpacity(0.65),
                              //           ],
                              //         ),
                              //         // boxShadow: [
                              //         //   BoxShadow(
                              //         //       color: HexColor('#04060F'),
                              //         //       offset: Offset(10, 10),
                              //         //       blurRadius: 10)
                              //         // ],
                              //         borderRadius: BorderRadius.circular(20)),
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Container(
                              //           child: Padding(
                              //             padding: const EdgeInsets.only(
                              //                 left: 40,
                              //                 top: 15,
                              //                 right: 15,
                              //                 bottom: 15),
                              //             child: Text(
                              //               "Technique",
                              //               style: FontStyleUtility.h15(
                              //                   fontColor:
                              //                       ColorUtils.primary_grey,
                              //                   family: 'PM'),
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //         height: 500,
                              //           child: ListView.builder(
                              //             itemCount: List_content.length,
                              //               shrinkWrap: true,
                              //               padding: EdgeInsets.symmetric(horizontal: 15),
                              //               physics: ClampingScrollPhysics(),
                              //               itemBuilder: (BuildContext context, int index){
                              //               return Row(
                              //                 crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     "${index+1}. ",
                              //                     textAlign: TextAlign.justify,
                              //                     style: FontStyleUtility.h15(
                              //                         fontColor:
                              //                         ColorUtils.primary_grey,
                              //                         family: 'PM'),
                              //                   ),
                              //                   Expanded(
                              //                     child: Text(
                              //                       List_content[index],
                              //                       textAlign: TextAlign.justify,
                              //                       style: FontStyleUtility.h15(
                              //                           fontColor:
                              //                           ColorUtils.primary_grey,
                              //                           family: 'PM'),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               );
                              //               },
                              //           ),
                              //         ),
                              //
                              //       ],
                              //     )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }

  // M_ScreenWeeklyDataModel? m_screenWeeklyDataModel;

  // var getUSerModelList = M_ScreenGetModel().obs;
  var x_axis = ["M", "T", "W", "T", "F", "S", "S"];
  List<ChartData2> lifetime_data_list = [];
  List<ChartData2> daily_data_list = [];

  List<ChartData2> weekly_data_list = [];

  List<ChartData0> weekly_data = [];
  List<ChartData0> weekly_data2 = [];
  List<ChartData0> weekly_data3 = [];
  List<ChartData0> weekly_data4 = [];
  List<ChartData2> weekly_data5 = [];

  List<ChartData2> weekly_data_listS = [];
  List<ChartData2> weekly_data_listM = [];
  List<ChartData2> weekly_data_listT = [];
  List<ChartData2> weekly_data_listW = [];
  List<ChartData2> weekly_data_listTU = [];
  List<ChartData2> weekly_data_listF = [];
  List<ChartData2> weekly_data_listSA = [];

  List colors = [Colors.red, Colors.blue, Colors.green, Colors.purple];
  Random random = new Random();

  int index = 0;

  Future changeIndex() async {
    setState(() => index = random.nextInt(1));
  }

  // Future<dynamic> MasturbationWeekly_Data_get_API(BuildContext context) async {
  //   print('Inside creator get email');
  //   showLoader(context);
  //   String id_user = await PreferenceManager().getPref(URLConstants.id);
  //   print("UserID $id_user");
  //   String url =
  //       "${URLConstants.base_url}${URLConstants.masturbation_get_weekly_data}?userId=$id_user";
  //   // debugPrint('Get Sales Token ${tokens.toString()}');
  //   // try {
  //   // } catch (e) {
  //   //   print('1-1-1-1 Get Purchase ${e.toString()}');
  //   // }
  //
  //   try {
  //     http.Response response = await http.get(Uri.parse(url));
  //
  //     print('Response request: ${response.request}');
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var data = convert.jsonDecode(response.body);
  //       m_screenWeeklyDataModel = M_ScreenWeeklyDataModel.fromJson(data);
  //       // getUSerModelList(userInfoModel_email);
  //       if (m_screenWeeklyDataModel!.error == false) {
  //         hideLoader(context);
  //         debugPrint(
  //             '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenWeeklyDataModel!.data!.length}');
  //         // CommonWidget().showToaster(msg: breathingGetModel!.message!);
  //         // CommonWidget().showToaster(msg: data["success"].toString());
  //         // await Get.to(Dashboard());
  //         CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //
  //         // for (var i = 0; i < m_screenWeeklyDataModel!.data!.length; i++) {
  //         //   // x_axis = data_sales[i]["month"];
  //         //   var y1 = double.parse(
  //         //       m_screenWeeklyDataModel!.data![0].methods![i].totalTime!);
  //         //   // var y2 = data_gst_receivable[i]['value'];
  //         //   // var y3 =
  //         //   gst_payable_list.add(ChartData(
  //         //     x_axis[i],
  //         //     y1,
  //         //     y1,
  //         //     y1,
  //         //   ));
  //         // }
  //
  //         return m_screenWeeklyDataModel;
  //       } else {
  //         hideLoader(context);
  //
  //         CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //         return null;
  //       }
  //     } else if (response.statusCode == 422) {
  //       hideLoader(context);
  //       CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //     } else if (response.statusCode == 401) {
  //       hideLoader(context);
  //       CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //     } else {
  //       // CommonWidget().showToaster(msg: msg.toString());
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     // TODO
  //   }
  // }

  String selected_time = 'days';

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  final Ledger_Setup_controller _swipe_setup_controller = Get.put(
      Ledger_Setup_controller(),
      tag: Ledger_Setup_controller().toString());

  startWatch() {
    setState(() {
      timer_started = true;
      _swipe_setup_controller.m_running = true;
      startStop = false;
      paused = false;
      started = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  startWatch2() {
    setState(() {
      watch2.start();
      timer2 = Timer.periodic(Duration(milliseconds: 100), updateTime2);
    });
  }

  bool paused = false;

  stopWatch() {
    setState(() {
      startStop = true;
      started = false;
      paused = true;
      watch.stop();
      setTime();
    });
  }

  stopWatch_finish() {
    setState(() {
      _swipe_setup_controller.m_running = false;
      startStop = true;
      started = true;
      paused = false;
      _animationController!.stop();
      animation_started = false;
      watch.stop();
      setTime_finish();
    });
  }

  List paused_time = [];

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
      paused_time.add(elapsedTime);
    });
    print("elapsedTime $elapsedTime");
    print("elapsedTime Listtttttt $paused_time");
  }

  setTime_finish() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
    // paused_time.add(elapsedTime);
    // print("elapsedTime $elapsedTime");
    // print("elapsedTime Listtttttt $paused_time");
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  M_ScreenWeeklyDataModel? m_screenWeeklyDataModel;
  M_ScreenLifeTimeDataModel? m_screenLifeTimeDataModel;
  M_ScreenDailyDataModel? m_screenDailyDataModel;
  WeeklyData? weeklyData;
  List testList = [];
  List testList2 = [];
  bool loader = true;
  List methoddd2 = [];
  List coloring2 = [];

  List<ChartSeries<Days_weekly, String>> mohit = [];

  GetMasturbationMethod? getMasturbationMethod;

  Future Masturbation_Get_Method() async {
    String idUser = await PreferenceManager().getPref(URLConstants.id);
    var url =
        "${URLConstants.base_url}${URLConstants.masturbation_get_method}?user_id=$idUser";

    try {
      // showLoader(context);
      var response = await http.get(Uri.parse(url));
      print(response.body);
      print(response.request);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var data = convert.jsonDecode(response.body);
        Map<String, dynamic> data =
        json.decode(response.body.replaceAll('}[]', '}'));
        print("Data :${data}");
        getMasturbationMethod = GetMasturbationMethod.fromJson(data);
        // getUSerModelList(userInfoModel_email);
        if (getMasturbationMethod!.error == false) {
          // hideLoader(context);
          debugPrint(
              '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${getMasturbationMethod!.data!.length}');
          if (_masturbation_screen_controller.method_list.isNotEmpty) {
            _masturbation_screen_controller.method_list.clear();
          }
          for (var i = 0; i < getMasturbationMethod!.data!.length; i++) {
            setState(() {
              _masturbation_screen_controller.method_list.add(methods_list(
                  method_name: getMasturbationMethod!.data![i].methodName,
                  method_id: getMasturbationMethod!.data![i].id,
                  color: getMasturbationMethod!.data![i].colorCode));
            });
          }

          return getMasturbationMethod;
        } else {
          // hideLoader(context);

          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          return null;
        }
      } else if (response.statusCode == 422) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: getMasturbationMethod!.message!);
      } else if (response.statusCode == 401) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: getMasturbationMethod!.message!);
      } else {
        // CommonWidget().showToaster(msg: msg.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }

  PostMasturbationMethod? postMasturbationMethod;

  Future Masturbation_Post_Method(
      {required String method_name, required String method_color}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // showLoader(context);
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    // username,phone,email,dob,gender,password,image
    Map data = {
      'user_id': id_user,
      'method_name': method_name,
      'color_code': method_color,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.masturbation_post_method);
    print("url : $url");
    print("body : $data");

    var response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    print(response.request);
    print(response.statusCode);
    // var final_data = jsonDecode(response.body);

    // print('final data $final_data');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      postMasturbationMethod = PostMasturbationMethod.fromJson(data);
      print(postMasturbationMethod);
      if (postMasturbationMethod!.error == false) {
        await Masturbation_Get_Method();
        CommonWidget().showToaster(msg: postMasturbationMethod!.message!);
        // hideLoader(context);
      } else {
        // hideLoader(context);
        CommonWidget().showErrorToaster(msg: postMasturbationMethod!.message!);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }

  Future MasturbationWeekly_Data_get_API() async {
    String idUser = await PreferenceManager().getPref(URLConstants.id);
    var url =
        "${URLConstants.base_url}${URLConstants.masturbation_get_weekly_data}?userId=$idUser";

    try {
      // showLoader(context);
      var response = await http.get(Uri.parse(url));
      print(response.body);
      print(response.request);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var data = convert.jsonDecode(response.body);
        Map<String, dynamic> data =
        json.decode(response.body.replaceAll('}[]', '}'));
        print("Data :${data}");
        setState(() {
          m_screenWeeklyDataModel = M_ScreenWeeklyDataModel.fromJson(data);
        });
        weeklyData = WeeklyData.fromJson(data);

        // getUSerModelList(userInfoModel_email);
        setState(() {
          loader = false;
        });
        print('m_screenWeeklyDataModel!.error');
        print(m_screenWeeklyDataModel!.error);

        if (m_screenWeeklyDataModel!.error == false) {
          // hideLoader(context);
          debugPrint(
              '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenWeeklyDataModel!.data!.length}');

          if (mohit.isNotEmpty) {
            mohit.clear();
          }
          if (m_screenWeeklyDataModel!.data!.isNotEmpty) {
            for (var i = 0; i < m_screenWeeklyDataModel!.data!.length; i++) {
              var y1 = m_screenWeeklyDataModel!.data![i].createdDate!;
              print(y1);
              String tempDate =
              DateFormat('EEEE').format(DateFormat("yyyy-MM-dd").parse(y1));
              print(tempDate);

              for (var k = 0;
              k < m_screenWeeklyDataModel!.data![i].days!.length;
              k++) {
                DateTime tempDate_ = new DateFormat("mm:ss")
                    .parse(weeklyData!.data![i].days![k].totalTime!);
                print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");
                var totalTime = (tempDate_.minute * 60) + tempDate_.second;
                var y = double.parse((totalTime / 60).toString());

                var datar = ColumnSeries(
                    dataSource: m_screenWeeklyDataModel!.data![i].days!,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                    pointColorMapper: (Days_weekly data, _) =>
                        HexColor(weeklyData!.data![i].days![k].colorCode!),
                    xValueMapper: (Days_weekly data, _) => DateFormat('EEEE')
                        .format(
                        DateFormat("yyyy-MM-dd").parse(data.createdDate!)),
                    width: 0.5,
                    spacing: 0.3,
                    yValueMapper: (Days_weekly data, _) => y);

                setState(() {
                  mohit.add(datar);
                });
                print("mohit ${mohit}");
                List new1 = [];
                List new2 = [];
                setState(() {
                  new1.add(weeklyData!.data![i].days![k].methodName!);
                  new2.add(weeklyData!.data![i].days![k].colorCode!);
                });

                setState(() {
                  methoddd2.add(weeklyData!.data![i].days![k].methodName!);
                  // methoddd2.add(weeklyData!.data![i].days![k].methodName!);
                  coloring2.add(weeklyData!.data![i].days![k].colorCode!);
                });
              }

              setState(() {
                methoddd2 = methoddd2.toSet().toList();
                // coloring2 = coloring2.toSet().toList();
              });
            }
          }

          // for (var i = 0; i <= weeklyData!.data!.length; i++) {
          //   var y1 = m_screenWeeklyDataModel!.data![i].createdDate!;
          //   print(y1);
          //   String tempDate =
          //       DateFormat('EEEE').format(DateFormat("yyyy-MM-dd").parse(y1));
          //   print(tempDate);
          //   // DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //   //                          .parse(element.createdDate!))
          //
          //   for (var j = 0; j < weeklyData!.data![i].days!.length; j++) {
          //     var test = weeklyData!.data![i].days![j].methodName!;
          //     testList.add(test);
          //     print('Testjj: $testList');
          //
          //     var test2 = weeklyData!.data![i].days![j].totalPauses!;
          //     testList2.add(test2);
          //     print('Test: $testList2');
          //
          //     DateTime tempDate_ = new DateFormat("mm:ss")
          //         .parse(weeklyData!.data![i].days![0].totalTime!);
          //     print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");
          //     var totalTime = (tempDate_.minute * 60) + tempDate_.second;
          //     var y = double.parse((totalTime / 60).toString());
          //
          //     setState(() {
          //       weekly_data5.add(ChartData2(
          //         DateFormat('EEEE').format(DateFormat("yyyy-MM-dd")
          //             .parse(weeklyData!.data![i].days![j].createdDate!)),
          //         weeklyData!.data![i].days![j].methodName!,
          //         y,
          //         m_screenWeeklyDataModel!.data![i].days![0].colorCode!
          //             .substring(2),
          //         double.parse(weeklyData!.data![i].days![j].totalPauses!),
          //       ));
          //     });
          //   }
          //   if (weeklyData!.data![i].days!.length > 1) {
          //     DateTime tempDate_ = new DateFormat("mm:ss")
          //         .parse(weeklyData!.data![i].days![1].totalTime!);
          //     print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");
          //
          //     var totalTime = (tempDate_.minute * 60) + tempDate_.second;
          //     var y = double.parse((totalTime / 60).toString());
          //
          //     setState(() {
          //       weekly_data2.add(ChartData0(
          //         tempDate,
          //         m_screenWeeklyDataModel!.data![i].days![1].methodName!,
          //         y,
          //         // double.parse(
          //         //     m_screenWeeklyDataModel!.data![i].days![1].totalPauses!),
          //         m_screenWeeklyDataModel!.data![i].days![0].colorCode!
          //             .substring(2),
          //       ));
          //     });
          //   }
          //   if (weeklyData!.data![i].days!.length > 2) {
          //     DateTime tempDate_ = new DateFormat("mm:ss")
          //         .parse(weeklyData!.data![i].days![2].totalTime!);
          //     print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");
          //
          //     var totalTime = (tempDate_.minute * 60) + tempDate_.second;
          //     var y = double.parse((totalTime / 60).toString());
          //
          //     setState(() {
          //       weekly_data3.add(ChartData0(
          //         tempDate,
          //         m_screenWeeklyDataModel!.data![i].days![2].methodName!,
          //         y,
          //         m_screenWeeklyDataModel!.data![i].days![0].colorCode!
          //             .substring(2),
          //       ));
          //     });
          //   }
          //   if (weeklyData!.data![i].days!.length > 3) {
          //     DateTime tempDate_ = new DateFormat("mm:ss")
          //         .parse(weeklyData!.data![i].days![3].totalTime!);
          //     print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");
          //
          //     var totalTime = (tempDate_.minute * 60) + tempDate_.second;
          //     var y = double.parse((totalTime / 60).toString());
          //
          //     setState(() {
          //       weekly_data4.add(ChartData0(
          //         tempDate,
          //         m_screenWeeklyDataModel!.data![i].days![3].methodName!,
          //         y,
          //         m_screenWeeklyDataModel!.data![i].days![0].colorCode!
          //             .substring(2),
          //       ));
          //     });
          //   }
          //   DateTime tempDate_ = new DateFormat("mm:ss")
          //       .parse(weeklyData!.data![i].days![0].totalTime!);
          //   print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");
          //
          //   var totalTime = (tempDate_.minute * 60) + tempDate_.second;
          //   var y = double.parse((totalTime / 60).toString());
          //
          //   setState(() {
          //     weekly_data.add(ChartData0(
          //       tempDate,
          //       m_screenWeeklyDataModel!.data![i].days![0].methodName!,
          //       y,
          //       m_screenWeeklyDataModel!.data![i].days![0].colorCode!
          //           .substring(2),
          //     ));
          //   });
          // }
          // setState(() {
          //   methoddd2 = methoddd2.toSet().toList();
          //   coloring2 = coloring2.toSet().toList();
          // });
          print("methoddd2 ${methoddd2}");
          // print("coloring2 ${coloring2}");
          // print("weekly_data[i] ${weekly_data[0].x}");
          // print("weekly_data[i] ${weekly_data[0].y}");
          // print("weekly_data[i] ${weekly_data[0].x1}");
          // print("weekly_data[i] ${weekly_data[1].x}");
          // print("weekly_data[i] ${weekly_data[1].y}");
          // print("weekly_data[i] ${weekly_data[1].x1}");
          // print("weekly_data[i] ${weekly_data[2].x}");
          // print("weekly_data[i] ${weekly_data[2].y}");
          // print("weekly_data[i] ${weekly_data[2].x1}");
          // CommonWidget().showToaster(msg: breathingGetModel!.message!);
          // CommonWidget().showToaster(msg: data["success"].toString());
          // await Get.to(Dashboard());
          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);

          //        for (var i = 0;
          //        i < m_screenWeeklyDataModel!.data!.length;
          //        i++) {
          //          // x_axis = data_sales[i]["month"];
          //          var y1 = m_screenWeeklyDataModel!.data![i].createdDate!;
          //          DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(y1);
          //          var date_day = DateFormat('EEEE').format(tempDate);
          //          // print(DateFormat('EEEE').format(tempDate)); // prints Tuesday
          //          var data_n1 = m_screenWeeklyDataModel!.data!.firstWhere(
          //              (element) =>
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(element.createdDate!)) ==
          //                  'Sunday');
          //          var data_n2 = m_screenWeeklyDataModel!.data!.firstWhere(
          //              (element) =>
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(element.createdDate!)) ==
          //                  'Monday');
          //          var data_n3 = m_screenWeeklyDataModel!.data!.firstWhere(
          //              (element) =>
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(element.createdDate!)) ==
          //                  'Tuesday');
          // var data_n4 = m_screenWeeklyDataModel!.data!.firstWhere(
          //              (element) =>
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(element.createdDate!)) ==
          //                  'Wednesday');
          // var data_n5 = m_screenWeeklyDataModel!.data!.firstWhere(
          //              (element) =>
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(element.createdDate!)) ==
          //                  'Thursday');
          // var data_n6 = m_screenWeeklyDataModel!.data!.firstWhere(
          //              (element) =>
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(element.createdDate!)) ==
          //                  'Friday');
          // var data_n7 = m_screenWeeklyDataModel!.data!.firstWhere(
          //              (element) =>
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(element.createdDate!)) ==
          //                  'Saturday');
          //
          //          // print('i did it');
          //          print(data_n1.days![0].methodName);
          //          // print(data_n2.days![0].methodName);
          //          // print(data_n3.days![0].methodName);
          //          // print(data_n.id);
          //
          //          // var y2 = data_gst_receivable[i]['value'];
          //          // var y3 =
          //
          //            setState(() {
          //              weekly_data.add(ChartData2(
          //                DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                    .parse(data_n1.createdDate!)),
          //                data_n1.days![0].methodName!,
          //                double.parse(data_n1.days![0].totalPauses!),
          //                Colors.white,
          //              ));
          //            });
          //            setState(() {
          //              weekly_data.add(ChartData2(
          //                DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                    .parse(data_n2.createdDate!)),
          //                data_n2.days![0].methodName!,
          //                double.parse(data_n2.days![0].totalPauses!),
          //                Colors.white,
          //              ));
          //            });
          //            setState(() {
          //              weekly_data.add(ChartData2(
          //                DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                    .parse(data_n3.createdDate!)),
          //                data_n3.days![0].methodName!,
          //                double.parse(data_n3.days![0].totalPauses!),
          //                Colors.white,
          //              ));
          //            });setState(() {
          //              weekly_data.add(ChartData2(
          //                DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                    .parse(data_n4.createdDate!)),
          //                data_n4.days![0].methodName!,
          //                double.parse(data_n4.days![0].totalPauses!),
          //                Colors.white,
          //              ));
          //            });setState(() {
          //              weekly_data.add(ChartData2(
          //                DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                    .parse(data_n5.createdDate!)),
          //                data_n5.days![0].methodName!,
          //                double.parse(data_n5.days![0].totalPauses!),
          //                Colors.white,
          //              ));
          //            });setState(() {
          //              weekly_data.add(ChartData2(
          //                DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                    .parse(data_n6.createdDate!)),
          //                data_n6.days![0].methodName!,
          //                double.parse(data_n6.days![0].totalPauses!),
          //                Colors.white,
          //              ));
          //            });setState(() {
          //              weekly_data.add(ChartData2(
          //                  DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                      .parse(data_n7.createdDate!)),
          //                data_n7.days![0].methodName!,
          //                double.parse(data_n7.days![0].totalPauses!),
          //                Colors.white,
          //              ));
          //            });
          //
          //            print("weekly data : ${weekly_data}");
          //
          //          setState(() {
          //            weekly_data_list.add(ChartData2(
          //                DateFormat('EEEE').format(DateFormat("yyyy-MM-dd hh:mm:ss")
          //                    .parse(m_screenWeeklyDataModel!.data![0].createdDate!)),
          //              m_screenWeeklyDataModel!.data![0].days![0].methodName!,
          //              double.parse(m_screenWeeklyDataModel!.data![0].days![0].totalPauses!),
          //              Colors.white,
          //            ));
          //          });

          // print(weekly_data_listS[i].y);
          // }
          print("gst_payable_list");

          return m_screenWeeklyDataModel;
        } else {
          // hideLoader(context);

          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          return null;
        }
      } else if (response.statusCode == 422) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else if (response.statusCode == 401) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else {
        // CommonWidget().showToaster(msg: msg.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }

  Future Masturbation_LifeTime_Data_get_API() async {
    String idUser = await PreferenceManager().getPref(URLConstants.id);
    var url =
        "${URLConstants.base_url}${URLConstants.masturbation_get_lifetime_data}?userId=$idUser";

    try {
      // showLoader(context);
      var response = await http.get(Uri.parse(url));
      print(response.body);
      print(response.request);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var data = convert.jsonDecode(response.body);
        Map<String, dynamic> data =
        json.decode(response.body.replaceAll('}[]', '}'));
        print("Data :${data}");
        m_screenLifeTimeDataModel = M_ScreenLifeTimeDataModel.fromJson(data);
        // getUSerModelList(userInfoModel_email);
        if (m_screenLifeTimeDataModel!.error == false) {
          // hideLoader(context);
          debugPrint(
              '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenLifeTimeDataModel!.data!.length}');
          // CommonWidget().showToaster(msg: breathingGetModel!.message!);
          // CommonWidget().showToaster(msg: data["success"].toString());
          // await Get.to(Dashboard());
          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          List var_ = [];

          if (lifetime_data_list.isNotEmpty) {
            lifetime_data_list.clear();
          }

          for (var i = 0;
          i < m_screenLifeTimeDataModel!.data![0].methods!.length;
          i++) {
            // x_axis = data_sales[i]["month"];
            var x =
            m_screenLifeTimeDataModel!.data![0].methods![i].createdDate!;
            var x1 = m_screenLifeTimeDataModel!.data![0].methods![i].methodName;

            // var y = double.parse(
            //     m_screenLifeTimeDataModel!.data![0].methods![i].totalPauses!);
            // var inputFormat = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("14:15:00"));
            DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(x);

            String formattedTime = DateFormat.jm().format(tempDate);
            // print(formattedTime);//5:08 PM
            // var y2 = data_gst_receivable[i]['value'];
            // var y3 =
            DateTime tempDate_ = new DateFormat("mm:ss").parse(
                m_screenLifeTimeDataModel!.data![0].methods![i].totalTime!);
            print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");

            var totalTime = (tempDate_.minute * 60) + tempDate_.second;
            print("TOTAL TIMEEE : ${totalTime / 60}");
            var y = double.parse((totalTime / 60).toString());

            setState(() {
              lifetime_data_list.add(ChartData2(
                  formattedTime,
                  x1!,
                  y,
                  '#75C043',
                  double.parse(m_screenLifeTimeDataModel!
                      .data![0].methods![i].pauses!)));
            });
            // print(lifetime_data_list[i].x1);
          }
          print("gst_payable_list");

          return m_screenWeeklyDataModel;
        } else {
          // hideLoader(context);

          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          return null;
        }
      } else if (response.statusCode == 422) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else if (response.statusCode == 401) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else {
        // CommonWidget().showToaster(msg: msg.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }

  bool loading = true;
  List temp = [];
  List methoddd = [];

  List coloring = [];

  Future Masturbation_Daily_Data_get_API() async {
    String idUser = await PreferenceManager().getPref(URLConstants.id);
    var url =
        "${URLConstants.base_url}${URLConstants.masturbation_get_daily_data}?userId=$idUser&createdDate=$selected_date";

    try {
      // showLoader(context);
      var response = await http.get(Uri.parse(url));
      print(response.body);
      print(response.request);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var data = convert.jsonDecode(response.body);
        Map<String, dynamic> data =
        json.decode(response.body.replaceAll('}[]', '}'));
        print("Data :${data}");
        m_screenDailyDataModel = M_ScreenDailyDataModel.fromJson(data);
        // getUSerModelList(userInfoModel_email);

        setState(() {
          loading = false;
        });
        if (m_screenDailyDataModel!.error == false) {
          // hideLoader(context);
          debugPrint(
              '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenDailyDataModel!.data!.length}');
          // CommonWidget().showToaster(msg: breathingGetModel!.message!);
          // CommonWidget().showToaster(msg: data["success"].toString());
          // await Get.to(Dashboard());
          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);

          if (daily_data_list.isNotEmpty) {
            daily_data_list.clear();
          }
          for (var i = 0;
          i < m_screenDailyDataModel!.data![0].days!.length;
          i++) {
            // x_axis = data_sales[i]["month"];
            // print(
            //     "date : ${m_screenDailyDataModel!.data![0].days![i].totalTime}");

            setState(() {
              methoddd
                  .add(m_screenDailyDataModel!.data![0].days![i].methodName!);
              coloring
                  .add(m_screenDailyDataModel!.data![0].days![i].colorCode!);
              methoddd = methoddd.toSet().toList();
              // coloring = coloring.toSet().toList();
            });

            print("methoddd ${methoddd}");
            print("coloring ${coloring}");

            DateTime tempDate_ = new DateFormat("mm:ss")
                .parse(m_screenDailyDataModel!.data![0].days![i].totalTime!);
            print("TIME : ${tempDate_.minute} : TIME ${tempDate_.second}");

            var totalTime = (tempDate_.minute * 60) + tempDate_.second;
            print("TOTAL TIMEEE : ${totalTime / 60}");

            // if (m_screenDailyDataModel!
            //     .data![0].days![i].pausesTime!.isNotEmpty) {
            //   for (var j = 0;
            //       j <
            //           m_screenDailyDataModel!
            //               .data![0].days![i].pausesTime!.length;
            //       j++) {
            //     DateTime tempD = new DateFormat("mm:ss").parse(
            //         m_screenDailyDataModel!.data![0].days![i].pausesTime![j]);
            //     print("TIME : ${tempD.minute} : TIME ${tempD.second}");
            //
            //     var totaL = (tempD.minute * 60) + tempD.second;
            //     print("TOTAL TIMWWWWWW : ${totaL}");
            //     List mohit = [];
            //     mohit.add(totaL);
            //     print("totaL : $totaL");
            //   }
            // }
            var x = m_screenDailyDataModel!.data![0].days![i].createdDate!;
            var x1 = m_screenDailyDataModel!.data![0].days![i].methodName;
            var y = double.parse((totalTime / 60).toString());
            // var inputFormat = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("14:15:00"));
            DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(x);

            String formattedTime = DateFormat.jm().format(tempDate);
            // print(formattedTime);//5:08 PM
            temp.add(m_screenDailyDataModel!.data![0].days![i].methodName);
            var color = (x1 == 'Hand'
                ? Colors.red
                : (x1 == 'Dildo'
                ? Colors.blue
                : (x1 == 'Sex'
                ? Colors.green
                : (x1 == 'Fleshlight'
                ? Colors.purple
                : list[random.nextInt(list.length)]))));
            print("Color $color");
            // var y2 = data_gst_receivable[i]['value'];
            // var y3 =
            // method_time.clear()
            for (var j = 0;
            j <
                m_screenDailyDataModel!
                    .data![0].days![i].pausesTime!.length;
            j++) {
              setState(() {
                double day = (m_screenDailyDataModel!
                    .data![0].days![i].pausesTime![j].isNotEmpty
                    ? double.parse(m_screenDailyDataModel!
                    .data![0].days![i].pausesTime![j])
                    : 0);
                daily_data_list.add(ChartData2(
                  formattedTime,
                  x1!,
                  y,
                  m_screenDailyDataModel!.data![0].days![i].colorCode!,
                  day / 60,
                ));
              });
            }
            setState(() {
              print(daily_data_list);
              method_time.add(ListMethodClass(
                method_name:
                m_screenDailyDataModel!.data![0].days![i].methodName!,
                pauses: m_screenDailyDataModel!.data![0].days![i].totalPauses!,
                pause_time:
                m_screenDailyDataModel!.data![0].days![i].pausesTime,
                total_time:
                m_screenDailyDataModel!.data![0].days![i].totalTime!,
                color: m_screenDailyDataModel!.data![0].days![i].colorCode!,
                id: m_screenDailyDataModel!.data![0].days![i].id!,
              ));
            });
            print("daily_data_list.toSet().toList().length"); // => ['a', 'b']
            setState(() {
              daily_data_list = daily_data_list.toSet().toList();
            });
            print(daily_data_list.toSet().toList().length); // => ['a', 'b']
            // print("${daily_data_list[i].x} :${daily_data_list[i].x1} :${daily_data_list[i].y}");
          }

          // print("methoddd ${methoddd}");
          // print("coloring ${coloring}");
          print("gst_payable_list");
          print("gst_payable_list");
          print(temp);

          // var unique = List.from(_masturbation_screen_controller.method_list)..addAll(temp);
          setState(() {
            // _masturbation_screen_controller.method_list = <methods_list>{..._masturbation_screen_controller.method_list, ...temp}.toList();
          });

          print("unique");
          print("unique");
          print(_masturbation_screen_controller.method_list);
          return m_screenWeeklyDataModel;
        } else {
          // hideLoader(context);
          // CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          return null;
        }
      } else if (response.statusCode == 422) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else if (response.statusCode == 401) {
        // hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else {
        // CommonWidget().showToaster(msg: msg.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }

  bool isinfoLoading = true;
  GetTechniqueModel? MasturbationTechniqueModel;

  Future<dynamic> masturbation_technique_API({required BuildContext context,required String method}) async {
    setState(() {
      isinfoLoading= true;
    });
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url =
    // "${URLConstants.base_url}${URLConstants.kegel_technique}";
        "${URLConstants.base_url}$method";
    // showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      MasturbationTechniqueModel = GetTechniqueModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (MasturbationTechniqueModel!.error == false) {
        // hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${MasturbationTechniqueModel!.data!}');
        setState(() {
          isinfoLoading = false;
        });

        return MasturbationTechniqueModel;
      } else {
        setState(() {
          isinfoLoading = false;
        });

        // hideLoader(context);

        // CommonWidget().showToaster(msg: kegelGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {
      // hideLoader(context);

      CommonWidget().showToaster(msg: MasturbationTechniqueModel!.message!);
    } else if (response.statusCode == 401) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: MasturbationTechniqueModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }
  }

}
