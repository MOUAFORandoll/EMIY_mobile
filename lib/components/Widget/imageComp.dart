import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageComp extends StatelessWidget {
  File file;
  int index;
  ImageComp({
    required this.file,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: kMdHeight / 5,
      width: Get.width / 3,
      child: Image.file(
        file,
        fit: BoxFit.cover,
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      //   image: DecorationImage(
      //       image: AssetImage(file.path),
      //       fit: BoxFit.cover,
      //       colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
      // ),
    );
  }
}
