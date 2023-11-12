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
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: kMarginY / 2),
        decoration: BoxDecoration(
            color: ColorsApp.grey, borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    // width: kSmWidth * .6,

                    child: SimpleText(
                  text: /* 'Transaction : ' +  */
                      transaction.typeTransaction,
                  bolder: true,
                )),
                Container(
                    child: Text(
                  'Fait le : ' + transaction.dateCreated.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: kDescription,
                    fontFamily: 'Lato',
                  ),
                )),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                  children: [
                    Container(
                        child: Text(
                      'XAF ',
                      style: TextStyle(
                        fontSize: kDescription,
                        fontFamily: 'Lato',
                      ),
                    )),
                    Container(
                        child: Text(
                      transaction.montant.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: kTitle,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800),
                    )),
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Container(
                        child: Text(
                      'Etat : ',
                      style: TextStyle(
                        fontSize: kDescription,
                        fontFamily: 'Lato',
                      ),
                    )),
                    Container(
                        child: Text(
                      transaction.status.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Lato', fontWeight: FontWeight.w800),
                    )),
                    Container(
                        margin: EdgeInsets.only(left: kMarginX),
                        child: Icon(
                          transaction.status == 'Valide'
                              ? Icons.verified_rounded
                              : Icons.close,
                          color: transaction.status == 'Valide'
                              ? ColorsApp.skyBlue
                              : ColorsApp.red,
                        )),
                  ],
                )),
              ],
            ),
          ),
        ]),
      ),
      onTap: () {},
    );
  }
}
