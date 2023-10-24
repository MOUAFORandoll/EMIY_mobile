// ignore: must_be_immutable
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:EMIY/controller/linkController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProduitForBoutiqueLinkComponent extends StatelessWidget {
  var produit;

  ProduitForBoutiqueLinkComponent({
    required this.produit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: kHeight / 4,
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
                produit.negociable
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
                    : Container()
              ]),
              Container(
                width: kWidth / 2,
                margin: EdgeInsets.symmetric(horizontal: kMarginX / 2),
                child: Text(produit.titre,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: ColorsApp.marron,
                        fontWeight: FontWeight.w600,
                        fontSize: 12)),
              ),
              Container(
                width: kWidth / 2,
                margin: EdgeInsets.symmetric(horizontal: kMarginX / 2),
                child: Text('XAF ' + produit.prix.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorsApp.skyBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.w600)),
              ),
            ]),
      ),
      onTap: () {
        Get.find<LinkController>().getUniLinkProduit(produit.codeProduit);
        Get.toNamed(AppLinks.PRODUCT_FOR_LINK);
      },
    );
  }
}
