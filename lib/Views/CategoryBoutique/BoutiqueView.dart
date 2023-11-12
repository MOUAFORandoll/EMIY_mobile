import 'package:EMIY/Views/CategoryBoutique/ReadShortBoutiqueView.dart';
import 'package:EMIY/components/Button/ShareButton.dart';
import 'package:EMIY/components/Widget/BoutiqueHeadComponent.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/theme.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/components/Widget/produitForBoutiqueComponent.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe

import '../../components/Widget/app_empty.dart';

class BoutiqueView extends StatelessWidget {
  BoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    print(Get.parameters);
    print(Get.parameters['status_abonnement']);
    var status_abonnement = Get.parameters['status_abonnement'];

    Get.find<CategoryBoutiqueController>()
        .getDataForBoutique(Get.parameters['codeBoutique']);
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          BoutiqueHeadComponent(
              titre: Get.parameters['nomBoutique'],
              description: Get.parameters['description'],
              ville: Get.parameters['ville'],
              note: Get.parameters['note'],
              nombre_produit: Get.parameters['nombre_produit'] ?? '0',
              lienBoutique: Get.parameters['lienBoutique'],
              status_abonnement: Get.parameters['status_abonnement']),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => GetBuilder<CategoryBoutiqueController>(
                  builder: (_bscontroler) => _bscontroler.isLoadedPB == 0
                      ? Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.symmetric(
                              vertical: kMarginY * 2, horizontal: kMarginX),
                          child: ShimmerProduit())
                      : Container(
                          // height: double.maxFinite,
                          margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                          child: _bscontroler.isLoadedPB == 1
                              ? (_bscontroler.produitBoutiqueList.length != 0)
                                  ? Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                vertical: kMarginY * 2,
                                                horizontal: kMarginX * 5),
                                            padding: EdgeInsets.symmetric(
                                              vertical: kMarginY,
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                              color: ColorsApp.grey,
                                            ))),
                                            child: Text(
                                              'Produits Disponibles',
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  TexteStyle().blargeTextStyle,
                                            )),
                                        SingleChildScrollView(
                                            child: GridView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: kMarginX),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 20.0,
                                                        childAspectRatio: 0.7,
                                                        mainAxisSpacing: 20.0),
                                                itemCount: _bscontroler
                                                    .produitBoutiqueList.length,
                                                itemBuilder: (_ctx, index) =>
                                                    ProduitForBoutiqueComponent(
                                                        produit: _bscontroler
                                                                .produitBoutiqueList[
                                                            index],
                                                        index: index)))
                                      ],
                                    )
                                  : Container(
                                      height: kHeight,
                                      child: AppEmpty(title: 'Aucun Produit'))
                              : Container(
                                  height: kMdHeight * .6,
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Text('Error'),
                                  )))),
              childCount: 1,
            ),
          ),
        ],
      )),

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: InkWell(
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: ColorsApp.black,
      //     ),
      //     onTap: () {
      //       Get.back();
      //     },
      //   ),
      //   title: BigtitleText0(
      //       text: Get.parameters['nomBoutique'].toString(), bolder: true),
      // ),
      // body: RefreshIndicator(
      //     color: ColorsApp.skyBlue,
      //     onRefresh: () async {
      //       Get.find<CategoryBoutiqueController>()
      //           .getDataForBoutique(Get.parameters['codeBoutique']);
      //     },
      //     child: GetBuilder<CategoryBoutiqueController>(
      //         builder: (_bscontroler) => _bscontroler.isLoadedPB == 0
      //             ? Shimmer.fromColors(
      //                 baseColor: Colors.blueGrey,
      //                 highlightColor: Colors.greenAccent,
      //                 child: SizedBox(
      //                   height: kMdHeight,
      //                   child: Stack(
      //                     children: [
      //                       GridView.builder(
      //                         padding: const EdgeInsets.all(20),
      //                         gridDelegate:
      //                             SliverGridDelegateWithFixedCrossAxisCount(
      //                                 crossAxisCount: 2,
      //                                 crossAxisSpacing: 20.0,
      //                                 mainAxisSpacing: 50.0),
      //                         itemCount: 10,
      //                         itemBuilder: (_ctx, index) => Container(
      //                           height: kMdHeight * 2,
      //                           width: kMdWidth * 1.1,
      //                           margin: EdgeInsets.only(right: kMarginX),
      //                           decoration: BoxDecoration(
      //                               color: ColorsApp.greySecond,
      //                               borderRadius: BorderRadius.circular(8)),
      //                           child: Column(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceEvenly,
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.center,
      //                               children: [
      //                                 Container(
      //                                     height: kMdHeight * .115,
      //                                     width: Get.width * .5,
      //                                     decoration: BoxDecoration(
      //                                         image: DecorationImage(
      //                                       image:
      //                                           AssetImage('assets/logo/logoNew.png'),
      //                                     ))),
      //                                 Container(
      //                                   width: kSmWidth * .6,
      //                                   margin: EdgeInsets.only(
      //                                       top: Get.height * .005,
      //                                       left: Get.width * .008),
      //                                   child: Text('produit.titre',
      //                                       overflow: TextOverflow.ellipsis,
      //                                       style: TextStyle(
      //                                           color: ColorsApp.black,
      //                                           fontSize: 12)),
      //                                 ),
      //                                 // Container(
      //                                 //   width: kSmWidth * .6,
      //                                 //   margin: EdgeInsets.only(
      //                                 //       top: Get.height * .005,
      //                                 //       left: Get.width * .008),
      //                                 //   child: Text('XAF ' + '1000',
      //                                 //       overflow: TextOverflow.ellipsis,
      //                                 //       style: TextStyle(
      //                                 //           color: Colors.red,
      //                                 //           fontSize: 12,
      //                                 //           fontWeight: FontWeight.w600)),
      //                                 // ),
      //                               ]),
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ))
      //             : _bscontroler.isLoadedPB == 1
      //                 ? (_bscontroler.produitBoutiqueList.length != 0)
      //                     ? SingleChildScrollView(
      //                         child: GridView.builder(
      //                             physics: NeverScrollableScrollPhysics(),
      //                             shrinkWrap: true,
      //                             padding: const EdgeInsets.all(20),
      //                             gridDelegate:
      //                                 SliverGridDelegateWithFixedCrossAxisCount(
      //                                     crossAxisCount: 2,
      //                                     crossAxisSpacing: 10.0,
      //                                     mainAxisSpacing: 10.0),
      //                             itemCount:
      //                                 _bscontroler.produitBoutiqueList.length,
      //                             itemBuilder: (_ctx, index) =>
      //                                 ProduitForBoutiqueComponent(
      //                                     produit: _bscontroler
      //                                         .produitBoutiqueList[index],
      //                                     index: index)),
      //                       )
      //                     : Container(
      //                         height: kMdHeight * .6,
      //                         alignment: Alignment.center,
      //                         child: Center(
      //                           child: Text('Aucun Produit'),
      //                         ))
      //                 : Container(
      //                     height: kMdHeight * .6,
      //                     alignment: Alignment.center,
      //                     child: Center(
      //                       child: Text('Error'),
      //                     )))),

      // Builds 1000 ListTiles
    );
  }
}

