import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppIconButton extends StatelessWidget {
  var icon, color, onTap, inconSize, backgroundColor;
  AppIconButton(
      {this.icon,
      this.color = ColorsApp.greenLight,
      this.backgroundColor = Colors.white,
      this.inconSize = 22.0,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        child: Icon(icon, color: color, size: inconSize),
      ),
      onTap: onTap,
    );
  }
}
