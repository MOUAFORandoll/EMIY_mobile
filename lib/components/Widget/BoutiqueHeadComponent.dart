import 'dart:ui';

import 'package:EMIY/Views/CategoryBoutique/ReadShortBoutiqueView.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../Text/SimpleText.dart';
import 'icon_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class BoutiqueHeadComponent extends StatelessWidget {
  BoutiqueHeadComponent(
      {this.status_abonnement,
      this.titre,
      this.description,
      this.note,
      this.ville,
      this.nombre_produit,
      this.lienBoutique});
  String? status_abonnement;
  String? titre;
  String? note;
  String? description;
  String? ville;
  String? nombre_produit;
  String? lienBoutique;

  Widget build(BuildContext context) {
    var abonnement = this.status_abonnement == 'true';
    return GetBuilder<BoutiqueController>(
      builder: (_Boutiquecontroller) => SliverAppBar(
        foregroundColor: ColorsApp.red,
        automaticallyImplyLeading: false,
        title: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Container(
                margin: EdgeInsets.zero,
                // padding: EdgeInsets.all(5),
                decoration: BoxDecoration(

                    // borderRadius: BorderRadius.circular(20),
                    ),
                child: Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 25.0),
              ),
              onTap: () {
                Get.back();
              },
            ),
            InkWell(
                child: Container(
                  // margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(kMarginX / 3),
                  height: 40,
                  width: 40,
                  // decoration: BoxDecoration(
                  // border: Border.all(color: Colors.blue, width: 2),
                  // borderRadius: BorderRadius.circular(30)),
                  child: SvgPicture.asset(
                    Assets.story_boutique,
                    width: 90,
                    height: 90,
                    // color: ColorsApp.skyBlue,
                  ),
                ),
                onTap: () {
                  // Get.find<ShortController>().getListShortForBoutique(
                  //     Get.parameters['codeBoutique']) ;

                  Get.to(ReadShortBoutiqueView(
                      codeBoutique: Get.parameters['codeBoutique']));
                })
          ],
        )),
        flexibleSpace: FlexibleSpaceBar(
            background: Container(
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(Get.parameters['image']
                        .toString()), // Remplacez par le chemin de votre image
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 15,
                      sigmaY: 15), // Ajustez le flou selon vos besoins
                  child: Container(
                    color: Colors.black.withOpacity(
                        0), // Vous pouvez ajuster la couleur de l'arrière-plan flou
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: kMarginX, vertical: kMarginY),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      // height: 165,
                      // width: kWidth * .78,

                      decoration: new BoxDecoration(
                          /*    borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffDDDDDD),
                              blurRadius: 0, // Soften the shaodw
                              spreadRadius: 0,
                              offset: Offset(-1.2, 1.8),
                            )
                          ] */
                          ),
                      padding: EdgeInsets.symmetric(
                          horizontal: kMarginX, vertical: kMarginY / 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                width: kHeight / 8,
                                height: kHeight / 8,
                                fit: BoxFit.cover,
                                imageUrl: Get.parameters['image'].toString(),
                                imageBuilder: (context, imageProvider) {
                                  return Container(
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
                                        image: AssetImage(
                                            'assets/logo/logoNew.png'),
                                      )));
                                },
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: kMarginX * 1.5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SimpleText(
                                        text: titre!,
                                        bolder: true,
                                        color: ColorsApp.white,
                                      ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color: ColorsApp.grey,
                                      //   ),
                                      //   // height: .3,
                                      //   margin: EdgeInsets.symmetric(
                                      //       vertical: kMarginY / 2),
                                      // ),
                                      InfoComponent(
                                        icon: SvgIcon(
                                          icon: Assets.location,
                                        ),
                                        text: ville,
                                      ),
                                      InfoComponent(
                                        icon: SvgIcon(
                                          icon: Assets.nmreproduit,
                                        ),
                                        text: nombre_produit! +
                                            ' produits a son actif',
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: kMarginY),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  abonnement
                                      ? InkWell(
                                          child: Container(
                                              width: kWidth * .43,
                                              padding: EdgeInsets.all(8).add(
                                                  EdgeInsets.only(right: 10)),
                                              decoration: BoxDecoration(
                                                  color: ColorsApp.red,
                                                  border: Border.all(
                                                      color: ColorsApp.red),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: SvgIcon(
                                                        color: ColorsApp.white,
                                                        icon: Assets.hand,
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: kMarginX),
                                                        child: Text(
                                                          'Ne plus suivre',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              // fontSize:
                                                              //     kDescription,
                                                              fontFamily:
                                                                  'Lato',
                                                              color: ColorsApp
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )),
                                                  ])),
                                          onTap: () async {
                                            abonnement = !abonnement;
                                            print('---------------------');
                                            await _Boutiquecontroller
                                                .abonnementAdd(Get.parameters[
                                                    'codeBoutique']);
                                          })
                                      : InkWell(
                                          child: Container(
                                              padding: EdgeInsets.all(8).add(
                                                  EdgeInsets.only(right: 10)),
                                              width: kWidth * .43,
                                              decoration: BoxDecoration(
                                                  color: ColorsApp.white,
                                                  border: Border.all(
                                                      color: ColorsApp.white),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child:
                                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                Container(
                                                  child: SvgIcon(
                                                    icon: Assets.hand,
                                                    color:
                                                        ColorsApp.primaryBlue,
                                                  ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: kMarginX * 1.5),
                                                    child: Text(
                                                      'Suivre',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          // fontSize:
                                                          //     kDescription,
                                                          fontFamily: 'Lato',
                                                          color: ColorsApp
                                                              .primaryBlue,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                              ])),
                                          onTap: () async {
                                            abonnement = !abonnement;
                                            print('---------------------');
                                            await _Boutiquecontroller
                                                .abonnementAdd(Get.parameters[
                                                    'codeBoutique']);
                                          }),
                                  InkWell(
                                      onTap: () => Share.share(
                                          'Suivez ce lien pour consulter cette boutique  : ' +
                                              lienBoutique.toString(),
                                          subject: 'Look what I made!'),
                                      child: Container(
                                        width: kWidth * .43,
                                        padding: EdgeInsets.all(8)
                                            .add(EdgeInsets.only(right: 10)),
                                        decoration: BoxDecoration(
                                            color: ColorsApp.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.share_sharp,
                                                  color: ColorsApp.primaryBlue,
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: kMarginX * 1.5),
                                                  child: Text(
                                                    'Partager',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: kDescription,
                                                        fontFamily: 'Lato',
                                                        color: ColorsApp
                                                            .primaryBlue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                            ]),
                                      )),
                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.all(5)
                                .add(EdgeInsets.only(right: 10)),
                            decoration: BoxDecoration(
                                color: ColorsApp.secondBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  itemSize: 20.0,
                                  initialRating: double.parse(
                                    note!,
                                  ),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    Get.find<GeneralController>()
                                        .notationBoutique(
                                      rating,
                                      Get.parameters['codeBoutique'].toString(),
                                    );
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: kMarginX),
                                    child: Text(
                                      note!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          // fontSize: kDescription,
                                          fontFamily: 'Lato',
                                          color: ColorsApp.white,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: kMarginY),
                              child: Text(
                                description!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: kDescription,
                                  fontFamily: 'Lato',
                                  color: ColorsApp.grey,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
        expandedHeight: 310,
        pinned: true,
      ),
    );
  }
}

// ignore: must_be_immutable
class InfoComponent extends StatelessWidget {
  InfoComponent({
    this.icon,
    this.text,
  });
  var icon;
  var text;
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      margin: EdgeInsets.symmetric(vertical: kMarginY / 2),

      child: Row(children: [
        Container(
          // margin: EdgeInsets.symmetric(vertical: kMarginY),
          child: icon,
        ),
        Container(
            width: kWidth * .4,
            margin: EdgeInsets.symmetric(horizontal: kMarginX),
            child: Text(
              text!,
              maxLines: 2,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: kDescription,
                fontFamily: 'Lato',
                color: ColorsApp.white,
              ),
            )),
      ]),
    );
  }
}
