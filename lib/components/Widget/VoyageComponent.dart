import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/model/data/VoyageModelH.dart';
import 'package:fahkapmobile/styles/colorApp.dart';

class VoyageComponent extends StatelessWidget {
  VoyageComponent({required this.voyage, this.onTap});
  var onTap;
  Datum voyage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
          // right: Get.width * .020,
          top: Get.height * .01,
        ),
        decoration: BoxDecoration(
            gradient: GradientApp.blueR,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: AssetImage('assets/login.png'))),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Container(
            //     height: Get.height * .2,
            //     width: Get.width * .8,
            //     margin: EdgeInsets.only(bottom: Get.height * .010),
            //     child: Image.asset('assets/login.png'),
            //     decoration: BoxDecoration(

            //         // borderRadius: BorderRadius.only(
            //         //     topLeft: Radius.circular(10),
            //         //     topRight: Radius.circular(10)),
            //         border: Border(
            //             bottom: BorderSide(
            //                 color: ColorsApp.greenLight, width: 1.0)))),
            Container(
                decoration: BoxDecoration(
                    color: ColorsApp.grey,
                    borderRadius: BorderRadius.circular(13)),
                margin: EdgeInsets.only(
                  top: Get.height * .01,
                  bottom: Get.height * .01,
                  right: Get.width * .01,
                  left: Get.width * .01,
                ),
                padding: EdgeInsets.only(
                  bottom: Get.height * .01,
                  top: Get.height * .01,
                  left: Get.width * .01,
                ),
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(left: Get.width * .017),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${voyage.nomVoyage}',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: Get.width * .017),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${voyage.pointVente}',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: Get.width * .017),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${voyage.heureDepart}',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: Get.width * .017),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${voyage.nomTrajet}',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  // Container(
                  //     margin: EdgeInsets.only(left: Get.width * .017),
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       '${voyage}',
                  //       // style: TextStyle(fontWeight: FontWeight.bold),
                  //     ))
                ]))
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
