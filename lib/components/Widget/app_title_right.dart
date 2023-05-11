import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTitleRight extends StatelessWidget {
  AppTitleRight(
      {required this.title, required this.description, required this.icon});
  final String description;
  final icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Row(
        children: [
          Container(
              child: Text(
            title,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: ColorsApp.black,
                fontWeight: FontWeight.bold),
          )),
          Container(
              child: icon != null
                  ? SvgPicture.asset(
                      icon,
                      width: 18,
                      height: 18,
                      color: ColorsApp.black,
                    )
                  : null),
        ],
      ),
      Container(
          child: Text(
        description,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          fontSize: 11,
          color: ColorsApp.black,
          fontFamily: 'Montserrat',
        ),
      ))
    ]));
  }
}
