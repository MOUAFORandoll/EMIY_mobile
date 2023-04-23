import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:Fahkap/styles/textStyle.dart';

// ignore: must_be_immutable
class AppSettingComp extends StatelessWidget {
  String title;
  IconData icon;
  var onTap;
  Color color;
  AppSettingComp(
      {required this.title,
      required this.icon,
      required this.onTap,
      this.color = ColorsApp.greySecond});
  @override
  Widget build(BuildContext context) => InkWell(
      child: Container(
          decoration: BoxDecoration(
            color: ColorsApp.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding:
              EdgeInsets.symmetric(vertical: kMarginY, horizontal: kMarginX),
          margin: EdgeInsets.symmetric(
            vertical: kMarginY,
          ),
          child: Row(children: [
            Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.5),
                ),
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.only(right: kMarginX * 2),
                child: Icon(icon, size: 20)),
            Expanded(
                child: Container(
                    child: Text(title,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600)))),
            Container(
                child: Icon(
              Icons.keyboard_arrow_right_sharp,
              color: ColorsApp.greySecond,
            )),
          ])),
      onTap: onTap);
}
