import 'dart:io';

import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Button/uploadImage.dart';
import 'package:Fahkap/components/Form/commentForm.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Widget/app_bar_custom.dart';
import 'package:Fahkap/components/Widget/app_empty.dart';
import 'package:Fahkap/components/Widget/app_input.dart';
import 'package:Fahkap/components/Widget/app_input_new.dart';
import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/imageComp.dart';
import 'package:Fahkap/components/Widget/productBoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class ProduitBoutiqueUserView extends StatelessWidget {
  ProduitBoutiqueUserView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  // Initial Selected Value
  // String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    CategoryModel dropdownvalue = new CategoryModel.fromJson(
        {"id": 0, "libelle": '', "description": '', "status": false});

    // Get.find<BoutiqueController>().onInitData();
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // Container(
        //   decoration: BoxDecoration(color: ColorsApp.grey),
        //   child:
        //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //     Container(
        //       child: _controller.searchProB
        //           ? KTextField(
        //               controllerField: controllerField,
        //               onChange: _controller.searchProduitB)
        //           : Text(
        //               'Vos produits',
        //               style: TextStyle(color: Colors.black),
        //             ),
        //     ),
        //     InkWell(
        //         child: Container(
        //             margin: EdgeInsets.only(right: 10),
        //             child: !_controller.searchProB
        //                 ? Icon(
        //                     Icons.search,
        //                     color: Colors.red,
        //                   )
        //                 : Icon(
        //                     Icons.close,
        //                     color: Colors.red,
        //                   )),
        //         onTap: () {
        //           controllerField.text = '';
        //           _controller.searchProBButtom();
        //         })
        //   ]),
        // ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: kMarginX),
            child: AppBarCustom(
              title: !_controller.addProduct
                  ? 'Liste de vos produits'
                  : 'Ajouter un produit',
              titleBtn: !_controller.addProduct ? 'Ajouter' : 'Liste',
              onTap: () {
                // _controller.chageState(!_controller.addProduct);

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
                                    child: Text('Annuler'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Enregistrer'),
                                    onPressed: () async {
                                      await _controller.addProduit();
                                      // _controller.chageState(!_controller.addProduct);
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
                                    return Validators.isValidUsername(value!);
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
                                    return Validators.usNumeriqValid(value!);
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
                                      vertical: kMarginY, horizontal: kMarginX),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorsApp.greySearch),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Disponible'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              child: Icon(Icons.remove),
                                              onTap: () {
                                                _controller.mamageQte(false);
                                              }),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: ColorsApp.greySecond),
                                            width: kMdWidth / 2,
                                            height: 35,
                                            alignment: Alignment.center,
                                            child: AppInputNew(
                                              controller: _controller.quantite,
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
                                      _Ncontroller.listImgProduits.length != 0
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
                                    border:
                                        Border.all(color: ColorsApp.greySecond)
                                    // color: (color == null) ? ColorsApp.blue : color,
                                    ),
                                child: TextFormField(
                                  controller: _controller.descriptionP,
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    return Validators.isValidUsername(value!);
                                  },
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                  ),
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorsApp.skyBlue, width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorsApp.greySearch),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 8,
                                      fontFamily: 'Montserrat',
                                    ),
                                    labelStyle: TextStyle(
                                      color: ColorsApp.black,
                                      fontFamily: 'Montserrat',
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
                                      fontFamily: 'orkney',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  decoration:
                                      BoxDecoration(color: ColorsApp.grey),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // smallText(
                                        //   text: _controller.Boutique.titre,
                                        // ),
                                        // CustomBtn(
                                        //   color: ColorsApp.greenLight,
                                        //   title: 'Ajouter Produit',
                                        //   onTap: () async {
                                        //     await _controller.addProduit();
                                        //     // _controller.chageState(!_controller.addProduct);
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
        /*   !_controller.addProduct
            ? */
        _controller.isLoadedPB == 0
            ? AppLoading()
            : _controller.produitBoutiqueList.length == 0
                ? Container(
                    height: kHeight, child: AppEmpty(title: 'Aucun Produit'))
                : SingleChildScrollView(
                    child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _controller.produitBoutiqueList.length,
                    itemBuilder: (_ctx, index) {
                      return ProductBoutiqueComponent(
                          produit: _controller.produitBoutiqueList[index]);
                    },
                  )) /*  :  */
      ]));
    });
  }
}
