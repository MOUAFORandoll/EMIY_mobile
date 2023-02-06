import 'dart:io';

import 'package:fahkapmobile/components/Button/AppIconButton.dart';
import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Form/commentForm.dart';
import 'package:fahkapmobile/components/Form/formComponent.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Widget/cardBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Widget/imageComp.dart';
import 'package:fahkapmobile/components/Widget/productBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/shoppingproductComponent.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Container(
        //   decoration: BoxDecoration(color: ColorsApp.grey),
        //   padding: EdgeInsets.only(
        //       left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
        //   alignment: Alignment.topLeft,
        //   child: smallText(
        //     text: 'Nom Boutique',
        //   ),
        // ),
        Container(
            margin: EdgeInsets.only(bottom: kMarginY * 2),
            decoration: BoxDecoration(color: ColorsApp.grey),
            padding: EdgeInsets.only(
                left: kMdWidth / 6,
                right: kMdWidth / 6,
                top: kMarginY * 2.2,
                bottom: kMarginY * 2.2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(
                    text: _controller.Boutique.titre,
                  ),
                  // CustomBtn(
                  //   color: ColorsApp.greenLight,
                  //   title:
                  //       _controller.addProduct ? 'Retour' : 'Ajouter Produit',
                  //   onTap: () {
                  //     _controller.chageState(!_controller.addProduct);
                  //   },
                  // )
                ])),

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
            // CardBoutiqueComponent(
            //     title: 'Transaction Compte',
            //     link: AppLinks.HISTORIQUE_FOR_BOUTIQUE),
            // CardBoutiqueComponent(
            //     title: 'Compte ', link: AppLinks.COMPTE_FOR_BOUTIQUE),
          ]),
        ]))
      ]);
    });
  }
}
