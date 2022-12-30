import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconButtonF extends StatelessWidget {
  var icon, color, onTap, inconSize, backgroundColor;
  IconButtonF(
      {this.icon,
      this.color = Colors.white,
      this.backgroundColor = Colors.white,
      this.inconSize = 20.0,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: backgroundColor),
        child: Icon(icon, color: color, size: inconSize),
      ),
      onTap: onTap,
    );
  }
}
