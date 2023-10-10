import 'package:EMIY/components/ShortComponent/shortAction.dart';
import 'package:EMIY/components/exportcomponent.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/utils/Services/routing.dart';
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
          ? /*  Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 100,
                      width: 50,
                    ), */
          Align(
              alignment: Alignment.topCenter,
              child: /* GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_ShortController
                                    .controllerForYou.value.isPlaying) {
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
                            child:  */
                  AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: _ShortController.comment
                          ? 0.33 * MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width,
                      height: _ShortController.comment
                          ? 0.33 * MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height,
                      child: AspectRatio(
                        aspectRatio: 9.7 / 17.7,
                        child: VideoPlayer(_ShortController.controllerForYou),
                      )))
          /*  if (_ShortController.controllerForYou != null)
                      /*    Positioned(
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
           */
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
                              top: kHeight / 4,
                              left: kWidth / 1.3,
                              child: Container(
                                  child: InkWell(
                                child: ShortAction(
                                  short: _ShortController.listForYouShort[
                                      _ShortController.indexForYou],
                                ),
                                onTap: () {
                                  _ShortController.controllerForYou.pause();
                                  // currentReadShortData
                                  Get.toNamed(AppLinks.BOUTIQUE +
                                      '?lienBoutique=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.lienBoutique.toString()}note=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.note}&codeBoutique=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.codeBoutique}&note=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.note}&nomBoutique=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.titre}&description=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.description}&ville=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.localisation.ville}&image=${_ShortController.listForYouShort[_ShortController.indexForYou].boutique.images[_ShortController.listForYouShort[_ShortController.indexForYou].boutique.images.length - 1].src}');
                                },
                              ))),
                  ],
                ) */
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
