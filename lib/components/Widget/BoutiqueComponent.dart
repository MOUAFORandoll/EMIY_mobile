// ignore: must_be_immutable
import 'package:fahkapmobile/Views/Category/ProductCategoryView.dart';
import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BoutiqueComponent extends StatelessWidget {
  BoutiqueModel boutique;

  BoutiqueComponent({required this.boutique});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
            AppLinks.BOUTIQUE + '?codeBoutique=${boutique.codeBoutique}');
      },
      child: Container(
          height: kSmHeight * 3,
          width: kSmWidth * .9,
          alignment: Alignment.center,
          padding: EdgeInsets.all(kMarginX),
          margin: EdgeInsets.all(Get.size.width * .02),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Text(
            boutique.titre,
            textAlign: TextAlign.center,
          )),
    );
  }
}
