import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  SvgIcon({this.width = 18, this.height = 18, required this.icon});
  final double height;
  final icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: icon != null
            ? SvgPicture.asset(
                icon,
                width: width,
                height: height,
              )
            : null);
  }
}
