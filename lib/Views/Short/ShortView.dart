import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/ShortComponent/shortAction.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:video_player/video_player.dart';

class ShortView extends StatefulWidget {
  @override
  _ShortViewState createState() => _ShortViewState();
}

class _ShortViewState extends State<ShortView> {
  dispose() {
    super.dispose();
    print('dispose');
    Get.find<ShortController>().controller!.pause();
  }

  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return WillPopScope(
          onWillPop: () async {
            _ShortController.controller!.play();

            return true;
          },
          child: Scaffold(
              backgroundColor: ColorsApp.black,
              body: Stack(
                children: [
                  Container(
                      height: Get.height,
                      width: Get.width,
                      child: _ShortController.isLoadedP == 0
                          ? Container(
                              child: SpinKitRing(
                                lineWidth: 4,
                                color: ColorsApp.skyBlue,
                                size: 45,
                              ),
                            )
                          : _ShortController.listShort.length == 0
                              ? Container(
                                  height: kHeight,
                                  child: AppEmpty(title: 'Aucun Short'))
                              : ShortViewF()),
                  Positioned(
                      top: 30,
                      left: 0,
                      child: Container(
                          child: IconButtonF0(
                        color: Colors.black,
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          _ShortController.disposePLayer();
                          Get.back();
                        },
                      ))),
                  _ShortController.isLoadedP == 0
                      ? Container(
                          child: SpinKitRing(
                            lineWidth: 4,
                            color: ColorsApp.skyBlue,
                            size: 45,
                          ),
                        )
                      : Positioned(
                          top: kHeight / 1.7,
                          left: kWidth / 1.3,
                          child: Container(
                              child: InkWell(
                            child: ShortAction(
                              short: _ShortController
                                  .listShort[_ShortController.currentShort],
                            ),
                            onTap: () {
                              _ShortController.controller!.pause();

                              Get.toNamed(AppLinks.BOUTIQUE +
                                  '?note=${_ShortController.listShort[_ShortController.currentShort].boutique.note}&codeBoutique=${_ShortController.listShort[_ShortController.currentShort].boutique.codeBoutique}&note=${_ShortController.listShort[_ShortController.currentShort].boutique.note}&nomBoutique=${_ShortController.listShort[_ShortController.currentShort].boutique.titre}&description=${_ShortController.listShort[_ShortController.currentShort].boutique.description}&ville=${_ShortController.listShort[_ShortController.currentShort].boutique.localisation.ville}&image=${_ShortController.listShort[_ShortController.currentShort].boutique.images[_ShortController.listShort[_ShortController.currentShort].boutique.images.length - 1].src}');
                            },
                          ))),
                ],
              )));
    });
  }
}

class ShortViewF extends StatefulWidget {
  @override
  State<ShortViewF> createState() => _ShortViewFState();
}

class _ShortViewFState extends State<ShortViewF> {
  // PageController _pageController = PageController(initialPage: 0);

  late VideoPlayerController _videoPlayerController;

  int _currentIndex = 0;

  // List videoUrls = [
  ShortController short = Get.find();

  double position = 0.0;
  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: 0);
    //print('**********************short.listShort');
    Get.find<ShortController>().initialise
        ? Get.find<ShortController>().controller!.play()
        : Get.find<ShortController>().changeVideo(0);
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return Container(
          height: kHeight,
          child: PageView.builder(
            itemCount: _ShortController.listShort.length,
            scrollDirection: Axis.vertical,
            controller: _ShortController.pageController,
            onPageChanged: (index) {
              //print(index);
              //print(_ShortController.listShort[index].src);
              index = index % (_ShortController.listShort.length);

              // if (_ShortController.controller!.value.isInitialized) {
              //   _ShortController.controller!.dispose();
              // }
              _ShortController.changeVideo(index);
              // _initializeVideoPlayer(_ShortController.listShort[index].src);
              _ShortController.setCurrent(index);
            },
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      // if (_ShortController
                      //     .listShort[index].controller!.value.isPlaying) {
                      //   _ShortController.listShort[index].controller!.pause();
                      // } else {
                      //   _ShortController.listShort[index].controller!.play();
                      // }
                      if (_ShortController.controller!.value.isPlaying) {
                        _ShortController.controller!.pause();
                      } else {
                        _ShortController.controller!.play();
                      }
                    });
                  },
                  child: _ShortController.initialise
                      ? SingleChildScrollView(
                          child: Stack(children: [
                          AspectRatio(
                            aspectRatio:
                                /* _videoPlayerController.value.aspectRatio */ Get
                                        .width /
                                    Get.height,
                            child: VideoPlayer(_ShortController.controller!),
                          ),
                          Positioned(
                            top: kHeight * .5,
                            left: kWidth * .8,
                            child: Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  vertical: kMarginY * 2, horizontal: kMarginX),
                              width: 230,
                              child: Stack(
                                children: [
                                  CircularProgressIndicator(
                                    value: _ShortController.progressValue,
                                    strokeWidth: 5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorsApp.skyBlue),
                                  ),
                                  Positioned.fill(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        if (_ShortController
                                            .controller!.value.isPlaying) {
                                          _ShortController.controller!.pause();
                                        } else {
                                          _ShortController.controller!.play();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]))
                      : Container(
                          child: SpinKitRing(
                            lineWidth: 4,
                            color: ColorsApp.skyBlue,
                            size: 45,
                          ),
                        ),
                ),
              );
            },
          ));
    });
  }
}

