import 'package:EMIY/Views/Produit/ProduitViewShort.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/ShortComponent/shortAction.dart';
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:video_player/video_player.dart';

import '../../components/Widget/app_loading.dart';

class ShortView extends StatefulWidget {
  @override
  _ShortViewState createState() => _ShortViewState();
}

class _ShortViewState extends State<ShortView> with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;

  int _currentIndex = 0;

  ShortController short = Get.find();

  double position = 0.0;
  bool _showHeart = false;
  Offset _heartPosition = Offset.zero;

  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    super.initState();
    Get.find<ShortController>().initialise
        ? Get.find<ShortController>().controller!.play()
        : Get.find<ShortController>().changeVideo(0);
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
      return Container(
        decoration: BoxDecoration(color: ColorsApp.black),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _ShortController.listShort.length == 0 ||
                    _ShortController.controller == null
                ? AppLoading()
                : PageView.builder(
                    itemCount: _ShortController.listShort.length,
                    scrollDirection: Axis.vertical,
                    controller: _ShortController.pageController,
                    onPageChanged: (index) {
                      index = index % (_ShortController.listShort.length);
                      _ShortController.controller.pause();
                      print('-------------------00000000000000000000000000');
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
                                  aspectRatio: 9 / 14.2,
                                  child:
                                      VideoPlayer(_ShortController.controller!),
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
            if (_ShortController.initialise)
              Positioned(
                bottom: 15,
                left: 10,
                child: Container(
                    alignment: Alignment.center,
                    width: kWidth,
                    height: kHeight * .1,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _ShortController
                            .listShort[_ShortController.currentShort]
                            .produits
                            .length,
                        itemBuilder: (ctx, i) => InkWell(
                            child: Container(
                                decoration: BoxDecoration(
                                  color: ColorsApp.greySecond,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: CachedNetworkImage(
                                  height: kHeight * .09,
                                  width: kWidth * .17,
                                  fit: BoxFit.cover,
                                  imageUrl: _ShortController
                                      .listShort[_ShortController.currentShort]
                                      .produits[i]
                                      .images[0]
                                      .src,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: ColorsApp.greySecond,
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return ShimmerBox(height: kHeight * .09);
                                  },
                                  errorWidget: (context, url, error) {
                                    return CircleAvatar(
                                        backgroundColor: ColorsApp.skyBlue,
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                            "assets/images/error.gif"));
                                  },
                                )),
                            onTap: () async {
                              Get.to(ProduitViewShort(
                                produit: _ShortController
                                    .listShort[_ShortController.currentShort]
                                    .produits[i],
                              ));
                            }))),
              ),
            if (_ShortController.initialise)
              Positioned(
                  bottom: 2,
                  child: Container(
                      height: 8,
                      width: kWidth,
                      child: VideoProgressIndicator(
                          _ShortController.controller!,
                          colors: VideoProgressColors(
                              playedColor: Color.fromARGB(255, 31, 59, 151)),
                          allowScrubbing: true))),
            if (_ShortController.initialise)
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
              ),
            if (_ShortController.initialise)
              Positioned(
                  top: kHeight / 4,
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
                  ))),
          ],
        ),
      );
    });
  }
}
/* 
class ShortViewF extends StatefulWidget {
  @override
  State<ShortViewF> createState() => _ShortViewFState();
}

class _ShortViewFState extends State<ShortViewF> with TickerProviderStateMixin {
  // PageController _pageController = PageController(initialPage: 0);

  late VideoPlayerController _videoPlayerController;

  int _currentIndex = 0;

  // List videoUrls = [
  ShortController short = Get.find();

  double position = 0.0;
  bool _showHeart = false;
  Offset _heartPosition = Offset.zero;

  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    super.initState();
    // _pageController = PageController(initialPage: 0);
    // print('**********************short.listShort');
    // print('*********************${Get.find<ShortController>().initialise}');
    Get.find<ShortController>().initialise
        ? Get.find<ShortController>().controller!.play()
        : Get.find<ShortController>().changeVideo(0);
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

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
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
                  onDoubleTapDown: _handleDoubleTap,
                  onDoubleTap: () {
                    _ShortController.newLikeShort();
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
                          ),
                          Positioned(
                              bottom: 2,
                              child: Container(
                                  height: 8,
                                  width: kWidth,
                                  child: VideoProgressIndicator(
                                      _ShortController.controller!,
                                      colors: VideoProgressColors(
                                          playedColor:
                                              Color.fromARGB(255, 31, 59, 151)),
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
 
 */



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

