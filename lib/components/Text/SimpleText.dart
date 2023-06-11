import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/textStyle.dart';

// ignore: must_be_immutable
class SimpleText extends StatelessWidget {
  String text;
  // String content;
  bool bolder;
  SimpleText({this.text = '', this.bolder = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: bolder ? FontWeight.bold : FontWeight.normal),
    ));
  }
}
