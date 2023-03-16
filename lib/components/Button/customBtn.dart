// ignore: must_be_immutable
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBtn extends StatelessWidget {
  var title, onTap, color, validator;

  CustomBtn({this.validator, this.title, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            width: Get.size.width * 0.35,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (color == null) ? ColorsApp.blue : color,
            ),
            child: ((validator == null) ? false : validator)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : smallText(text: title)));
  }
}
