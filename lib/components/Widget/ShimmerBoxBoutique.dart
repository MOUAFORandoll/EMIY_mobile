import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ShimmerBoxBoutique extends StatelessWidget {
  ShimmerBoxBoutique({this.height});
  var height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorsApp.grey,
        highlightColor: Colors.blueGrey,
        child: Container(
            height: kHeight * .2,
            width: kHeight * .15,
            decoration: BoxDecoration(
              color: ColorsApp.greySecond,
              borderRadius: BorderRadius.circular(50),
            )));
  }
}
