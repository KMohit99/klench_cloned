import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/setting_page/video_viewer.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

import '../../front_page/FrontpageScreen.dart';
import '../homepage/controller/kegel_excercise_controller.dart';
import '../utils/TextStyle_utils.dart';

class Intro_videoScreen extends StatefulWidget {
  const Intro_videoScreen({Key? key}) : super(key: key);

  @override
  State<Intro_videoScreen> createState() => _Intro_videoScreenState();
}

class _Intro_videoScreenState extends State<Intro_videoScreen> {
  final Kegel_controller _kegel_controller =
      Get.put(Kegel_controller(), tag: Kegel_controller().toString());

  List<File> imgFile_list = [];
  bool loading = true;

  thumbnail() async {
    for (var i = 0; i < _kegel_controller.introVideoModel!.data!.length; i++) {
      final fileName = await VideoThumbnail.thumbnailFile(
        video:
            "http://foxyserver.com/klench/video/${_kegel_controller.introVideoModel!.data![i].uploadVideo}",
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 64,
        // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 75,
      );
      imgFile_list.add(File(fileName!));
      print(fileName);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    thumbnail();
    super.initState();
  }

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
                  itemCount: _kegel_controller.introVideoModel!.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          child: Text(
                            _kegel_controller
                                .introVideoModel!.data![index].title!,
                            style: FontStyleUtility.h12(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PM'),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(VideoViewer(
                              url: _kegel_controller
                                  .introVideoModel!.data![index].uploadVideo!,
                            ));
                          },
                          child: Container(
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
                                          child: (loading
                                              ? Image.asset(
                                                  'assets/images/App Icon.png',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  imgFile_list[index],
                                                  fit: BoxFit.cover,
                                                )),
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
                                            onPressed: () {
                                              Get.to(VideoViewer(
                                                url: _kegel_controller
                                                    .introVideoModel!.data![index].uploadVideo!,
                                              ));
                                            },
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
                        SizedBox(
                          height: 18,
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
