//

import 'package:EMIY/Views/Produit/ProduitViewShort.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/ShortComponent/shortAction.dart';
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:video_player/video_player.dart';

class SingleShortView extends StatefulWidget {
  var idShort;
  var codeShort;
  SingleShortView({this.idShort, this.codeShort = 0});

  @override
  _SingleShortViewState createState() => _SingleShortViewState();
}

class _SingleShortViewState extends State<SingleShortView>
    with TickerProviderStateMixin {
  dispose() {
    super.dispose();
    print('dispose');
    _heartAnimationController.dispose();

    Get.find<ShortController>().disposePLayerAll();
  }

  late VideoPlayerController _controller;

  @override
  void initState() {
    Get.find<ShortController>().disposePLayerAll();

    super.initState();
    // Get.find<ShortController>()
    //     .getUniqueShort(widget.idShort, widget.codeShort);
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
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        ApiUrl.stream_serveurUrl +
            "/short?video=" +
            Get.find<ShortController>().currentReadShortData.src))
      ..initialize().then((_) {
        setState(() {
          Get.find<ShortController>().setControllerUniquePlayer(_controller);
          print('444---');

          Get.find<ShortController>().isUniqueVideoPlayer.play();
        });
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
            await _ShortController.disposePLayerAll();

            return true;
          },
          child: Scaffold(
              backgroundColor: ColorsApp.black,
              body: _ShortController.isUnique == 0
                  ? AppLoading()
                  : Stack(
                      children: [
                        GetBuilder<ShortController>(
                          builder: (_ShortController) => _ShortController
                                      .isUniqueVideoPlayer !=
                                  null
                              ? _ShortController
                                      .isUniqueVideoPlayer.value.isInitialized
                                  ? Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (_ShortController
                                                  .isUniqueVideoPlayer
                                                  .value
                                                  .isPlaying) {
                                                _ShortController
                                                    .isUniqueVideoPlayer
                                                    .pause();
                                              } else {
                                                _ShortController
                                                    .isUniqueVideoPlayer
                                                    .play();
                                              }
                                            });
                                          },
                                          // onDoubleTapDown: _handleDoubleTap,
                                          onDoubleTap: () {
                                            _ShortController.newLikeShort();
                                          },
                                          child: AspectRatio(
                                            aspectRatio: 9.7 / 17.7,
                                            child: VideoPlayer(_ShortController
                                                .isUniqueVideoPlayer),
                                          )))
                                  : AspectRatio(
                                      aspectRatio: 9.7 / 17.7,
                                      child: Image.network(
                                        _ShortController
                                            .isUniqueVideoPlayer.preview,

                                        fit: BoxFit
                                            .cover, // Spécifie comment l'image doit s'adapter au conteneur
                                      ))
                              : AspectRatio(
                                  aspectRatio: 9.7 / 17.7,
                                  child: Image.network(
                                    _ShortController
                                        .currentReadShortData.preview,

                                    fit: BoxFit
                                        .cover, // Spécifie comment l'image doit s'adapter au conteneur
                                  )),
                        ),
                        if (_ShortController.isUniqueVideoPlayer != null)
                          Positioned(
                            bottom: 15,
                            left: 5,
                            right: 5,
                            child: Container(
                                alignment: Alignment.center,
                                width: kWidth,
                                height: kHeight * .1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _ShortController
                                        .currentReadShortData.produits.length,
                                    itemBuilder: (ctx, i) => InkWell(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: ColorsApp.greySecond,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: CachedNetworkImage(
                                              height: kHeight * .09,
                                              width: kWidth * .17,
                                              fit: BoxFit.cover,
                                              imageUrl: _ShortController
                                                  .currentReadShortData
                                                  .produits[i]
                                                  .images[0]
                                                  .src,
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorsApp.greySecond,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                              placeholder: (context, url) {
                                                return ShimmerBox(
                                                    height: kHeight * .09);
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return CircleAvatar(
                                                    backgroundColor:
                                                        ColorsApp.skyBlue,
                                                    radius: 50,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/error.gif"));
                                              },
                                            )),
                                        onTap: () async {
                                          Get.to(() => ProduitViewShort(
                                                produit: _ShortController
                                                    .currentReadShortData
                                                    .produits[i],
                                              ));
                                        }))),
                          ),
                        // if (_ShortController.isUniqueVideoPlayer != null &&
                        //     _ShortController.isUniqueVideoPlayer.value.isInitialized)
                        //   Positioned(
                        //       bottom: 2,
                        //       child: Container(
                        //           height: 8,
                        //           width: kWidth,
                        //           child: VideoProgressIndicator(
                        //               _ShortController.isUniqueVideoPlayer,
                        //               colors: VideoProgressColors(
                        //                   playedColor: Color.fromARGB(255, 31, 59, 151)),
                        //               allowScrubbing: true))),
                        if (_ShortController.isUniqueVideoPlayer != null)
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
                        if (_ShortController.isUniqueVideoPlayer != null)
                          Positioned(
                              top: kHeight / 2,
                              left: kWidth / 1.3,
                              child: Container(
                                  child: InkWell(
                                child: ShortAction(
                                  short: _ShortController.currentReadShortData,
                                ),
                                onTap: () {
                                  _ShortController.disposePLayerAll();

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
