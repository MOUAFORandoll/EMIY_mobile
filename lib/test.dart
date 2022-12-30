import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Container(
            height: kMdHeight / 4,
            width: kMdWidth * 1.1,
            alignment: Alignment.center,
            // padding: EdgeInsets.all(kMarginX),
            margin: EdgeInsets.only(right: kMarginX),
            decoration: BoxDecoration(
                color: ColorsApp.greySecond,
                borderRadius: BorderRadius.circular(8)),

            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: kMdHeight * .15,
                      width: Get.width * .5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ))),
                  Container(
                    width: kSmWidth * .6,
                    margin: EdgeInsets.only(
                        top: Get.height * .005, left: Get.width * .008),
                    child: Text('produit.titre',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: ColorsApp.black, fontSize: 12)),
                  ),
                  Container(
                    width: kSmWidth * .6,
                    margin: EdgeInsets.only(
                        top: Get.height * .005, left: Get.width * .008),
                    child: Text('XAF ' + '1000',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ]),
          ),
        ]));
  }
}
