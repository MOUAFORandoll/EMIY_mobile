import 'dart:io';
import 'package:Fahkap/components/Widget/BtnManageView.dart';
import 'package:Fahkap/components/Widget/app_setting_comp.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/Views/BoutiqueUser/BoutiqueUserView.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/controller/TransactionController.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Fahkap/components/Widget/infoComponent.dart';
// import 'package:Fahkap/components/informationComponent.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';

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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // BigtitleText(text: 'Category', bolder: true),
                                Container(
                                  child: AppTitleRight(
                                      title: 'Gerer',
                                      description: 'Gerer votre compte',
                                      icon: null),
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          .005),
                                ),
                              ])),
                    ]),
                  ),
                ),
                expandedHeight: 60,
              ),
              SliverList(

                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => Container(
                  constraints: BoxConstraints(minHeight: kHeight * .7),
                  height: kHeight * .7,
                  decoration: BoxDecoration(
                    color: ColorsApp.greySecond,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: kMarginY, horizontal: kMarginX),
                  margin: EdgeInsets.symmetric(
                      vertical: kMarginY, horizontal: kMarginX),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      AppSettingComp(
                          title: 'Affichage',
                          icon: Assets.phone_mobile,
                          color: ColorsApp.orange,
                          onTap: () {
                            Get.toNamed(AppLinks.SETTING);
                          }),
                      _manager.User != null
                          ? AppSettingComp(
                              title: 'Utilisateur',
                              icon: Assets.user,
                              color: ColorsApp.skyBlue,
                              onTap: () {
                                Get.toNamed(AppLinks.USERVIEW);
                              })
                          : AppSettingComp(
                              title: 'Se connecter',
                              icon: Assets.user,
                              color: ColorsApp.skyBlue,
                              onTap: () {
                                Get.toNamed(AppLinks.LOGIN);
                              }),
                      _manager.User != null
                          ? AppSettingComp(
                              title: 'Porte Feuille',
                              icon: Assets.bagmoney,
                              color: ColorsApp.blue,
                              onTap: () {
                                Get.find<TransactionController>()
                                    .getTransactions();
                                Get.toNamed(AppLinks.WALLET);
                              })
                          : AppSettingComp(
                              title: 'S\'inscrire',
                              icon: Assets.user,
                              color: ColorsApp.skyBlue,
                              onTap: () {
                                Get.toNamed(AppLinks.REGISTER);
                              }),
                      AppSettingComp(
                          title: 'Boutique',
                          icon: Assets.bagmoney,
                          color: ColorsApp.orange,
                          onTap: () {
                            Get.toNamed(AppLinks.BOUTIQUE_USER);
                          }),
                      AppSettingComp(
                          title: 'Commande',
                          icon: Assets.bagmoney,
                          onTap: () {
                            Get.find<CommandeController>().getListCommandes();
                            Get.toNamed(AppLinks.COMMANDE_FOR_USER);
                          }),
                      AppSettingComp(
                          title: 'Parrainage',
                          icon: Assets.bagmoney,
                          onTap: () {
                            ViewFunctions().showIndisponible();
                            // Get.toNamed(AppLinks.COMMANDE_FOR_USER);
                            // Share.share('check out my website https://example.com',
                            //     subject: 'Look what I made!');
                          }),
                    ],
                  )),
                ),

                childCount: 1,
              ))
            ]));
  }
  // Builds 1000 ListTiles
}
