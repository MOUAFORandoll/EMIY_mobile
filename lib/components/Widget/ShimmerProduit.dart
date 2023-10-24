import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProduit extends StatelessWidget {
  const ShimmerProduit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsApp.grey,
      highlightColor: Colors.blueGrey,
      child: Container(
         height: kMdHeight / 1.8,
          margin: EdgeInsets.symmetric(horizontal: kMarginX),
          child:  
            SizedBox(
                height: kMdHeight/2,
                child: Stack(children: [
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 10.0),
                      itemCount: 6,
                      itemBuilder: (_ctx, index) => Container(
                            height: kMdHeight / 4.2,
                            width: kMdWidth * 1.1,
                            alignment: Alignment.center,
                            // padding: EdgeInsets.all(kMarginX),
                            margin: EdgeInsets.only(right: kMarginX),
                            decoration: BoxDecoration(
                                color: ColorsApp.greySecond,
                                borderRadius: BorderRadius.circular(8)),
                          ))
                ]))
          ),
    );
  }
}
