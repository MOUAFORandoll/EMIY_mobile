// ignore_for_file: unnecessary_null_comparison

import 'package:EMIY/components/Button/uploadImage.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_bar_custom.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_input_new.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/imageComp.dart';
import 'package:EMIY/components/Widget/produitBoutiqueComponent.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Widget/app_title_right.dart';

class ProduitBoutiqueUserView extends StatelessWidget {
  ProduitBoutiqueUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get.find<BoutiqueController>().onInitData();
    return GetBuilder<BoutiqueController>(builder: (_controller) {
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
                                title: 'produit'.tr,
                                description: ''.tr,
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ])),
              ]),
          body: Column(children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: kMarginY, horizontal: kMarginX),
                child: KTextField(
                    controllerField: _controller.searchInBoutiqueCont,
                    onClear: _controller.onClearAllController,
                    onChange: _controller.searchProduitB)),
            Container(
                margin: EdgeInsets.symmetric(horizontal: kMarginX),
                child: AppBarCustom(
                  title: !_controller.addProduit
                      ? 'Liste de vos produits'
                      : 'Ajouter un produit',
                  titleBtn: !_controller.addProduit ? 'Ajouter' : 'Liste',
                  onTap: () {
                    // _controller.chageState(!_controller.addProduit);

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
                          padding: EdgeInsets.symmetric(horizontal: kMarginX),
                          child: Column(
                            children: [
                              // _controller.listImgProduits.length != 0
                              //     ? smallText(
                              //         text: 'Listes images',
                              //       )
                              //     : Container(),
                              Container(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          'Annuler',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            fontFamily: 'Lato',
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Enregistrer',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            fontFamily: 'Lato',
                                            color: ColorsApp.skyBlue,
                                          ),
                                        ),
                                        onPressed: () async {
                                          await _controller.ajouterProduit();
                                          // _controller.chageState(!_controller.addProduit);
                                        },
                                      )
                                    ]),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                      child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: kMarginY * 1.5,
                                    ),
                                    child: AppInputNew(
                                      controller: _controller.name,
                                      icon: Icon(Icons.label),
                                      label: 'lbnameprod'.tr,
                                      validator: (value) {
                                        return Validators.isValidUsername(
                                            value!);
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: kMarginY,
                                    ),
                                    child: AppInputNew(
                                      textInputType: TextInputType.number,
                                      controller: _controller.prix,
                                      icon: Icon(Icons.monetization_on),
                                      label: 'lbprixprod'.tr,
                                      validator: (value) {
                                        return Validators.usNumeriqValid(
                                            value!);
                                      },
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text('Stock')),
                                  Container(
                                      margin: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: kMarginY,
                                          horizontal: kMarginX),
                                      height: kHeight * .06,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: ColorsApp.greySearch),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Disponible'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  child: Icon(Icons.remove),
                                                  onTap: () {
                                                    _controller
                                                        .mamageQte(false);
                                                  }),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color:
                                                        ColorsApp.greySecond),
                                                width: kMdWidth / 2,
                                                // height: 35,
                                                // alignment: Alignment.center,
                                                child: AppInputNew(
                                                  controller:
                                                      _controller.quantite,
                                                  label: '',
                                                  // border: true,
                                                  alignStart: false,
                                                  textInputType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    return Validators
                                                        .usNumeriqValid(value!);
                                                  },
                                                ),
                                              ),
                                              InkWell(
                                                  child: Icon(Icons.add),
                                                  onTap: () {
                                                    _controller.mamageQte(true);
                                                  })
                                            ],
                                          )
                                        ],
                                      )),
                                  GetBuilder<BoutiqueController>(
                                      builder: (_Ncontroller) =>
                                          _Ncontroller.listImgProduits.length !=
                                                  0
                                              ? Container(
                                                  height: kSmHeight * 2,
                                                  margin: EdgeInsets.only(
                                                    top: kMarginY,
                                                  ),
                                                  child: ListView.builder(
                                                    itemCount: _Ncontroller
                                                        .listImgProduits.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder: (_ctx, index) =>
                                                        _Ncontroller.listImgProduits[
                                                                    index] !=
                                                                null
                                                            ? ImageComp(
                                                                file: _Ncontroller
                                                                        .listImgProduits[
                                                                    index],
                                                                index: index)
                                                            : Container(),
                                                  ),
                                                )
                                              : Container()),
                                  Container(
                                      margin: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      // decoration: BoxDecoration(color: ColorsApp.grey),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          UploadImage(
                                            color: ColorsApp.skyBlue,
                                            title: 'Appareil photo',
                                            icon: Icons.camera_alt,
                                            onTap: () {
                                              _controller.getImageAppareil();
                                            },
                                          ),
                                          UploadImage(
                                            color: ColorsApp.skyBlue,
                                            icon: Icons.photo,
                                            title: 'Galerie',
                                            onTap: () {
                                              _controller.getImageGalerie();
                                            },
                                          )
                                        ],
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: kMarginY,
                                    ),
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: ColorsApp.greySecond)
                                        // color: (color == null) ? ColorsApp.blue : color,
                                        ),
                                    child: TextFormField(
                                      controller: _controller.descriptionP,
                                      onChanged: (String value) {},
                                      validator: (value) {
                                        return Validators.isValidUsername(
                                            value!);
                                      },
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Lato',
                                      ),
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorsApp.skyBlue,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorsApp.greySearch),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 8,
                                          fontFamily: 'Lato',
                                        ),
                                        labelStyle: TextStyle(
                                          color: ColorsApp.black,
                                          fontFamily: 'Lato',
                                          // fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                        labelText: 'lbdescprod'.tr,
                                        fillColor: ColorsApp.skyBlue,
                                        counter: Offstage(),
                                        hintText: 'lbdescprod'.tr,
                                        alignLabelWithHint: true,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      decoration:
                                          BoxDecoration(color: ColorsApp.grey),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // smallText(
                                            //   text: _controller.Boutique.titre,
                                            // ),
                                            // CustomBtn(
                                            //   color: ColorsApp.greenLight,
                                            //   title: 'Ajouter Produit',
                                            //   onTap: () async {
                                            //     await _controller.ajouterProduit();
                                            //     // _controller.chageState(!_controller.addProduit);
                                            //   },
                                            // )
                                          ])),
                                ],
                              )))
                            ],
                          )),
                      isScrollControlled: true,
                      // isDismissible: true,
                    );
                  },
                )),
            /*   !_controller.addProduit
            ? */
            Expanded(
              child: _controller.isLoadedPB == 0
                  ? AppLoading()
                  : _controller.produitBoutiqueList.length == 0
                      ? Container(
                          height: kHeight,
                          child: AppEmpty(title: 'Aucun Produit'))
                      : SingleChildScrollView(
                          child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _controller.produitBoutiqueList.length,
                          itemBuilder: (_ctx, index) {
                            return ProduitBoutiqueComponent(
                                produit:
                                    _controller.produitBoutiqueList[index]);
                          },
                        )),
            ) /*  :  */
          ]));
    });
  }
}
