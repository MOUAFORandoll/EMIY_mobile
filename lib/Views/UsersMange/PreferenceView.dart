import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/produitForBoutiqueComponent.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Widget/app_empty.dart';

class PreferenceView extends StatelessWidget {
  PreferenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProduitController>(
      builder: (_controler) => _controler.isLoadedPB == 0
          ? Container(
              // height: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: kMarginY * 3),
              child: ShimmerProduit())
          : Container(
              // height: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: kMarginY * 3),
              child: _controler.isLoadedPB == 1
                  ? (_controler.preferenceList.length != 0)
                      ? SingleChildScrollView(
                          child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding:
                                  EdgeInsets.symmetric(horizontal: kMarginX),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      childAspectRatio: 0.7,
                                      mainAxisSpacing: 20.0),
                              itemCount: _controler.preferenceList.length,
                              itemBuilder: (_ctx, index) =>
                                  ProduitForBoutiqueComponent(
                                      produit: _controler.preferenceList[index],
                                      type: 'favorite',
                                      index: index)))
                      : Container(
                          height: kHeight,
                          child: AppEmpty(title: 'Aucun Produit'))
                  : Container(
                      height: kMdHeight * .6,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text('Error'),
                      ))),
    );
  }
}
