// ignore: must_be_immutable
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/model/data/BoutiqueModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
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
            '?lienBoutique=${boutique.lienBoutique.toString()}&status_abonnement=${boutique.status_abonnement.toString()}&note=${boutique.note}&codeBoutique=${boutique.codeBoutique}&note=${boutique.note}&nomBoutique=${boutique.titre}&nombre_produit=${boutique.nombre_produit}&description=${boutique.description}&ville=${boutique.localisation.ville}&image=${boutique.images[boutique.images.length - 1].src}');
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
                  return ShimmerBox();
                },
                errorWidget: (context, url, error) {
                  return Container(
                      height: kHeight / 4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/logo/logoNew.png'),
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
                        fontWeight: FontWeight.w600,
                        fontSize: 12))),
          ],
        ),
      ),
    );
  }
}
