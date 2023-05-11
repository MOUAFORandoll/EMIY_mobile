import 'dart:io';

import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/commentForm.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Widget/app_bar_custom.dart';
import 'package:Fahkap/components/Widget/app_empty.dart';
import 'package:Fahkap/components/Widget/app_input.dart';
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

  TextEditingController name = TextEditingController();
  TextEditingController titre = TextEditingController();
  TextEditingController quantite = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController description = TextEditingController();
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
                _controller.chageState(!_controller.addProduct);
              },
            )),
        !_controller.addProduct
            ? _controller.isLoadedPB == 0
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
                          return ProductBoutiqueComponent(
                              produit: _controller.produitBoutiqueList[index]);
                        },
                      ))
            : Container(
                margin: EdgeInsets.symmetric(horizontal: kMarginX),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    _controller.listImgProduits.length != 0
                        ? smallText(
                            text: 'Listes images',
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY,
                      ),
                      child: AppInput(
                        controller: titre,
                        label: 'lbnameprod'.tr,
                        validator: (value) {
                          return Validators.isValidUsername(value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY,
                      ),
                      child: AppInput(
                        controller: prix,
                        label: 'lbprixprod'.tr,
                        validator: (value) {
                          return Validators.usNumeriqValid(value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY,
                      ),
                      child: AppInput(
                        controller: quantite,
                        label: 'lbnqteprod'.tr,
                        validator: (value) {
                          return Validators.usNumeriqValid(value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY,
                      ),
                      child: TextFormField(
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
                            borderSide:
                                BorderSide(color: ColorsApp.orange, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            //  borderSide : BorderSide(color:Colors.blue,width: 3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 8,
                            fontFamily: 'Montserrat',
                          ),
                          labelStyle: TextStyle(
                            color: ColorsApp.orange, fontFamily: 'Montserrat',
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
                    _controller.listImgProduits.length != 0
                        ? Container(
                            height: kSmHeight * 2,
                            margin:
                                EdgeInsets.symmetric(vertical: kMarginY * .1),
                            child: ListView.builder(
                              itemCount: _controller.listImgProduits.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_ctx, index) => _controller
                                          .listImgProduits[index] !=
                                      null
                                  ? ImageComp(
                                      file: _controller.listImgProduits[index],
                                      index: index)
                                  : Container(),
                            ),
                          )
                        : Container(),
                    Container(
                        decoration: BoxDecoration(color: ColorsApp.grey),
                        child: CustomBtn(
                          color: ColorsApp.greenLight,
                          title: 'Selectionner image',
                          onTap: () {
                            _controller.getImage();
                          },
                        )),
                    Container(
                        decoration: BoxDecoration(color: ColorsApp.grey),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // smallText(
                              //   text: _controller.Boutique.titre,
                              // ),
                              CustomBtn(
                                color: ColorsApp.greenLight,
                                title: 'Ajouter Produit',
                                onTap: () async {
                                  var key = await _controller.s.getKey();
                                  Map<String, Object> dataS = {
                                    'keySecret': key,
                                    'titre': titre.text,
                                    'description': description.text,
                                    'prixUnitaire': prix.text,
                                    'quantite': quantite.text,
                                    // 'idCategory':
                                    //     _controller.categorySelect.id,
                                    'codeBoutique':
                                        _controller.Boutique.codeBoutique,
                                    'countImage':
                                        _controller.listImgProduits.length
                                  };
                                  print(dataS);

                                  _controller.listImgProduits.forEach((e) {
                                    dataS.addAll({
                                      "file${_controller.listImgProduits.indexOf(e)}":
                                          MultipartFile(
                                        e.path,
                                        filename: "Image.jpg",
                                      )
                                    });
                                  });
                                  FormData data = new FormData(dataS);

                                  await _controller.addProduit(data);
                                  // _controller.chageState(!_controller.addProduct);
                                },
                              )
                            ])),
                  ],
                ))),
      ]));
    });
  }
}
