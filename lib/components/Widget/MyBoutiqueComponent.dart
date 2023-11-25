// ignore: must_be_immutable
import 'package:EMIY/components/Widget/ShimmerBox.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/model/data/BoutiqueUserModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyBoutiqueComponent extends StatelessWidget {
  BoutiqueUserModel boutique;

  MyBoutiqueComponent({required this.boutique});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(
      builder: (_bcontroller) => Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 253, 253, 255),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorsApp.greyN, width: .8),
          ),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: boutique.images[0].src,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: kWidth / 4,
                              width: kWidth / 4,
                              decoration: BoxDecoration(
                                color: ColorsApp.greySecond,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.transparent,
                                        BlendMode.colorBurn)),
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
                        margin: EdgeInsets.only(left: kMarginX * 1.5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                boutique.titre,
                                style: TextStyle(
                                  fontSize: kTitle,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w700,
                                  // color: ColorsApp.whitecolor,
                                ),
                              )),
                              Container(
                                  width: kWidth / 2,
                                  margin: EdgeInsets.only(top: kMarginY / 2),
                                  child: Text(
                                    boutique.description,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: kDescription,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w500,
                                      color: ColorsApp.grey1,
                                    ),
                                  )),
                            ]),
                      ),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorsApp.greyN,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: ColorsApp.secondBlue,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: kMarginX * 1.5),
                              child: Text(
                                "${boutique.commandes} Commandes enregistres",
                                style: TextStyle(
                                    fontSize: kBasics,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    color: ColorsApp.secondBlue),
                              )),
                        ],
                      )),
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.delivery_dining,
                                  color: ColorsApp.secondBlue),
                              Container(
                                  margin: EdgeInsets.only(left: kMarginX * 1.5),
                                  child: Text(
                                    "${boutique.nombre_produit} produits",
                                    style: TextStyle(
                                        fontSize: kBasics,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w500,
                                        color: ColorsApp.secondBlue),
                                  )),
                            ]),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
