import 'dart:io';

import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
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
          margin: EdgeInsets.only(right: 5),
          height: kMdHeight / 5,
          width: Get.width / 3,
          child: Image.file(
            file,
            fit: BoxFit.cover,
          )),
      Positioned(
          left: 0,
          top: 0,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              padding: EdgeInsets.all(5),
              child: InkWell(
                  child: Icon(Icons.close, color: Colors.red),
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
