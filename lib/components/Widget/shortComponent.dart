import 'package:EMIY/Views/Short/SingleShortView.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/styles/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/components/Widget/ShimmerBox.dart';

// ignore: must_be_immutable
class ShortComponentModel extends StatelessWidget {
  ShortModel short;

  ShortComponentModel({
    required this.short,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          // height: kHeight / 2.7,
          // margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              boxShadow: [
                // BoxShadow(
                //   color: Color(0xffDDDDDD),
                //   blurRadius: 0, // Soften the shaodw
                //   spreadRadius: 0,
                //   offset: Offset(-2.0, 3),
                // )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: short.preview,
                imageBuilder: (context, imageProvider) {
                  return Container(
                      height: kHeight / 5,
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
                  return /* Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: ColorsApp.skyBlue,
                      )),
                    ) */
                      Container(height: kHeight / 5, child: ShimmerBox());
                },
                errorWidget: (context, url, error) {
                  return Container(
                      height: kHeight / 5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/logo/logoNew.png'),
                      )));
                },
              ),
              Container(
                  width: kWidth / 2,
                  child: Text(short.titre,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TexteStyle().secondaryTextStyle)),
            ],
          )),
      onTap: () {
        // Get.find<ShortController>().getThisSHort();
        Get.to(
          () => SingleShortView(idShort: short.id),
        );
      },
    );
  }
}
