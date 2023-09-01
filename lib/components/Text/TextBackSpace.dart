import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/textStyle.dart';

// ignore: must_be_immutable
class TextBackSpace extends StatelessWidget {
  String text;
  // String content;
  bool bolder;
  Color color;
  TextBackSpace(
      {this.text = '',
      this.color = ColorsApp.primaryText,
      this.bolder = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: kWidth / 1.5),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: color,
              fontWeight: bolder ? FontWeight.bold : FontWeight.normal),
        ));
  }
}
