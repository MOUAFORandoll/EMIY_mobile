import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/model/data/UserModel.dart';
import 'package:EMIY/model/socket/NegociationModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Fieul extends StatelessWidget {
  Fieul({required this.fieul});

  final UserModel fieul;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: ColorsApp.greySecond),
                  top: BorderSide(color: ColorsApp.greySecond))),
          padding: EdgeInsets.symmetric(vertical: kMarginY * 2),
          margin: EdgeInsets.symmetric(vertical: kMarginY)
              .add(EdgeInsets.only(left: kMarginX)),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleImage(imageUrl: fieul.profile),
            Container(
                margin: EdgeInsets.symmetric(vertical: kMarginY)
                    .add(EdgeInsets.only(left: kMarginX)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: kWidth * .6,
                              child: Text(
                                fieul.prenom + ' ' + fieul.nom,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                                width: kWidth * .6,
                                child: Text(
                                  fieul.phone.toString(),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: ColorsApp.black,
                                  ),
                                )),
                            Container(
                                width: kWidth * .6,
                                child: Text(
                                  'Le ' + fieul.dateCreated.toString(),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: ColorsApp.black,
                                  ),
                                )),
                          ]),
                    ])),
          ])),
    );
  }
}
