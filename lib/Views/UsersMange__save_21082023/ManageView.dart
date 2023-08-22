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
                floating: true,
                flexibleSpace: InkWell(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.only(top: Get.height * .030),
                          padding: EdgeInsets.only(
                              left: Get.width * .030, right: Get.width * .030),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigtitleText(
                                    text: 'Menu', bolder: true, size: 22),
                                Container(
                                    child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorsApp.greySecond,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                              Icons.power_settings_new_sharp,
                                              color: ColorsApp.red,
                                              size: 22),
                                        ),
                                        onTap: () async {
                                          await _manager.deconnectUser();
                                          await _manager.deconnectUser();
                                          //print(_manager.state);
                                          // Get.toNamed(AppLinks.LOGIN);
                                        })),
                              ])),
                    ]),
                  ),
                ),
                expandedHeight: 60,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
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
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: ColorsApp.greySecond,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: kMarginY, horizontal: kMarginX),
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
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
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
                                                        child: Text('Annuler'),
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
                                                  child: SingleChildScrollView(
                                                      child: Column(children: [
                                                // _controller.listImgProduits.length != 0
                                                //     ? smallText(
                                                //         text: 'Listes images',
                                                //       )
                                                //     : Container(),

                                                Container(
                                                    margin: EdgeInsets.only(
                                                      top: 50,
                                                    ),
                                                    child: LoginScreen())
                                              ])))
                                            ])),
                                        isScrollControlled: true,
                                      );
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (_manager.User != null)
                                      InkWell(
                                        onTap: () => _manager.updateImageUser(),
                                        child: CircleImage(
                                            imageUrl: _manager.User.profile),
                                      ),
                                    (_manager.User != null)
                                        ? Container(
                                            padding: EdgeInsets.all(5),
                                            child: TextBackSpace(
                                              text: _manager.User.prenom +
                                                  ' ' +
                                                  _manager.User.nom,
                                              bolder: true,
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(5),
                                            child: TextBackSpace(
                                              text: 'Se connecter',
                                              bolder: true,
                                            ),
                                          ),
                                    if (_manager.User != null)
                                      Container(
                                          child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: ColorsApp.skyBlue
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            padding: EdgeInsets.all(2),
                                            child: Icon(Icons.settings,
                                                weight: 20, size: 20),
                                          )
                                        ],
                                      ))
                                  ]))),
                      (_manager.User != null)
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: kMarginY),
                              child: Row(children: [
                                BigtitleText(
                                    text: 'User', bolder: true, size: 12)
                              ]))
                          : Container(
                              margin: EdgeInsets.symmetric(vertical: kMarginY),
                              child: Row(children: [
                                BigtitleText(
                                    text: 'Money', bolder: true, size: 12)
                              ])),
                      Container(
                          decoration: BoxDecoration(
                            color: ColorsApp.greySecond,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: kMarginY, horizontal: kMarginX),
                          child: InkWell(
                              onTap: () {
                                if (_manager.User != null) {
                                  Get.find<TransactionController>()
                                      .getTransactions();
                                  Get.toNamed(AppLinks.WALLET);
                                } else {
                                  Get.bottomSheet(
                                    Container(
                                        margin: EdgeInsets.only(
                                          top: kMarginY * 8,
                                        ),
                                        decoration: BoxDecoration(
                                            color: ColorsApp.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15))),
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
                                                    child: Text('Annuler'),
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
                                              child: SingleChildScrollView(
                                                  child: Column(children: [
                                            // _controller.listImgProduits.length != 0
                                            //     ? smallText(
                                            //         text: 'Listes images',
                                            //       )
                                            //     : Container(),

                                            Container(
                                                margin: EdgeInsets.only(
                                                  top: 50,
                                                ),
                                                child: RegisterScreen())
                                          ])))
                                        ])),
                                    isScrollControlled: true,
                                  );
                                }
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (_manager.User != null)
                                      Container(
                                        // decoration: BoxDecoration(
                                        //   color: ColorsApp.skyBlue.withOpacity(.5),
                                        //   borderRadius: BorderRadius.circular(30),
                                        // ),
                                        padding: EdgeInsets.all(2),
                                        child: Icon(Icons.monetization_on_sharp,
                                            weight: 20, size: 20),
                                      ),
                                    (_manager.User != null)
                                        ? Container(
                                            padding: EdgeInsets.all(5),
                                            child: TextBackSpace(
                                              text:
                                                  '${_manager.Compte.solde} XAF',
                                              bolder: true,
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(5),
                                            child: TextBackSpace(
                                              text: 'S\'inscrire',
                                              bolder: true,
                                            ),
                                          ),
                                    if (_manager.User != null)
                                      Container(
                                          child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: ColorsApp.skyBlue
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            padding: EdgeInsets.all(2),
                                            child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                weight: 20,
                                                size: 20),
                                          )
                                        ],
                                      ))
                                  ]))),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: kMarginY),
                          child: Row(children: [
                            BigtitleText(
                                text: 'Pour moi', bolder: true, size: 12)
                          ])),
                      GridView.count(
                        crossAxisCount: 2, // Number of columns in the grid
                        mainAxisSpacing: 1.0, // Spacing between rows
                        crossAxisSpacing: 1.0, // Spacing between columns
                        childAspectRatio: 2.0, //
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // scrollDirection: Axis
                        //     .horizontal, // Set the direction of scrolling
                        children: <Widget>[
                          AppSettingComp(
                              title: 'Affichage',
                              icon: Assets.phone_mobile,
                              color: ColorsApp.orange,
                              onTap: () {
                                Get.toNamed(AppLinks.SETTING);
                              }),
                          // if (_manager.User != null)
                          //   AppSettingComp(
                          //       title: 'Service Client',
                          //       icon: Assets.phone_mobile,
                          //       color: ColorsApp.orange,
                          //       onTap: () {

                          //         Get.toNamed(AppLinks.SERVICE_CLIENT);

                          //       }),
                          // _manager.User != null
                          //     ? AppSettingComp(
                          //         title: 'Utilisateur',
                          //         icon: Assets.user,
                          //         color: ColorsApp.skyBlue,
                          //         onTap: () {
                          //           Get.toNamed(AppLinks.USERVIEW);
                          //         })
                          //     : AppSettingComp(
                          //         title: 'Se connecter',
                          //         icon: Assets.user,
                          //         color: ColorsApp.skyBlue,
                          //         onTap: () {
                          //           // Get.toNamed(AppLinks.LOGIN);
                          //           Get.bottomSheet(
                          //             Container(
                          //                 margin: EdgeInsets.only(
                          //                   top: kMarginY * 8,
                          //                 ),
                          //                 decoration: BoxDecoration(
                          //                     color: ColorsApp.white,
                          //                     borderRadius: BorderRadius.only(
                          //                         topLeft: Radius.circular(15),
                          //                         topRight:
                          //                             Radius.circular(15))),
                          //                 height: 800,
                          //                 padding: EdgeInsets.symmetric(
                          //                     horizontal: kMarginX),
                          //                 child: Column(children: [
                          //                   Container(
                          //                     child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .spaceBetween,
                          //                         children: [
                          //                           TextButton(
                          //                             child: Text('Annuler'),
                          //                             onPressed: () {
                          //                               Get.back();
                          //                             },
                          //                           ),
                          //                           // TextButton(
                          //                           //   child: Text('Ajouter'),
                          //                           //   onPressed: () async {
                          //                           //     // await _controller.addShort();
                          //                           //     // _controller.chageState(!_controller.addProduit);
                          //                           //   },
                          //                           // )
                          //                         ]),
                          //                   ),
                          //                   Expanded(
                          //                       child: SingleChildScrollView(
                          //                           child: Column(children: [
                          //                     // _controller.listImgProduits.length != 0
                          //                     //     ? smallText(
                          //                     //         text: 'Listes images',
                          //                     //       )
                          //                     //     : Container(),

                          //                     Container(
                          //                         margin: EdgeInsets.only(
                          //                           top: 50,
                          //                         ),
                          //                         child: LoginScreen())
                          //                   ])))
                          //                 ])),
                          //             isScrollControlled: true,
                          //           );
                          //         }),
                          // _manager.User != null
                          //     ? AppSettingComp(
                          //         title: 'Porte Feuille',
                          //         icon: Assets.bagmoney,
                          //         color: ColorsApp.blue,
                          //         onTap: () {
                          //           Get.find<TransactionController>()
                          //               .getTransactions();
                          //           Get.toNamed(AppLinks.WALLET);
                          //         })
                          //     : AppSettingComp(
                          //         title: 'S\'inscrire',
                          //         icon: Assets.user,
                          //         color: ColorsApp.skyBlue,
                          //         onTap: () {
                          //           // Get.toNamed(AppLinks.REGISTER);
                          //           Get.bottomSheet(
                          //             Container(
                          //                 margin: EdgeInsets.only(
                          //                   top: kMarginY * 8,
                          //                 ),
                          //                 decoration: BoxDecoration(
                          //                     color: ColorsApp.white,
                          //                     borderRadius: BorderRadius.only(
                          //                         topLeft: Radius.circular(15),
                          //                         topRight:
                          //                             Radius.circular(15))),
                          //                 height: 800,
                          //                 padding: EdgeInsets.symmetric(
                          //                     horizontal: kMarginX),
                          //                 child: Column(children: [
                          //                   Container(
                          //                     child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .spaceBetween,
                          //                         children: [
                          //                           TextButton(
                          //                             child: Text('Annuler'),
                          //                             onPressed: () {
                          //                               Get.back();
                          //                             },
                          //                           ),
                          //                           // TextButton(
                          //                           //   child: Text('Ajouter'),
                          //                           //   onPressed: () async {
                          //                           //     // await _controller.addShort();
                          //                           //     // _controller.chageState(!_controller.addProduit);
                          //                           //   },
                          //                           // )
                          //                         ]),
                          //                   ),
                          //                   Expanded(
                          //                       child: SingleChildScrollView(
                          //                           child: Column(children: [
                          //                     // _controller.listImgProduits.length != 0
                          //                     //     ? smallText(
                          //                     //         text: 'Listes images',
                          //                     //       )
                          //                     //     : Container(),

                          //                     Container(
                          //                         margin: EdgeInsets.only(
                          //                           top: 50,
                          //                         ),
                          //                         child: RegisterScreen())
                          //                   ])))
                          //                 ])),
                          //             isScrollControlled: true,
                          //           );
                          //         }),
                          if (_manager.User != null)
                            AppSettingComp(
                                title:
                                    Get.find<BoutiqueController>().Boutique !=
                                            null
                                        ? 'Ma Boutique'
                                        : "Creer ma boutique",
                                icon: Assets.bagmoney,
                                color: ColorsApp.orange,
                                onTap: () {
                                  /*  Get.find<BoutiqueController>().isLoaded == 0
                                ? ViewFunctions()
                                    .loading('Boutique', 'Veuillez patienter')
                                : */

                                  Get.find<BoutiqueController>().Boutique !=
                                          null
                                      ? Get.toNamed(AppLinks.BOUTIQUE_USER)
                                      : Get.toNamed(AppLinks.BOUTIQUE_NEW);
                                }),
                          if (_manager.User != null)
                            AppSettingComp(
                                title: 'Mes Commandes',
                                icon: Assets.bagmoney,
                                onTap: () {
                                  Get.find<CommandeController>()
                                      .getListCommandes();
                                  Get.toNamed(AppLinks.COMMANDE_FOR_USER);
                                }),
                          // if (_manager.User != null)
                          if (_manager.User != null)
                            AppSettingComp(
                                title: 'Mes affilies',
                                icon: Assets.bagmoney,
                                onTap: () {
                                  // ViewFunctions().showIndisponible();
                                  Get.toNamed(AppLinks.FIEU_LIST);
                                  // Share.share('check out my website https://example.com',
                                  //     subject: 'Look what I made!');
                                }),
                          if (_manager.User != null)
                            AppSettingComp(
                                title: 'Mes Preferences',
                                icon: Assets.bagmoney,
                                onTap: () {
                                  // ViewFunctions().showIndisponible();
                                  Get.toNamed(AppLinks.PREFERENCE_CLIENT);
                                  // Share.share('check out my website https://example.com',
                                  //     subject: 'Look what I made!');
                                }),
                          if (_manager.User != null)
                            AppSettingComp(
                                title: 'Mes interrets',
                                icon: Assets.bagmoney,
                                onTap: () {
                                  // ViewFunctions().showIndisponible();
                                  Get.toNamed(AppLinks.INTERET);
                                  // Share.share('check out my website https://example.com',
                                  //     subject: 'Look what I made!');
                                }),

                          AppSettingComp(
                              title: 'Fermer',
                              icon: Assets.bagmoney,
                              onTap: () {
                                // ViewFunctions().showIndisponible();
                                SystemNavigator.pop();
                                // Share.share('check out my website https://example.com',
                                //     subject: 'Look what I made!');
                              }),
                        ],
                      ),
                    ],
                  )),
                ),
                childCount: 1,
              ))
            ]));
  }
  // Builds 1000 ListTiles
}
