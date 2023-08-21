// import 'dart:io';

// import 'package:EMIY/components/Button/AppIconButton.dart';
// import 'package:EMIY/components/Button/IconButtonF.dart';
// import 'package:EMIY/components/Button/customBtn.dart';
// import 'package:EMIY/components/Form/commentForm.dart';
// import 'package:EMIY/components/Form/formComponent.dart';
// import 'package:EMIY/components/Form/formComponent2.dart';
// import 'package:EMIY/components/Text/bigText.dart';
// import 'package:EMIY/components/Text/bigtitleText.dart';
// import 'package:EMIY/components/Text/bigtitleText0.dart';
// import 'package:EMIY/components/Widget/app_back_button.dart';
// import 'package:EMIY/components/Widget/cardBoutiqueComponent.dart';
// import 'package:EMIY/components/Widget/categoryComponent.dart';
// import 'package:EMIY/components/Text/smallText.dart';
// import 'package:EMIY/components/Widget/imageComp.dart';
// import 'package:EMIY/components/Widget/produitBoutiqueComponent.dart';
// import 'package:EMIY/components/Widget/shoppingproduitComponent.dart';
// import 'package:EMIY/controller/boutiqueController.dart';
// import 'package:EMIY/controller/cartController.dart';
// import 'package:EMIY/styles/colorApp.dart';
// import 'package:EMIY/styles/textStyle.dart';
// import 'package:EMIY/utils/Services/routing.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../components/Widget/app_title_right.dart';

// class BoutiqueUserView extends StatelessWidget {
//   BoutiqueUserView({Key? key}) : super(key: key);
//   ScrollController _scrollController = new ScrollController();

//   TextEditingController name = TextEditingController();
//   TextEditingController titre = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController pass = TextEditingController();
//   TextEditingController repass = TextEditingController();
//   TextEditingController email = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<BoutiqueController>(builder: (_controller) {
//       // Get.find<BoutiqueController>().getCategory();
//       return Scaffold(
//           body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//         Container(
//           margin: EdgeInsets.only(bottom: kMarginY * 2),
//           decoration: BoxDecoration(color: ColorsApp.grey),
//           padding: EdgeInsets.only(
//               left: kMdWidth / 6,
//               right: kMdWidth / 6,
//               top: kMarginY * 2.2,
//               bottom: kMarginY * 2.2),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Container(child: AppBackButton()),
//             Container(
//               child: AppTitleRight(
//                   title: 'yboutique'.tr,
//                   description: 'ysboutique'.tr,
//                   icon: null),
//               margin: EdgeInsets.only(
//                   right: MediaQuery.of(context).size.width * .005),
//             ),
//           ]),
//         ),
//         SingleChildScrollView(
//             child: Column(children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             CardBoutiqueComponent(
//                 title: 'Produits', link: AppLinks.PRODUCT_FOR_BOUTIQUE),
//             CardBoutiqueComponent(
//               title: 'Commandes',
//               link: AppLinks.COMMANDE_FOR_BOUTIQUE,
//             ),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             CardBoutiqueComponent(
//                 title: 'Historiques', link: AppLinks.HISTORIQUE_FOR_BOUTIQUE),
//             CardBoutiqueComponent(
//                 title: 'Gerer votre Boutique ',
//                 link: AppLinks.MANAGE_FOR_BOUTIQUE),
//           ]),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             CardBoutiqueComponent(
//                 title: 'SHort', link: AppLinks.SHORT_BOUTIQUE),
//             // CardBoutiqueComponent(
//             //     title: 'Compte ', link: AppLinks.COMPTE_FOR_BOUTIQUE),
//           ]),
//         ]))
//       ]));
//     });
//   }
// }
