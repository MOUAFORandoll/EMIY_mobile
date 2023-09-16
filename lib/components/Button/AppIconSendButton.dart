import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppIconSendButton extends StatelessWidget {
  var icon, color, onTap, inconSize, backgroundColor, sending;
  AppIconSendButton(
      {this.icon,
      this.backgroundColor = ColorsApp.secondBlue,
      this.color = Colors.white,
      this.inconSize = 22.0,
      this.sending = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(
          left: 2,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        child: sending
            ? Container(
                width: 22, height: 22, child: CircularProgressIndicator())
            : Icon(icon, color: color, size: inconSize),
      ),
      onTap: onTap,
    );
  }
}
