import 'package:EMIY/components/Button/ShareButton.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/produitForBoutiqueLinkComponent.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/linkController.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BoutiqueViewForLink extends StatelessWidget {
  BoutiqueViewForLink({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LinkController>(
        builder: (manageLink) => Scaffold(
              body: manageLink.isLoaded != 1
                  ? AppLoading()
                  : SafeArea(
                      child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
//  backgroundColor: ColorsApp.greySecond,
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
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Icon(
                                        Icons.amp_stories,
                                        color: Colors.red,
                                      )),
                                  onTap: () {
                                    Get.find<ShortController>()
                                        .getListForYouShort();

                                    Get.toNamed(AppLinks.SHORT);
                                  })
                            ],
                          )),
                          flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  height: kMdHeight * .30,
                                  width: kWidth,
                                  fit: BoxFit.cover,
                                  imageUrl: manageLink.boutique.images![0]!.src
                                      .toString(),
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
                                Positioned(
                                  top: kMdHeight * .30 / 2.7,
                                  // bottom: kMdHeight * .30 / 2.4,
                                  left: kWidth / 2.2,
                                  right: kWidth / 2.2,
                                  child: InkWell(
                                      child: Container(
                                          // margin: EdgeInsets.only(right: 10),
                                          // padding: EdgeInsets.all(kMarginX / 3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorsApp.white,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Icon(
                                            manageLink.boutique
                                                        .status_abonnement ==
                                                    'true'
                                                ? Icons.remove
                                                : Icons.add,
                                            color: Colors.red,
                                          )),
                                      onTap: () async {
                                        print('---------------------');
                                        await Get.find<BoutiqueController>()
                                            .abonnementAdd(manageLink
                                                .boutique.codeBoutique);
                                      }),
                                )
                              ],
                            ),
                          )),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(35),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30))),
                              child: Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          manageLink
                                                              .boutique.titre
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 2,
                                                                    bottom: 3),
                                                            height: 3,
                                                            width:
                                                                kMdWidth * .5,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // gradient: GradientApp.blueG,
                                                                    color: ColorsApp
                                                                        .skyBlue,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                            child: Container()),
                                                      ],
                                                    ),
                                                    // RatingBar(
                                                    //   initialRating:
                                                    //       double.parse(
                                                    //     manageLink.boutique.note
                                                    //         .toString(),
                                                    //   ),
                                                    //   filledIcon: Icons.star,
                                                    //   emptyIcon:
                                                    //       Icons.star_border,
                                                    //   halfFilledIcon:
                                                    //       Icons.star_half,
                                                    //   isHalfAllowed: true,
                                                    //   filledColor:
                                                    //       Colors.yellow,
                                                    //   emptyColor: Colors.yellow,
                                                    //   halfFilledColor:
                                                    //       Colors.yellow,
                                                    //   size: 19,
                                                    //   onRatingChanged:
                                                    //       (double rating) {
                                                    //     //print(rating);
                                                    //     //print(Get.parameters['codeBoutique']
                                                    //     // .toString());
                                                    //     Get.find<
                                                    //             GeneralController>()
                                                    //         .notationBoutique(
                                                    //       rating,
                                                    //       manageLink.boutique
                                                    //           .codeBoutique,
                                                    //     );
                                                    //   },
                                                    // )
                                                  ]),
                                              onTap: () {})
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Text(
                                              //   Get.parameters['description'].toString(),
                                              //   style: TextStyle(
                                              //     fontSize: 14,
                                              //     fontWeight: FontWeight.w600,
                                              //   ),
                                              // ),
                                              Text(
                                                'Situe a ' +
                                                    manageLink.boutique
                                                        .localisation!.ville
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ]),
                                        ShareButton(
                                          libelle:
                                              'Suivez ce lien pour consulter cette boutique  : ' +
                                                  manageLink
                                                      .boutique.lienBoutique
                                                      .toString(),
                                        )
                                      ],
                                    )
                                  ])),
                              padding: EdgeInsets.only(top: 5, bottom: 10).add(
                                  EdgeInsets.symmetric(horizontal: kMarginX)),
                              width: double.maxFinite,
                            ),
                          ),
                          expandedHeight: 250,
                          pinned: true,
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Container(
                                // height: double.maxFinite,
                                margin: EdgeInsets.symmetric(
                                    vertical: kMarginY * .2),
                                child: SingleChildScrollView(
                                    child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kMarginX),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20.0,
                                                childAspectRatio: 0.7,
                                                mainAxisSpacing: 20.0),
                                        itemCount: manageLink
                                            .boutique.produits!.length,
                                        itemBuilder: (_ctx, index) =>
                                            ProduitForBoutiqueLinkComponent(
                                              produit: manageLink
                                                  .boutique.produits![index],
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
            ));
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
                   baseColor: ColorsApp.grey,
                                            highlightColor: Colors.blueGrey,
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
