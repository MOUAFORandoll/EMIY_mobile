import 'package:fahkapmobile/Views/Shopping/BuyShoopingCart.dart';
import 'package:fahkapmobile/controller/BuyShopController.dart';
import 'package:fahkapmobile/model/data/LivreurModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';

class LivreurComponent extends StatelessWidget {
  final LivreurModel livreur;

  LivreurComponent({required this.livreur});

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
              decoration: _controller.isLivreur == livreur.id
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorsApp.bleuLight)
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Color(0xfff)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    (livreur.nom).toString() +
                        ' ' +
                        (livreur.prenom).toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    livreur.localisation.distance,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
          onTap: () {
            _controller.setLivreur(livreur.id);
          });
    });
  }
}
