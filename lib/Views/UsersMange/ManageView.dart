import 'dart:io';
import 'package:EMIY/Views/UsersMange/RegisterScreen.dart';
import 'package:EMIY/components/Text/TextBackSpace.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/BtnManageView.dart';
import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/components/Widget/app_setting_comp.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/Views/BoutiqueUser/BoutiqueUserView.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/ServiceClientController.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/views/UsersMange/LoginScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:EMIY/components/Widget/infoComponent.dart';
// import 'package:EMIY/components/informationComponent.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import '../../utils/functions/viewFunctions.dart';

// ignore: must_be_immutable
class ManageView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(
        builder: (_manager) =>
            CustomScrollView(controller: _scrollController, slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                floating: false,
                pinned: false,
                flexibleSpace: InkWell(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            height: kHeight * .20,
                            decoration: BoxDecoration(
                              color: ColorsApp.secondBlue,
                              // borderRadius: BorderRadius.circular(30),
                            ),
                            // margin: EdgeInsets.only(top: Get.height * .030),
                            padding: EdgeInsets.only(
                                left: Get.width * .030,
                                right: Get.width * .030),
                          ),
                          Positioned(
                            top: kHeight * .09,
                            left: kWidth * .05,
                            child: Container(
                                // decoration: BoxDecoration(
                                //   color: ColorsApp.greySecond,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // padding: EdgeInsets.symmetric(
                                //     vertical: kMarginY, horizontal: kMarginX),
                                child: InkWell(
                                    onTap: () {
                                      (_manager.User != null)
                                          ? Get.toNamed(AppLinks.USERVIEW)
                                          : Get.bottomSheet(
                                              Container(
                                                  margin: EdgeInsets.only(
                                                    top: kMarginY * 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: ColorsApp.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15))),
                                                  height: 800,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: kMarginX),
                                                  child: Column(children: [
                                                    Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            TextButton(
                                                              child: Text(
                                                                  'Annuler'),
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                            ),
                                                            // TextButton(
                                                            //   child: Text('Ajouter'),
                                                            //   onPressed: () async {
                                                            //     // await _controller.addShort();
                                                            //     // _controller.chageState(!_controller.addProduit);
                                                            //   },
                                                            // )
                                                          ]),
                                                    ),
                                                    Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                                child: Column(
                                                                    children: [
                                                          // _controller.listImgProduits.length != 0
                                                          //     ? smallText(
                                                          //         text: 'Listes images',
                                                          //       )
                                                          //     : Container(),

                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 50,
                                                              ),
                                                              child:
                                                                  LoginScreen())
                                                        ])))
                                                  ])),
                                              isScrollControlled: true,
                                            );
                                    },
                                    child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (_manager.User != null)
                                            InkWell(
                                              onTap: () =>
                                                  _manager.updateImageUser(),
                                              child: CircleImage(
                                                  imageUrl:
                                                      _manager.User.profile),
                                            ),
                                          (_manager.User != null)
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: kWidth * .030),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: TextBackSpace(
                                                          text: _manager
                                                                  .User.prenom +
                                                              ' ' +
                                                              _manager.User.nom,
                                                          bolder: true,
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.phone,
                                                                size: 14,
                                                                color: ColorsApp
                                                                    .white),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: kWidth *
                                                                          .010),
                                                              child:
                                                                  TextBackSpace(
                                                                text: _manager
                                                                    .User.phone,
                                                                // bolder: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: TextBackSpace(
                                                    text: 'Se connecter',
                                                    bolder: true,
                                                  ),
                                                ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Solde : ${_manager.Compte.solde} XAF',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                    child: Icon(Icons
                                                        .keyboard_double_arrow_up)),
                                                Container(
                                                    child: Icon(Icons
                                                        .keyboard_double_arrow_down)),
                                              ],
                                            ),
                                          )
                                        ]))),
                          )
                        ]),
                        Container(
                            alignment: Alignment.center,
                            width: kWidth,
                            height: kHeight * .1,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _manager.title.length,
                                itemBuilder: (ctx, i) => InkWell(
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Text(
                                          _manager.title[i].toString(),
                                          style: TextStyle(
                                              fontSize: _manager.current == i
                                                  ? 15
                                                  : 12,
                                              fontWeight: _manager.current == i
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: _manager.current == i
                                                  ? ColorsApp.black
                                                  : ColorsApp.greyTh),
                                        )),
                                    onTap: () async {
                                      _manager.setContain(i);
                                    })))
                      ],
                    ),
                  ),
                ),
                expandedHeight: kHeight * .25,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => Container(
                    constraints: BoxConstraints(minHeight: kHeight * .7),
                    // height: kHeight * .7,
                    // decoration: BoxDecoration(
                    //   color: ColorsApp.greySecond,
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    padding: EdgeInsets.symmetric(
                        vertical: kMarginY, horizontal: kMarginX),
                    // margin: EdgeInsets.symmetric(
                    //     vertical: kMarginY, horizontal: kMarginX),
                    child: _manager.buildContent()),

                childCount: 1,
              ))
            ]));
  }
  // Builds 1000 ListTiles
}
