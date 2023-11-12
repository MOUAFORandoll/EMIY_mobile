import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';

class ReadSuivisVideoPlayer extends StatefulWidget {
  final ShortModel short;
  ReadSuivisVideoPlayer({required this.short});

  @override
  State<ReadSuivisVideoPlayer> createState() => _ReadSuivisVideoPlayerState();
}

class _ReadSuivisVideoPlayerState extends State<ReadSuivisVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        ApiUrl.stream_serveurUrl + "/short?video=" + widget.short.src))
      ..initialize().then((_) {
        setState(() {
          Get.find<ShortController>().setControllerSuivis(_controller);

          Get.find<ShortController>().controllerSuivis.play();
        });
      });
  }

  @override
  void dispose() {
    // _controller.dispose();

    super.dispose();
    print('dispose');

    // if (short
    //     .currentReadShortData
    //     .controller
    //     .value
    //     .isPlaying) {
    //   short.currentReadShortData.controller.pause();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(
      builder: (_ShortController) => _ShortController.controllerSuivis !=
                  null &&
              _ShortController.controllerSuivis.value.isInitialized &&
              _ShortController.controllerSuivis.value != null
          ? /*  Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 100,
                      width: 50,
                    ), */
          Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_ShortController.controllerSuivis.value.isPlaying) {
                        _ShortController.controllerSuivis.pause();
                      } else {
                        _ShortController.controllerSuivis.play();
                      }
                    });
                  },
                  // onDoubleTapDown: _handleDoubleTap,
                  onDoubleTap: () {
                    _ShortController.newLikeShort();
                  },
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: _ShortController.comment
                          ? 0.33 * MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width,
                      height: _ShortController.comment
                          ? 0.33 * MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height,
                      child: AspectRatio(
                        aspectRatio: 9.7 / 17.7,
                        child: VideoPlayer(_ShortController.controllerSuivis),
                      ))))
          : AspectRatio(
              aspectRatio: 9.7 / 17.7,
              child: Image.network(
                _ShortController
                    .listSuivisShort[_ShortController.indexSuivis].preview,
                fit: BoxFit
                    .cover, // Spécifie comment l'image doit s'adapter au conteneur
              )),
    );
    // GetBuilder<ShortController>(
    //   builder: (_ShortController) => _ShortController.controllerSuivis != null
    //       ? _ShortController.controllerSuivis.value.isInitialized
    //           ? Center(
    //               child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       if (_ShortController
    //                           .controllerSuivis.value.isPlaying) {
    //                         _ShortController.controllerSuivis.pause();
    //                       } else {
    //                         _ShortController.controllerSuivis.play();
    //                       }
    //                     });
    //                   },
    //                   // onDoubleTapDown: _handleDoubleTap,
    //                   onDoubleTap: () {
    //                     _ShortController.newLikeShort();
    //                   },
    //                   child: AspectRatio(
    //                     aspectRatio: 9.7 / 17.7,
    //                     child: VideoPlayer(_ShortController.controllerSuivis),
    //                   )))
    //           : AspectRatio(
    //               aspectRatio: 9.7 / 17.7,
    //               child: Image.network(
    //                 _ShortController
    //                     .listSuivisShort[_ShortController.indexSuivis].preview,

    //                 fit: BoxFit
    //                     .cover, // Spécifie comment l'image doit s'adapter au conteneur
    //               ))
    //       : AspectRatio(
    //           aspectRatio: 9.7 / 17.7,
    //           child: Image.network(
    //             _ShortController
    //                 .listSuivisShort[_ShortController.indexSuivis].preview,

    //             fit: BoxFit
    //                 .cover, // Spécifie comment l'image doit s'adapter au conteneur
    //           )),
    // );
  }
}
