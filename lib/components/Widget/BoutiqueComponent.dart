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
class BoutiqueComponent extends StatelessWidget {
  BoutiqueModel boutique;

  BoutiqueComponent({required this.boutique});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppLinks.BOUTIQUE +
            '?note=${boutique.note}&codeBoutique=${boutique.codeBoutique}&note=${boutique.note}&nomBoutique=${boutique.titre}&description=${boutique.description}&ville=${boutique.localisation.ville}&image=${boutique.images[boutique.images.length - 1].src}');
      },
      child: Container(
        height: kHeight / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: boutique.images[boutique.images.length - 1].src,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: kHeight / 4,
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
                      height: kHeight / 4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      )));
                },
              ),
            ),
            Container(
                width: kWidth / 2,
                child: Text(boutique.titre,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: ColorsApp.marron,
                        fontWeight: FontWeight.bold,
                        fontSize: 12))),
          ],
        ),
      ),
    );
  }
}
