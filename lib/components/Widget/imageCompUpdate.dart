import 'dart:io';

import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/model/data/ProduitBoutiqueModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class imageCompUpdate extends StatelessWidget {
  ImageU image;
  imageCompUpdate({
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(
        builder: (_controller) => InkWell(
              child: Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.greySecond,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 1)
                      .add(EdgeInsets.only(right: kMarginX)),
                  child: CachedNetworkImage(
                    height: kMdHeight * .2,
                    width: Get.width * .3,
                    fit: BoxFit.cover,
                    imageUrl: image.src,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
                          backgroundColor: ColorsApp.skyBlue,
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/error.gif"));
                    },
                  )),
              onTap: () {
                _controller.updateProduitImage(image.id);
              },
            ));
  }
}
