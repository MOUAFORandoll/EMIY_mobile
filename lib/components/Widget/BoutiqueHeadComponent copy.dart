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
      builder: (_Boutiquecontroller) =>   SliverAppBar(
            backgroundColor: ColorsApp.greySecond,
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
                  CachedNetworkImage(
                    width: kWidth,
                    fit: BoxFit.cover,
                    imageUrl: Get.parameters['image'].toString(),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          color: ColorsApp.greySecond,
                          // borderRadius: BorderRadius.circular(8),
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
                  ), Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 165,
              // width: kWidth * .78,

              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: ColorsApp.grey,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 0, // Soften the shaodw
                      spreadRadius: 0,
                      offset: Offset(-1.2, 1.8),
                    )
                  ]),
              padding: EdgeInsets.symmetric(
                  horizontal: kMarginX, vertical: kMarginY),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      text: titre!,
                      bolder: true,
                    ),
                    Container(
                        child: Text(
                      description!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: kDescription,
                        fontFamily: 'Lato',
                        color: ColorsApp.grey,
                      ),
                    )),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsApp.grey,
                      ),
                      height: .3,
                      margin: EdgeInsets.symmetric(vertical: kMarginY),
                    ),
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
                      text: nombre_produit! + ' produits a son actif',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: kMarginY),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            abonnement
                                ? InkWell(
                                    child: Container(
                                        padding: EdgeInsets.all(8)
                                            .add(EdgeInsets.only(right: 10)),
                                        decoration: BoxDecoration(
                                            color: ColorsApp.red,
                                            border: Border.all(
                                                color: ColorsApp.red),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Row(children: [
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
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: kDescription,
                                                    fontFamily: 'Lato',
                                                    color: ColorsApp.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                        ])),
                                    onTap: () async {
                                      abonnement = !abonnement;
                                      print('---------------------');
                                      await _Boutiquecontroller.abonnementAdd(
                                          Get.parameters['codeBoutique']);
                                    })
                                : InkWell(
                                    child: Container(
                                        padding: EdgeInsets.all(8)
                                            .add(EdgeInsets.only(right: 10)),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorsApp.secondBlue),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Row(children: [
                                          Container(
                                            child: SvgIcon(
                                              icon: Assets.hand,
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: kMarginX * 4.5),
                                              child: Text(
                                                'Suivre',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: kDescription,
                                                    fontFamily: 'Lato',
                                                    color: ColorsApp.secondBlue,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                        ])),
                                    onTap: () async {
                                      abonnement = !abonnement;
                                      print('---------------------');
                                      await _Boutiquecontroller.abonnementAdd(
                                          Get.parameters['codeBoutique']);
                                    }),
                            InkWell(
                                onTap: () => Share.share(
                                    'Suivez ce lien pour consulter cette boutique  : ' +
                                        lienBoutique.toString(),
                                    subject: 'Look what I made!'),
                                child: Container(
                                  padding: EdgeInsets.all(8)
                                      .add(EdgeInsets.only(right: 10)),
                                  decoration: BoxDecoration(
                                      color: ColorsApp.secondBlue,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(children: [
                                    Container(
                                      child: Icon(
                                        Icons.share,
                                        color: ColorsApp.white,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: kMarginX * 4.5),
                                        child: Text(
                                          'Partager',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: kDescription,
                                              fontFamily: 'Lato',
                                              color: ColorsApp.white,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ]),
                                )),
                          ]),
                    ),
                  ]),
            ),
            Positioned(
                top: 30,
                left: kWidth / 4.5,
                right: kWidth / 4.5,
                child: Container(
                  padding: EdgeInsets.all(5).add(EdgeInsets.only(right: 10)),
                  decoration: BoxDecoration(
                      color: ColorsApp.secondBlue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
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
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          Get.find<GeneralController>().notationBoutique(
                            rating,
                            Get.parameters['codeBoutique'].toString(),
                          );
                        },
                      ),
                      // RatingBar(
                      //   initialRating: double.parse(
                      //     note!,
                      //   ),
                      //   filledIcon: Icons.star,
                      //   emptyIcon: Icons.star_border,
                      //   halfFilledIcon: Icons.star_half,
                      //   isHalfAllowed: true,
                      //   filledColor: Colors.yellow,
                      //   emptyColor: Colors.yellow,
                      //   halfFilledColor: Colors.yellow,
                      //   size: 19,
                      //   onRatingChanged: (double rating) {
                      //     //print(rating);
                      //     //print(Get.parameters['codeBoutique']
                      //     // .toString());
                      //     Get.find<GeneralController>().notationBoutique(
                      //       rating,
                      //       Get.parameters['codeBoutique'].toString(),
                      //     );
                      //   },
                      // ),
                      Container(
                          margin: EdgeInsets.only(left: kMarginX),
                          child: Text(
                            note!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kDescription,
                                fontFamily: 'Lato',
                                color: ColorsApp.white,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ))
          ],
        ),
      )  ],
              ),
            )),
            expandedHeight: 250,
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
      child: Row(children: [
        Container(
          // margin: EdgeInsets.symmetric(vertical: kMarginY),
          child: icon,
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: kMarginX),
            child: Text(
              text!,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: kDescription,
                fontFamily: 'Lato',
                color: ColorsApp.grey,
              ),
            )),
      ]),
    );
  }
}
