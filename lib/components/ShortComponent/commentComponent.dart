import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/components/Widget/UserTagComponent.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/CommentShortModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CommentComponent extends StatelessWidget {
  CommentComponent({required this.comment, this.type = 0});

  final CommentShortModel comment;
  var type = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Container(
          margin: EdgeInsets.symmetric(vertical: kMarginY),
          //     .add(EdgeInsets.only(left: kMarginX)),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleImage(
                        imageUrl: comment.userphoto,
                        radius: type == 0 ? 20 : 15),
                    Expanded(
                        // margin: EdgeInsets.symmetric(horizontal: kMarginX),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: kMarginX * .6),
                                  // width: kWidth * .2,
                                  child: Text(
                                    comment.username,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      // fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (comment.target_user.isNotEmpty)
                                  Container(
                                    // width: kWidth * .5,
                                    child: Text(
                                      ' > ',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                Container(
                                  // width: kWidth * .2,
                                  child: Text(
                                    comment.target_user,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ]),
                          Container(
                              margin: EdgeInsets.only(left: kMarginX * .6),
                              width: kWidth * .58,
                              child: Text(comment.commentaire_text,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    overflow: TextOverflow.fade,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsApp.black,
                                  ))),
                          Container(
                            margin: EdgeInsets.only(left: kMarginX * .6),
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  "9 sem",

                                  // softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 10,
                                    color: ColorsApp.grey1,
                                  ),
                                )),
                                InkWell(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text("Repondre",

                                          // softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 10,
                                              color: ColorsApp.grey1,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    onTap: () {
                                      Get.find<ShortController>()
                                          .setIdRef(comment);
                                    }),
                              ],
                            ),
                          ),
                          if (comment.nbre_com != 0 &&
                              comment.comments.isEmpty &&
                              Get.find<ShortController>().loadCommentComment !=
                                  0)
                            InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            color: ColorsApp.grey,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        height: 1.5,
                                        width: kWidth * .08,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kMarginX),
                                      ),
                                      InkWell(
                                          child: Container(
                                            child: Text(
                                                "Afficher ${comment.nbre_com.toString()} reponses",

                                                // softWrap: true,
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorsApp.black,
                                                )),
                                          ),
                                          onTap: () {
                                            Get.find<ShortController>()
                                                .getListCommentCommentShort(
                                                    comment);
                                          }),
                                    ],
                                  ),
                                ),
                                onTap: () {}),
                          Get.find<ShortController>().idCurrentComment !=
                                      comment.id &&
                                  comment.comments.isEmpty
                              ? SizedBox(
                                  width: 0,
                                  height: 0,
                                )
                              : Get.find<ShortController>()
                                          .loadCommentComment ==
                                      0
                                  ? Container(
                                      width: 30,
                                      margin: EdgeInsets.only(right: 5, top: 2),
                                      height: 30,
                                      // padding: EdgeInsets.symmetric(
                                      //     horizontal: kMarginX),
                                      child: CircularProgressIndicator(
                                        color: ColorsApp.secondBlue,
                                      ))
                                  : Container(
                                      // height: 100,
                                      width: kWidth * .85,
                                      margin: EdgeInsets.only(right: 5),
                                      // margin: EdgeInsets.symmetric(
                                      //     horizontal: kMarginX),
                                      child: SingleChildScrollView(
                                        child: ListView.builder(
                                            itemCount: comment.comments.length,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (_ctx, index) =>
                                                CommentComponent(
                                                    comment:
                                                        comment.comments[index],
                                                    type: 1)),
                                      ),
                                    ),
                        ])),
                    Container(
                        // margin: EdgeInsets.only(left: kMarginX),
                        child: Row(
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.favorite_outlined,
                            color: comment.is_like_com
                                ? Colors.red
                                : ColorsApp.black,
                            size: 20,
                          ),
                          onTap: () => Get.find<ShortController>()
                              .newLikeShortCom(comment, type),
                        ),
                        Container(
                            child: Text(comment.nbre_like_com.toString(),
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 12,
                                  overflow: TextOverflow.fade,
                                  color: ColorsApp.black,
                                ))),
                      ],
                    )),
                  ]),
            ],
          )),
    );
  }
}
