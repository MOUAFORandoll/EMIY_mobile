import 'dart:async';

import 'package:EMIY/Views/Shopping/PaiementView.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/formComponent.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Widget/DeliveryComponent.dart';
import 'package:EMIY/components/Widget/pointLivraisonComponent.dart';
import 'package:EMIY/components/Widget/SelectComponent.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_input.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/icon_svg.dart';
import 'package:EMIY/components/Widget/produitBuyComponent.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/BuyShopController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/model/data/ModePaiementModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';

// ignore: must_be_immutable
class SelectPaiementMode extends StatelessWidget {
  SelectPaiementMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<BuyShopController>().onInit();
    Get.find<ManagerController>().getLocalU();
    return GetBuilder<GeneralController>(
        builder: (_Acontroller) => Container(
            height: Get.height * .8,
            padding: EdgeInsets.symmetric(
              vertical: kMarginY,
              horizontal: kMarginX,
            ),
            margin: EdgeInsets.only(
              top: kMarginY * 8,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: Colors.white),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(
                    top: kMarginY,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'paymentM'.tr,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      InkWell(
                        child: Icon(Icons.close),
                        onTap: () {
                          Get.back();
                        },
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kMarginY * 4,
                  ),
                  child: SingleChildScrollView(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _Acontroller.lmodePaiement.length,
                          itemBuilder: (_ctx, index) => SelectComponent(
                              select: index + 1 == _Acontroller.selected,
                              mode: _Acontroller.lmodePaiement[index]))))
            ])));
  }
}
