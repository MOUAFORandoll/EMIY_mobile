// ignore: must_be_immutable import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBoutiqueOption extends StatelessWidget {
  String title;
  var onTap;
  bool select;
  AppBoutiqueOption(
      {required this.title, required this.onTap, required this.select});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          // height: kSmHeight,
          // width: kSmWidth,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              vertical: kMarginY / 50, horizontal: kMarginX * 2),
          margin: EdgeInsets.only(right: kMarginX),
          decoration: BoxDecoration(
              color: select ? ColorsApp.bleuLight : null,
              border: Border.all(
                color: select ? ColorsApp.bleuLight : ColorsApp.grey,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Text(title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ColorsApp.grey, fontSize: 12)),
        ));
  }
}
