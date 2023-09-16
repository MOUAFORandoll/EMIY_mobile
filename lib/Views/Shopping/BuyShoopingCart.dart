import 'dart:async';

import 'package:EMIY/Views/Shopping/PaiementView.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/formComponent.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Widget/DeliveryComponent.dart';
import 'package:EMIY/components/Widget/pointLivraisonComponent.dart';
import 'package:EMIY/components/Widget/SelectComponent.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_input.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/icon_svg.dart';
import 'package:EMIY/components/Widget/produitBuyComponent.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/BuyShopController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/model/data/ModePaiementModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:EMIY/styles/colorApp.dart';

// import 'package:cinetpay/cinetpay.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';

class BuyShoopingCart extends StatelessWidget {
  BuyShoopingCart({Key? key}) : super(key: key);

  int counter = 0;
  String selectedPlace = '0';
  String selectedPlaceId = '0';

  String message = '';
  Color color = ColorsApp.skyBlue;

  bool select = false;
  bool finish = false;
  bool ok = false;
  bool _loading = false;

  @override
  void initState() {}

  ViewFunctions functions = new ViewFunctions();

  int _index = 0;
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.find<BuyShopController>().onInit();
    Get.find<ManagerController>().getLocalU();
    return GetBuilder<BuyShopController>(builder: (_Bcontroller) {
      return GetBuilder<CartController>(builder: (_controller) {
        return Scaffold(
            backgroundColor: Colors.white,
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
                                  title: 'Panier',
                                  description: 'Votre panier',
                                  icon: Assets.shoppingCart),
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * .005),
                            ),
                          ])),
                ]),
            body: SafeArea(
              child: CustomScrollView(
                  controller: Get.find<GeneralController>().scrollcontroller,
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: kMarginX, vertical: kMarginY),
                                child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY / 2),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    child: Text(
                                                  'adL'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 12,
                                                      color: ColorsApp.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                                Container(
                                                    child: InkWell(
                                                        child: Text(
                                                          'Change',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Lato',
                                                              fontSize: 14,
                                                              color: ColorsApp
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        onTap: () {
                                                          Get.bottomSheet(
                                                            Container(
                                                                height:
                                                                    Get.height *
                                                                        2,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      kMarginY,
                                                                  horizontal:
                                                                      kMarginX,
                                                                ),
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top:
                                                                      kMarginY *
                                                                          8,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                15),
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                15)),
                                                                    color: Colors
                                                                        .white),
                                                                // padding: EdgeInsets.only(
                                                                //   top: 25,
                                                                // ),
                                                                child:
                                                                    SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                  children: [
                                                                    Padding(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .only(
                                                                          top:
                                                                              kMarginY,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'livrInfo'.tr,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              child: Icon(Icons.close),
                                                                              onTap: () {
                                                                                Get.back();
                                                                              },
                                                                            )
                                                                          ],
                                                                        )),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            kMarginY,
                                                                      ),
                                                                      child:
                                                                          AppInput(
                                                                        controller:
                                                                            _Bcontroller.nameController,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .check_circle_sharp,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          ;
                                                                        },
                                                                        label: 'name'
                                                                            .tr,
                                                                        validator:
                                                                            (value) {},
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            kMarginY,
                                                                      ),
                                                                      child:
                                                                          AppInput(
                                                                        controller:
                                                                            _Bcontroller.phoneController,
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .check_circle_sharp,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          ;
                                                                        },
                                                                        label: 'labelphone'
                                                                            .tr,
                                                                        validator:
                                                                            (value) {},
                                                                      ),
                                                                    ),
                                                                    // Padding(
                                                                    //   padding: EdgeInsets.only(
                                                                    //     top: kMarginY,
                                                                    //   ),
                                                                    //   child: AppInput(
                                                                    //     controller: _Bcontroller.phoneController,
                                                                    //     icon: Icon(
                                                                    //       Icons.check_circle_sharp,
                                                                    //     ),
                                                                    //     onChanged: (value) {
                                                                    //       ;
                                                                    //     },
                                                                    //     label: 'mail'.tr,
                                                                    //     validator: (value) {},
                                                                    //   ),
                                                                    // ),
                                                                    InkWell(
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(Get.height * .02),
                                                                            margin: EdgeInsets.only(
                                                                              top: kMarginY,
                                                                            ),
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorsApp.secondBlue),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  'livrP'.tr,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                  ),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                                Container(
                                                                                    child: SvgPicture.asset(
                                                                                  Assets.localisation,
                                                                                  width: 18,
                                                                                  height: 18,
                                                                                  color: ColorsApp.orange,
                                                                                )),
                                                                              ],
                                                                            )),
                                                                        onTap: () {
                                                                          Get.bottomSheet(
                                                                            GetBuilder<BuyShopController>(
                                                                                builder: (_BCcontroller) => Container(
                                                                                    padding: EdgeInsets.symmetric(
                                                                                      vertical: kMarginY,
                                                                                      horizontal: kMarginX,
                                                                                    ),
                                                                                    margin: EdgeInsets.only(
                                                                                      top: kMarginY * 8,
                                                                                    ),
                                                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
                                                                                    child: SingleChildScrollView(
                                                                                        child: Column(children: [
                                                                                      Padding(
                                                                                          padding: EdgeInsets.only(
                                                                                            top: kMarginY,
                                                                                          ),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                'livrInfo'.tr,
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              ),
                                                                                              InkWell(
                                                                                                child: Icon(Icons.close),
                                                                                                onTap: () {
                                                                                                  Get.back();
                                                                                                },
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.symmetric(
                                                                                          vertical: kMarginY * 2,
                                                                                        ),
                                                                                        child: AppInput(
                                                                                          controller: _BCcontroller.searchController,
                                                                                          label: 'Rechercher'.tr,
                                                                                          onChanged: (value) {
                                                                                            return _BCcontroller.searchPointLivraison();
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      _BCcontroller.searchController.text.length == 0 ? ListView.builder(physics: NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: _BCcontroller.livraison_point.length, itemBuilder: (_ctx, index) => PointLivraisonComponent(point_livraison: _BCcontroller.livraison_point[index])) : ListView.builder(physics: NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: _BCcontroller.search_livraison_point.length, itemBuilder: (_ctx, index) => PointLivraisonComponent(point_livraison: _BCcontroller.search_livraison_point[index]))
                                                                                    ])))),
                                                                            isScrollControlled:
                                                                                true,
                                                                          );
                                                                        }),
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                        top:
                                                                            kMarginY,
                                                                      ),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _Bcontroller.lieuxController,

                                                                        // keyboardType: type,
                                                                        // obscureText: obscureText!,
                                                                        // maxLengthEnforced: false,
                                                                        maxLength:
                                                                            10,
                                                                        maxLines:
                                                                            10,
                                                                        decoration:
                                                                            new InputDecoration(
                                                                          fillColor:
                                                                              ColorsApp.skyBlue,
                                                                          // counter: Offstage(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                              borderSide: BorderSide(
                                                                                color: ColorsApp.skyBlue,
                                                                              )),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: ColorsApp.skyBlue,
                                                                            ),
                                                                          ),
                                                                          contentPadding:
                                                                              EdgeInsets.only(
                                                                            left:
                                                                                12,
                                                                            bottom:
                                                                                10,
                                                                            top:
                                                                                10,
                                                                            right:
                                                                                12,
                                                                          ),
                                                                          hintText:
                                                                              'Donnez moi plus d\'indication, un petit texte sera un plus',
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontFamily:
                                                                                'orkney',
                                                                          ),
                                                                          // suffixIcon: InkWell(
                                                                          //   onTap: () => onTap,
                                                                          //   child: Icon(
                                                                          //     icon,
                                                                          //     color: Colors.grey,
                                                                          //   ),
                                                                          // ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ))),
                                                            isScrollControlled:
                                                                true,
                                                          );
                                                        }))
                                              ])),
                                      Container(
                                          decoration: BoxDecoration(
                                            color: ColorsApp.greySearch,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY),
                                          padding:
                                              EdgeInsets.all(Get.height * .02),
                                          child: SingleChildScrollView(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                DeliveryComponent(
                                                  icon: Assets.user,
                                                  bold: true,
                                                  text: _Bcontroller
                                                      .nameController.text,
                                                ),
                                                DeliveryComponent(
                                                  icon: Assets.call,
                                                  text: _Bcontroller
                                                      .phoneController.text,
                                                ),
                                                DeliveryComponent(
                                                  icon: Assets.localisation,
                                                  text: _Bcontroller
                                                      .selected_livraison_point
                                                      .libelle,
                                                ),
                                              ]))),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kMarginY / 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              'adL'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 12,
                                                  color: ColorsApp.black,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            color: ColorsApp.greySearch,
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY),
                                          padding:
                                              EdgeInsets.all(Get.height * .02),
                                          child: SingleChildScrollView(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: kMarginY),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          child: Text(
                                                        'produit'.tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Lato',
                                                          fontSize: 12,
                                                          color:
                                                              ColorsApp.black,
                                                        ),
                                                      )),
                                                      Container(
                                                          child: Text(
                                                              _controller
                                                                  .totalItems
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 12,
                                                                  color:
                                                                      ColorsApp
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: kMarginY),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          child: Text(
                                                        'monT'.tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Lato',
                                                          fontSize: 12,
                                                          color:
                                                              ColorsApp.black,
                                                        ),
                                                      )),
                                                      Container(
                                                          child: Text(
                                                              'FCFA ' +
                                                                  _controller
                                                                      .totalPrix
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 12,
                                                                  color:
                                                                      ColorsApp
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                    ],
                                                  ),
                                                ),
                                              ]))),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kMarginY / 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              'paymentM'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 12,
                                                  color: ColorsApp.black,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            GetBuilder<GeneralController>(
                                                builder: (_Acontroller) =>
                                                    InkWell(
                                                        child: Container(
                                                            child: SvgIcon(
                                                                icon: Assets
                                                                    .refresh)),
                                                        onTap: () async {
                                                          await _Acontroller
                                                              .getListModePaiement();
                                                        })),
                                          ],
                                        ),
                                      ),
                                      GetBuilder<GeneralController>(
                                          builder: (_Acontroller) => _Acontroller
                                                      .isLoadedMP ==
                                                  0
                                              ? Container(
                                                  child: SpinKitCircle(
                                                    color: Colors.blue,
                                                    size: 40,
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      // top: Get.size.height * .015,
                                                      bottom: Get.size.height *
                                                          .025),
                                                  // decoration: BoxDecoration(
                                                  //     borderRadius: BorderRadius.circular(15),
                                                  //     color: Colors.white),
                                                  // padding: EdgeInsets.only(
                                                  //   top: 25,
                                                  // ),
                                                  child: Column(
                                                    children: [
                                                      SingleChildScrollView(
                                                          child: ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  _Acontroller
                                                                      .lmodePaiement
                                                                      .length,
                                                              itemBuilder: (_ctx,
                                                                      index) =>
                                                                  SelectComponent(
                                                                      select: index +
                                                                              1 ==
                                                                          _Acontroller
                                                                              .selected,
                                                                      mode: _Acontroller
                                                                              .lmodePaiement[
                                                                          index])))
                                                    ],
                                                  ))),
                                      CustomBtn(
                                        color: ColorsApp.secondBlue,
                                        title: 'Terminer',
                                        onTap: () async {
                                          await _Bcontroller.buyCart();
                                        },
                                      )
                                    ]))),
                            childCount: 1))
                  ]),
            ));
      });
    });
  }
}
