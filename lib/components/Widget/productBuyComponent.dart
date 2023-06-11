// ignore: must_be_immutable
import 'package:EMIY/model/data/CartModel.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductBuyComponent extends StatelessWidget {
  CartModel cartModel;

  ProductBuyComponent({required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: Get.height * .6,
        width: Get.width * .5,
        padding: EdgeInsets.all(0),
        // decoration: BoxDecoration(
        //     color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: Text(cartModel.name)),
              Container(
                // margin: EdgeInsets.only(left: Get.width * .008),
                child: Text(cartModel.prix.toString(),
                    style: TextStyle(fontSize: 15)),
              ),
              Container(
                // margin: EdgeInsets.only(left: Get.width * .008),
                child: Text(cartModel.quantity.toString(),
                    style: TextStyle(fontSize: 15)),
              ),
              Container(
                // margin: EdgeInsets.only(left: Get.width * .008),
                child: Text((cartModel.prix * cartModel.quantity).toString(),
                    style: TextStyle(fontSize: 15)),
              ),
            ]));
  }
}
