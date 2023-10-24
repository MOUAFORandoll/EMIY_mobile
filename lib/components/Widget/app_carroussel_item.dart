// ignore_for_file: must_be_immutable

import 'package:EMIY/components/Widget/app_text_title.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';

class AppCarrousselItem extends StatelessWidget {
  AppCarrousselItem(
      {required this.title,
      required this.description,
      required this.image,
      this.index = 0});
  var title, description, image, index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(5.0),
        // color: Colors.white,
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.only(
          //       left: kMarginX * 3, right: kMarginX * 3, top: kMarginX * 2.5),
          //   // margin: EdgeInsets.symmetric(
          //   //     vertical: kMarginY, horizontal: kMarginX * 3),
          //   child: Image.asset(
          //     image,
          //     height: kMdHeight / 2.5,
          //     width: kMdHeight / 3,
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border(top: BorderSide.none),
            ),
            margin: EdgeInsets.only(
              bottom: kMarginY * 10,
            ),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(kMarginX),
                    // margin: EdgeInsets.symmetric(
                    //     vertical: kMarginY, horizontal: kMarginX * 3),
                    child: AppTextTitle(
                      text: title,
                      percent: 1.1,
                      big: true,
                      color: ColorsApp.white,
                      bolder: true,
                    )),
                Container(
                    padding: EdgeInsets.all(kMarginX),
                    // margin: EdgeInsets.symmetric(
                    //     vertical: kMarginY, horizontal: kMarginX * 3),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorsApp.white,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
