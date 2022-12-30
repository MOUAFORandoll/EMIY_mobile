// ignore: must_be_immutable
import 'package:flutter/material.dart';

class ParticularBtn extends StatelessWidget {
  String? subtitle;
  IconData? icon;
  Function? onTap;
  Color? color;

  ParticularBtn({this.icon, this.color, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onTap,
          child: Icon(
            icon,
            size: 25,
            color: (color == null) ? Colors.grey : color,
          ),
        ),
        Text(
          subtitle!,
          style: TextStyle(
            fontFamily: 'orkney',
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
