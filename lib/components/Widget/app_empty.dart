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
class AppEmpty extends StatelessWidget {
  AppEmpty({this.title = 'Vide'});
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.warning, size: 50),
            SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
