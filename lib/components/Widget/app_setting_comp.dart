import 'package:EMIY/components/Widget/icon_svg.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/textStyle.dart';

// ignore: must_be_immutable
class AppSettingComp extends StatelessWidget {
  String title;
  var icon;
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
            color: ColorsApp.greySecond,
            borderRadius: BorderRadius.circular(7),
          ),
          padding: EdgeInsets.symmetric(
              vertical: kMarginY * 2, horizontal: kMarginX),
          margin: EdgeInsets.all(
            2,
          ),

          // alignment: Alignment.topLeft,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.5),
                ),
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.only(right: kMarginX * 2),
                child: SvgIcon(icon: icon)),
            /*  Expanded(
                child: */
            Container(
                child: Text(title,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600)) /* ) */),
            // Container(
            //     child: Icon(
            //   Icons.keyboard_arrow_right_sharp,
            //   color: ColorsApp.greySecond,
            // )),
          ])),
      onTap: onTap);
}
