import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

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
                  child: Text(nbr.toString()))
            ],
          ),
        ),
        onTap: onTap);
  }
}
