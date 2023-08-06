// ignore: must_be_immutable import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTabComponent extends StatelessWidget {
  var libelle, onTap;
  bool selected;
  AppTabComponent({required this.libelle, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 5,
          // width: kSmWidth,
          alignment: Alignment.center,
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.only(right: kMarginX),
          decoration: BoxDecoration(
              color: selected ? Colors.red : Colors.transparent,
              border: Border.all(
                  color: selected ? Colors.red : ColorsApp.greyFirst),
              borderRadius: BorderRadius.circular(12)),
          child: Text(libelle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: !selected ? ColorsApp.greyFirst : ColorsApp.white,
                  fontSize: 12)),
        ));
  }
}
