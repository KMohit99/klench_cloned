import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klench_/utils/colorUtils.dart';
import 'package:video_player/video_player.dart';
// import 'package:vimeo_video_player/vimeo_video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoViewer extends StatefulWidget {
  final String url;

  const VideoViewer({Key? key, required this.url}) : super(key: key);

  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  VideoPlayerController? _controller;
  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();
    print("URL : http://foxyserver.com/klench/video/${widget.url}");
    // _controller = VideoPlayerController.network(
    //     'http://foxyserver.com/klench/video/${widget.url}')
    //   ..initialize().then((_) {
    //     _controller!.play();
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network("url"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      // extendBodyBehindAppBar: true,
      body:  FlickVideoPlayer(
          flickManager: flickManager!
      ),
      // VimeoVideoPlayer(
      //   vimeoPlayerModel: VimeoPlayerModel(
      //     url: 'https://vimeo.com/70591644',
      //     systemUiOverlay: const [
      //       SystemUiOverlay.top,
      //       SystemUiOverlay.bottom,
      //     ],
      //   ),
      // )
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   onPressed: () {
      //     setState(() {
      //       _controller!.value.isPlaying
      //           ? _controller!.pause()
      //           : _controller!.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //     color: ColorUtils.primary_gold,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
