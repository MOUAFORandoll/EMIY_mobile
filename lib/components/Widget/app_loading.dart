// ignore: must_be_immutable import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: kHeight * .85,
      alignment: Alignment.center,
      child: Shimmer.fromColors(
        baseColor: ColorsApp.bleuLight,
        highlightColor: ColorsApp.grey,
        child: Container(
          padding: EdgeInsets.all(100),
          child: Image.asset(
            Assets.shop1,
          ),
        ),
      ),
    );
  }
}
