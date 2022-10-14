import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SignUp/model/signUpmodel.dart';
import 'package:klench_/utils/Common_buttons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/Asset_utils.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/colorUtils.dart';
import 'qr_scan_screen.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  PageController? controller;
  int _curr = 0;
  GlobalKey globalKey = new GlobalKey();

  List img_icons = [
    AssetUtils.wp_icons,
    AssetUtils.twitter_icons,
    AssetUtils.telegram_icons,
    AssetUtils.line_icons,
    AssetUtils.facebook_icons,
    AssetUtils.snapchat_icons,
    AssetUtils.instagram_icons,
    AssetUtils.Foursquare_icons,
  ];
  List img_icons_text = [
    'WhatsApp',
    "Twitter",
    "Telegran",
    "Line",
    "Facebook",
    "Snapchat",
    "Instagram",
    "Foursquare",
  ];

  @override
  void initState() {
    init();
    controller = PageController(initialPage: 0, keepPage: false);
    super.initState();
  }

  String? Username;
  init() async {
    String id_user = await PreferenceManager().getPref(URLConstants.username);
    setState((){
      Username = id_user;
      print(Username);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
          "My QR",
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.primary_grey, family: 'PM'),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // selectTowerBottomSheet(context);
              _captureAndSharePng(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 33),
              child: Image.asset(
                AssetUtils.share_icon,
                height: 22,
                width: 19,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
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
            borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(top: 0, right: 8, left: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
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
                    borderRadius: BorderRadius.circular(10)),
                margin:
                    EdgeInsets.only(bottom: 40, top: 40, right: 33, left: 33),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   AssetUtils.qrcode_big_icons,
                      //   color: Colors.white,
                      // ),
                      RepaintBoundary(
                        key: globalKey,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: QrImage(
                            data:(Username == null ? "Username" :  Username!),
                            // size: 200,
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '$Username',
                        style: FontStyleUtility.h14(
                            fontColor: ColorUtils.primary_grey, family: 'PM'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                Get.to(QrScanScreen());
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Scan QR',
                    style: FontStyleUtility.h14(
                        fontColor: ColorUtils.primary_grey, family: 'PM'),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  File? file;

  Future<void> _captureAndSharePng(BuildContext context) async {
    // try {
    //   RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    //   var image = await boundary.toImage();
    //   ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    //   Uint8List pngBytes = byteData!.buffer.asUint8List();
    //
    //   final tempDir = await getTemporaryDirectory();
    //   final file = await new File('${tempDir.path}/image.png').create();
    //   await file.writeAsBytes(pngBytes);
    //
    //   final channel = const MethodChannel('channel:me.alfian.share/share');
    //   channel.invokeMethod('shareFile', 'image.png');
    //
    // } catch(e) {
    //   print(e.toString());
    // }

    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//captures qr image
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
      final appDir = await getApplicationDocumentsDirectory();
//current time
      var datetime = DateTime.now();
//qr image file creation
      file = await File('${appDir.path}/$datetime.png').create();
//appending data
      await file?.writeAsBytes(pngBytes);
//Shares QR image
      await Share.shareFiles(
        [file!.path],
        mimeTypes: ["image/png"],
        text: "Share the QR Code",
      );
      print(file!.path);
      // final ByteData bytes = await rootBundle.load('assets/image1.png');
      // await Share.file(
      //     'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
      //     text: 'My optional text.');
    } catch (e) {
      print(e.toString());
    }
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
                height: screenheight * 0.5,
                width: screenwidth,
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(33.9),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 0),
                        child: Text('Select media',
                            style: FontStyleUtility.h16(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR')),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: screenheight / 5,
                        child: PageView(
                          children: [
                            Container(
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 20),
                                  itemCount: 8,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            img_icons[index],
                                            height: 40,
                                            width: 40,
                                          ),
                                          Text(
                                            img_icons_text[index],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontFamily: 'PR'),
                                          )
                                        ],
                                      ),
                                      // decoration: BoxDecoration(
                                      //     color: Colors.amber,
                                      //     borderRadius:
                                      //         BorderRadius.circular(15)),
                                    );
                                  }),
                            ),
                            Center(
                                child: Container(
                              child: Text(
                                'Second',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                            Center(
                                child: Container(
                              child: Text('Third',
                                  style: TextStyle(color: Colors.white)),
                            ))
                          ],
                          scrollDirection: Axis.horizontal,

                          // reverse: true,
                          // physics: BouncingScrollPhysics(),
                          controller: controller,
                          onPageChanged: (num) {
                            setState(() {
                              _curr = num;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: common_button_gold(title_text: 'Share'))
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
