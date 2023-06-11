import 'package:EMIY/Views/Shopping/BuyShoopingCart.dart';
import 'package:EMIY/controller/BuyShopController.dart';
import 'package:EMIY/model/data/LivreurModel.dart';
import 'package:EMIY/model/data/PointLivraisonModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';

class PointLivraisonComponent extends StatelessWidget {
  final PointLivraisonModel point_livraison;

  PointLivraisonComponent({required this.point_livraison});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyShopController>(builder: (_controller) {
      return InkWell(
          child: Container(
              margin: EdgeInsets.only(
                  // top: Get.height * .005,
                  left: Get.width * .01,
                  right: Get.width * .01,
                  bottom: Get.height * .009),
              padding: EdgeInsets.all(Get.height * .02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _controller.selected_livraison_point.id ==
                          point_livraison.id
                      ? ColorsApp.skyBlue
                      : ColorsApp.greySecond),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    (point_livraison.libelle).toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    point_livraison.ville.toString() +
                        ', ' +
                        point_livraison.quartier.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
          onTap: () {
            _controller.selectPoint(point_livraison);
            Get.back();
          });
    });
  }
}
