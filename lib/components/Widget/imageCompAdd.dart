import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageCompAdd extends StatelessWidget {
  int id;
  ImageCompAdd({
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(
        builder: (_controller) => InkWell(
              child: Container(
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 1)
                      .add(EdgeInsets.only(right: kMarginX)),
                  height: kMdHeight * .2,
                  width: Get.width * .3,
                  decoration: BoxDecoration(
                    color: ColorsApp.greySecond,
                    borderRadius: BorderRadius.circular(8),
                  )),
              onTap: () {
                _controller.addProduitImage(id);
              },
            ));
  }
}
