import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTitleRight extends StatelessWidget {
  AppTitleRight(
      {required this.title,
      required this.description,
      required this.icon,
      this.onTap,
      this.center = false});
  final String description;
  final icon;
  final String title;
  final onTap;
  final center;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            child: Column(
                crossAxisAlignment:
                    center ? CrossAxisAlignment.center : CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                          child: Text(
                        title,
                        textAlign: center ? TextAlign.center : TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: ColorsApp.black,
                            fontWeight: FontWeight.w600),
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
                    textAlign: center ? TextAlign.center : TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 11,
                      color: ColorsApp.black,
                      fontFamily: 'Lato',
                    ),
                  ))
                ]),
            onTap: onTap));
  }
}
