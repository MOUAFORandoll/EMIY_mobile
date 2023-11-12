import 'dart:async';

import 'package:EMIY/Views/Shopping/InfoUserPaiment.dart';
import 'package:EMIY/Views/Shopping/PaiementView.dart';
import 'package:EMIY/Views/Shopping/SelectPaiementMode.dart';
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
              title: Container(child: Text('Order Details')),
              centerTitle: true,
              /*   actions: [
                  Row(
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
                          ]) ),
                ] */
            ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kMarginY),
                                        child: Column(
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
                                                    'My Cart'.tr,
                                                    style: TextStyle(
                                                        fontSize: kBasics * 1.3,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsApp.greySearch,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: kMarginY),
                                                padding: EdgeInsets.all(
                                                    Get.height * .02),
                                                child: SingleChildScrollView(
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    kMarginY),
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
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 12,
                                                                color: ColorsApp
                                                                    .black,
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
                                                                        fontSize:
                                                                            12,
                                                                        color: ColorsApp
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w700))),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    kMarginY),
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
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 12,
                                                                color: ColorsApp
                                                                    .black,
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
                                                                        fontSize:
                                                                            12,
                                                                        color: ColorsApp
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w700))),
                                                          ],
                                                        ),
                                                      ),
                                                    ]))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kMarginY),
                                        child: Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: kMarginY / 2),
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
                                                        'adL'.tr,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            fontSize:
                                                                kBasics * 1.3,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )),
                                                    ])),
                                            InkWell(
                                                child: GetBuilder<
                                                        BuyShopController>(
                                                    builder: (_B0controller) =>
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                color: ColorsApp
                                                                    .greySearch,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top:
                                                                        kMarginY),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    Get.height *
                                                                        .02),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SingleChildScrollView(
                                                                        child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                          DeliveryComponent(
                                                                            icon:
                                                                                Assets.user,
                                                                            bold:
                                                                                true,
                                                                            text:
                                                                                _B0controller.nameController.text,
                                                                          ),
                                                                          DeliveryComponent(
                                                                            icon:
                                                                                Assets.call,
                                                                            text:
                                                                                _B0controller.phoneController.text,
                                                                          ),
                                                                          DeliveryComponent(
                                                                            icon:
                                                                                Assets.localisation,
                                                                            text:
                                                                                _B0controller.selected_livraison_point.libelle,
                                                                          ),
                                                                        ])),
                                                                    Container(
                                                                      child: Icon(
                                                                          Icons
                                                                              .keyboard_arrow_right),
                                                                    )
                                                                  ],
                                                                ),
                                                                Container(
                                                                    child: Text(
                                                                  _B0controller
                                                                      .lieuxController
                                                                      .text,
                                                                  maxLines: 3,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        kDescription,
                                                                  ),
                                                                )),
                                                              ],
                                                            ))),
                                                onTap: () {
                                                  Get.bottomSheet(
                                                    InfoUserPaiment(),
                                                    isScrollControlled: true,
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kMarginY),
                                        child: Column(
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
                                                    'paymentM'.tr,
                                                    style: TextStyle(
                                                        fontSize: kBasics * 1.3,
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                                    : InkWell(
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                color: ColorsApp
                                                                    .greySearch,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5)),
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        kMarginY),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    Get.height *
                                                                        .02),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        color: ColorsApp
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5)),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                5),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      height:
                                                                          25,
                                                                      width: 25,
                                                                      // fit: BoxFit.cover,
                                                                      imageUrl: _Acontroller
                                                                          .smode
                                                                          .img,
                                                                      imageBuilder:
                                                                          (context,
                                                                              imageProvider) {
                                                                        return Container(
                                                                          height:
                                                                              28,
                                                                          width:
                                                                              40,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(
                                                                              image: imageProvider,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      placeholder:
                                                                          (context,
                                                                              url) {
                                                                        return Container(
                                                                          child: Center(
                                                                              child: CircularProgressIndicator(
                                                                            color:
                                                                                ColorsApp.skyBlue,
                                                                          )),
                                                                        );
                                                                      },
                                                                      errorWidget:
                                                                          (context,
                                                                              url,
                                                                              error) {
                                                                        return Container(
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                          image:
                                                                              AssetImage('assets/logo/logoNew.png'),
                                                                        )));
                                                                      },
                                                                    )),
                                                                Container(
                                                                    child: Text(
                                                                  _Acontroller
                                                                      .smode
                                                                      .libelle,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          kBasics *
                                                                              1.3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )),
                                                                Container(
                                                                    child: Icon(
                                                                        Icons
                                                                            .keyboard_arrow_right))
                                                              ],
                                                            )),
                                                        onTap: () {
                                                          Get.bottomSheet(
                                                            SelectPaiementMode(),
                                                            isScrollControlled:
                                                                true,
                                                          );
                                                        })),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kMarginY),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: kMarginY / 2),
                                              child: Text(
                                                'Order Info'.tr,
                                                style: TextStyle(
                                                    fontSize: kBasics * 1.3,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: kMarginY),
                                                child: Text(
                                                  "Les frais de livraisons sont gratuits pour votre premiere livraison",
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      // fontSize: kDescription,
                                                      ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY),
                                          child: CustomBtn(
                                            color: ColorsApp.secondBlue,
                                            title: 'Terminer',
                                            onTap: () async {
                                              await _Bcontroller.buyCart();
                                            },
                                          ))
                                    ]))),
                            childCount: 1))
                  ]),
            ));
      });
    });
  }
}
