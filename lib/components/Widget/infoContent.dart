import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:Fahkap/styles/textStyle.dart';

// ignore: must_be_immutable
class InfoContent extends StatelessWidget {
  String title;
  String content;
  bool marginBool;
  InfoContent({this.title = '', this.content = '', this.marginBool = false});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              margin: this.marginBool
                  ? EdgeInsets.only(left: kMarginLeft / 5)
                  : EdgeInsets.all(0),
              child: Text(
                title + ' :',
              ))),
      Expanded(
        child: Text(content),
      )
    ]);
  }
}
