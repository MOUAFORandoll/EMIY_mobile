import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Form/text_field.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/components/Widget/productComponentAll.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    // Get.find<ProductController>().getPopularProduit();
    //  Get.find<CategoryController>().getCategory();
    return GetBuilder<ProductController>(builder: (prods) {
      return RefreshIndicator(
          color: ColorsApp.skyBlue,
          onRefresh: () async {
            print('****debut');
            await Get.find<CategoryController>().getCategory();
            print('****mid');

            await prods.getPopularProduit();
            print('****fin');
          },
          child: CustomScrollView(controller: _scrollController, slivers: [
            // Add the app bar to the CustomScrollView.
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              // Provide a standard title.
              // title: Text('title'),
              // Allows the user to reveal the app bar if they begin scrolling
              // back up the list of items.
              floating: true,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: Container(
                margin: EdgeInsets.only(top: Get.height * .030, left: 0),
                padding: EdgeInsets.only(
                    left: Get.width * .030, right: Get.width * .030),
                child: !prods.searchPro
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            BigtitleText(text: 'Home', bolder: true),
                            InkWell(
                                child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.red,
                                    )),
                                onTap: () {
                                  controllerField.text = '';
                                  prods.searchProButtom();
                                })
                          ])
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            KTextField(
                                controllerField: controllerField,
                                onChange: prods.searchProduit),
                            InkWell(
                                child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )),
                                onTap: () {
                                  controllerField.text = '';
                                  prods.searchProButtom();
                                })
                          ]),

                /*   onTap: () => filterDest() */
              ),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 60,
            ),

            SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                    // The builder function returns a ListTile with a title that
                    // displays the index of the current item.
                    (context, index) =>
                        GetBuilder<CategoryController>(builder: (categorys) {
                          return categorys.isLoaded == 0 || prods.isLoadedP == 0
                              ? Shimmer.fromColors(
                                  baseColor: Colors.blueGrey,
                                  highlightColor: Colors.greenAccent,
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: kMarginX),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          titleText(text: 'Categorie'),
                                          Container(
                                            height: kSmHeight,
                                            margin: EdgeInsets.symmetric(
                                                vertical: kMarginY * .2),
                                            child: ListView.builder(
                                              itemCount: 5,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (_ctx, index) =>
                                                  Container(
                                                      height: kSmHeight,
                                                      width: kSmWidth,
                                                      padding: EdgeInsets.all(
                                                          kMarginX),
                                                      margin: EdgeInsets.only(
                                                          right: kMarginX),
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // Container(
                                                            //   child: ClipRRect(
                                                            //     borderRadius: BorderRadius.only(
                                                            //         topRight: Radius.circular(10),
                                                            //         topLeft: Radius.circular(10)),
                                                            //     child: Image.asset('assets/om.png',
                                                            //         height: kSmHeight * .8,
                                                            //         width: Get.width * .5,
                                                            //         fit: BoxFit.cover),
                                                            //   ),
                                                            // ),
                                                            Container(
                                                              width:
                                                                  kSmWidth * .6,
                                                              margin: EdgeInsets.only(
                                                                  top:
                                                                      Get.height *
                                                                          .005,
                                                                  left:
                                                                      Get.width *
                                                                          .008),
                                                              child: Text('',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15)),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets.only(
                                                                    top: Get.height *
                                                                        .005,
                                                                    left: Get
                                                                            .width *
                                                                        .008),
                                                                child: Icon(
                                                                  Icons
                                                                      .no_backpack,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ])),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              titleText(text: 'Populaire(s)'),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: Get.height * .005,
                                                      left: Get.width * .008),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    // color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          Container(
                                              height: kMdHeight * .25,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: kMarginY * .2),
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 10,
                                                itemBuilder: (_ctx, index) =>
                                                    Container(
                                                        height: kMdHeight,
                                                        width: kMdWidth,
                                                        // padding: EdgeInsets.all(kMarginX),
                                                        margin: EdgeInsets.only(
                                                            right: kMarginX),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                ColorsApp.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child:
                                                            /* SingleChildScrollView(
              child: */
                                                            Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                              Stack(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        kMdHeight *
                                                                            .15,
                                                                    width:
                                                                        Get.width *
                                                                            .5,
                                                                  ),
                                                                  Positioned(
                                                                    top: 0,
                                                                    left:
                                                                        Get.height *
                                                                            .158,
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              6),
                                                                      decoration: BoxDecoration(
                                                                          gradient: GradientApp
                                                                              .blueG,
                                                                          borderRadius: BorderRadius.only(
                                                                              bottomLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10))),
                                                                      child: Icon(
                                                                          Icons
                                                                              .shopping_cart_outlined,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Container(
                                                                width:
                                                                    kSmWidth *
                                                                        .6,
                                                                margin: EdgeInsets.only(
                                                                    top: Get.height *
                                                                        .005,
                                                                    left: Get
                                                                            .width *
                                                                        .008),
                                                                child: Text('',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: ColorsApp
                                                                            .greenLight,
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                              Container(
                                                                width:
                                                                    kSmWidth *
                                                                        .6,
                                                                margin: EdgeInsets.only(
                                                                    top: Get.height *
                                                                        .005,
                                                                    left: Get
                                                                            .width *
                                                                        .008),
                                                                child: Text(
                                                                    'XAF ' +
                                                                        '10',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                              Container(
                                                                width:
                                                                    kSmWidth *
                                                                        .6,
                                                                margin: EdgeInsets.only(
                                                                    top: Get.height *
                                                                        .005,
                                                                    left: Get
                                                                            .width *
                                                                        .008),
                                                                child: Text(
                                                                    'XAF ' +
                                                                        '10',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        decoration: TextDecoration
                                                                            .lineThrough,
                                                                        decorationColor: Colors
                                                                            .black,
                                                                        decorationThickness:
                                                                            2.85,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                            ])),
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              titleText(text: 'All'),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: Get.height * .005,
                                                      left: Get.width * .008),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    // color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                              height: kMdHeight,
                                              child: Stack(
                                                children: [
                                                  GridView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  10.0,
                                                              mainAxisSpacing:
                                                                  50.0),
                                                      itemCount: 10,
                                                      itemBuilder:
                                                          (_ctx, index) =>
                                                              Container(
                                                                  height:
                                                                      kMdHeight /
                                                                          4,
                                                                  width:
                                                                      kMdWidth *
                                                                          1.1,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  // padding: EdgeInsets.all(kMarginX),
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              kMarginX),
                                                                  decoration: BoxDecoration(
                                                                      color: ColorsApp
                                                                          .greySecond,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                            height: kMdHeight *
                                                                                .15,
                                                                            width:
                                                                                Get.width * .5,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                              image: AssetImage('assets/logo.png'),
                                                                            ))),
                                                                        Container(
                                                                          width:
                                                                              kSmWidth * .6,
                                                                          margin: EdgeInsets.only(
                                                                              top: Get.height * .005,
                                                                              left: Get.width * .008),
                                                                          child: Text(
                                                                              'produit.titre',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: ColorsApp.black, fontSize: 12)),
                                                                        ),
                                                                        // Container(
                                                                        //   width:
                                                                        //       kSmWidth *
                                                                        //           .6,
                                                                        //   margin: EdgeInsets.only(
                                                                        //       top: Get.height *
                                                                        //           .005,
                                                                        //       left: Get
                                                                        //               .width *
                                                                        //           .008),
                                                                        //   child: Text(
                                                                        //       'XAF ' +
                                                                        //           '1000',
                                                                        //       overflow:
                                                                        //           TextOverflow
                                                                        //               .ellipsis,
                                                                        //       style: TextStyle(
                                                                        //           color: Colors
                                                                        //               .red,
                                                                        //           fontSize:
                                                                        //               12,
                                                                        //           fontWeight:
                                                                        //               FontWeight.bold)),
                                                                        // ),
                                                                      ]))),
                                                ],
                                              )),
                                        ],
                                      ))),
                                )
                              : !prods.searchPro
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: kMarginX),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          titleText(text: 'Categorie'),
                                          Container(
                                            height: kSmHeight,
                                            margin: EdgeInsets.symmetric(
                                                vertical: kMarginY * .2),
                                            child: ListView.builder(
                                              itemCount:
                                                  categorys.categoryList.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (_ctx, index) =>
                                                  CategoryComponent(
                                                category: categorys
                                                    .categoryList[index],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              titleText(text: 'Populaire(s)'),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: Get.height * .005,
                                                      left: Get.width * .008),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    // color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          Container(
                                            height: kMdHeight * .25,
                                            margin: EdgeInsets.symmetric(
                                                vertical: kMarginY * .2),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  prods.produitList.length,
                                              itemBuilder: (_ctx, index) =>
                                                  ProductComponent(
                                                      produit: prods
                                                          .produitList[index],
                                                      index: index),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              titleText(text: 'All'),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: Get.height * .005,
                                                      left: Get.width * .008),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    // color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                              height: kMdHeight * 1.2,
                                              child: Stack(
                                                children: [
                                                  StaggeredGridView
                                                      .countBuilder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    crossAxisCount: 4,
                                                    itemCount: prods
                                                        .produitList.length,
                                                    itemBuilder: (_ctx,
                                                            index) =>
                                                        ProductComponentAll(
                                                            produit: prods
                                                                    .produitList[
                                                                index],
                                                            index: index),
                                                    staggeredTileBuilder: (int
                                                            index) =>
                                                        new StaggeredTile.count(
                                                            2,
                                                            index.isEven
                                                                ? 3
                                                                : 2),
                                                    mainAxisSpacing: 2.0,
                                                    crossAxisSpacing: 4.0,
                                                  ),
                                                  //   GridView.builder(
                                                  //       physics:
                                                  //           NeverScrollableScrollPhysics(),
                                                  //       gridDelegate:
                                                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                                                  //               crossAxisCount: 2,
                                                  //               crossAxisSpacing:
                                                  //                   10.0,
                                                  //               mainAxisSpacing:
                                                  //                   50.0),
                                                  //       itemCount:
                                                  //           prods.produitList.length,
                                                  //       itemBuilder: (_ctx, index) =>
                                                  //           ProductComponentAll(
                                                  //               produit:
                                                  //                   prods.produitList[
                                                  //                       index],
                                                  //               index: index)),
                                                ],
                                              )),
                                        ],
                                      )),
                                    )
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: kMarginX),
                                      child: SingleChildScrollView(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: kMarginX),
                                                  child: titleText(
                                                    text: 'Result',
                                                  )),
                                              //   Container(
                                              //       margin: EdgeInsets.only(
                                              //           top: Get.height * .005,
                                              //           left: Get.width * .008),
                                              //       child: Icon(
                                              //         Icons
                                              //             .arrow_forward_ios_outlined,
                                              //         // color: Colors.white,
                                              //       )),
                                            ],
                                          ),
                                          SizedBox(
                                              height: kMdHeight,
                                              child: Stack(
                                                children: [
                                                  GridView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  10.0,
                                                              mainAxisSpacing:
                                                                  50.0),
                                                      itemCount: prods
                                                          .produitList.length,
                                                      itemBuilder: (_ctx,
                                                              index) =>
                                                          ProductComponentAll(
                                                              produit: prods
                                                                      .produitList[
                                                                  index],
                                                              index: index)),
                                                ],
                                              )),
                                        ],
                                      )),
                                    );
                        }),
                    childCount: 1))
          ]));
    });
  }
}
