// ignore: must_be_immutable
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BtnCatListVente extends StatelessWidget {
  var title, onTap, active, pVal;

  BtnCatListVente({this.active = false, this.title, this.onTap, this.pVal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: Get.size.width * 0.3,
          height: Get.size.height * 0.3,
          alignment: Alignment.center,
          padding: EdgeInsets.all(this.pVal ?? 10),
          margin: EdgeInsets.all(this.pVal ?? 10),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: /* (active) ?  */ ColorsApp
                .bleuLight /* : Color(0x71755050) */,
          ),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'orkney',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
