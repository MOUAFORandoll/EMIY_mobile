// ignore: must_be_immutable
import 'package:EMIY/Views/Produit/ProduitView.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/theme.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:EMIY/model/data/HomeComponentModel.dart';

// ignore: must_be_immutable
class HomeModuleComponent extends StatelessWidget {
  HomeComponentModel homeComponent;
  HomeModuleComponent({required this.homeComponent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: EdgeInsets.only(top: kMarginY),
          child: Column(children: [
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(homeComponent.titre,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: kBasics,
                              color: ColorsApp.secondBlue,
                              fontWeight: FontWeight.w700)),
                    ),
                    InkWell(
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                child: Text('See all',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: kBasics,
                                        color: ColorsApp.secondBlue,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorsApp.secondBlue,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.find<ProduitController>()
                              .getListProduitBuyHomeSelect(homeComponent.type);
                          Get.toNamed(AppLinks.PRODUCT_VIEW_BY_HOME);
                        })
                  ]),
            ),
            Container(
                margin: EdgeInsets.only(top: kMarginY),
                height: kHeight * .31,
                child: ListView.builder(
                    itemCount: homeComponent.produits.length < 8
                        ? homeComponent.produits.length
                        : 8,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_ctx, index) => (index ==
                            (homeComponent.produits.length < 8
                                ? homeComponent.produits.length - 1
                                : 7))
                        ? InkWell(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Text('See all',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: kBasics,
                                            color: ColorsApp.secondBlue,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorsApp.secondBlue,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.find<ProduitController>()
                                  .getListProduitBuyHomeSelect(
                                      homeComponent.type);
                              Get.toNamed(AppLinks.PRODUCT_VIEW_BY_HOME);
                            })
                        : InkWell(
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                // padding: EdgeInsets.all(5),

                                width: kWidth / 2.65,
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
                                      // Image.network(homeComponent
                                      //     .produits[index].images[0].src),
                                      CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: homeComponent
                                            .produits[index].images[0].src,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                              height: kHeight / 5,
                                              width: kWidth / 2.65,
                                              decoration: BoxDecoration(
                                                // color: ColorsApp.red,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.transparent,
                                                            BlendMode
                                                                .colorBurn)),
                                              ));
                                        },
                                        placeholder: (context, url) {
                                          return ShimmerBox();
                                        },
                                        errorWidget: (context, url, error) {
                                          return Container(
                                              height: kHeight / 5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/logo/logoNew.png'),
                                              )));
                                        },
                                      ),
                                      (homeComponent.produits[index].negociable)
                                          ? Positioned(
                                              top: 2,
                                              right: 2,
                                              child: InkWell(
                                                  child: Icon(Icons.handshake),
                                                  onTap: () {
                                                    Get.find<
                                                            NegociationController>()
                                                        .newNegociation(
                                                            homeComponent
                                                                .produits[index]
                                                                .codeProduit);
                                                  }),
                                            )
                                          : Container(),
                                      Positioned(
                                        bottom: 2,
                                        right: 2,
                                        child: InkWell(
                                            child: Icon(Icons.favorite,
                                                color: homeComponent
                                                        .produits[index].islike
                                                    ? ColorsApp.red
                                                    : ColorsApp.white),
                                            onTap: () {
                                              Get.find<GeneralController>()
                                                  .likeProduit(
                                                      homeComponent
                                                          .produits[index]
                                                          .codeProduit,
                                                      0);
                                            }),
                                      )
                                    ]),
                                    Container(
                                        width: kWidth / 2,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: kMarginX / 2),
                                        child: Text(
                                            homeComponent.produits[index].titre,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.left,
                                            style: TexteStyle()
                                                .secondaryTextStyle)),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: kMarginX / 2),
                                        width: kWidth / 2,
                                        child: Text(
                                            'XAF ' +
                                                homeComponent
                                                    .produits[index].prix
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TexteStyle()
                                                .secondaryTextStyle)),
                                  ],
                                )),
                            onTap: () {
                              Get.find<ProduitController>().resetIndexSup();
                              Get.to(() => ProduitView(
                                  produit: homeComponent.produits[index],
                                  index: index));
                              // Get.toNamed(AppLinks.PRODUCT +
                              //     '?index=${index}&type=homeComponent&id=${homeComponent.produits[index].id}&codeProduit=${homeComponent.produits[index].codeProduit}&titre=${homeComponent.produits[index].titre}&description=${homeComponent.produits[index].description}&image=${ApiUrl.baseUrl}/images/produits/${homeComponent.produits[index].images[0].src}');
                            },
                          )))
          ])),
      onTap: () {
        // Get.find<ProduitController>().resetIndexSup();
        //  Get.to(() => ProduitView(produit : , index :index));
        // Get.toNamed(AppLinks.PRODUCT +
        //     '?index=${index}&type=${type}&id=${homeComponent.produits[index].id}&titre=${homeComponent.produits[index].titre}&description=${homeComponent.produits[index].description}&image=${ApiUrl.baseUrl}/images/produits/${homeComponent.produits[index].images[0].src}');
      },
    );
  }
}