class VideoPlayerProgressBar extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPlayerProgressBar({required this.controller});

  @override
  _VideoPlayerProgressBarState createState() => _VideoPlayerProgressBarState();
}

class _VideoPlayerProgressBarState extends State<VideoPlayerProgressBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      Get.find<ShortController>().changeVideoSlide(
          widget.controller.value.position.inSeconds.toDouble() /
              widget.controller.value.duration.inSeconds.toDouble());

      // setState(() {
      //   _progressValue = widget.controller.value.position.inSeconds.toDouble() /
      //       widget.controller.value.duration.inSeconds.toDouble();
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0.0,
      max: 1.0,
      value: Get.find<ShortController>().progressValue,
      onChanged: (value) {
        // Get.find<ShortController>().changeVideoSlide(value);

        // setState(() {
        //   _progressValue = value;
        // });
        final duration = widget.controller.value.duration.inSeconds.toDouble();
        final newPosition = value * duration;
        widget.controller.seekTo(Duration(seconds: newPosition.toInt()));
      },
    );
  }
}




/**
 * 
class ShortViewF extends StatefulWidget {
  // final List<String> videoUrls;
  final bool autoPlay;
  final bool loop;

  ShortViewF({
    // @required this.videoUrls,
    this.autoPlay = true,
    this.loop = false,
  });

  @override
  _ShortViewFState createState() => _ShortViewFState();
}

class _ShortViewFState extends State<ShortViewF> {
  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  int _currentIndex = 0;
  // List videoUrls = [
  //   'https://www.youtube.com/watch?v=_voM01HKp4E',
  //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
  // ];
  ShortController short = Get.find();
  List<VideoPlayerController> _ListController = [];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    //print('**********************short.listShort');
    // //print(short.listShort);
    _initializeVideoPlayer(short.listShort[0].src);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer(String url) async {
    //print(url);
    // if (_videoPlayerController != null) {
    //   if (_videoPlayerController.value.isPlaying) {
    //     //print('********');
    //     _videoPlayerController.dispose();
    //   }
    // }
    _videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        if (widget.autoPlay) {
          // _videoPlayerController.pause();
          _videoPlayerController.play();
        }
        setState(() {});
      });
    // _videoPlayerController.setLooping(widget.loop);
    // //print(_videoPlayerController.value.aspectRatio);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return Container(
          height: 200.0,
          child: PageView.builder(
            itemCount: _ShortController.listShort.length,
            scrollDirection: Axis.vertical,
            controller: _pageController,
            onPageChanged: (index) {
              //print(index);
              //print(_ShortController.listShort[index].src);

              // _videoPlayerController.pause();
              // _videoPlayerController.seekTo(Duration.zero);

              _initializeVideoPlayer(_ShortController.listShort[index].src);
              _ShortController.setCurrent(index);
            },
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_videoPlayerController.value.isPlaying) {
                        _videoPlayerController.pause();
                      } else {
                        _videoPlayerController.play();
                      }
                    });
                  },
                  child: _videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio:
                              /* _videoPlayerController.value.aspectRatio */ Get
                                      .width /
                                  Get.height,
                          child: VideoPlayer(_videoPlayerController),
                        )
                      : Container(
                          child: SpinKitCircle(
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                ),
              );
            },
          ));
    });
  }
}

 */

