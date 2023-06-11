import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';

class TownComponent extends StatefulWidget {
  TownComponent({this.ville = 'douala'});
  var ville;

  @override
  State<TownComponent> createState() => _TownComponentState();
}

class _TownComponentState extends State<TownComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: Get.height * .06,
        margin: EdgeInsets.only(right: Get.width * .012),
        padding:
            EdgeInsets.only(right: Get.width * .012, left: Get.width * .012),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: GradientApp.blueG,
            borderRadius: BorderRadius.circular(15)),
        child: Text(widget.ville, style: TextStyle(color: ColorsApp.textBlue)));
  }
}
