import 'package:Fahkap/components/Form/home_search_field.dart';
import 'package:Fahkap/components/Form/search_field.dart';
import 'package:Fahkap/components/Widget/BoutiqueComponentHomeN.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/controller/ShortController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/Views/Home/SearchView.dart';
import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/BoutiqueComponentHome.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/components/Widget/productComponentAll.dart';
import 'package:Fahkap/controller/categoryBoutiqueController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/controller/productController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/Button/app_button.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    return GetBuilder<ProductController>(builder: (prods) {
      return RefreshIndicator(
          color: ColorsApp.skyBlue,
          onRefresh: () async {
            print('****debut');
            await Get.find<CategoryBoutiqueController>().getCategory();
            await Get.find<CategoryBoutiqueController>().getListBoutiques();

            await Get.find<CommandeController>().getListCommandes();
            await Get.find<ManagerController>().getKeyU();
            await Get.find<ManagerController>().getLocalU();
            await Get.find<ManagerController>().getUser();
            await Get.find<ShortController>().getListShort();

            await prods.getPopularProduit();
          },
          child: CustomScrollView(
              controller: Get.find<ActionController>().scrollcontroller,
              slivers: [
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: AppTitleRight(
                                  title: 'Hi Boy!',
                                  description: 'Welcome dear',
                                  icon: Assets.home),
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * .005),
                            ),
                            InkWell(
                                child: Container(
                                    // margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(kMarginX / 3),
                                    // margin: EdgeInsets.only(right: kMarginX),
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
                                  Get.find<ShortController>().getListShort();

                                  Get.toNamed(AppLinks.SHORT);
                                })
                          ])

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
                  (context, index) => GetBuilder<CategoryBoutiqueController>(
                      builder: (categorys) {
                    return categorys.isLoadedCat == 0 || prods.isLoadedP == 0
                        ? Shimmer.fromColors(
                            baseColor: Colors.blueGrey,
                            highlightColor: Colors.greenAccent,
                            child: Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: kMarginX),
                                child: SingleChildScrollView(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(text: 'Categorie'),
                                    Container(
                                      height: kSmHeight,
                                      margin: EdgeInsets.symmetric(
                                          vertical: kMarginY * .2),
                                      child: ListView.builder(
                                        itemCount: 5,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_ctx, index) => Container(
                                            height: kSmHeight,
                                            width: kSmWidth,
                                            padding: EdgeInsets.all(kMarginX),
                                            margin: EdgeInsets.only(
                                                right: kMarginX),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    width: kSmWidth * .6,
                                                    margin: EdgeInsets.only(
                                                        top: Get.height * .005,
                                                        left: Get.width * .008),
                                                    child: Text('',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15)),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top:
                                                              Get.height * .005,
                                                          left:
                                                              Get.width * .008),
                                                      child: Icon(
                                                        Icons.no_backpack,
                                                        color: Colors.white,
                                                      )),
                                                ])),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        titleText(
                                            text: 'Boutique Populaire(s)'),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: Get.height * .005,
                                                left: Get.width * .008),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
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
                                          itemCount: 10,
                                          itemBuilder: (_ctx, index) =>
                                              Container(
                                                  height: kMdHeight,
                                                  width: kMdWidth,
                                                  // padding: EdgeInsets.all(kMarginX),
                                                  margin: EdgeInsets.only(
                                                      right: kMarginX),
                                                  decoration: BoxDecoration(
                                                      color: ColorsApp.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                              width: Get.width *
                                                                  .5,
                                                            ),
                                                            Positioned(
                                                              top: 0,
                                                              left: Get.height *
                                                                  .158,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(6),
                                                                decoration: BoxDecoration(
                                                                    gradient:
                                                                        GradientApp
                                                                            .blueG,
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(10))),
                                                                child: Icon(
                                                                    Icons
                                                                        .shopping_cart_outlined,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Container(
                                                          width: kSmWidth * .6,
                                                          margin: EdgeInsets.only(
                                                              top: Get.height *
                                                                  .005,
                                                              left: Get.width *
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
                                                          width: kSmWidth * .6,
                                                          margin: EdgeInsets.only(
                                                              top: Get.height *
                                                                  .005,
                                                              left: Get.width *
                                                                  .008),
                                                          child: Text(
                                                              'XAF ' + '10',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        Container(
                                                          width: kSmWidth * .6,
                                                          margin: EdgeInsets.only(
                                                              top: Get.height *
                                                                  .005,
                                                              left: Get.width *
                                                                  .008),
                                                          child: Text(
                                                              'XAF ' + '10',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  decorationColor:
                                                                      Colors
                                                                          .black,
                                                                  decorationThickness:
                                                                      2.85,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ])),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        titleText(text: 'Best Selling'),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: Get.height * .005,
                                                left: Get.width * .008),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
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
                                                        crossAxisSpacing: 10.0,
                                                        mainAxisSpacing: 50.0),
                                                itemCount: 10,
                                                itemBuilder: (_ctx, index) =>
                                                    Container(
                                                        height: kMdHeight / 4,
                                                        width: kMdWidth * 1.1,
                                                        alignment:
                                                            Alignment.center,
                                                        // padding: EdgeInsets.all(kMarginX),
                                                        margin: EdgeInsets.only(
                                                            right: kMarginX),
                                                        decoration: BoxDecoration(
                                                            color: ColorsApp
                                                                .greySecond,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                  height:
                                                                      kMdHeight *
                                                                          .15,
                                                                  width:
                                                                      Get.width *
                                                                          .5,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/logo.png'),
                                                                  ))),
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
                                                                    'produit.titre',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: ColorsApp
                                                                            .black,
                                                                        fontSize:
                                                                            12)),
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
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: kMarginX),
                            child: SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KHomeSearchField(
                                  controllerField: controllerField,
                                  prefix: null,
                                ),
                                Container(
                                  height: kSmHeight / 1.2,
                                  margin:
                                      EdgeInsets.symmetric(vertical: kMarginY),
                                  child: ListView.builder(
                                    itemCount: categorys.categoryList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_ctx, index) =>
                                        CategoryComponent(
                                      category: categorys.categoryList[index],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: kMdHeight / 6,
                                  child: CarouselSlider.builder(
                                    itemCount: categorys.ListBoutiqueF.length,
                                    itemBuilder: (_ctx, i, index) =>
                                        BoutiqueComponentHomeN(
                                      boutique: categorys.ListBoutiqueF[index],
                                    ),
                                    options: CarouselOptions(
                                      aspectRatio: 4 / 4,

                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.scale,
                                      initialPage: 0,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      onPageChanged: (index, reason) {
                                        categorys.setCurrent(index);
                                      },

                                      disableCenter: true,
                                      height: Get.height,
                                      // enlargeCenterPage: true,
                                      // autoPlay: true,

                                      // autoPlayCurve: Curves.fastOutSlowIn,
                                      // enableInfiniteScroll: true,
                                      viewportFraction: 1.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 2.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: ['0', '1', '2']
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                          child: Container(
                                        width: 6.0,
                                        height: 6.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: (ColorsApp.greenLight)
                                                .withOpacity(categorys.indexB ==
                                                        entry.key
                                                    ? 1
                                                    : 0.2)),
                                      ));
                                    }).toList(),
                                  ),
                                ),
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    // Ratio largeur/hauteur pour chaque élément

                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20.0,
                                            childAspectRatio: kMarginX / 12,
                                            mainAxisSpacing: 10.0),
                                    itemCount: prods.produitList.length,
                                    itemBuilder: (_ctx, index) =>
                                        // Créez un widget ProductComponentAll pour chaque produit dans la liste
                                        ProductComponentAll(
                                          produit: prods.produitList[index],
                                          index: index,
                                        )),
                              ],
                            )),
                          );
                  }),
                  childCount: 1,
                ))
              ]));
    });
  }
}
