// ignore: must_be_immutable
import 'package:flutter/material.dart';

class ParticularBtn extends StatelessWidget {
  final String? subtitle;
  final IconData? icon;
  final Function? onTap;
  final Color? color;

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
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
