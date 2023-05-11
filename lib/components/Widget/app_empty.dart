// ignore: must_be_immutable import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/components/Button/app_button.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
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
