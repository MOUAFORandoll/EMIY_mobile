// ignore: must_be_immutable
import 'package:EMIY/Views/Produit/ProduitView.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/components/Widget/ShimmerBox.dart';

// ignore: must_be_immutable
class ProduitComponentAll extends StatelessWidget {
  ProduitModel produit;
  var height, index, type;

  ProduitComponentAll(
      {required this.produit,
      required this.index,
      this.height,
      this.type = 'home',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          // height: kHeight / 2.7,
          // margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffDDDDDD),
                  blurRadius: 0, // Soften the shaodw
                  spreadRadius: 0,
                  offset: Offset(-2.0, 3),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: produit.images[0].src,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                        height: kHeight / 4.8,
                        decoration: BoxDecoration(
                          color: ColorsApp.greySecond,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.transparent, BlendMode.colorBurn)),
                        ));
                  },
                  placeholder: (context, url) {
                    return /* Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: ColorsApp.skyBlue,
                      )),
                    ) */

                        ShimmerBox();
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                        height: kHeight / 5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/logo/logoNew.png'),
                        )));
                  },
                ),
                (produit.negociable)
                    ? Positioned(
                        top: 2,
                        right: 2,
                        child: InkWell(
                            child: Icon(Icons.handshake),
                            onTap: () {
                              Get.find<NegociationController>()
                                  .newNegociation(produit.codeProduit);
                            }),
                      )
                    : Container(),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: InkWell(
                      child: Icon(Icons.favorite,
                          color:
                              produit.islike ? ColorsApp.red : ColorsApp.white),
                      onTap: () {
                        Get.find<GeneralController>()
                            .likeProduit(produit.codeProduit, 0);
                      }),
                )
              ]),
              Container(
                  width: kWidth / 2,

                  margin: EdgeInsets.symmetric(horizontal: kMarginX / 2),
                  child: Text(produit.titre,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left,
                      style: TexteStyle().secondaryTextStyle)),
              Container(
                  width: kWidth / 2,

                  margin: EdgeInsets.symmetric(horizontal: kMarginX / 2),
                  child: Text('XAF ' + produit.prix.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TexteStyle().bprimaryTextStyle)),
            ],
          )),
      onTap: () {
        Get.back();

        Get.to(
          () => ProduitView(produit: produit, index: index),
        );

        Get.find<ProduitController>().resetIndexSup();
        // Get.toNamed(AppLinks.PRODUCT +
        //     '?index=${index}&type=${type}&codeProduit=${produit.codeProduit}&id=${produit.id}&titre=${produit.titre}&description=${produit.description}&image=${ApiUrl.baseUrl}/images/produits/${produit.images[0].src}');
      },
    );
  }
}
