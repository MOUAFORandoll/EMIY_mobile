import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class AppTextDivider extends StatelessWidget {
  final String texte;

  AppTextDivider({
    Key? key,
    required this.texte,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: kHeight / 10,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Text(texte),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          height: 0.5,
          decoration: BoxDecoration(color: ColorsApp.secondBlue),
        )
      ],
    ));
  }
}
