import 'dart:io';

import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/commentForm.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Text/bigtitleText0.dart';
import 'package:Fahkap/components/Widget/app_back_button.dart';
import 'package:Fahkap/components/Widget/cardBoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/imageComp.dart';
import 'package:Fahkap/components/Widget/productBoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/Widget/app_title_right.dart';

class BoutiqueUserView extends StatelessWidget {
  BoutiqueUserView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  TextEditingController name = TextEditingController();
  TextEditingController titre = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      // Get.find<BoutiqueController>().getCategory();
      return Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(bottom: kMarginY * 2),
          decoration: BoxDecoration(color: ColorsApp.grey),
          padding: EdgeInsets.only(
              left: kMdWidth / 6,
              right: kMdWidth / 6,
              top: kMarginY * 2.2,
              bottom: kMarginY * 2.2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(child: AppBackButton()),
            Container(
              child: AppTitleRight(
                  title: 'yboutique'.tr, description: 'ysboutique'.tr, icon: null),
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .005),
            ),
          ]),
        ),
        SingleChildScrollView(
            child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CardBoutiqueComponent(
                title: 'Produits', link: AppLinks.PRODUCT_FOR_BOUTIQUE),
            CardBoutiqueComponent(
              title: 'Commandes',
              link: AppLinks.COMMANDE_FOR_BOUTIQUE,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CardBoutiqueComponent(
                title: 'Historiques', link: AppLinks.HISTORIQUE_FOR_BOUTIQUE),
            CardBoutiqueComponent(
                title: 'Gerer votre Boutique ',
                link: AppLinks.MANAGE_FOR_BOUTIQUE),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CardBoutiqueComponent(
                title: 'SHort', link: AppLinks.SHORT_BOUTIQUE),
            // CardBoutiqueComponent(
            //     title: 'Compte ', link: AppLinks.COMPTE_FOR_BOUTIQUE),
          ]),
        ]))
      ]));
    });
  }
}
