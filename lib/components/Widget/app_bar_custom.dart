// ignore: must_be_immutable import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/components/Button/app_button.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget {
  String title;
  String titleBtn;
  var onTap;
  AppBarCustom(
      {required this.title, required this.titleBtn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: ColorsApp.grey, borderRadius: BorderRadius.circular(9)),
        padding: EdgeInsets.only(left: kMdWidth / 10, top: 2, bottom: 2),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: Get.size.width * 0.4,
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'orkney',
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 11),
              )),
          Container(
              width: Get.size.width * 0.25,

              // margin: EdgeInsets.only(bottom: kMarginY),
              child: AppButton(
                  size: MainAxisSize.max,
                  bgColor: ColorsApp.skyBlue,
                  text: titleBtn,
                  onTap: onTap))
        ]));
  }
}
