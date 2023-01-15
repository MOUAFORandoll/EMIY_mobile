import 'dart:io';

import 'package:fahkapmobile/components/Button/AppIconButton.dart';
import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Form/commentForm.dart';
import 'package:fahkapmobile/components/Form/formComponent.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Form/text_field.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Widget/imageComp.dart';
import 'package:fahkapmobile/components/Widget/productBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/shoppingproductComponent.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
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
    Get.find<BoutiqueController>().getCategory();
    Get.find<BoutiqueController>().getListProduitForBoutique();
    Get.find<BoutiqueController>().onInitData();
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onTap: () => Get.back()),
            title: _controller.searchProB
                ? KTextField(
                    controllerField: controllerField,
                    onChange: _controller.searchProduitB)
                : Text(
                    'Vos produits',
                    style: TextStyle(color: Colors.black),
                  ),
            actions: [
              InkWell(
                  child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: !_controller.searchProB
                          ? Icon(
                              Icons.search,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.close,
                              color: Colors.red,
                            )),
                  onTap: () {
                    controllerField.text = '';
                    _controller.searchProBButtom();
                  })
            ],
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            // Container(
            //   decoration: BoxDecoration(color: ColorsApp.grey),
            //   padding: EdgeInsets.only(
            //       left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
            //   alignment: Alignment.topLeft,
            //   child: smallText(
            //     text: 'Nom Boutique',
            //   ),
            // ),
            Container(
                decoration: BoxDecoration(color: ColorsApp.grey),
                padding: EdgeInsets.only(
                    left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      smallText(
                        text: !_controller.addProduct ? 'Liste' : 'Nouveau',
                      ),
                      CustomBtn(
                        color: ColorsApp.greenLight,
                        title: _controller.addProduct
                            ? 'Retour'
                            : 'Ajouter Produit',
                        onTap: () {
                          _controller.chageState(!_controller.addProduct);
                        },
                      )
                    ])),
            !_controller.addProduct
                ? _controller.isLoadedPB == 0
                    ? Shimmer.fromColors(
                        baseColor: Colors.blueGrey,
                        highlightColor: Colors.greenAccent,
                        child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: kMarginX),
                            child: SingleChildScrollView(
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (_ctx, index) => Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: kMdHeight / 9,
                                                  // width: kMdWidth,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: kMarginX,
                                                      vertical: kMarginY),
                                                  width: Get.width / 3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8)),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/error.gif"),
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors.blue,
                                                                BlendMode
                                                                    .colorBurn)),
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: kMarginX,
                                                      vertical: kMarginY),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        // width: kSmWidth * .6,

                                                        child: Text('Nom : ',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: ColorsApp
                                                                    .greenLight,
                                                                fontSize: 12)),
                                                      ),
                                                    ],
                                                  ))
                                            ])))))
                    : _controller.produitBoutiqueList.length == 0
                        ? Center(child: Text('Aucun Produit'))
                        : SingleChildScrollView(
                            child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _controller.produitBoutiqueList.length,
                            itemBuilder: (_ctx, index) {
                              return ProductBoutiqueComponent(
                                  produit:
                                      _controller.produitBoutiqueList[index]);
                            },
                          ))
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        FormComponent2(
                            icon: Icons.account_circle,
                            type: 0,
                            controller: titre,
                            enabled: true,
                            titre: 'Nom du produit',
                            hint: "Iphone 11"),
                        FormComponent2(
                            icon: Icons.account_circle,
                            type: 0,
                            controller: quantite,
                            enabled: true,
                            titre: 'Quantite',
                            kType: TextInputType.number,
                            hint: "10"),
                        FormComponent2(
                            icon: Icons.account_circle,
                            type: 0,
                            controller: prix,
                            kType: TextInputType.number,
                            enabled: true,
                            titre: 'Prix',
                            hint: "1500"),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text('Categorie'),
                        ),
                        _controller.isLoadedC == 0
                            ? CircularProgressIndicator(
                                color: Colors.blueAccent,
                              )
                            : Container(
                                alignment: Alignment.center,
                                width: Get.width,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.only(
                                  left: Get.width * .08,
                                  right: Get.width * .08,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton(
                                  // Initial Value
                                  value: _controller.categorySelect,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: _controller.categoryList.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item.libelle),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    _controller.secelctCate(newValue);
                                    // setState(() {
                                    //   dropdownvalue = newValue!;
                                    // });
                                  },
                                )),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text('Description'),
                        ),
                        TextFormField(
                          onChanged: (String value) {
                            // if (onChange != null) onChange!(value);
                          },
                          controller: description,
                          validator: (value) {
                            return value!.isEmpty
                                ? "veillez remplir se champs"
                                : null;
                          },
                          // keyboardType: type,
                          // obscureText: obscureText!,
                          maxLengthEnforced: false,
                          maxLength: 10,
                          maxLines: 10,
                          decoration: new InputDecoration(
                            fillColor: ColorsApp.skyBlue,
                            counter: Offstage(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: ColorsApp.bleuLight,
                                )),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(
                            //     color: ColorsApp.skyBlue,
                            //   ),
                            // ),
                            contentPadding: EdgeInsets.only(
                              left: 12,
                              bottom: 10,
                              top: 10,
                              right: 12,
                            ),
                            hintText: 'Entrer une description',
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
                        _controller.listImgProduits.length != 0
                            ? smallText(
                                text: 'Listes images',
                              )
                            : Container(),
                        _controller.listImgProduits.length != 0
                            ? Container(
                                height: kSmHeight * 2,
                                margin: EdgeInsets.symmetric(
                                    vertical: kMarginY * .1),
                                child: ListView.builder(
                                  itemCount: _controller.listImgProduits.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_ctx, index) =>
                                      _controller.listImgProduits[index] != null
                                          ? ImageComp(
                                              file: _controller
                                                  .listImgProduits[index],
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
                                      Map<String, Object> dataS = {
                                        'keySecret': _controller.s.getKey(),
                                        'titre': titre.text,
                                        'description': description.text,
                                        'prixUnitaire': prix.text,
                                        'quantite': quantite.text,
                                        'idCategory':
                                            _controller.categorySelect.id,
                                        'codeBoutique':
                                            _controller.Boutique.codeBoutique,
                                        'countImage':
                                            _controller.listImgProduits.length
                                      };
                                      ;
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
          ])));
    });
  }
}
