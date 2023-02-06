import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText0.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/components/Widget/productForBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/productForCatComponent.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/categoryBoutiqueController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BoutiqueView extends StatelessWidget {
  BoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    print(Get.parameters);

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
                // BigtitleText0(
                //     text: Get.parameters['nomBoutique'].toString(),
                //     bolder: true),
                Container(
                  margin: EdgeInsets.only(right: kMdWidth * .2),
                ),
              ],
            )),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: GradientApp.blueG,
                ),
                child: CachedNetworkImage(
                  height: kMdHeight * .30,
                  width: kSmWidth * 1.3,
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
              ),
            ),
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Get.parameters['nomBoutique'].toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 2, bottom: 3),
                                      height: 3,
                                      width: kMdWidth * .5,
                                      decoration: BoxDecoration(
                                          gradient: GradientApp.blueG,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Container())
                                ])
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Get.parameters['description'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                                                image: AssetImage(
                                                    'assets/logo.png'),
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
                                          padding: const EdgeInsets.all(20),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10.0,
                                                  mainAxisSpacing: 10.0),
                                          itemCount: _bscontroler
                                              .produitBoutiqueList.length,
                                          itemBuilder: (_ctx, index) =>
                                              ProductForBoutiqueComponent(
                                                  produit: _bscontroler
                                                          .produitBoutiqueList[
                                                      index],
                                                  index: index)))
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
    print(Get.parameters);

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