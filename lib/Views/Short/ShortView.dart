import 'package:EMIY/Views/Produit/ProduitViewShort.dart';
import 'package:EMIY/Views/Short/ReadForYouVideoPlayer.dart';
import 'package:EMIY/Views/Short/ReadSuivisVideoPlayer.dart';
import 'package:EMIY/components/ShortComponent/shortAction.dart';
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../components/Widget/app_loading.dart';

class ShortView extends StatefulWidget {
  @override
  _ShortViewState createState() => _ShortViewState();
}

class _ShortViewState extends State<ShortView> with TickerProviderStateMixin {
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
    // short.initialise ? short.init() : short.changeVideoForYou(0);
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

  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Stack(alignment: AlignmentDirectional.center, children: [
            PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2, // Number of items in each horizontal row

                onPageChanged: (index) {
                  if (index == 1) {
                    _ShortController.setStateShortPage(1);
                  } else {
                    _ShortController.setStateShortPage(0);
                  }
                },
                itemBuilder: (context, horizontalIndex) =>
                    _ShortController.stateShortPage == 0
                        ? buildForYouPage(context)
                        : buildSuivisPage(context)),
            if (!_ShortController.comment)
              Positioned(
                  top: 2,
                  left: kWidth / 3,
                  child: Container(
                      height: kHeight * .05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Pour toi',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color:
                                              _ShortController.stateShortPage ==
                                                      0
                                                  ? ColorsApp.white
                                                  : ColorsApp.greyTh,
                                        ),
                                      ),
                                    ),
                                    if (_ShortController.stateShortPage == 0)
                                      Container(
                                          height: 4,
                                          width: 30,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: ColorsApp.white)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                _ShortController.setStateShortPage(0);
                              }),
                          InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Suivis',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color:
                                              _ShortController.stateShortPage ==
                                                      1
                                                  ? ColorsApp.white
                                                  : ColorsApp.greyTh,
                                        ),
                                      ),
                                    ),
                                    if (_ShortController.stateShortPage == 1)
                                      Container(
                                          height: 4,
                                          width: 30,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: ColorsApp.white)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                _ShortController.setStateShortPage(1);
                              }),
                          // InkWell(
                          //     child: Container(
                          //       margin: EdgeInsets.symmetric(
                          //         horizontal: 5,
                          //       ),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Container(
                          //             child: Text(
                          //               /*    _ShortController.listShort.length
                          //                   .toString() */
                          //               _ShortController
                          //                   .currentReadShortData.titre,
                          //               style: TextStyle(
                          //                 fontFamily: 'Lato',
                          //                 fontWeight: FontWeight.w600,
                          //                 fontSize: 15,

                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     onTap: () {
                          //       // _ShortController.setStateShortPage();
                          //     }),
                        ],
                      ))),
          ]));
    });
  }

  Widget buildForYouPage(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return InkWell(
        onTap: () {
          print(_ShortController.listForYouShort.length);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _ShortController.listForYouShort.isEmpty
                ? AppLoading()
                : PageView.builder(
                    itemCount: _ShortController.listForYouShort.length,
                    scrollDirection: Axis.vertical,
                    controller: _ShortController.pageForYouController,
                    onPageChanged: (index) {
                      _ShortController.controllerForYou.pause();
                      _ShortController.disposePLayerAll();
                      index = index % (_ShortController.listForYouShort.length);
                      print(_ShortController
                          .listForYouShort[_ShortController.indexForYou]
                          .preview);
                      print('-------------------00000000000000000000000000');
                      _ShortController.changeVideoForYou(index);
                      _ShortController.setCurrent(index);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ReaderForYouVideoPlayer(
                        short: _ShortController
                            .listForYouShort[_ShortController.indexForYou],
                      );
                    },
                  ),
            if (_ShortController.controllerForYou != null)
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
                            .listForYouShort[_ShortController.indexForYou]
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
                                      .listForYouShort[
                                          _ShortController.indexForYou]
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
                              Get.to(() => ProduitViewShort(
                                    produit: _ShortController
                                        .listForYouShort[
                                            _ShortController.indexForYou]
                                        .produits[i],
                                  ));
                            }))),
              ),
            if (_ShortController.controllerForYou != null &&
                _ShortController.controllerForYou.value.isInitialized)
              // Positioned(
              //     bottom: 2,
              //     child: Container(
              //         height: 8,
              //         width: kWidth,
              //         child: VideoProgressIndicator(
              //             _ShortController.controllerForYou,
              //             colors: VideoProgressColors(
              //                 playedColor: Color.fromARGB(255, 31, 59, 151)),
              //             allowScrubbing: true))),
              if (_ShortController.controllerForYou != null)
                Positioned(
                    top: kHeight / 3,
                    left: kWidth / 1.22,
                    child: Container(
                        child: InkWell(
                      child: ShortAction(
                        short: _ShortController
                            .listForYouShort[_ShortController.indexForYou],
                      ),
                      onTap: () {
                        _ShortController.controllerForYou.pause();
                        // currentReadShortData
                        Get.toNamed(AppLinks.BOUTIQUE +
                            '?lienBoutique=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.lienBoutique.toString()}note=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.note}&codeBoutique=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.codeBoutique}&note=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.note}&nomBoutique=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.titre}&description=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.description}&ville=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.localisation.ville}&image=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.images[_ShortController.listForYouShort[_ShortController.indexForYou].boutique.images.length - 1].src}');
                      },
                    ))),
          ],
        ),
      );
    });
  }

  Widget buildSuivisPage(BuildContext context) {
    return GetBuilder<ShortController>(builder: (_ShortController) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _ShortController.listSuivisShort.isEmpty
              ? AppLoading()
              : PageView.builder(
                  itemCount: _ShortController.listSuivisShort.length,
                  scrollDirection: Axis.vertical,
                  controller: _ShortController.pageSuivisController,
                  onPageChanged: (index) {
                    _ShortController.controllerSuivis.pause();
                    _ShortController.disposePLayerAll();
                    index = index % (_ShortController.listSuivisShort.length);
                    print('-------------------suivis');
                    _ShortController.changeVideoSuivis(index);
                    _ShortController.setCurrent(index);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ReadSuivisVideoPlayer(
                      short: _ShortController
                          .listSuivisShort[_ShortController.indexSuivis],
                    );
                  },
                ),
          if (_ShortController.controllerSuivis != null)
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
                          .listSuivisShort[_ShortController.indexSuivis]
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
                                    .listSuivisShort[
                                        _ShortController.indexSuivis]
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
                            Get.to(() => ProduitViewShort(
                                  produit: _ShortController
                                      .listSuivisShort[
                                          _ShortController.indexSuivis]
                                      .produits[i],
                                ));
                          }))),
            ),
          // if (_ShortController.controllerSuivis != null &&
          //     _ShortController.controllerSuivis.value.isInitialized)
          //   Positioned(
          //       bottom: 2,
          //       child: Container(
          //           height: 8,
          //           width: kWidth,
          //           child: VideoProgressIndicator(
          //               _ShortController.controllerSuivis,
          //               colors: VideoProgressColors(
          //                   playedColor: Color.fromARGB(255, 31, 59, 151)),
          //               allowScrubbing: true))),
          if (_ShortController.controllerSuivis != null)
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
          if (_ShortController.controllerSuivis != null)
            Positioned(
                top: kHeight / 4,
                left: kWidth / 1.3,
                child: Container(
                    child: InkWell(
                  child: ShortAction(
                    short: _ShortController
                        .listSuivisShort[_ShortController.indexSuivis],
                  ),
                  onTap: () {
                    _ShortController.controllerSuivis.pause();
// currentReadShortData
                    Get.toNamed(AppLinks.BOUTIQUE +
                        '?lienBoutique=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.lienBoutique.toString()}note=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.note}&codeBoutique=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.codeBoutique}&note=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.note}&nomBoutique=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.titre}&description=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.description}&ville=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.localisation.ville}&image=${_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.images[_ShortController.listSuivisShort[_ShortController.indexSuivis].boutique.images.length - 1].src}');
                  },
                ))),
        ],
      );
    });
  }
}
