// ignore: must_be_immutable
 
import 'package:EMIY/components/Text/SimpleText.dart'; 
import 'package:EMIY/components/Text/bigtitleText0.dart'; 
import 'package:EMIY/model/data/TransactionModel.dart';
import 'package:EMIY/styles/textStyle.dart'; 
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
        margin: EdgeInsets.symmetric(
            horizontal: kMarginX / 2, vertical: kMarginY / 2),
        decoration: BoxDecoration(
            color: ColorsApp.grey, borderRadius: BorderRadius.circular(8)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(left: Get.width * .008),
                  child: Icon(transaction.typeTransactionId == 1
                      ? Icons.transit_enterexit
                      : Icons.transfer_within_a_station)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // width: kSmWidth * .6,
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: BigtitleText0(
                        text: /* 'Transaction : ' +  */
                            transaction.typeTransaction,
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
                  //           decorationColor:  ColorsApp.black,
                  //           decorationThickness: 2.85,
                  //           color:  ColorsApp.black,
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
