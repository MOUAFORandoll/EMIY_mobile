// ignore: must_be_immutable import 'package:EMIY/model/data/CategoryModel.dart';
 
import 'package:EMIY/styles/textStyle.dart'; 
import 'package:EMIY/utils/constants/assets.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kWidth,

      // color: Colors.white,
      child: Shimmer.fromColors(
          baseColor: ColorsApp.grey,
          highlightColor: Colors.blueGrey,
          child: SvgPicture.asset(
            Assets.logoSvg,
            width: kWidth,
            height: kHeight,
          )),
    );
  }
}
