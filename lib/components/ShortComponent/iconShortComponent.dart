
import 'package:EMIY/styles/textStyle.dart'; 
import 'package:flutter/material.dart'; 

class IconShortComponent extends StatelessWidget {
  IconShortComponent(
      {required this.icon,
      required this.onTap,
      this.color = Colors.white,
      this.nbr = ''});

  final onTap, icon, color, nbr;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: kMarginY * 2, horizontal: kMarginX),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: kMarginY),
                  child: Text(nbr.toString(),
                      style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
        onTap: onTap);
  }
}
