import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBoxBoutique extends StatelessWidget {
  ShimmerBoxBoutique({this.height});
  var height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.blueGrey,
        highlightColor: Colors.greenAccent,
        child: Container(
            height: kHeight * .15,
            decoration: BoxDecoration(
              color: ColorsApp.greySecond,
              borderRadius: BorderRadius.circular(50),
            )));
  }
}
