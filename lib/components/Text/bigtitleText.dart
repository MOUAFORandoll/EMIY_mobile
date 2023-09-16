import 'package:EMIY/styles/theme.dart'; 
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/textStyle.dart';

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
        constraints: BoxConstraints(maxWidth: kWidth),
        child: Text(text,
            overflow: TextOverflow.ellipsis,
            // textAlign: TextAlign.left,
            style: bolder
                ? TexteStyle().blargeTextStyle
                : TexteStyle().largeTextStyle));
  }
}
/*
  
                */