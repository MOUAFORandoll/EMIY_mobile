// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/model/data/CartModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShoppingproduitComponent extends StatelessWidget {
  CartModel cartM;

  ShoppingproduitComponent({required this.cartM});

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

                  //print("Edit");
                } else if (direction == DismissDirection.endToStart) {
                  // Right to left
                  //print("Delete");
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
                                              "assets/logo/logoNew.png"));
                                    },
                                  )),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: kWidth * .4,
                                      margin: EdgeInsets.only(
                                          top: Get.height * .005,
                                          left: kWidth * .05),
                                      child: smallText(
                                          text: cartM.name,
                                          al: true,
                                          size: 15)),
                                  Container(
                                      width: kWidth * .4,
                                      margin: EdgeInsets.only(
                                          top: Get.height * .005,
                                          left: kWidth * .05),
                                      child: smallText(
                                          text: 'XAF ' + cartM.prix.toString(),
                                          bolder: true,
                                          al: true,
                                          size: 12)),
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
                                  //   Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     IconButtonF1(
                                  //       icon: Icons.remove,
                                  //       inconSize: 15.0,
                                  //       onTap: () {
                                  //         prodController.setQuantity(false);
                                  //         prodController.addItem(produit, index,
                                  //             Get.parameters['type']);
                                  //       },
                                  //     ),
                                  //     SimpleText(
                                  //         text: (prodController.inCartItems)
                                  //             .toString(),
                                  //         bolder: true),
                                  //     IconButtonF1(
                                  //       icon: Icons.add,
                                  //       inconSize: 15.0,
                                  //       onTap: () {
                                  //         prodController.setQuantity(true);
                                  //         prodController.addItem(produit, index,
                                  //             Get.parameters['type']);
                                  //         //print(
                                  //         // "****************${prod.inCartItems}");
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                  IconButtonF(
                                    backgroundColor: Colors.transparent,
                                    icon: Icons.add,
                                    inconSize: 12.0,
                                    semanticLabel: "Ajouter",
                                    onTap: () {
                                      print(cartM.id);
                                      cart.updateQuantityProduit(
                                          cartM.id, true); // Get.back();
                                    },
                                  ),
                                  Container(
                                    width: kSmWidth * .2,
                                    // margin:
                                    //     EdgeInsets.only(top: Get.height * .005),
                                    child: smallText(
                                        text: cartM.quantity.toString(),
                                        bolder: true,
                                        size: 15),
                                  ),
                                  IconButtonF(
                                    backgroundColor: Colors.transparent,
                                    icon: Icons.remove,
                                    semanticLabel: "Reduire",
                                    inconSize: 12.0,
                                    onTap: () {
                                      cart.updateQuantityProduit(
                                          cartM.id, false); // Get.back();
                                    },
                                  ),
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
