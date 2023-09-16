//

import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/ShortComponent/shortAction.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
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

    // if (Get.find<ShortController>().controller!.value.isPlaying) {
    //   Get.find<ShortController>().controller!.pause();
    // }
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
            if (_ShortController.controllerShortBoutique != null) {
              _ShortController.controllerShortBoutique.pause();
              _ShortController.cleanListShort();
            }
            Get.back();
            return true;
          },
          child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  _ShortController.listBoutiqueShort.length == 0
                      ? Container(
                          child: AppLoading(),
                        )
                      : PageView.builder(
                          itemCount: _ShortController.listBoutiqueShort.length,
                          scrollDirection: Axis.vertical,
                          // controller: _ShortController.pageController,
                          onPageChanged: (index) {
                            index = index %
                                (_ShortController.listBoutiqueShort.length);

                            _ShortController.changeVideoForBoutique(index);
                            _ShortController.setCurrent(index);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ReaderBoutiqueVideoPlayer(
                              short: _ShortController.listBoutiqueShort[
                                  _ShortController.indexShortBoutique],
                            );
                          },
                        ),
                  Positioned(
                      top: 30,
                      left: 0,
                      child: Container(
                          child: IconButtonF0(
                        color: ColorsApp.black,
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          if (_ShortController.controllerShortBoutique !=
                              null) {
                            _ShortController.controllerShortBoutique.pause();
                            // _ShortController.cleanlistBoutiqueShort();
                          }
                          Get.back();
                        },
                      ))),
                  if (_ShortController.controllerShortBoutique != null)
                    // Positioned(
                    //     bottom: 2,
                    //     child: Container(
                    //         height: 8,
                    //         width: kWidth,
                    //         child: VideoProgressIndicator(
                    //             _ShortController.controllerShortBoutique,
                    //             colors: VideoProgressColors(
                    //                 playedColor:
                    //                     Color.fromARGB(255, 31, 59, 151)),
                    //             allowScrubbing: true))),
                    if (_ShortController.controllerShortBoutique != null)
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
                  if (_ShortController.controllerShortBoutique != null)
                    Positioned(
                        top: kHeight / 3,
                        left: kWidth / 1.3,
                        child: Container(
                            child: InkWell(
                          child: ShortAction(
                            short: _ShortController.listBoutiqueShort[
                                _ShortController.indexShortBoutique],
                          ),
                          onTap: () {
                            _ShortController.controllerShortBoutique!.pause();

                            Get.toNamed(AppLinks.BOUTIQUE +
                                '?lienBoutique=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.lienBoutique.toString()}note=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.note}&codeBoutique=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.codeBoutique}&note=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.note}&nomBoutique=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.titre}&description=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.description}&ville=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.localisation.ville}&image=${_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.images[_ShortController.listBoutiqueShort[_ShortController.indexShortBoutique].boutique.images.length - 1].src}');
                          },
                        )))
                ],
              )));
    });
  }
}

class ReaderBoutiqueVideoPlayer extends StatefulWidget {
  final ShortModel short;
  ReaderBoutiqueVideoPlayer({required this.short});

  @override
  State<ReaderBoutiqueVideoPlayer> createState() =>
      _ReaderBoutiqueVideoPlayerState();
}

class _ReaderBoutiqueVideoPlayerState extends State<ReaderBoutiqueVideoPlayer>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        ApiUrl.stream_serveurUrl + "/short?video=" + widget.short.src))
      ..initialize().then((_) {
        setState(() {
          Get.find<ShortController>().setControllerShortBoutique(_controller);

          Get.find<ShortController>().controllerShortBoutique.play();
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
      builder: (_ShortController) => _ShortController.controllerShortBoutique !=
                  null &&
              _ShortController.controllerShortBoutique.value.isInitialized
          ? Center(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_ShortController
                          .controllerShortBoutique.value.isPlaying) {
                        _ShortController.controllerShortBoutique.pause();
                      } else {
                        _ShortController.controllerShortBoutique.play();
                      }
                    });
                  },
                  // onDoubleTapDown: _handleDoubleTap,
                  onDoubleTap: () {
                    _ShortController.newLikeShort();
                  },
                  child: AspectRatio(
                    aspectRatio: 9.7 / 17.7,
                    child:
                        VideoPlayer(_ShortController.controllerShortBoutique),
                  )))
          : AspectRatio(
              aspectRatio: 9.7 / 17.7,
              child: Image.network(
                _ShortController
                    .listBoutiqueShort[_ShortController.indexShortBoutique]
                    .preview,

                fit: BoxFit
                    .cover, // Spécifie comment l'image doit s'adapter au conteneur
              )),
    );
  }
}
