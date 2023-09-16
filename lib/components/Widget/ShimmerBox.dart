import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart'; 
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ShimmerBox extends StatelessWidget {
  ShimmerBox({this.height});
  var height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorsApp.grey,
        highlightColor: Colors.blueGrey,
        child: Container(
            height: kHeight / 4,
            // width: kMdWidth * 1.1,
            alignment: Alignment.center,
            // padding: EdgeInsets.all(kMarginX),
            // margin: EdgeInsets.only(right: kMarginX),
            decoration: BoxDecoration(
                color: ColorsApp.greySecond,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: height ?? kMdHeight * .15,
                      // width: Get.width * .5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/logo/logoNew.png'),
                      ))),
                ])));
  }
}
