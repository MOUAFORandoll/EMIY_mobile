import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProduit extends StatelessWidget {
  const ShimmerProduit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blueGrey,
      highlightColor: Colors.greenAccent,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: kMarginX),
          child: SingleChildScrollView(
              child: Column(children: [
            SizedBox(
                height: kMdHeight,
                child: Stack(children: [
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 50.0),
                      itemCount: 4,
                      itemBuilder: (_ctx, index) => Container(
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
                                      image: AssetImage('assets/logo/logo.png'),
                                    ))),
                                Container(
                                  width: kSmWidth * .6,
                                  margin: EdgeInsets.only(
                                      top: Get.height * .005,
                                      left: Get.width * .008),
                                  child: Text('produit.titre',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: ColorsApp.black,
                                          fontSize: 12)),
                                ),
                              ])))
                ]))
          ]))),
    );
  }
}
