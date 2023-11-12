import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/model/data/ModePaiementModel.dart';
import 'package:EMIY/styles/textStyle.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:get/get.dart';

import '../../utils/constants/assets.dart';

// ignore: must_be_immutable
class EmptyShopComponent extends StatelessWidget {
  var type;
  EmptyShopComponent({this.type = 0});

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: kHeight / 6),
        padding: EdgeInsets.symmetric(vertical: kMarginY),
        decoration: BoxDecoration(
          // color: ColorsApp.white,

          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: kHeight / 3.5,
                margin: EdgeInsets.only(left: kMarginX),
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage(Assets.empty_shop)))),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kMarginX, vertical: kMarginY),
                child: Text(
                  "Hey, Your Cart Is Empty !",
                  style:
                      TextStyle(fontSize: kBasics, fontWeight: FontWeight.w700),
                )),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kMarginX, vertical: kMarginY),
                child: Text(
                  "Retourner en arriere et ajouter des produits a votre panier.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: kDescription,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(bottom: kMarginY),
                padding: EdgeInsets.symmetric(
                    horizontal: kMarginX, vertical: kMarginY),
                child: AppButton(
                  size: MainAxisSize.max,
                  bgColor: ColorsApp.skyBlue,
                  text: 'Go Back',
                  onTap: () {
                    type == 1
                        ? Get.back()
                        : Get.find<GeneralController>().setGoHome();
                  },
                ))
          ],
        ));
  }
}
