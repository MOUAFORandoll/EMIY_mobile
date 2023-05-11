// ignore: must_be_immutable
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
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
            height: kHeight / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: 'https://placehold.co/600x400@2x.png',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                        height: kHeight / 4,
                        // margin: EdgeInsets.only(bottom: 10),
                        // padding: EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                        decoration: BoxDecoration(
                          color: ColorsApp.greySecond,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.transparent, BlendMode.colorBurn)),
                        ));
                  },
                  placeholder: (context, url) {
                    return Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: ColorsApp.skyBlue,
                      )),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                        height: kHeight / 4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                        )));
                  },
                ),
                Container(
                    width: kWidth / 2,
                    child: Text(category.libelle,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: ColorsApp.marron,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))),
              ],
            )));
  }
}