/**
 * 
class BoutiqueView extends StatelessWidget {
  BoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    //print(Get.parameters);

    Get.find<CategoryBoutiqueController>()
        .getDataForBoutique(Get.parameters['codeBoutique']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorsApp.black,
          ),
          onTap: () {
            Get.back();
          },
        ),
        title: BigtitleText0(
            text: Get.parameters['nomBoutique'].toString(), bolder: true),
      ),
      body: RefreshIndicator(
          color: ColorsApp.skyBlue,
          onRefresh: () async {
            Get.find<CategoryBoutiqueController>()
                .getDataForBoutique(Get.parameters['codeBoutique']);
          },
          child: GetBuilder<CategoryBoutiqueController>(
              builder: (_bscontroler) => _bscontroler.isLoadedPB == 0
                  ? Shimmer.fromColors(
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.greenAccent,
                      child: SizedBox(
                        height: kMdHeight,
                        child: Stack(
                          children: [
                            GridView.builder(
                              padding: const EdgeInsets.all(20),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20.0,
                                      mainAxisSpacing: 50.0),
                              itemCount: 10,
                              itemBuilder: (_ctx, index) => Container(
                                height: kMdHeight * 2,
                                width: kMdWidth * 1.1,
                                margin: EdgeInsets.only(right: kMarginX),
                                decoration: BoxDecoration(
                                    color: ColorsApp.greySecond,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: kMdHeight * .115,
                                          width: Get.width * .5,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image:
                                                AssetImage('assets/logo/logoNew.png'),
                                          ))),
                                      Container(
                                        width: kSmWidth * .6,
                                        margin: EdgeInsets.only(
                                            top: Get.height * .005,
                                            left: Get.width * .008),
                                        child: Text('produit.titre',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: ColorsApp.black,
                                                fontSize: 12)),
                                      ),
                                      // Container(
                                      //   width: kSmWidth * .6,
                                      //   margin: EdgeInsets.only(
                                      //       top: Get.height * .005,
                                      //       left: Get.width * .008),
                                      //   child: Text('XAF ' + '1000',
                                      //       overflow: TextOverflow.ellipsis,
                                      //       style: TextStyle(
                                      //           color: Colors.red,
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.w600)),
                                      // ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ))
                  : _bscontroler.isLoadedPB == 1
                      ? (_bscontroler.produitBoutiqueList.length != 0)
                          ? SingleChildScrollView(
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(20),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0),
                                  itemCount:
                                      _bscontroler.produitBoutiqueList.length,
                                  itemBuilder: (_ctx, index) =>
                                      ProduitForBoutiqueComponent(
                                          produit: _bscontroler
                                              .produitBoutiqueList[index],
                                          index: index)),
                            )
                          : Container(
                              height: kMdHeight * .6,
                              alignment: Alignment.center,
                              child: Center(
                                child: Text('Aucun Produit'),
                              ))
                      : Container(
                          height: kMdHeight * .6,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text('Error'),
                          )))),

      // Builds 1000 ListTiles
    );
  }
}

 */
