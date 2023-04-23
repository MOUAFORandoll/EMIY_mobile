import 'package:Fahkap/components/Widget/app_text_title.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCarrousselItem extends StatelessWidget {
  var title, description, image, index = 0;
  AppCarrousselItem(
      {required this.title,
      required this.description,
      required this.image,
      this.index = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: kMarginX * 3, right: kMarginX * 3, top: kMarginX * 2.5),
            // margin: EdgeInsets.symmetric(
            //     vertical: kMarginY, horizontal: kMarginX * 3),
            child: Image.asset(
              image,
              height: kMdHeight / 2.5,
              width: kMdHeight / 3,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide.none),
            ),
            margin: EdgeInsets.only(
              top: kMarginY * 8,
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
                      bolder: true,
                    )),
                Container(
                    padding: EdgeInsets.all(kMarginX),
                    // margin: EdgeInsets.symmetric(
                    //     vertical: kMarginY, horizontal: kMarginX * 3),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
