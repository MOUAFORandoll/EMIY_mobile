// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Text/QteText.dart';
import 'package:EMIY/components/Text/SimpleText.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText0.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/productController.dart';
import 'package:EMIY/model/data/CartModel.dart';
import 'package:EMIY/model/data/TransactionModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TransactionComponent extends StatelessWidget {
  TransactionModel transaction;

  TransactionComponent({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: kMdHeight * .13,
        width: kMdWidth,
        // padding: EdgeInsets.all(kMarginX),
        margin: EdgeInsets.symmetric(horizontal: kMarginX, vertical: kMarginY),
        decoration: BoxDecoration(
            color: ColorsApp.grey, borderRadius: BorderRadius.circular(8)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(left: Get.width * .008),
                        child: Icon(transaction.typeTransactionId == 1
                            ? Icons.transit_enterexit
                            : Icons.transfer_within_a_station))
                  ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // width: kSmWidth * .6,
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: BigtitleText0(
                        text: 'Transaction : ' + transaction.typeTransaction,
                        bolder: true,
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: SimpleText(
                        text: 'Montant : XAF ' + transaction.montant.toString(),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: SimpleText(
                        text: 'Fait le : ' + transaction.dateCreated.toString(),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: SimpleText(
                        text: 'Etat : ' + transaction.status.toString(),
                      )),
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
      ),
      onTap: () {},
    );
  }
}
