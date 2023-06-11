// ignore: must_be_immutable import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingComponent extends StatelessWidget {
  Widget action;
  String title = '';
  var onTap;
  SettingComponent(
      {required this.title, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            height: kSmHeight,
            // width: kSmWidth,
            padding: EdgeInsets.all(kMarginX),
            margin: EdgeInsets.symmetric(horizontal: kMarginX, vertical: 5),
            decoration: BoxDecoration(
                // gradient: GradientApp.blueG,
                color: ColorsApp.greySecond,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: kSmWidth * .6,
                    margin: EdgeInsets.only(
                        top: Get.height * .005, left: Get.width * .008),
                    child: Text(title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ),
                  action
                ])),
        onTap: onTap);
  }
}
