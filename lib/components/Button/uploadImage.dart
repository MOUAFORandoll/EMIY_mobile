// ignore: must_be_immutable
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadImage extends StatelessWidget {
  var title, onTap, color, icon;

  UploadImage({this.icon, this.title, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            width: Get.size.width / 2.35,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            margin: EdgeInsets.all(5),
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorsApp.greySecond)
                // color: (color == null) ? ColorsApp.blue : color,
                ),
            child: Column(
              children: [
                Center(
                  child: Icon(icon, color: color),
                ),
                smallText(text: title, color: color),
              ],
            )));
  }
}
