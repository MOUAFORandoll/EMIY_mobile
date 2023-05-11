// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/model/data/BoutiqueModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BoutiqueComponentHomeN extends StatelessWidget {
  BoutiqueModel boutique;

  BoutiqueComponentHomeN({required this.boutique});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppLinks.BOUTIQUE +
            '?note=${boutique.note}&codeBoutique=${boutique.codeBoutique}&nomBoutique=${boutique.titre}&description=${boutique.description}&ville=${boutique.localisation.ville}&image=${boutique.images[boutique.images.length - 1].src}');
      },
      child: Container(
        height: 10,
        // width: kSmWidth * 1.3,
        // alignment: Alignment.center,
        // padding: EdgeInsets.all(kMarginX / 4),
        margin: EdgeInsets.symmetric(vertical: Get.size.width * .02),
        decoration: BoxDecoration(
            color: ColorsApp.greySecond,
            borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: CachedNetworkImage(
            // width: kSmWidth * 1.3,

            fit: BoxFit.cover,
            imageUrl: boutique.images[boutique.images.length - 1].src,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  color: ColorsApp.greySecond,
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
              return Container(
                  height: kMdHeight * .15,
                  width: Get.width * .5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  )));
            },
          ),
        ),
      ),
    );
  }
}
