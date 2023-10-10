// ignore: must_be_immutable

import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BtnManageView extends StatelessWidget {
  var title, onTap;
  bool selected;
  BtnManageView(
      {required this.title, required this.onTap, required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          // height: kSmHeight * 1.2,
          width: kSmWidth * 0.5,
          padding: EdgeInsets.all(kMarginX / 1.1),
          margin:
              EdgeInsets.symmetric(vertical: kMarginY, horizontal: kMarginX),
          decoration: BoxDecoration(
              gradient: selected ? GradientApp.blueG : null,
              color: selected ? null : ColorsApp.greySecond,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(10),
                //         topLeft: Radius.circular(10)),
                //     child: Image.asset('assets/om.png',
                //         height: kSmHeight ,
                //         width: Get.width * .5,
                //         fit: BoxFit.cover),
                //   ),
                // ),

                // Container(
                //     decoration: BoxDecoration(
                //         color: ColorsApp.greySecond,
                //         borderRadius: BorderRadius.circular(20)),
                //     //  alignment: Alignment.center,
                //     padding: EdgeInsets.all(10),
                //     child: Icon(
                //       IconData(category.icon, fontFamily: 'MaterialIcons'),
                //       color: Colors.white,
                //     )),
                Container(
                  width: kSmWidth,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(
                  //     top: Get.height * .005, left: Get.width * .008),
                  child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ])),
    );
  }
}
