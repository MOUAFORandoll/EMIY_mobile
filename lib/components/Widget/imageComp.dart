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
        child: CachedNetworkImage(
          height: kMdHeight / 9,
          width: Get.width / 3,
          fit: BoxFit.cover,
          imageUrl: file.uri.toFilePath(),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
              ),
            );
          },
          placeholder: (context, url) {
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                color: ColorsApp.skyBlue,
              )),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                image: DecorationImage(
                    image: AssetImage("assets/images/error.gif"),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
              ),
            );
          },
        ));
  }
}
