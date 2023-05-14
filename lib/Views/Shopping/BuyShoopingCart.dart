import 'dart:async';

import 'package:Fahkap/Views/Shopping/PaiementView.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/DeliveryComponent.dart';
import 'package:Fahkap/components/Widget/LivreurComponent.dart';
import 'package:Fahkap/components/Widget/SelectComponent.dart';
import 'package:Fahkap/components/Widget/app_input.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/components/Widget/icon_svg.dart';
import 'package:Fahkap/components/Widget/productBuyComponent.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/BuyShopController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/model/data/ModePaiementModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:Fahkap/styles/colorApp.dart';

// import 'package:cinetpay/cinetpay.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';

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
            appBar: null,
            backgroundColor: Colors.white,
            body: CustomScrollView(
                controller: Get.find<ActionController>().scrollcontroller,
                slivers: [
                  // Add the app bar to the CustomScrollView.
                  SliverAppBar(
                    backgroundColor: Colors.white,

                    elevation: 0,
                    // Provide a standard title.
                    // title: Text('title'),
                    // Allows the user to reveal the app bar if they begin scrolling
                    // back up the list of items.
                    floating: true,
                    // Display a placeholder widget to visualize the shrinking size.
                    flexibleSpace: Container(
                        margin:
                            EdgeInsets.only(top: Get.height * .030, left: 0),
                        padding: EdgeInsets.only(
                            left: Get.width * .030, right: Get.width * .030),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: InkWell(
                                      child: Icon(Icons.arrow_back_ios_new,
                                          color: Colors.black),
                                      onTap: () => Get.back())),
                              Container(
                                child: AppTitleRight(
                                    title: 'Panier',
                                    description: 'Votre panier',
                                    icon: Assets.shoppingCart),
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        .005),
                              ),
                            ])

                        /*   onTap: () => filterDest() */
                        ),
                    // Make the initial height of the SliverAppBar larger than normal.
                    expandedHeight: 60,
                  ),

                  SliverList(

                      // Use a delegate to build items as they're scrolled on screen.
                      delegate: SliverChildBuilderDelegate(
                          // The builder function returns a ListTile with a title that
                          // displays the index of the current item.
                          (context, index) => Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: kMarginX),
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kMarginY / 3),
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
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12,
                                                    color: ColorsApp.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Container(
                                                  child: InkWell(
                                                      child: Text(
                                                        'Change',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 14,
                                                            color:
                                                                ColorsApp.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      onTap: () {
                                                        Get.bottomSheet(
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical:
                                                                    kMarginY,
                                                                horizontal:
                                                                    kMarginX,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
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
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'orkney',
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Icon(Icons.close),
                                                                            onTap:
                                                                                () {
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
                                                                          _Bcontroller
                                                                              .nameController,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .check_circle_sharp,
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        ;
                                                                      },
                                                                      label:
                                                                          'name'
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
                                                                          _Bcontroller
                                                                              .phoneController,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .check_circle_sharp,
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        ;
                                                                      },
                                                                      label:
                                                                          'labelphone'
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
                                                                          _Bcontroller
                                                                              .phoneController,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .check_circle_sharp,
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        ;
                                                                      },
                                                                      label:
                                                                          'mail'
                                                                              .tr,
                                                                      validator:
                                                                          (value) {},
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                      child: Container(
                                                                          padding: EdgeInsets.all(Get.height * .02),
                                                                          margin: EdgeInsets.only(
                                                                            top:
                                                                                kMarginY,
                                                                          ),
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorsApp.bleuLight),
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                'livrP'.tr,
                                                                                style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'orkney',
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
                                                                        Get.bottomSheet(Container(
                                                                            padding: EdgeInsets.symmetric(
                                                                              vertical: kMarginY,
                                                                              horizontal: kMarginX,
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
                                                                                          fontFamily: 'orkney',
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
                                                                              ListView.builder(physics: NeverScrollableScrollPhysics(), shrinkWrap: true, itemCount: 50, itemBuilder: (_ctx, index) => Text('iii'))
                                                                            ]))));
                                                                      }),
                                                                  Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      top:
                                                                          kMarginY,
                                                                    ),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          _Bcontroller
                                                                              .lieuxController,

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
                                                                            color:
                                                                                ColorsApp.skyBlue,
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
                                                                            'Entrer une description',
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
                                                  text: 'Mouafo Takoumbo'),
                                              DeliveryComponent(
                                                  icon: Assets.call,
                                                  text: '690863838'),
                                              DeliveryComponent(
                                                  icon: Assets.localisation,
                                                  text:
                                                      'Douala, Bepanda Tonnere'),
                                            ]))),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: kMarginY / 3),
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
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                color: ColorsApp.black,
                                                fontWeight: FontWeight.bold),
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                      'product'.tr,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 12,
                                                        color: ColorsApp.black,
                                                      ),
                                                    )),
                                                    Container(
                                                        child: Text(
                                                            _controller
                                                                .totalItems
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 12,
                                                                color: ColorsApp
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                      'monT'.tr,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 12,
                                                        color: ColorsApp.black,
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
                                                                    'Montserrat',
                                                                fontSize: 12,
                                                                color: ColorsApp
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                  ],
                                                ),
                                              ),
                                            ]))),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: kMarginY / 3),
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
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                color: ColorsApp.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          GetBuilder<ActionController>(
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
                                    GetBuilder<ActionController>(
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
                                                    bottom:
                                                        Get.size.height * .025),
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
                                      color: ColorsApp.greenLight,
                                      title: 'Terminer',
                                      onTap: () async {
                                        await _Bcontroller.buyCart();
                                      },
                                    )
                                  ]))),
                          childCount: 1))
                ]));
      });
    });
  }
}
