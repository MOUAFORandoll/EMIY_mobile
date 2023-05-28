import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/ShortController.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Text/bigtitleText0.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/components/Widget/productForBoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/productForCatComponent.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/controller/categoryBoutiqueController.dart';
import 'package:Fahkap/controller/productController.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../components/Widget/app_empty.dart';

class BoutiqueView extends StatelessWidget {
  BoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    //print(Get.parameters);

    Get.find<CategoryBoutiqueController>()
        .getDataForBoutique(Get.parameters['codeBoutique']);
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
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
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.amp_stories,
                          color: Colors.red,
                        )),
                    onTap: () {
                      Get.find<ShortController>().getListShort();

                      Get.toNamed(AppLinks.SHORT);
                    })
              ],
            )),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              decoration: BoxDecoration(
                gradient: GradientApp.blueG,
              ),
              child: CachedNetworkImage(
                height: kMdHeight * .30,
                width: kWidth,
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
                        image: AssetImage('assets/logo.png'),
                      )));
                },
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            Get.parameters['nomBoutique']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 2, bottom: 3),
                                              height: 3,
                                              width: kMdWidth * .5,
                                              decoration: BoxDecoration(
                                                  // gradient: GradientApp.blueG,
                                                  color: ColorsApp.skyBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Container()),
                                        ],
                                      ),
                                      RatingBar(
                                        initialRating: double.parse(
                                          Get.parameters['note'].toString(),
                                        ),
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                        halfFilledIcon: Icons.star_half,
                                        isHalfAllowed: true,
                                        filledColor: Colors.yellow,
                                        emptyColor: Colors.yellow,
                                        halfFilledColor: Colors.yellow,
                                        size: 19,
                                        onRatingChanged: (double rating) {
                                          //print(rating);
                                          //print(Get.parameters['codeBoutique']
                                          // .toString());
                                          Get.find<ActionController>()
                                              .notationBoutique(
                                            rating,
                                            Get.parameters['codeBoutique']
                                                .toString(),
                                          );
                                        },
                                      )
                                    ]),
                                onTap: () {})
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   Get.parameters['description'].toString(),
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            Text(
                              'Situe a ' + Get.parameters['ville'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ])
                    ])),
                padding: EdgeInsets.only(top: 5, bottom: 10)
                    .add(EdgeInsets.symmetric(horizontal: kMarginX)),
                width: double.maxFinite,
              ),
            ),
            expandedHeight: 250,
            pinned: true,
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              (context, index) => GetBuilder<CategoryBoutiqueController>(
                  builder: (_bscontroler) => _bscontroler.isLoadedPB == 0
                      ? AppLoading()
                      : Container(
                          // height: double.maxFinite,
                          margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                          child: _bscontroler.isLoadedPB == 1
                              ? (_bscontroler.produitBoutiqueList.length != 0)
                                  ? SingleChildScrollView(
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
                                              ProductForBoutiqueComponent(
                                                  produit: _bscontroler
                                                          .produitBoutiqueList[
                                                      index],
                                                  index: index)))
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
      //                                           AssetImage('assets/logo.png'),
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
      //                                 //           fontWeight: FontWeight.bold)),
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
      //                                 ProductForBoutiqueComponent(
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
                                                AssetImage('assets/logo.png'),
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
                                      //           fontWeight: FontWeight.bold)),
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
                                      ProductForBoutiqueComponent(
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