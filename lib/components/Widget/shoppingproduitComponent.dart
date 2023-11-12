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
          height: kMdHeight * .115,
          width: kMdWidth,
          padding: EdgeInsets.only(bottom: kMarginY * 2),
          margin:
              EdgeInsets.symmetric(horizontal: kMarginX, vertical: kMarginY),
          decoration: BoxDecoration(
              /*  color: ColorsApp.grey, */ border:
                  Border(bottom: BorderSide(color: ColorsApp.grey))),
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
                                      width: kWidth * .5,
                                      margin: EdgeInsets.only(
                                          top: Get.height * .005,
                                          left: kWidth * .05),
                                      child: smallText(
                                          text: cartM.name,
                                          bolder: true,
                                          al: true,
                                          color: ColorsApp.primaryText,
                                          size: kBasics)),
                                  Container(
                                      width: kWidth * .4,
                                      margin: EdgeInsets.only(
                                          top: Get.height * .005,
                                          left: kWidth * .05),
                                      child: smallText(
                                          text: 'XAF ' + cartM.prix.toString(),
                                          al: true,
                                          color: ColorsApp.primaryText,
                                          size: kBasics)),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: kHeight * .035,
                                        left: kWidth * .025),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButtonF1(
                                          icon: Icons.remove,
                                          inconSize: 15.0,
                                          onTap: () {
                                            cart.updateQuantityProduit(
                                                cartM.id, false);
                                          },
                                        ),
                                        Container(
                                            width: kSmWidth * .2,
                                            // margin:
                                            //     EdgeInsets.only(top: Get.height * .005),
                                            child: smallText(
                                                text: cartM.quantity.toString(),
                                                color: ColorsApp.primaryText,
                                                bolder: true,
                                                size: 15)),
                                        IconButtonF1(
                                          icon: Icons.add,
                                          inconSize: 15.0,
                                          onTap: () {
                                            cart.updateQuantityProduit(
                                                cartM.id, true);
                                            //print(
                                            // "****************${prod.inCartItems}");
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                        GetBuilder<CartController>(builder: (cart) {
                          return Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => cart.removeItem(cartM.id),
                                child: Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorsApp
                                            .secondBlue /*  ColorsApp.orange */),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: ColorsApp
                                        .secondBlue /*  ColorsApp.orange */,
                                    size: 12,
                                    semanticLabel: 'Close',
                                  ),
                                ),
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
