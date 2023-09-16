import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';

class ReaderForYouVideoPlayer extends StatefulWidget {
  final ShortModel short;
  ReaderForYouVideoPlayer({required this.short});

  @override
  State<ReaderForYouVideoPlayer> createState() =>
      _ReaderForYouVideoPlayerState();
}

class _ReaderForYouVideoPlayerState extends State<ReaderForYouVideoPlayer>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        ApiUrl.stream_serveurUrl + "/short?video=" + widget.short.src))
      ..initialize().then((_) {
        setState(() {
          Get.find<ShortController>().setControllerForYou(_controller);

          Get.find<ShortController>().controllerForYou.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(
      builder: (_ShortController) => _ShortController.controllerForYou !=
                  null &&
              _ShortController.controllerForYou.value.isInitialized
          ? Center(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_ShortController.controllerForYou.value.isPlaying) {
                        _ShortController.controllerForYou.pause();
                      } else {
                        _ShortController.controllerForYou.play();
                      }
                    });
                  },
                  // onDoubleTapDown: _handleDoubleTap,
                  onDoubleTap: () {
                    _ShortController.newLikeShort();
                  },
                  child: AspectRatio(
                    aspectRatio: 9.7 / 17.7,
                    child: VideoPlayer(_ShortController.controllerForYou),
                  )))
          : AspectRatio(
              aspectRatio: 9.7 / 17.7,
              child: Image.network(
                _ShortController
                    .listForYouShort[_ShortController.indexForYou].preview,

                fit: BoxFit
                    .cover, // Spécifie comment l'image doit s'adapter au conteneur
              )),
    );
  }
}
