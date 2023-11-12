import 'package:EMIY/components/Button/AppIconSendButton.dart';
import 'package:EMIY/components/ShortComponent/iconShortComponent.dart';
import 'package:EMIY/components/ShortComponent/commentComponent.dart';
import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/components/Widget/InputComment.dart';
import 'package:EMIY/components/Widget/InputMessaage.dart';
import 'package:EMIY/components/Widget/UserTagComponent.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/managerController.dart';

// ignore: must_be_immutable
class ShortAction extends StatelessWidget {
  ShortAction({required this.short});
  ShortModel short;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShortController>(
        builder: (_ShortController) => Container(
                child: Column(
              children: [
                Container(
                    width: 48,
                    height: 48,
                    margin: EdgeInsets.symmetric(
                        vertical: kMarginY * 2, horizontal: kMarginX),
                    child: CachedNetworkImage(
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      imageUrl: short.boutique.images[0].src,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ColorsApp.greySecond,
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.transparent, BlendMode.colorBurn)),
                          ),
                        );
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
                        return CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/logo/logoNew.png"));
                      },
                    )),
                IconShortComponent(
                    icon: Icons.favorite,
                    onTap: () => _ShortController.newLikeShort(),
                    color: short.is_like ? ColorsApp.red : Colors.white,
                    nbr: short.nbre_like),
                IconShortComponent(
                    icon: FontAwesomeIcons.solidComment,
                    nbr: short.nbre_commentaire,
                    onTap: () {
                      _ShortController.setComment();
                      _ShortController.getListCommentShort();
                      openModal();
                    }),
                IconShortComponent(
                    icon: FontAwesomeIcons.share,
                    onTap: () => Share.share(
                        'Regarde ce short : ' + short.codeShort,
                        subject: 'Look what I made!')),
              ],
            )));
  }

  void openModal() {
    Get.bottomSheet(
            GetBuilder<ShortController>(
                builder: (_ShortController) => Container(
                      margin: EdgeInsets.only(
                        top: kMarginY * 8,
                      ),
                      decoration: BoxDecoration(
                          color: ColorsApp.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      height: kHeight / 1.5,
                      padding: EdgeInsets.symmetric(
                          horizontal: kMarginX, vertical: kMarginY),
                      child: Column(
                        children: [
                          Container(
                            child: Column(children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorsApp.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                height: 5,
                                width: kWidth * .12,
                                padding:
                                    EdgeInsets.symmetric(horizontal: kMarginX),
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: kMarginY),
                                  child: Text(
                                      '${short.nbre_commentaire} commentaires')),
                            ]),
                          ),
                          _ShortController.loadComment == 0
                              ? Container(
                                  width: 22,
                                  height: 22,
                                  margin: EdgeInsets.symmetric(
                                      vertical: kHeight / 4.7),
                                  child: CircularProgressIndicator(
                                      color: ColorsApp.secondBlue))
                              : GetBuilder<ShortController>(
                                  builder: (_ShortController) =>
                                      (_ShortController.openTagList)
                                          ? _ShortController.isLoadingUsertag ==
                                                  0
                                              ? Container(
                                                  width: 22,
                                                  height: 22,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: kHeight / 4.7),
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: ColorsApp
                                                              .secondBlue))
                                              : Expanded(
                                                  child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorsApp.bg0,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15)),
                                                  ),
                                                  height: kHeight / 1.5,
                                                  child: SingleChildScrollView(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            _ShortController
                                                                .usertagList
                                                                .length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder: (_ctx,
                                                                index) =>
                                                            UserTagComponent(
                                                                user: _ShortController
                                                                        .usertagList[
                                                                    index],
                                                                onTap: () {
                                                                  _ShortController.selectUserTag(_ShortController
                                                                      .usertagList[
                                                                          index]
                                                                      .user_tag!);
                                                                })),
                                                  ),
                                                ))
                                          : Expanded(
                                              // margin: EdgeInsets.only(
                                              //   top: kMarginY * 6,
                                              // ),
                                              // decoration: BoxDecoration(
                                              //     // color: ColorsApp.red,
                                              //     borderRadius:
                                              //         BorderRadius.only(
                                              //             topLeft:
                                              //                 Radius.circular(
                                              //                     15),
                                              //             topRight:
                                              //                 Radius.circular(
                                              //                     15))),
                                              // height: kHeight / 1.5,
                                              child: SingleChildScrollView(
                                                child: ListView.builder(
                                                    itemCount: _ShortController
                                                        .listCommentShort
                                                        .length,
                                                    shrinkWrap: true,
                                                    // controller: _ShortController.scrollController,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemBuilder: (_ctx,
                                                            index) =>
                                                        CommentComponent(
                                                            comment:
                                                                _ShortController
                                                                        .listCommentShort[
                                                                    index])),
                                              ),
                                            ),
                                ),
                          Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Column(children: [
                                GetBuilder<ShortController>(
                                    builder: (_ShortController) =>
                                        _ShortController.refCom != null
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsApp.greySearch,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    )),
                                                padding: EdgeInsets.all(2.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Reponse a ' +
                                                          _ShortController
                                                              .refCom.username),
                                                      IconButton(
                                                          iconSize: 20,
                                                          onPressed: () {
                                                            _ShortController
                                                                .setIdRef(null);
                                                          },
                                                          icon:
                                                              Icon(Icons.close))
                                                    ]))
                                            : Text('')),
                                Row(
                                  children: [
                                    GetBuilder<ManagerController>(
                                        builder: (_UController) => CircleImage(
                                            imageUrl:
                                                _UController.Userget.profile,
                                            radius: 20)),
                                    InputComment(
                                      controller: _ShortController
                                          .textEditingController,
                                      focusNode:
                                          _ShortController.focusNodeComment,
                                      userTag: _ShortController.userTagSelect,
                                    ),
                                    AppIconSendButton(
                                        icon: Icons.send,
                                        sending: _ShortController.sendComment,
                                        onTap: () =>
                                            _ShortController.newCommentShort()),
                                  ],
                                ),
                              ]))
                        ],
                      ),
                    )),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0)
        .whenComplete(() {
      print('....');
      Get.find<ShortController>().unSetComment();
    });
  }
}
