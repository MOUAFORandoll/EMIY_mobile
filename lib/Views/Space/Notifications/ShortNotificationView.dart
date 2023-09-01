//

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

class ShortNotificationView extends StatefulWidget {
  var idShort;
  var codeShort;
  ShortNotificationView({this.idShort, this.codeShort = 0});

  @override
  _ShortNotificationViewState createState() => _ShortNotificationViewState();
}

class _ShortNotificationViewState extends State<ShortNotificationView>
    with TickerProviderStateMixin {
  dispose() {
    super.dispose();
    print('dispose');
    _heartAnimationController.dispose();

    Get.find<ShortController>().disposeUniquePLayer();
  }

  @override
  void initState() {
    super.initState();
    Get.find<ShortController>()
        .getUniqueShort(widget.idShort, widget.codeShort);
    _heartAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _heartAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
          parent: _heartAnimationController, curve: Curves.easeInOut),
    );

    _heartAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.reverse();
      }
    });
  }

  double position = 0.0;
  bool _showHeart = false;
  Offset _heartPosition = Offset.zero;

  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  void _handleDoubleTap(details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);

    setState(() {
      _showHeart = true;
      _heartPosition = localPosition;
    });

    _heartAnimationController.forward();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showHeart = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return WillPopScope(
          onWillPop: () async {
            Get.back();
            await _ShortController.disposeUniquePLayer();

            return true;
          },
          child: Scaffold(
              backgroundColor: ColorsApp.black,
              body: Stack(
                children: [
                  Container(
                      height: Get.height,
                      width: Get.width,
                      child: _ShortController.isUnique == 0
                          ? Container(
                              child: SpinKitRing(
                                lineWidth: 4,
                                color: ColorsApp.skyBlue,
                                size: 45,
                              ),
                            )
                          : Container(
                              height: kHeight,
                              child: Center(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // if (_ShortController
                                          //     .listShort[index].controller!.value.isPlaying) {
                                          //   _ShortController.listShort[index].controller!.pause();
                                          // } else {
                                          //   _ShortController.listShort[index].controller!.play();
                                          // }
                                          if (_ShortController
                                              .currentReadShortData
                                              .controller
                                              .value
                                              .isPlaying) {
                                            _ShortController
                                                .currentReadShortData.controller
                                                .pause();
                                          } else {
                                            _ShortController
                                                .currentReadShortData.controller
                                                .play();
                                          }
                                        });
                                      },
                                      onDoubleTapDown: _handleDoubleTap,
                                      onDoubleTap: () {
                                        _ShortController.newLikeShort();
                                      },
                                      child: SingleChildScrollView(
                                          child: Stack(children: [
                                        AspectRatio(
                                          aspectRatio:
                                              /* _videoPlayerController.value.aspectRatio */ Get
                                                      .width /
                                                  Get.height,
                                          child: VideoPlayer(_ShortController
                                              .currentReadShortData.controller),
                                        ),
                                        Positioned(
                                          top: kHeight * .5,
                                          left: kWidth * .8,
                                          child: Container(
                                            height: 200,
                                            margin: EdgeInsets.symmetric(
                                                vertical: kMarginY * 2,
                                                horizontal: kMarginX),
                                            width: 230,
                                            child: Stack(
                                              children: [
                                                // CircularProgressIndicator(
                                                //   value: _ShortController
                                                //       .progressValue,
                                                //   strokeWidth: 5,
                                                //   valueColor:
                                                //       AlwaysStoppedAnimation<
                                                //               Color>(
                                                //           ColorsApp.skyBlue),
                                                // ),
                                                Positioned.fill(
                                                  child: GestureDetector(
                                                    behavior: HitTestBehavior
                                                        .translucent,
                                                    onTap: () {
                                                      if (_ShortController
                                                          .controller!
                                                          .value
                                                          .isPlaying) {
                                                        _ShortController
                                                            .currentReadShortData
                                                            .controller
                                                            .pause();
                                                      } else {
                                                        _ShortController
                                                            .currentReadShortData
                                                            .controller
                                                            .play();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 2,
                                            child: Container(
                                                height: 8,
                                                width: kWidth,
                                                child: VideoProgressIndicator(
                                                    _ShortController
                                                        .currentReadShortData
                                                        .controller,
                                                    colors: VideoProgressColors(
                                                        playedColor:
                                                            Color.fromARGB(255,
                                                                31, 59, 151)),
                                                    allowScrubbing: true))),
                                        Positioned(
                                          top: _heartPosition.dy - 40,
                                          left: _heartPosition.dx - 40,
                                          child: _showHeart
                                              ? ScaleTransition(
                                                  scale: _heartAnimation,
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                    size: 80,
                                                  ),
                                                )
                                              : Container(),
                                        )
                                      ])))))),
                  Positioned(
                      top: 30,
                      left: 0,
                      child: Container(
                          child: IconButtonF0(
                        color: ColorsApp.black,
                        icon: Icons.arrow_back_ios_new,
                        onTap: () async {
                          Get.back();
                          await _ShortController.disposeUniquePLayer();

                          return true;
                        },
                      ))),
                  /*   _ShortController.isLoadedP == 0
                      ? Container(
                          child: SpinKitRing(
                            lineWidth: 4,
                            color: ColorsApp.skyBlue,
                            size: 45,
                          ),
                        )
                      : */
                  if (_ShortController.currentReadShortData != null)
                    if (_ShortController.currentReadShortData.controller !=
                        null)
                      Positioned(
                          top: kHeight / 2,
                          left: kWidth / 1.3,
                          child: Container(
                              child: InkWell(
                            child: ShortAction(
                              short: _ShortController.currentReadShortData,
                            ),
                            onTap: () {
                              _ShortController.disposeUniquePLayer();

                              Get.toNamed(AppLinks.BOUTIQUE +
                                  '?lienBoutique=${_ShortController.currentReadShortData.boutique.lienBoutique.toString()}note=${_ShortController.currentReadShortData.boutique.note}&codeBoutique=${_ShortController.currentReadShortData.boutique.codeBoutique}&note=${_ShortController.currentReadShortData.boutique.note}&nomBoutique=${_ShortController.currentReadShortData.boutique.titre}&description=${_ShortController.currentReadShortData.boutique.description}&ville=${_ShortController.currentReadShortData.boutique.localisation.ville}&image=${_ShortController.currentReadShortData.boutique.images[_ShortController.currentReadShortData.boutique.images.length - 1].src}');
                            },
                          ))),
                ],
              )));
    });
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

