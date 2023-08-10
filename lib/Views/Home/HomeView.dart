import 'package:EMIY/components/Form/home_search_field.dart';
import 'package:EMIY/components/Form/search_field.dart';
import 'package:EMIY/components/Widget/BoutiqueComponentHomeN.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/icon_svg.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/productComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/productComponentAll.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/productController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/Button/app_button.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  ScrollController _scrollController = new ScrollController();
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController()..addListener(handleScrolling);
  }

  void handleScrolling() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      print('gin*************************');
    }
    if (_scrollController.offset + Get.height * 1.5 >=
        _scrollController.position.maxScrollExtent) {
      Get.find<ProductController>().getPopularProduit();
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state*************************");
    print(AppLifecycleState.resumed);
    if (state == AppLifecycleState.paused) {
      Get.find<ShortController>().disposePLayer();
      // Perform actions when the app is resumed
    }
    // You can also handle other lifecycle states if needed
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    return GetBuilder<GeneralController>(
        builder: (generalController) =>
            GetBuilder<ProductController>(builder: (prods) {
              return RefreshIndicator(
                  color: ColorsApp.skyBlue,
                  onRefresh: () async {
                    //print('****debut');
                    Get.find<GeneralController>().getHome();

                    await Get.find<CategoryBoutiqueController>().getCategory();
                    await Get.find<CategoryBoutiqueController>().getCategory();
                    // await Get.find<CategoryBoutiqueController>()
                    //     .getListBoutiques();

                    await Get.find<CommandeController>().getListCommandes();
                    await Get.find<ManagerController>().getKeyU();
                    await Get.find<ManagerController>().getLocalU();
                    await Get.find<ManagerController>().getUser();
                    await Get.find<ShortController>().getListShort();

                    // await prods.getPopularProduit();
                  },
                  child: CustomScrollView(
                      controller:
                          // _scrollController,
                          prods
                              .controllerT, // controller: Get.find<GeneralController>().scrollcontroller,
                      slivers: [
                        SliverAppBar(
                          // backgroundColor: Colors.white,
                          elevation: 0,
                          floating: true,
                          flexibleSpace: Container(
                              margin: EdgeInsets.only(
                                  top: Get.height * .030, left: 0),
                              padding: EdgeInsets.only(
                                  left: Get.width * .030,
                                  right: Get.width * .030),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: AppTitleRight(
                                                title: 'Hi Boy!',
                                                description: 'Welcome dear',
                                                icon: Assets.home),
                                            margin: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .005),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: Get.width * .030,
                                            ),
                                            child: AppTitleRight(
                                                title: 'Abonnement',
                                                description: 'Vos Abonnements',
                                                center: true,
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppLinks.ABONNEMENT);
                                                },
                                                icon: null),
                                          )
                                        ]),
                                    InkWell(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            padding:
                                                EdgeInsets.all(kMarginX / 3),
                                            // margin: EdgeInsets.only(right: kMarginX),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: SvgIcon(icon: Assets.bell)),
                                        onTap: () {
                                          Get.toNamed(AppLinks.NOTIFICATION);
                                        })
                                  ])),
                          expandedHeight: 60,
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              GetBuilder<CategoryBoutiqueController>(
                                  builder: (categorys) {
                            return generalController.isLoadedHome == 0
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
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                    .circular(
                                                                        8)),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                titleText(
                                                    text:
                                                        'Boutique Populaire(s)'),
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      kMarginX),
                                                          decoration: BoxDecoration(
                                                              color: ColorsApp
                                                                  .grey,
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
                                                                      left: Get
                                                                              .height *
                                                                          .158,
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(6),
                                                                        decoration: BoxDecoration(
                                                                            gradient:
                                                                                GradientApp.blueG,
                                                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
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
                                                                  child: Text(
                                                                      '',
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                titleText(text: 'Best Selling'),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: Get.height * .005,
                                                        left: Get.width * .008),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
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
                                                                crossAxisCount:
                                                                    2,
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
                                                                    margin: EdgeInsets.only(
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
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                              height: kMdHeight * .15,
                                                                              width: Get.width * .5,
                                                                              decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                                                                image: AssetImage('assets/logo/logo.png'),
                                                                              ))),
                                                                          Container(
                                                                            width:
                                                                                kSmWidth * .6,
                                                                            margin:
                                                                                EdgeInsets.only(top: Get.height * .005, left: Get.width * .008),
                                                                            child: Text('produit.titre',
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
                                        KHomeSearchField(
                                          controllerField: controllerField,
                                          prefix: null,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY * .7),
                                          child: Text("Categories",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: ColorsApp.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Container(
                                          height: kSmHeight * 1.3,
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY),
                                          child: ListView.builder(
                                            itemCount:
                                                categorys.categoryList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (_ctx, index) =>
                                                CategoryComponent(
                                              category:
                                                  categorys.categoryList[index],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // height: kMdHeight / 6,
                                          child: CarouselSlider.builder(
                                            itemCount:
                                                categorys.ListBoutiqueF.length,
                                            itemBuilder: (_ctx, i, index) =>
                                                BoutiqueComponentHomeN(
                                              boutique: categorys
                                                  .ListBoutiqueF[index],
                                            ),
                                            options: CarouselOptions(
                                              height: kMdHeight / 5,
                                              aspectRatio: 4 / 4,
                                              autoPlay: true,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .scale,
                                              initialPage: 0,
                                              enlargeCenterPage: true,
                                              enableInfiniteScroll: false,
                                              reverse: false,
                                              onPageChanged: (index, reason) {
                                                categorys.setCurrent(index);
                                              },
                                              disableCenter: true,
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              viewportFraction: 0.75,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY * .7),
                                          child: Text("Populaire",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: ColorsApp.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        // GridView.builder(
                                        //     shrinkWrap: true,
                                        //     physics: ClampingScrollPhysics(),
                                        //     controller: _scrollController,
                                        //     gridDelegate:
                                        //         SliverGridDelegateWithFixedCrossAxisCount(
                                        //       crossAxisCount: 2,
                                        //       crossAxisSpacing: 20.0,
                                        //       childAspectRatio: kMarginX / 12,
                                        //       mainAxisSpacing: 10.0,
                                        //     ),
                                        //     itemCount: prods.produitList.length,
                                        //     itemBuilder: (_ctx, index) =>
                                        //         ProductComponentAll(
                                        //           key: ValueKey<int>(prods
                                        //               .produitList[index].id),
                                        //           produit:
                                        //               prods.produitList[index],
                                        //           index: index,
                                        //         )),
                                        // prods.loaddata == true
                                        //     ? ShimmerProduit() /*   Container(
                                        //         alignment: Alignment.center,
                                        //         margin: EdgeInsets.all(10),
                                        //         child:
                                        //             CircularProgressIndicator()) */
                                        //     : Container(),
                                      ],
                                    )),
                                  );
                          }),
                          childCount: 1,
                        )),
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: kMarginX / 12,
                            mainAxisSpacing: 8.0,
                          ),
                          // itemCount: prods.produitList.length,
                          // itemBuilder: (_ctx, index) =>
                          //     ProductComponentAll(
                          //       key: ValueKey<int>(prods
                          //           .produitList[index].id),
                          //       produit:
                          //           prods.produitList[index],
                          //       index: index,
                          //     )),
                          // gridDelegate:
                          //     SliverGridDelegateWithMaxCrossAxisExtent(
                          //   maxCrossAxisExtent:
                          //       200.0, // Largeur maximale de chaque cellule
                          //   mainAxisSpacing:
                          //       10.0, // Espace vertical entre les cellules
                          //   crossAxisSpacing:
                          //       10.0, // Espace horizontal entre les cellules
                          //   childAspectRatio:
                          //       1.0, // Ratio largeur/hauteur des cellules
                          // ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) =>
                                ProductComponentAll(
                              key: ValueKey<int>(prods.produitList[index].id),
                              produit: prods.produitList[index],
                              index: index,
                            ),

                            childCount: prods.produitList
                                .length, // Nombre total de cellules dans la grille
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: prods.loaddata == true
                                ? ShimmerProduit() /*   Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.all(10),
                                                child:
                                                    CircularProgressIndicator()) */
                                : Container()),
                      ]));
            }));
  }
}
