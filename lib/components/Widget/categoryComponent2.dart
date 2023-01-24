// ignore: must_be_immutable 
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryComponent2 extends StatelessWidget {
  CategoryModel category;

  CategoryComponent2({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppLinks.BOUTIQUE_FOR_CATEGORY +
            '?id=${category.id}&libelle=${category.libelle}');
      },
      child: Container(
          height: kSmHeight * 2,
          width: kSmWidth,
          padding: EdgeInsets.all(kMarginX),
          margin:
              EdgeInsets.symmetric(vertical: kMarginY, horizontal: kMarginX),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(10),
                //         topLeft: Radius.circular(10)),
                //     child: Image.asset('assets/om.png',
                //         height: kSmHeight * .8,
                //         width: Get.width * .5,
                //         fit: BoxFit.cover),
                //   ),
                // ),
                Container(
                    alignment: Alignment.center,
                    // margin: EdgeInsets.only(
                    //     top: Get.height * .005, left: Get.width * .008),
                    child: Icon(
                      Icons.no_backpack,
                      color: Colors.white,
                    )),
                Container(
                  width: kSmWidth * .6,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(
                  //     top: Get.height * .005, left: Get.width * .008),
                  child: Text(category.libelle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ])),
    );
  }
}
