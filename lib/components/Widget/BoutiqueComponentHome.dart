// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/model/data/BoutiqueModel.dart'; 
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BoutiqueComponentHome extends StatelessWidget {
  BoutiqueModel boutique;

  BoutiqueComponentHome({required this.boutique});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppLinks.BOUTIQUE +
            '?lienBoutique=${boutique.lienBoutique.toString()}status_abonnement=${boutique.status_abonnement.toString()}&note=${boutique.note}&codeBoutique=${boutique.codeBoutique}&nomBoutique=${boutique.titre}&nombre_produit=${boutique.nombre_produit}&description=${boutique.description}&ville=${boutique.localisation.ville}&image=${boutique.images[boutique.images.length - 1].src}');
      },
      child: Container(
          height: kMdHeight * .30,
          width: kSmWidth * 1.3,
          // alignment: Alignment.center,
          // padding: EdgeInsets.all(kMarginX / 4),
          margin: EdgeInsets.all(Get.size.width * .02),
          decoration: BoxDecoration(
              color: ColorsApp.greySecond,
              borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: [
              Container(
                child: CachedNetworkImage(
                  height: kMdHeight * .30,
                  width: kSmWidth * 1.3,
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
                          image: AssetImage('assets/logo/logoNew.png'),
                        )));
                  },
                ),
              ),
              Positioned(
                  top: kMdHeight * .18,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: kSmWidth * 1.25,
                      height: kMdHeight * .09,

                      // width: kSmWidth * .8,
                      decoration: BoxDecoration(
                          color: ColorsApp.greySecond,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(kMarginX),
                      margin: EdgeInsets.symmetric(horizontal: kMarginX),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            boutique.titre,
                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                                fontSize: 18,
                                color: ColorsApp.black,
                                fontWeight: FontWeight.bold),
                            // textAlign: TextAlign.start,
                          )),
                          Container(
                              width: kSmWidth * 1.25,
                              child: Text(
                                boutique.description,
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsApp.black,
                                    fontWeight: FontWeight.bold),
                                // textAlign: TextAlign.start,
                              )),
                          Container(
                              width: kSmWidth * 1.25,
                              child: Text(
                                'Situe a ' + boutique.localisation.ville,
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsApp.black,
                                    fontWeight: FontWeight.bold),
                                // textAlign: TextAlign.start,
                              ))
                        ],
                      )))
            ],
          )),
    );
  }
}
