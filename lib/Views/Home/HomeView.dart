import 'package:EMIY/components/Widget/BoutiqueCircleComponent.dart';
import 'package:EMIY/components/Widget/HomeModuleComponent.dart';
import 'package:EMIY/components/Widget/ShimmerHome.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/icon_svg.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/produitComponentAll.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
      Get.find<ProduitController>().getPopularProduit();
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state*************************");
    print(AppLifecycleState.resumed);
    if (state == AppLifecycleState.paused) {
      Get.find<ShortController>().pausePlay();
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
    return GetBuilder<GeneralController>(
        builder: (generalController) =>
            GetBuilder<ProduitController>(builder: (prods) {
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
                    await Get.find<ShortController>().getListForYouShort();

                    // await prods.getPopularProduit();
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: kMarginX),
                      child: CustomScrollView(
                          controller:
                              // _scrollController,
                              prods
                                  .controllerT, // controller: Get.find<GeneralController>().scrollcontroller,
                          slivers: [
                            SliverAppBar(
                              backgroundColor: ColorsApp.white,
                              elevation: 0,
                              // leading: Builder(builder: (context) {
                              //   return InkWell(
                              //       child: Icon(
                              //         Icons.menu,
                              //         color: Colors.blue,
                              //       ),
                              //       onTap: () => Scaffold.of(context).openDrawer());
                              // }),
                              floating: true,
                              flexibleSpace: FlexibleSpaceBar(
                                  background: Container(
                                      // decoration:
                                      //     BoxDecoration(color: Colors.red),
                                      margin: EdgeInsets.only(
                                          top: Get.height * .030, left: 0),
                                      padding: EdgeInsets.only(
                                          left: Get.width * .030,
                                          right: Get.width * .030),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: AppTitleRight(
                                                  title: 'Hi Boy!',
                                                  description: ' ',
                                                  icon: Assets.home),
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .005),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 15,
                                                                  right: 10),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  kMarginX / 3),
                                                          // margin: EdgeInsets.only(right: kMarginX),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .blue,
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          child: SvgIcon(
                                                              icon:
                                                                  Assets.bell)),
                                                      onTap: () {
                                                        Get.toNamed(AppLinks
                                                            .NOTIFICATION);
                                                      }),
                                                  InkWell(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 15),
                                                        padding: EdgeInsets.all(
                                                            kMarginX / 10),
                                                        // margin: EdgeInsets.only(right: kMarginX),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.blue,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: Icon(
                                                            Icons.search,
                                                            // color:
                                                            //     Colors.blue,
                                                            size: 22),
                                                      ),
                                                      onTap: () {
                                                        Get.toNamed(
                                                            AppLinks.SEARCH);
                                                      })
                                                ])
                                          ]))),
                              expandedHeight: kHeight * .1,
                            ),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  GetBuilder<CategoryBoutiqueController>(
                                      builder: (categorys) {
                                return generalController.isLoadedHome == 0
                                    ? ShimmerHome()
                                    : Container(
                                        // margin: EdgeInsets.only(top: kMarginX/2),
                                        child: SingleChildScrollView(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // InkWell(
                                            //     child: Container(
                                            //         decoration: BoxDecoration(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   5),
                                            //           color:
                                            //               ColorsApp.greySecond,
                                            //         ),
                                            //         height:
                                            //             kToolbarHeight / 1.7,
                                            //         // width: kWidth * .75,
                                            //         padding:
                                            //             EdgeInsets.symmetric(
                                            //                 horizontal: 10,
                                            //                 vertical: 5),
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .spaceBetween,
                                            //           children: [
                                            //             Container(
                                            //                 child: Text(
                                            //               "Rechercher",
                                            //               style: TextStyle(
                                            //                 color: Colors.grey,
                                            //                 fontSize: kBasics,
                                            //               ),
                                            //             )),
                                            //             InkWell(
                                            //                 child: Icon(
                                            //                   Icons.search,
                                            //                   color:
                                            //                       Colors.blue,
                                            //                 ),
                                            //                 onTap: () {}),
                                            //           ],
                                            //         )),
                                            //     onTap: () {
                                            //       Get.toNamed(AppLinks.SEARCH);
                                            //     }),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: kMarginY * .4),
                                              child: Text("Categories",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: kLgText,
                                                      color:
                                                          ColorsApp.secondBlue,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Container(
                                              height: kSmHeight * .9,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: kMarginY),
                                              child: ListView.builder(
                                                itemCount: categorys
                                                    .categoryList.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (_ctx, index) =>
                                                    CategoryComponent(
                                                  category: categorys
                                                      .categoryList[index],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: kMarginY * .4),
                                              child: Text("Boutiques",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: kBasics,
                                                      color:
                                                          ColorsApp.secondBlue,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Container(
                                              height: kHeight / 7,
                                              // margin: EdgeInsets.symmetric(
                                              //     vertical: kMarginY),
                                              child: ListView.builder(
                                                itemCount: categorys
                                                    .ListBoutiqueF.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (_ctx, index) =>
                                                    Container(
                                                  width: kWidth / 4,
                                                  // height: kWidth / 3,
                                                  margin: EdgeInsets.only(
                                                      right: kMarginX / 2),
                                                  child: BoutiqueCircleComponent(
                                                      boutique: categorys
                                                          .ListBoutiqueF[index],
                                                      type: 1),
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   // height: kMdHeight / 6,
                                            //   child: CarouselSlider.builder(
                                            //     itemCount:
                                            //         categorys.ListBoutiqueF.length,
                                            //     itemBuilder: (_ctx, i, index) =>
                                            //         BoutiqueComponentHomeN(
                                            //       boutique: categorys
                                            //           .ListBoutiqueF[index],
                                            //     ),
                                            //     options: CarouselOptions(
                                            //       height: kMdHeight / 5,
                                            //       aspectRatio: 4 / 4,
                                            //       autoPlay: true,
                                            //       enlargeStrategy:
                                            //           CenterPageEnlargeStrategy
                                            //               .scale,
                                            //       initialPage: 0,
                                            //       enlargeCenterPage: true,
                                            //       enableInfiniteScroll: false,
                                            //       reverse: false,
                                            //       onPageChanged: (index, reason) {
                                            //         categorys.setCurrent(index);
                                            //       },
                                            //       disableCenter: true,
                                            //       autoPlayCurve:
                                            //           Curves.fastOutSlowIn,
                                            //       viewportFraction: 0.75,
                                            //     ),
                                            //   ),
                                            // ),

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
                                            //         ProduitComponentAll(
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
                            if (generalController.homeComponent.length != 0)
                              SliverToBoxAdapter(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      generalController.homeComponent.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (_ctx, index) =>
                                      HomeModuleComponent(
                                    homeComponent:
                                        generalController.homeComponent[index],
                                  ),
                                ),
                              ),
                            if (prods.produitList.length != 0)
                              SliverToBoxAdapter(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: kMarginY * .7),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Text("Populaire",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontSize: kBasics,
                                                    color: ColorsApp.secondBlue,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                        Container(
                                            padding: EdgeInsets.all(3).add(
                                              EdgeInsets.symmetric(
                                                  horizontal: kMarginX * 1.2),
                                            ),
                                            decoration: BoxDecoration(
                                                color: ColorsApp.grey,
                                                borderRadius:
                                                    BorderRadius.circular(18)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: SvgIcon(
                                                      icon: Assets.grid1,
                                                      color: ColorsApp.skyBlue,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: kMarginX),
                                                    child: SvgIcon(
                                                      icon: Assets.list0,

                                                      width: 25, height: 25,
                                                      // color: _currentIndex == 1 ? ColorsApp.skyBlue : ColorsApp.grey,
                                                    ),
                                                  ),
                                                ])),
                                      ]),
                                ),
                              ),
                            if (prods.produitList.length != 0)
                              SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.0,
                                  childAspectRatio: kMarginX / 12,
                                  mainAxisSpacing: 10.0,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) =>
                                      ProduitComponentAll(
                                    key: ValueKey<int>(
                                        prods.produitList[index].id),
                                    produit: prods.produitList[index],
                                    index: index,
                                  ),

                                  childCount: prods.produitList
                                      .length, // Nombre total de cellules dans la grille
                                ),
                              ),

                            // SliverToBoxAdapter(
                            //     child: prods.loaddata == true
                            //         ? ShimmerProduit()
                            //         : Container()),
                          ])));
            }));
  }
}
