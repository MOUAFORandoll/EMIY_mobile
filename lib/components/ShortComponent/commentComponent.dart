import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/model/data/CommentShortModel.dart';
import 'package:EMIY/model/socket/NegociationModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommentComponent extends StatelessWidget {
  CommentComponent({required this.comment});

  final CommentShortModel comment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
          margin: EdgeInsets.symmetric(vertical: kMarginY),
          //     .add(EdgeInsets.only(left: kMarginX)),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleImage(imageUrl: comment.userphoto, radius: 20),
            Container(
                margin: EdgeInsets.symmetric(horizontal: kMarginX),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: kWidth * .5,
                              child: Text(
                                comment.username,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                                child: Text(
                              "9sem",

                              // softWrap: true,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 10,
                                color: ColorsApp.black,
                              ),
                            )),
                          ]),
                      Container(
                          width: kWidth * .58,
                          child: Text(comment.commentaire,
                              softWrap: true,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                overflow: TextOverflow.fade,
                                color: ColorsApp.black,
                              ))),
                    ])),
            Container(
                margin: EdgeInsets.only(left: kMarginX),
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 20,
                )),
          ])),
    );
  }
}
