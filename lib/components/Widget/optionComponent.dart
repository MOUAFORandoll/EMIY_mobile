import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';

// ignore: must_be_immutable
class OptionComponent extends StatelessWidget {
  OptionComponent({this.title, this.selected = false, this.onTap});
  final title, onTap;

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
              top: Get.height * .04,
              bottom: Get.height * .04,
              left: Get.width * .01,
              right: Get.width * .01),
          decoration: BoxDecoration(
            color: this.selected ? ColorsApp.grey : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(this.title), Icon(Icons.arrow_forward_ios_sharp)],
          ),
        ));
  }
}
