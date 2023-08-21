import 'package:EMIY/components/Button/ShareButton.dart';
import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/produitComponentAll.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/searchController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:EMIY/components/Button/AppIconButton.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Text/SimpleText.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/bigtitleText0.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share_plus/share_plus.dart';

class ProduitView extends StatelessWidget {
  final int index;
  ProduitView({Key? key, required this.index}) : super(key: key);

  ScrollController _scrollController = new ScrollController();

  final CarouselController _controller = CarouselController();

  // @override
  // void initState() {
  //   // Get.find<ManagerController>().initCurrent();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //print(index);
    Object produ = Get.parameters['type'] == 'home'
        ? Get.find<ProduitController>().produitList[index]
        : Get.parameters['type'] == 'supplementaire'
            ? Get.find<ProduitController>().produitSupplementaire[index]
            : Get.parameters['type'] == 'search'
                ? Get.find<SearchController>().listProduit[index]
                /*  : Get.parameters['type'] == '1'
                ? Get.find<ProduitController>().produitListAll[index]
                */
                : Get.parameters['type'] == 'favorite'
                    ? Get.find<ProduitController>().preferenceList[index]
                    : Get.find<CategoryBoutiqueController>()
                        .produitBoutiqueList[index];
    var produit = produ as ProduitModel;
    Get.find<ProduitController>()
        .initProduit(Get.find<CartController>(), produit);
    Get.find<ProduitController>()
        .getListProduitSupplementaire(produit.codeProduit);
    //print(produit);
    return GetBuilder<ProduitController>(
        builder: (prodController) => GetBuilder<ManagerController>(
            builder: (manage) => WillPopScope(
                onWillPop: () async {
                  prodController.unSetConf();
                  return true;
                },
                child: Scaffold(
                  body: SafeArea(
                      child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: ColorsApp.secondBlue,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButtonF(
                              icon: Icons.arrow_back_ios_new,
                              color: ColorsApp.black,
                              onTap: () {
                                Get.back();

                                Get.find<ProduitController>().unSetConf();
                              },
                            ),
                            GetBuilder<ProduitController>(
                                builder: (controller) {
                              return Stack(
                                children: [
                                  Container(
                                      child: Get.find<ProduitController>()
                                                  .totalItems >=
                                              1
                                          ? IconButtonF(
                                              color: ColorsApp.black,
                                              icon:
                                                  Icons.shopping_cart_outlined,
                                              onTap: () {
                                                Get.toNamed(
                                                  AppLinks.SHOPNEXT,
                                                );
                                              },
                                            )
                                          : Container()),
                                  Get.find<ProduitController>().totalItems >= 1
                                      ? Positioned(
                                          top: 0,
                                          left: 1,
                                          child: Container(
                                              child: smallText(
                                                  text: Get.find<
                                                          ProduitController>()
                                                      .totalItems
                                                      .toString(),
                                                  color: Colors.white)))
                                      : Container(),
                                ],
                              );
                            })
                          ],
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                            background: Column(children: [
                          Expanded(
                              child: CarouselSlider.builder(
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      aspectRatio: 4 / 4,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.scale,
                                      initialPage: 0,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      disableCenter: true,
                                      height: Get.height,
                                      // enlargeCenterPage: true,
                                      // autoPlay: true,

                                      // autoPlayCurve: Curves.fastOutSlowIn,
                                      // enableInfiniteScroll: true,
                                      viewportFraction: 1.0,
                                      onPageChanged: (index, reason) {
                                        // manage.setCurrent(index);
                                      },
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal),
                                  // options: CarouselOptions(
                                  //   height: 380.0,
                                  //   enlargeCenterPage: true,
                                  //   autoPlay: true,
                                  //   aspectRatio: 16 / 9,
                                  //   autoPlayCurve: Curves.fastOutSlowIn,
                                  //   enableInfiniteScroll: true,
                                  //   autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  //   viewportFraction: 0.8,
                                  // ),
                                  itemCount: produit.images.length,
                                  itemBuilder: (_ctx, i, j) => InkWell(
                                      child: CachedNetworkImage(
                                        height: kMdHeight * .15,
                                        width: Get.width * .5,
                                        fit: BoxFit.cover,
                                        imageUrl: produit.images[i].src,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: ColorsApp.greySecond,
                                            ),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: ColorsApp.skyBlue,
                                            )),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return CircleAvatar(
                                              backgroundColor:
                                                  ColorsApp.skyBlue,
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                  "assets/images/error.gif"));
                                        },
                                      ),
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImageScreen(
                                                imagePath:
                                                    produit.images[i].src),
                                          ),
                                        );
                                      })))
                        ])),
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
                            child: Center(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  // BigText(text: produit.titre, bolder: true),
                                  // BigText(
                                  //     text: 'XAF ' + produit.prix.toString(), bolder: true)
                                ])),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            width: double.maxFinite,
                          ),
                        ),
                        expandedHeight: 250,
                        pinned: true,
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: kMarginX),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children:
                                  //       produit.images.asMap().entries.map((entry) {
                                  //     // //print(entry.key);
                                  //     return GestureDetector(
                                  //       onTap: () =>
                                  //           _controller.animateToPage(entry.key),
                                  //       child: Container(
                                  //         width: 8.0,
                                  //         height: 8.0,
                                  //         margin: EdgeInsets.symmetric(
                                  //             vertical: 10.0, horizontal: 4.0),
                                  //         decoration: BoxDecoration(
                                  //             shape: BoxShape.circle,
                                  //             color: (Theme.of(context)
                                  //                             .brightness ==
                                  //                         Brightness.dark
                                  //                     ? Colors.white
                                  //                     :  ColorsApp.black)
                                  //                 .withOpacity(
                                  //                     manage.current == entry.key
                                  //                         ? 0.9
                                  //                         : 0.2)),
                                  //       ),
                                  //     );
                                  //   }).toList(),
                                  // ),
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            BigtitleText(
                                                text: produit.titre,
                                                bolder: true),
                                          ])),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigtitleText(
                                              text: 'XAF ' +
                                                  produit.prix.toString(),
                                              color: ColorsApp.black,
                                              bolder: true),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    IconButtonF1(
                                                      icon: Icons.remove,
                                                      inconSize: 15.0,
                                                      onTap: () {
                                                        prodController
                                                            .setQuantity(false);
                                                        prodController.addItem(
                                                            produit,
                                                            index,
                                                            Get.parameters[
                                                                'type']);
                                                      },
                                                    ),
                                                    SimpleText(
                                                        text: (prodController
                                                                .inCartItems)
                                                            .toString(),
                                                        bolder: true),
                                                    IconButtonF1(
                                                      icon: Icons.add,
                                                      inconSize: 15.0,
                                                      onTap: () {
                                                        prodController
                                                            .setQuantity(true);
                                                        prodController.addItem(
                                                            produit,
                                                            index,
                                                            Get.parameters[
                                                                'type']);
                                                        //print(
                                                        // "****************${prod.inCartItems}");
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                // SimpleText(
                                                //     text:
                                                //         (prod.inCartItems).toString(),
                                                //     bolder: true),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: ColorsApp.greyTh,
                                          border: Border.all(
                                              color: ColorsApp.greyTh),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: ColorsApp.orange,
                                                  ),
                                                  BigtitleText(
                                                      size: 12,
                                                      color: ColorsApp.black,
                                                      text: produit.quantite
                                                              .toString() +
                                                          ' Pieces disponible: ')
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.favorite,
                                                    color: ColorsApp.red,
                                                  ),
                                                  BigtitleText(
                                                      size: 12,
                                                      color: ColorsApp.black,
                                                      text: produit.like
                                                              .toString() +
                                                          ' Like ')
                                                ],
                                              ),
                                            ],
                                          ),
                                          ShareButton(
                                            libelle:
                                                'Suivez ce lien pour consulter ce produit  : ' +
                                                    produit.lienProduit,
                                          )
                                          /*  InkWell(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: ColorsApp.orange,
                                              ),
                                              BigtitleText(
                                                  size: 12,
                                                  color: ColorsApp.black,
                                                  text: produit.note.toString())
                                            ],
                                          ),
                                          onTap: () {
                                            Get.bottomSheet(Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsApp.grey,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: kSmWidth * .07),
                                                height: 800,
                                                child: SingleChildScrollView(
                                                    child: Column(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                      // RatingBar(
                                                      //   initialRating:
                                                      //       produit.note,
                                                      //   filledIcon: Icons.star,
                                                      //   emptyIcon:
                                                      //       Icons.star_border,
                                                      //   halfFilledIcon:
                                                      //       Icons.star_half,
                                                      //   isHalfAllowed: true,
                                                      //   filledColor:
                                                      //       Colors.yellow,
                                                      //   emptyColor:
                                                      //       Colors.yellow,
                                                      //   halfFilledColor:
                                                      //       Colors.yellow,
                                                      //   size: 30,
                                                      //   onRatingChanged:
                                                      //       (double rating) {
                                                      //     //print(rating);
                                                      //     Get.find<
                                                      //             GeneralController>()
                                                      //         .likeProduit(
                                                                
                                                      //             produit
                                                      //                 .codeProduit);
                                                      //   },
                                                      // ),
                                                    ]))));
                                          }) */
                                        ],
                                      )),
                                  Container(
                                    child: Row(
                                      // mainAxisAlignment:
                                      //   MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              prodController.setChoix(0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      prodController.choix == 0
                                                          ? ColorsApp.greyTh
                                                          : null,
                                                  border: Border.all(
                                                      color: ColorsApp.greyTh),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              margin: EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.all(8),
                                              child: BigtitleText(
                                                size: 14,
                                                text: 'Description',
                                                color: prodController.choix == 0
                                                    ? ColorsApp.orange
                                                    : ColorsApp.grey,
                                              )),
                                        ),
                                        InkWell(
                                            onTap: () =>
                                                prodController.setChoix(1),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        prodController.choix ==
                                                                1
                                                            ? ColorsApp.greyTh
                                                            : null,
                                                    border: Border.all(
                                                        color:
                                                            ColorsApp.greyTh),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                margin: EdgeInsets.only(
                                                    top: 10, left: 2),
                                                padding: EdgeInsets.all(8),
                                                child: BigtitleText(
                                                  size: 14,
                                                  text: 'Boutique',
                                                  color:
                                                      prodController.choix == 1
                                                          ? ColorsApp.orange
                                                          : ColorsApp.grey,
                                                ))),
                                        // Container(
                                        //     decoration: BoxDecoration(
                                        //         color: ColorsApp.greyTh,
                                        //         border: Border.all(
                                        //             color: ColorsApp.greyTh),
                                        //         borderRadius:
                                        //             BorderRadius.circular(8)),
                                        //     margin: EdgeInsets.only(
                                        //         top: 10, left: 2),
                                        //     padding: EdgeInsets.all(8),
                                        //     child: BigtitleText(
                                        //       size: 14,
                                        //       text: 'Appreciations',
                                        //     )),
                                      ],
                                    ),
                                  ),
                                  prodController.choix == 0
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Text(produit.description,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: ColorsApp.blackSecond,
                                                  fontSize: 13)))
                                      : Container(
                                          margin: EdgeInsets.only(
                                              top: 20, bottom: 10),
                                          child: Text(
                                              'Ce produit appartient a la boutique ' +
                                                  produit.boutique,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: ColorsApp.blackSecond,
                                                  fontSize: 13))),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: kMarginY),
                                    child: Text("Produits Similaires",
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: ColorsApp.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  prodController.isLoadedSupp == 0
                                      ? ShimmerProduit()
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),

                                          // Ratio largeur/hauteur pour chaque élément
                                          // controller: prods.controllerT,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.0,
                                            childAspectRatio: kMarginX / 13,
                                            mainAxisSpacing: 8.0,
                                          ),
                                          itemCount: prodController
                                              .produitSupplementaire.length,
                                          itemBuilder: (_ctx, index) =>
                                              ProduitComponentAll(
                                                  produit: prodController
                                                          .produitSupplementaire[
                                                      index],
                                                  index: index,
                                                  type: 'supplementaire')),
                                  prodController.loaddata == true
                                      ? Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(10),
                                          child: CircularProgressIndicator())
                                      : Container(),
                                ])),
                      ),
                    ],
                  )),
                  bottomNavigationBar: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: kMarginY * 2,
                        ).add(EdgeInsets.only(bottom: 5)),
                        padding: EdgeInsets.all(kMarginX / 3.2),
                        // decoration: BoxDecoration(color: ColorsApp.grey),
                        child: prodController.conf == false
                            ? Row(mainAxisSize: MainAxisSize.max, children: [
                                IconButtonF1(
                                  icon: Icons.favorite,
                                  inconSize: 15.0,
                                  color: produit.islike ? ColorsApp.red : null,
                                  backgroundColor:
                                      produit.islike ? ColorsApp.white : null,
                                  padding: 9.0,
                                  onTap: () {
                                    Get.find<GeneralController>()
                                        .likeProduit(produit.codeProduit, 1);
                                  },
                                ),
                                Container(
                                    width: kWidth * .80,
                                    child: AppButton(
                                      size: MainAxisSize.max,
                                      text: prodController.exitP(produit)
                                          ? "Augmenter"
                                          : 'Ajouter',
                                      onTap: () {
                                        prodController.setConf();
                                      },
                                    ))
                              ])
                            : Container(
                                decoration: BoxDecoration(
                                    color: ColorsApp.greySearch,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                padding: EdgeInsets.symmetric(
                                  horizontal: kSmWidth * .07,
                                ).add(EdgeInsets.only(bottom: 5)),
                                child: SingleChildScrollView(
                                    child: Column(
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigtitleText(
                                                size: 12,
                                                text: 'Quantite',
                                                bolder: true),
                                            InkWell(
                                                child: Container(
                                                  child: Icon(Icons.close,
                                                      color: ColorsApp.black),
                                                ),
                                                onTap: () {
                                                  prodController.unSetConf();
                                                }),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                IconButtonF0(
                                                  icon: Icons.remove,
                                                  inconSize: 15.0,
                                                  onTap: () {
                                                    prodController
                                                        .setQuantity(false);
                                                    prodController.addItem(
                                                        produit,
                                                        index,
                                                        Get.parameters['type']);
                                                  },
                                                ),
                                                SimpleText(
                                                    text: (prodController
                                                            .inCartItems)
                                                        .toString(),
                                                    bolder: true),
                                                IconButtonF0(
                                                  icon: Icons.add,
                                                  inconSize: 15.0,
                                                  onTap: () {
                                                    prodController
                                                        .setQuantity(true);
                                                    prodController.addItem(
                                                        produit,
                                                        index,
                                                        Get.parameters['type']);
                                                    //print(
                                                    // "****************${prod.inCartItems}");
                                                  },
                                                ),
                                              ],
                                            ),
                                            // SimpleText(
                                            //     text:
                                            //         (prod.inCartItems).toString(),
                                            //     bolder: true),
                                          ],
                                        ),
                                      )
                                    ]))),
                      )
                    ],
                  ),
                ))));
  }
}

class ImageScreen extends StatelessWidget {
  final String imagePath;

  ImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ColorsApp.greyFirst, // Fond noir pour l'effet d'agrandissement
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Ferme l'écran d'image agrandie lors du clic
        },
        child: Center(
          child: Hero(
            tag: 'imageTag',
            child: CachedNetworkImage(
              height: kHeight,
              width: kWidth,
              fit: BoxFit.contain,
              imageUrl: imagePath,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.greySecond,
                  ),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: ColorsApp.skyBlue,
                  )),
                );
              },
              errorWidget: (context, url, error) {
                return CircleAvatar(
                    backgroundColor: ColorsApp.skyBlue,
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/error.gif"));
              },
            ),
          ),
        ),
      ),
    );
  }
}
