import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:fahkapmobile/styles/textStyle.dart';

// ignore: must_be_immutable
class smallText extends StatelessWidget {
  String text;
  Color color;
  bool bolder;
  double size;
  // String content;
  // bool marginBool;
  smallText({this.text = '', this.color = Colors.black, this.bolder = false, this.size = 12});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: kSmWidth * .8,
        alignment: Alignment.center,
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
