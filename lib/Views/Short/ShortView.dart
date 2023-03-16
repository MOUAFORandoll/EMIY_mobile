import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/ShortComponent/shortAction.dart';
import 'package:Fahkap/controller/ShortController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
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
  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return Scaffold(
          backgroundColor: ColorsApp.black,
          body: Stack(
            children: [
              Container(
                  height: Get.height,
                  width: Get.width,
                  child: _ShortController.isLoadedP == 0
                      ? Container(
                          child: SpinKitCircle(
                            color: Colors.blue,
                            size: 40,
                          ),
                        )
                      : _ShortController.listShort.length == 0
                          ? Container(
                              child: Text('Aucun Short'),
                            )
                          : ShortViewF()),
              Positioned(
                  top: 30,
                  left: 0,
                  child: Container(
                      child: IconButtonF0(
                    color: Colors.black,
                    icon: Icons.arrow_back_ios_new,
                    onTap: () {
                      Get.find<ShortController>().disposePLayer();
                      Get.back();
                    },
                  ))),
              _ShortController.isLoadedP == 0
                  ? Container(
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 40,
                      ),
                    )
                  : Positioned(
                      top: 300,
                      left: 290,
                      child: Container(
                          child: ShortAction(
                        short: _ShortController
                            .listShort[_ShortController.currentShort],
                      ))),
            ],
          ));
    });
  }
}

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
  double position = 0.0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    print('**********************short.listShort');
    Get.find<ShortController>().changeVideo(0);
    // if (mounted) {
    //
    //   // print(short.listShort);
    //   Get.find<ShortController>().controller!.addListener(() {
    //     print('0000');
    //     setState(() {
    //       position = Get.find<ShortController>()
    //               .controller!
    //               .value
    //               .position
    //               .inSeconds
    //               .toDouble() /
    //           Get.find<ShortController>()
    //               .controller!
    //               .value
    //               .duration
    //               .inSeconds
    //               .toDouble();
    //     });
    //     print(
    //       'poition******${position}',
    //     );
    //     if (position == 1) {
    //       Get.find<ShortController>()
    //           .changeVideo(Get.find<ShortController>().currentShort + 1);
    //       print(
    //         'ici***************',
    //       );
    //     }
    //   });
    // }
  }

  @override
  void dispose() {
    _pageController.dispose();
    // if (Get.find<ShortController>().controller!.value.isInitialized) {
    // if (mounted) {
    //   Get.find<ShortController>().controller!.dispose();
    // }
    super.dispose();
  }

  void _initializeVideoPlayer(String url) async {
    print(url);
    // if (_videoPlayerController != null) {
    //   if (_videoPlayerController.value.isPlaying) {
    //     print('********');
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
    // print(_videoPlayerController.value.aspectRatio);
  }

  bool init = false;

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
              print(index);
              print(_ShortController.listShort[index].src);
              index = index % (_ShortController.listShort.length);
              // _videoPlayerController.pause();
              // _videoPlayerController.seekTo(Duration.zero);
              // _ShortController.controller!.dispose();
              if (_ShortController.controller!.value.isInitialized) {
                _ShortController.controller!.dispose();
              }
              _ShortController.changeVideo(index);
              // _initializeVideoPlayer(_ShortController.listShort[index].src);
              _ShortController.setCurrent(index);
            },
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   if (_ShortController
                    //       .listShort[index].controller!.value.isPlaying) {
                    //     _ShortController.listShort[index].controller!.pause();
                    //   } else {
                    //     _ShortController.listShort[index].controller!.play();
                    //   }
                    // });
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
                            // bottom: 0.0,
                            // left: Get.size.width / 2.2,
                            // top: 500.0,
                            top: 250,
                            left: 297,
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
                          // Positioned(
                          //     bottom: 0.0,
                          //     left: 0.0,
                          //     right: 0.0,
                          //     child: Padding(
                          //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                          //       child: Slider(
                          //         min: 0.0,
                          //         max: 1.0,
                          //         value:
                          //             _ShortController.progressValue.toDouble(),
                          //         onChanged: (double value) {
                          //           _ShortController.changeVideoSlide(value);
                          //         },
                          //         activeColor: Colors.white,
                          //         inactiveColor: Colors.grey[700],
                          //       ),
                          //     )),
                        ]))
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
    print('**********************short.listShort');
    // print(short.listShort);
    _initializeVideoPlayer(short.listShort[0].src);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer(String url) async {
    print(url);
    // if (_videoPlayerController != null) {
    //   if (_videoPlayerController.value.isPlaying) {
    //     print('********');
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
    // print(_videoPlayerController.value.aspectRatio);
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
              print(index);
              print(_ShortController.listShort[index].src);

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

