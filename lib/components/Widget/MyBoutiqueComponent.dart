// ignore: must_be_immutable
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/model/data/BoutiqueUserModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyBoutiqueComponent extends StatelessWidget {
  BoutiqueUserModel boutique;

  MyBoutiqueComponent({required this.boutique});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(
      builder: (_bcontroller) => Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorsApp.secondBlue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorsApp.secondBlue, width: 1.5),
          ),
          constraints:
              BoxConstraints(minHeight: kHeight / 8, minWidth: kWidth / 2.4),
          child: Stack(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      boutique.titre,
                      style: TextStyle(
                        fontSize: kBasics,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        // color: ColorsApp.whitecolor,
                      ),
                    )),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "20 produits",
                          style: TextStyle(
                            fontSize: kBasics,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            // color: ColorsApp.whitecolor,
                          ),
                        )),
                  ]),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: Icon(
                    Icons.access_time_filled,
                    color: ColorsApp.white,
                  ))
            ],
          )),
    );
  }
}
