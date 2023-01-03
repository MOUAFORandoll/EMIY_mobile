import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/components/Button/AppIconButton.dart';
import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatelessWidget {
  final int index;
  ProductView({Key? key, required this.index}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    print(index);

    Object produ = Get.parameters['type'] == '0'
        ? Get.find<ProductController>().produitList[index]
        : Get.find<ProductController>().produitcategoryList[index];
    var product = produ as ProduitModel;
    Get.find<ProductController>()
        .initProduct(Get.find<CartController>(), product);
    print(product);
    return Scaffold(
      body: CustomScrollView(controller: _scrollController, slivers: [
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorsApp.bleuLight,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButtonF(
                icon: Icons.close,
                color: ColorsApp.black,
                onTap: () {
                  Get.back();
                },
              ),
              GetBuilder<ProductController>(builder: (controller) {
                return Stack(
                  children: [
                    Container(
                        child: Get.find<ProductController>().totalItems >= 1
                            ? IconButtonF(
                                color: ColorsApp.black,
                                icon: Icons.shopping_cart_outlined,
                                onTap: () {
                                  // Get.toNamed(
                                  //   AppLinks.CART,
                                  // );
                                },
                              )
                            : Container()),
                    Get.find<ProductController>().totalItems >= 1
                        ? Positioned(
                            top: 0,
                            left: 1,
                            child: Container(
                                child: smallText(
                                    text: Get.find<ProductController>()
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
              background: CachedNetworkImage(
            height: kMdHeight * .15,
            width: Get.width * .5,
            fit: BoxFit.cover,
            imageUrl: product.images[0].src,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
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
              return CircleAvatar(
                  backgroundColor: ColorsApp.skyBlue,
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/error.gif"));
            },
          )),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Center(child: BigText(text: product.titre, bolder: true)),
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
              child: Text(
                product.description,
                textAlign: TextAlign.justify,
              )),
        ),
      ]),
      bottomNavigationBar: GetBuilder<ProductController>(builder: (prod) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: kMdWidth / 2, right: kMdWidth / 2, top: 2, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonF(
                    backgroundColor: ColorsApp.greenLight,
                    icon: Icons.remove,
                    inconSize: 15.0,
                    onTap: () {
                      prod.setQuantity(false); // Get.back();
                    },
                  ),
                  BigText(
                    text:
                        'XAF ${product.prix * (prod.inCartItems == 0 ? 1 : prod.inCartItems)}',
                  ),
                  IconButtonF(
                    backgroundColor: ColorsApp.greenLight,
                    icon: Icons.add,
                    inconSize: 15.0,
                    onTap: () {
                      prod.setQuantity(true); // Get.back();
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: ColorsApp.grey),
              // padding: EdgeInsets.only(
              //     left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // AppIconButton(
                  //   icon: Icons.favorite,
                  //   onTap: () {
                  //     // Get.back();
                  //   },
                  // ),
                  BigText(
                    text: prod.inCartItems.toString(),
                  ),
                  CustomBtn(
                    color: ColorsApp.greenLight,
                    title: prod.exitP(product) ? "Update" : 'Ajouter au panier',
                    onTap: () {
                      prod.addItem(product, index, Get.parameters['type']);
                    },
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
