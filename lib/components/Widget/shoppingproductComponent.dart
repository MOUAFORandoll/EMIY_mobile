// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Text/QteText.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/productController.dart';
import 'package:Fahkap/model/data/CartModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShoppingproductComponent extends StatelessWidget {
  CartModel cartM;

  ShoppingproductComponent({required this.cartM});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: kMdHeight * .1,
          width: kMdWidth,
          // padding: EdgeInsets.all(kMarginX),
          margin:
              EdgeInsets.symmetric(horizontal: kMarginX, vertical: kMarginY),
          decoration: BoxDecoration(
              color: ColorsApp.grey, borderRadius: BorderRadius.circular(8)),
          child: GetBuilder<CartController>(builder: (cart) {
            return Dismissible(
              direction: DismissDirection.endToStart,

              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  // Left to right

                  print("Edit");
                } else if (direction == DismissDirection.endToStart) {
                  // Right to left
                  print("Delete");
                  cart.removeItem(cartM.id);
                }
              },
              key: ObjectKey(cartM),
              // left side

              // right side
              background: Container(
                color: Colors.red[200],
                margin: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  color: ColorsApp.greySecond,
                ),
              ),
              child: Stack(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      child: CachedNetworkImage(
                                    height: kMdHeight * .15,
                                    width: Get.width * .25,
                                    fit: BoxFit.cover,
                                    imageUrl: cartM.img,
                                    imageBuilder: (context, imageProvider) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.transparent,
                                                      BlendMode.colorBurn))),
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
                                          backgroundImage: AssetImage(
                                              "assets/images/error.gif"));
                                    },
                                  )),
                                  // Positioned(
                                  //   top: 0,
                                  //   left: Get.height * .1,
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(3),
                                  //     decoration: BoxDecoration(
                                  //         gradient: GradientApp.blueG,
                                  //         borderRadius: BorderRadius.only(
                                  //             bottomLeft: Radius.circular(10),
                                  //             topRight: Radius.circular(10))),
                                  //     child: Icon(Icons.shopping_cart_outlined,
                                  //         color: Colors.red),
                                  //   ),
                                  // )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: kSmWidth * .6,
                                      margin: EdgeInsets.only(
                                          top: Get.height * .005,
                                          left: Get.width * .008),
                                      child: smallText(
                                          text: cartM.name, size: 15)),
                                  Container(
                                      width: kSmWidth * .6,
                                      margin: EdgeInsets.only(
                                          top: Get.height * .005,
                                          left: Get.width * .008),
                                      child: smallText(
                                          text: 'XAF ' + cartM.prix.toString(),
                                          bolder: true,
                                          size: 15)),
                                  // Container(
                                  //   width: kSmWidth * .6,
                                  //   margin: EdgeInsets.only(
                                  //       top: Get.height * .005, left: Get.width * .008),
                                  //   child: Text('XAF ' + price.toString(),
                                  //       overflow: TextOverflow.ellipsis,
                                  //       style: TextStyle(
                                  //           decoration: TextDecoration.lineThrough,
                                  //           decorationColor: Colors.black,
                                  //           decorationThickness: 2.85,
                                  //           color: Colors.black,
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.bold)),
                                  // ),
                                ],
                              ),
                            ]),
                        GetBuilder<CartController>(builder: (cart) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorsApp.skyBlue),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButtonF(
                                    backgroundColor: Colors.transparent,
                                    icon: Icons.add,
                                    inconSize: 15.0,
                                    semanticLabel: "Ajouter",
                                    onTap: () {
                                      cart.updateQuantityProduct(
                                          cartM.id, true); // Get.back();
                                    },
                                  ),
                                  Container(
                                    width: kSmWidth * .2,
                                    margin:
                                        EdgeInsets.only(top: Get.height * .005),
                                    child: smallText(
                                        text: cartM.quantity.toString(),
                                        bolder: true,
                                        size: 15),
                                  ),
                                  IconButtonF(
                                    backgroundColor: Colors.transparent,
                                    icon: Icons.remove,
                                    semanticLabel: "Reduire",
                                    inconSize: 15.0,
                                    onTap: () {
                                      cart.updateQuantityProduct(
                                          cartM.id, false); // Get.back();
                                    },
                                  ),
                                  // Container(
                                  //     width: kSmWidth * .5,
                                  //     margin: EdgeInsets.only(top: Get.height * .005),
                                  //     child: smallText(text: 'Quantite')),
                                  // Container(
                                  //   width: kSmWidth * .5,
                                  //   margin: EdgeInsets.only(top: Get.height * .005),
                                  //   child: smallText(
                                  //       text: cartM.quantity.toString(),
                                  //       bolder: true,
                                  //       size: 15),
                                  // ),
                                ],
                              ));
                        }),
                      ]),
                ],
              ),
            );
          })),
      onTap: () {
        // Get.toNamed(
        //     AppLinks.PRODUCT + '?index=${cartM.index}&type=${cartM.type}');
      },
    );
  }
}
