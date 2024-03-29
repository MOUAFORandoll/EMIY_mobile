import 'dart:io';

import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:get/get.dart';
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
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          margin: EdgeInsets.only(right: 5),
          height: kMdHeight / 5,
          width: Get.width / 3,
          child: Image.file(
            file,
            fit: BoxFit.cover,
          )),
      Positioned(
          right: 0,
          top: 0,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              padding: EdgeInsets.all(5),
              child: InkWell(
                  child: Icon(Icons.close, color: Colors.red, size: 15),
                  onTap: () async {
                    await Get.find<BoutiqueController>().deleteImage(index);
                  })))
    ]

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
