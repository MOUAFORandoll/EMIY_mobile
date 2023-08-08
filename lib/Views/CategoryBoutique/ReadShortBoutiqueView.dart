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

import '../../components/Widget/app_loading.dart';

class ReadShortBoutiqueView extends StatefulWidget {
  var codeBoutique;
  ReadShortBoutiqueView({
    this.codeBoutique,
  });

  @override
  _ReadShortBoutiqueViewState createState() => _ReadShortBoutiqueViewState();
}

class _ReadShortBoutiqueViewState extends State<ReadShortBoutiqueView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Get.find<ShortController>().getListShortForBoutique(
      widget.codeBoutique,
    );
    // Get.find<ShortController>().initialise
    //     ? Get.find<ShortController>().controller!.play()
    //     : Get.find<ShortController>().changeVideo(0);
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

  late VideoPlayerController _videoPlayerController;

  int _currentIndex = 0;

  ShortController short = Get.find();

  double position = 0.0;
  bool _showHeart = false;
  Offset _heartPosition = Offset.zero;

  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
    print('dispose');

    if (Get.find<ShortController>().controller!.value.isPlaying) {
      Get.find<ShortController>().controller!.pause();
    }
  }

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
            if (_ShortController.controller != null) {
              _ShortController.controller!.pause();
              _ShortController.cleanListShort();
            }
            Get.back();
            return true;
          },
          child: Scaffold(
              backgroundColor: ColorsApp.black,
              body: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  _ShortController.isLoadedForBoutiqueShort == 0 ||
                          _ShortController.listShort.length == 0 ||
                          _ShortController.controller == null
                      ? Container(
                          child: AppLoading(),
                        )
                      : PageView.builder(
                          itemCount: _ShortController.listShort.length,
                          scrollDirection: Axis.vertical,
                          controller: _ShortController.pageController,
                          onPageChanged: (index) {
                            index = index % (_ShortController.listShort.length);

                            _ShortController.changeVideo(index);
                            _ShortController.setCurrent(index);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_ShortController
                                        .controller!.value.isPlaying) {
                                      _ShortController.controller!.pause();
                                    } else {
                                      _ShortController.controller!.play();
                                    }
                                  });
                                },
                                onDoubleTapDown: _handleDoubleTap,
                                onDoubleTap: () {
                                  _ShortController.newLikeShort();
                                },
                                child: _ShortController
                                        .controller!.value.isInitialized
                                    ? AspectRatio(
                                        aspectRatio: 9 / 16,
                                        child: VideoPlayer(
                                            _ShortController.controller!),
                                      )
                                    : Container(
                                        child:
                                            AppLoading() /* SpinKitRing(
                                      lineWidth: 4,
                                      color: ColorsApp.skyBlue,
                                      size: 45,
                                    ) */
                                        ,
                                      ),
                              ),
                            );
                          },
                        ),
                  Positioned(
                      top: 30,
                      left: 0,
                      child: Container(
                          child: IconButtonF0(
                        color: Colors.black,
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          if (_ShortController.controller != null) {
                            _ShortController.controller!.pause();
                            _ShortController.cleanListShort();
                          }
                          Get.back();
                        },
                      ))),
                  _ShortController.initialise &&
                          _ShortController.listShort.isNotEmpty
                      ? Positioned(
                          bottom: 2,
                          child: Container(
                              height: 8,
                              width: kWidth,
                              child: VideoProgressIndicator(
                                  _ShortController.controller!,
                                  colors: VideoProgressColors(
                                      playedColor:
                                          Color.fromARGB(255, 31, 59, 151)),
                                  allowScrubbing: true)))
                      : Container(),
                  _ShortController.initialise &&
                          _ShortController.listShort.isNotEmpty
                      ? Positioned(
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
                      : Container(),
                  _ShortController.initialise &&
                          _ShortController.listShort.isNotEmpty
                      ? Positioned(
                          top: kHeight / 3,
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
                                  '?lienBoutique=${_ShortController.listShort[_ShortController.currentShort].boutique.lienBoutique.toString()}note=${_ShortController.listShort[_ShortController.currentShort].boutique.note}&codeBoutique=${_ShortController.listShort[_ShortController.currentShort].boutique.codeBoutique}&note=${_ShortController.listShort[_ShortController.currentShort].boutique.note}&nomBoutique=${_ShortController.listShort[_ShortController.currentShort].boutique.titre}&description=${_ShortController.listShort[_ShortController.currentShort].boutique.description}&ville=${_ShortController.listShort[_ShortController.currentShort].boutique.localisation.ville}&image=${_ShortController.listShort[_ShortController.currentShort].boutique.images[_ShortController.listShort[_ShortController.currentShort].boutique.images.length - 1].src}');
                            },
                          )))
                      : Container(),
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

