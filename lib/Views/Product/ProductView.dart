import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/controller/ActionController.dart';
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
import 'package:EMIY/controller/productController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';

class ProductView extends StatelessWidget {
  final int index;
  ProductView({Key? key, required this.index}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    Get.find<ManagerController>().initCurrent();

    //print(index);
    Object produ = Get.parameters['type'] == '0'
        ? Get.find<ProductController>().produitList[index]
        : Get.parameters['type'] == 'search'
            ? Get.find<SearchController>().listResultSeaarch[index]
            /*  : Get.parameters['type'] == '1'
                ? Get.find<ProductController>().produitListAll[index]
                */
            : Get.find<CategoryBoutiqueController>().produitBoutiqueList[index];
    var product = produ as ProduitModel;
    Get.find<ProductController>()
        .initProduct(Get.find<CartController>(), product);
    //print(product);
    return GetBuilder<ManagerController>(
        builder: (manage) => WillPopScope(
            onWillPop: () async {
              Get.find<ProductController>().unSetConf();
              return true;
            },
            child: Scaffold(
              body: SafeArea(
                  child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorsApp.bleuLight,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButtonF(
                          icon: Icons.arrow_back_ios_new,
                          color: ColorsApp.black,
                          onTap: () {
                            Get.back();

                            Get.find<ProductController>().unSetConf();
                          },
                        ),
                        GetBuilder<ProductController>(builder: (controller) {
                          return Stack(
                            children: [
                              Container(
                                  child: Get.find<ProductController>()
                                              .totalItems >=
                                          1
                                      ? IconButtonF(
                                          color: ColorsApp.black,
                                          icon: Icons.shopping_cart_outlined,
                                          onTap: () {
                                            Get.toNamed(
                                              AppLinks.SHOPNEXT,
                                            );
                                          },
                                        )
                                      : Container()),
                              Get.find<ProductController>().totalItems >= 1
                                  ? Positioned(
                                      top: 0,
                                      left: 1,
                                      child: Container(
                                          child: smallText(
                                              text:
                                                  Get.find<ProductController>()
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
                                    manage.setCurrent(index);
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
                              itemCount: product.images.length,
                              itemBuilder: (_ctx, i, j) => InkWell(
                                  child: CachedNetworkImage(
                                    height: kMdHeight * .15,
                                    width: Get.width * .5,
                                    fit: BoxFit.cover,
                                    imageUrl: product.images[i].src,
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
                                            child: CircularProgressIndicator(
                                          color: ColorsApp.skyBlue,
                                        )),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return CircleAvatar(
                                          backgroundColor: ColorsApp.skyBlue,
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
                                            imagePath: product.images[i].src),
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
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        child: Center(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                              // BigText(text: product.titre, bolder: true),
                              // BigText(
                              //     text: 'XAF ' + product.prix.toString(), bolder: true)
                            ])),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        width: double.maxFinite,
                      ),
                    ),
                    expandedHeight: 300,
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: kMarginX),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    product.images.asMap().entries.map((entry) {
                                  // //print(entry.key);
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black)
                                              .withOpacity(
                                                  manage.current == entry.key
                                                      ? 0.9
                                                      : 0.2)),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigtitleText(
                                        text: product.titre, bolder: true),
                                    BigtitleText(
                                        text: 'XAF ' + product.prix.toString(),
                                        color: ColorsApp.black,
                                        bolder: true),
                                  ]),
                              Container(
                                  margin: EdgeInsets.only(top: 2, left: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                              text:
                                                  product.quantite.toString() +
                                                      ' Pieces disponible: ')
                                        ],
                                      ),
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
                                                  text: product.note.toString())
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
                                                      //       product.note,
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
                                                      //             ActionController>()
                                                      //         .likeProduit(
                                                                
                                                      //             product
                                                      //                 .codeProduit);
                                                      //   },
                                                      // ),
                                                    ]))));
                                          }) */
                                    ],
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: BigtitleText(
                                    size: 14,
                                    text: 'Details',
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 5),
                                  child: Text(product.description,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: ColorsApp.black,
                                          fontSize: 12)))
                            ])),
                  ),
                ],
              )),
              bottomNavigationBar:
                  GetBuilder<ProductController>(builder: (prod) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.all(kMarginX)
                          .add(EdgeInsets.only(bottom: 15)),
                      padding: EdgeInsets.all(kMarginX / 3.2),
                      // decoration: BoxDecoration(color: ColorsApp.grey),
                      child: prod.conf == false
                          ? AppButton(
                              size: MainAxisSize.max,
                              text:
                                  prod.exitP(product) ? "Augmenter" : 'Ajouter',
                              onTap: () {
                                prod.setConf();
                              },
                            )
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
                                                prod.unSetConf();
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
                                                  prod.setQuantity(false);
                                                  prod.addItem(product, index,
                                                      Get.parameters['type']);
                                                },
                                              ),
                                              SimpleText(
                                                  text: (prod.inCartItems)
                                                      .toString(),
                                                  bolder: true),
                                              IconButtonF0(
                                                icon: Icons.add,
                                                inconSize: 15.0,
                                                onTap: () {
                                                  prod.setQuantity(true);
                                                  prod.addItem(product, index,
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
                );
              }),
            )));
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
