import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:Fahkap/styles/textStyle.dart';

// ignore: must_be_immutable
class smallText extends StatelessWidget {
  String text;
  Color color;
  bool bolder;
  double size;
  bool al;
  double width;
  // String content;
  // bool marginBool;
  smallText(
      {this.text = '',
      this.color = Colors.black,
      this.bolder = false,
      this.al = false,
      this.size = 12,
      this.width = 0.0});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width == 0 ? kSmWidth * .8 : width,
        alignment: al ? null : Alignment.center,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: size,
              color: color,
              fontWeight: bolder ? FontWeight.bold : FontWeight.normal),
        ));
  }
}
