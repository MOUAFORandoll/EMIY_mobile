import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:fahkapmobile/styles/textStyle.dart';

// ignore: must_be_immutable
class BigtitleText0 extends StatelessWidget {
  String text;
  // String content;
  bool bolder;
  BigtitleText0({this.text = '', this.bolder = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: bolder ? FontWeight.bold : FontWeight.normal),
        ));
  }
}
