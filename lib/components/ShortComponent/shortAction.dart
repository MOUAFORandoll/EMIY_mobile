import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ShortAction extends StatelessWidget {
  ShortAction({required this.short});
  ShortModel short;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(
        builder: (_ShortController) => Container(
                // alignment: Alignment.center,
                // padding: EdgeInsets.all(7),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50),
                //     border: Border.all(
                //       color: Colors.white,
                //     )),
                // color: Colors.red,
                child: Column(
              children: [
                Container(
                    width: 48,
                    height: 48,
                    margin: EdgeInsets.symmetric(
                        vertical: kMarginY * 2, horizontal: kMarginX),
                    child: CachedNetworkImage(
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      imageUrl: short.boutique.images[0].src,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ColorsApp.greySecond,
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.transparent, BlendMode.colorBurn)),
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: ColorsApp.skyBlue,
                          )),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/error.gif"));
                      },
                    )),

                InkWell(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: kMarginY * 2, horizontal: kMarginX),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  onTap: () {
                    //print(_ShortController
                    // .listShort[_ShortController.currentShort].id);
                  },
                ),
                // Container(
                //     margin: EdgeInsets.symmetric(
                //         vertical: kMarginY * 2, horizontal: kMarginX),
                //     child: Icon(
                //       FontAwesomeIcons.solidComment,
                //       color: Colors.white,
                //       size: 40,
                //     )),
                // Container(
                //     margin: EdgeInsets.symmetric(
                //         vertical: kMarginY * 2, horizontal: kMarginX),
                //     child: Icon(
                //       FontAwesomeIcons.share,
                //       color: Colors.white,
                //       size: 40,
                //     ))
              ],
            )));
  }
}
