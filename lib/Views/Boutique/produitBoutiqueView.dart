import 'dart:io';

import 'package:fahkapmobile/components/Button/AppIconButton.dart';
import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Form/commentForm.dart';
import 'package:fahkapmobile/components/Form/formComponent.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Widget/imageComp.dart';
import 'package:fahkapmobile/components/Widget/productBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/shoppingproductComponent.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProduitBoutiqueView extends StatelessWidget {
  ProduitBoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  TextEditingController name = TextEditingController();
  TextEditingController titre = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onTap: () => Get.back()),
            title: Text(
              'Liste de vos produits',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              InkWell(
                child: Icon(Icons.search, color: Colors.red),
              )
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
                        text: 'Categorie',
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
                ? SingleChildScrollView(
                    child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _controller.Boutique.produits.length,
                    itemBuilder: (_ctx, index) {
                      return ProductBoutiqueComponent(
                          produit: _controller.Boutique.produits[index]);
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
                            controller: titre,
                            enabled: true,
                            titre: 'Quantite',
                            kType: TextInputType.number,
                            hint: "10"),
                        FormComponent2(
                            icon: Icons.account_circle,
                            type: 0,
                            controller: titre,
                            kType: TextInputType.number,
                            enabled: true,
                            titre: 'Prix',
                            hint: "1500"),
                        CommentForm(
                          titre: 'Description',
                          // height: kMdHeight / 2,
                          width: kMdWidth * 4,
                        ),
                        _controller.listImgProduits.length != 0
                            ? smallText(
                                text: 'Listes images',
                              )
                            : Container(),
                        _controller.listImgProduits.length != 0
                            ? Container(
                                height: kSmHeight,
                                margin: EdgeInsets.symmetric(
                                    vertical: kMarginY * .1),
                                child: ListView.builder(
                                  itemCount: _controller.listImgProduits.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_ctx, index) => ImageComp(
                                      file: _controller.listImgProduits[index],
                                      index: index),
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
                                    title: _controller.addProduct
                                        ? 'Retour'
                                        : 'Ajouter Produit',
                                    onTap: () {
                                      _controller
                                          .chageState(!_controller.addProduct);
                                    },
                                  )
                                ])),
                      ],
                    ))),
          ])));
    });
  }
}
