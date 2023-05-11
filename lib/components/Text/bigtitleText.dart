import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:Fahkap/styles/textStyle.dart';

// ignore: must_be_immutable
class BigtitleText extends StatelessWidget {
  String text;
  var color;
  double size;
  // String content;
  bool bolder;
  BigtitleText(
      {this.text = '',
      this.size = 14,
      this.bolder = false,
      this.color = ColorsApp.black});
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: kWidth / 1.5),
        child: Text(text,
            overflow: TextOverflow.ellipsis,
            // textAlign: TextAlign.left,
            style: TextStyle(
                color: color,
                fontWeight: bolder ? FontWeight.bold : FontWeight.normal,
                fontSize: size)));
  }
}
/*
  
                */