// ignore: must_be_immutable import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryComponent extends StatelessWidget {
  CategoryModel category;

  CategoryComponent({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppLinks.BOUTIQUE_FOR_CATEGORY +
              '?id=${category.id}&libelle=${category.libelle}');
        },
        child: Container(
          // height: kSmHeight,
          // width: kSmWidth,
          alignment: Alignment.center,
          padding: EdgeInsets.all(kMarginX / 2),
          margin: EdgeInsets.only(right: kMarginX),
          decoration: BoxDecoration(
              border: Border.all(color: ColorsApp.greyFirst),
              borderRadius: BorderRadius.circular(8)),
          child: Text(category.libelle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ColorsApp.greyFirst, fontSize: 12)),
        ));
  }
}
