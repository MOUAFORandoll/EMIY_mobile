import 'dart:io';
import 'package:EMIY/components/Widget/BtnManageView.dart';
import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_input.dart';
import 'package:EMIY/components/Widget/app_setting_comp.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/Views/BoutiqueUser/BoutiqueUserView.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/validators.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:EMIY/components/Widget/infoComponent.dart';
// import 'package:EMIY/components/informationComponent.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class UserManageView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(builder: (_manager) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: AppBackButton(),
              actions: [
                Container(
                    margin: EdgeInsets.only(top: Get.height * .020),
                    padding: EdgeInsets.only(
                        left: Get.width * .030, right: Get.width * .030),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: AppTitleRight(
                                title: 'yutilisateur'.tr,
                                description: 'ysutilisateur'.tr,
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ])),
              ]),
          body: CustomScrollView(controller: _scrollController, slivers: [
            SliverList(
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
                    vertical: kMarginY * 2, horizontal: kMarginX),
                margin: EdgeInsets.symmetric(
                    vertical: kMarginY, horizontal: kMarginX),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _manager.updateImageUser(),
                          child: CircleImage(imageUrl: _manager.User.profile),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: kMarginY, horizontal: kMarginX),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    _manager.User.nom,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: ColorsApp.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat',
                                    ),
                                  )),
                                  Container(
                                      child: Text(
                                    _manager.User.email,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: ColorsApp.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                  )),
                                  Container(
                                      child: Text(
                                    _manager.User.phone,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: ColorsApp.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ))
                                ]))
                      ],
                    ),
                    AppSettingComp(
                      title: 'Modifier informations',
                      icon: Assets.user,
                      color: ColorsApp.orange,
                      onTap: () async {
                        Get.bottomSheet(Container(
                            height: kHeight,
                            padding: EdgeInsets.symmetric(
                                horizontal: kSmWidth * .07,
                                vertical: kSmHeight * .09),
                            // height: 800,
                            decoration: BoxDecoration(
                                color: ColorsApp.grey,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: SingleChildScrollView(
                              child: Form(
                                  key: _manager.formKeyUpdateU,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: kMarginY,
                                        ),
                                        child: AppInput(
                                          controller: _manager.nameU,
                                          label: 'labelname'.tr,
                                          validator: (value) {
                                            return Validators.isValidUsername(
                                                value!);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: kMarginY,
                                        ),
                                        child: AppInput(
                                          controller: _manager.surnameU,
                                          label: 'labelsurname'.tr,
                                          validator: (value) {
                                            return Validators.isValidUsername(
                                                value!);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: kMarginY,
                                        ),
                                        child: AppInput(
                                          controller: _manager.emailU,
                                          label: 'labelemail'.tr,
                                          validator: (value) {
                                            return Validators.isValidEmail(
                                                value);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: kMarginY,
                                        ),
                                        child: AppInput(
                                          controller: _manager.phoneU,
                                          label: 'labelphone'.tr,
                                          validator: (value) {
                                            return Validators.usPhoneValid(
                                                value!);
                                          },
                                        ),
                                      ),
                                      CustomBtn(
                                          color: ColorsApp.greenLight,
                                          title: 'Mettre a jour',
                                          onTap: () async {
                                            if (_manager
                                                .formKeyUpdateU.currentState!
                                                .validate()) {
                                              await _manager.updateUser();
                                            }
                                          })
                                    ],
                                  )),
                            )));
                      },
                    ),
                    AppSettingComp(
                      title: 'Modifier mot de passe',
                      icon: Assets.key,
                      onTap: () async {
                        Get.bottomSheet(Container(
                            height: kHeight,
                            padding: EdgeInsets.symmetric(
                                horizontal: kSmWidth * .07,
                                vertical: kSmHeight * .09),
                            // height: 800,
                            decoration: BoxDecoration(
                                color: ColorsApp.grey,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: SingleChildScrollView(
                              child: Form(
                                  key: _manager.formKeyUpdateU,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: kMarginY,
                                        ),
                                        child: AppInputPassword(
                                          controller: _manager.pwdCurrentU,
                                          label: 'labelpassword'.tr,
                                          obscureText: true,
                                          validator: (value) {
                                            return Validators.isValidPassword(
                                                value!);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: kMarginY,
                                        ),
                                        child: AppInputPassword(
                                          controller: _manager.newpwdU,
                                          label: 'labelnewpassword'.tr,
                                          obscureText: true,
                                          validator: (value) {
                                            return Validators.isValidPassword(
                                                value!);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: kMarginY,
                                        ),
                                        child: AppInputPassword(
                                          controller: _manager.rnewpwdU,
                                          label: 'labelrpassword'.tr,
                                          obscureText: true,
                                          validator: (value) {
                                            return Validators.isValidRePassword(
                                                _manager.repass.text !=
                                                    _manager.pass.text);
                                          },
                                        ),
                                      ),
                                      CustomBtn(
                                          color: ColorsApp.greenLight,
                                          title: 'Mettre a jour',
                                          onTap: () async {
                                            if (_manager
                                                .formKeyUpdateU.currentState!
                                                .validate()) {
                                              await _manager.updateUser();
                                            }
                                          })
                                    ],
                                  )),
                            )));
                      },
                    ),
                  ],
                )),
              ),

              childCount: 1,
            ))
          ]));
    });
  }
  // Builds 1000 ListTiles
}
