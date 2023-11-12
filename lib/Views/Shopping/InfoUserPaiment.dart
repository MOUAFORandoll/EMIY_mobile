import 'package:EMIY/components/Widget/pointLivraisonComponent.dart';
import 'package:EMIY/components/Widget/app_input.dart';
import 'package:EMIY/controller/BuyShopController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class InfoUserPaiment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyShopController>(
        builder: (_Bcontroller) => Container(
            height: Get.height * .8,
            padding: EdgeInsets.symmetric(
              vertical: kMarginY,
              horizontal: kMarginX,
            ),
            margin: EdgeInsets.only(
              top: kMarginY * 8,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: Colors.white),
            // padding: EdgeInsets.only(
            //   top: 25,
            // ),
            child: SingleChildScrollView(
                child: Column(
              children: [
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
                  padding: EdgeInsets.only(
                    top: kMarginY * 4,
                  ),
                  child: AppInput(
                    controller: _Bcontroller.nameController,
                    icon: Icon(
                      Icons.check_circle_sharp,
                    ),
                    onChanged: (value) {
                      _Bcontroller.refresh0();
                    },
                    label: 'name'.tr,
                    validator: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: kMarginY * 2,
                  ),
                  child: AppInput(
                    controller: _Bcontroller.phoneController,
                    icon: Icon(
                      Icons.check_circle_sharp,
                    ),
                    onChanged: (value) {
                      _Bcontroller.refresh0();
                    },
                    label: 'labelphone'.tr,
                    validator: (value) {},
                  ),
                ),
                GetBuilder<BuyShopController>(
                    builder: (_BsCcontroller) => InkWell(
                        child: _BsCcontroller.selected_livraison_point.id != 0
                            ? Container(
                                width: kWidth,
                                padding: EdgeInsets.all(Get.height * .02),
                                margin: EdgeInsets.only(
                                  top: kMarginY * 2,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsApp.secondBlue),
                                child: Text(
                                  _BsCcontroller
                                      .selected_livraison_point.libelle,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(Get.height * .02),
                                margin: EdgeInsets.only(
                                  top: kMarginY * 2,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorsApp.secondBlue),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15))),
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                            top: kMarginY,
                                          ),
                                          child: Row(
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
                                          padding: EdgeInsets.symmetric(
                                            vertical: kMarginY * 2,
                                          ),
                                          child: AppInput(
                                            controller:
                                                _BCcontroller.searchController,
                                            label: 'Rechercher'.tr,
                                            onChanged: (value) {
                                              return _BCcontroller
                                                  .searchPointLivraison();
                                            },
                                          )),
                                      Expanded(
                                          child: SingleChildScrollView(
                                              child: _BCcontroller
                                                          .searchController
                                                          .text
                                                          .length ==
                                                      0
                                                  ? ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _BCcontroller
                                                          .livraison_point
                                                          .length,
                                                      itemBuilder: (_ctx, index) =>
                                                          PointLivraisonComponent(
                                                              point_livraison: _BCcontroller.livraison_point[
                                                                  index]))
                                                  : ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _BCcontroller.search_livraison_point.length,
                                                      itemBuilder: (_ctx, index) => PointLivraisonComponent(point_livraison: _BCcontroller.search_livraison_point[index]))))
                                    ]))),
                            isScrollControlled: true,
                          );
                        })),
                Container(
                  margin: EdgeInsets.only(
                    top: kMarginY * 2,
                  ),
                  child: TextFormField(
                    controller: _Bcontroller.lieuxController,

                    // keyboardType: type,
                    // obscureText: obscureText!,
                    // maxLengthEnforced: false,
                    onChanged: (value) {
                      _Bcontroller.refresh0();
                    },
                    maxLines: 10,
                    decoration: new InputDecoration(
                      fillColor: ColorsApp.skyBlue,
                      // counter: Offstage(),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: ColorsApp.skyBlue,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: ColorsApp.skyBlue,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 12,
                        bottom: 10,
                        top: 10,
                        right: 12,
                      ),
                      hintText:
                          'Donnez moi plus d\'indication, un petit texte sera un plus',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'orkney',
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
            ))));
  }
}
