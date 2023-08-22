import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/components/Button/uploadImage.dart';
import 'package:EMIY/components/Widget/app_input_new.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:EMIY/components/Widget/settingComponent.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/Services/validators.dart';

class InteretsView extends StatelessWidget {
  InteretsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProduitController>(
        builder: (produit) => GetBuilder<CategoryBoutiqueController>(
            builder: (categorys) => Container(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: kMarginX * 3,
                            right: kMarginX * 3,
                            top: kMarginY),
                        // margin: EdgeInsets.symmetric(
                        //     vertical: kMarginY, horizontal: kMarginX * 3),
                        child: Image.asset(
                          Assets.onb1,
                          height: kHeight / 3,
                          width: kHeight / 2.5,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Wrap(
                              spacing: 7,
                              alignment: WrapAlignment.center,
                              runSpacing: kMarginY / 2,
                              children: List.generate(
                                  categorys.categoryList.length,
                                  (index) => InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: produit.select(
                                              categorys.categoryList[index].id,
                                            )
                                                ? ColorsApp.black
                                                : ColorsApp.greySecond,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            categorys
                                                .categoryList[index].libelle,
                                            style: TextStyle(
                                              // fontFamily: 'Montserrat',
                                              fontSize: 12,
                                              color: produit.select(
                                                categorys
                                                    .categoryList[index].id,
                                              )
                                                  ? ColorsApp.white
                                                  : ColorsApp.marron,
                                            ),
                                          ),
                                        ),
                                        onTap: () => produit.stateInterest(
                                          categorys.categoryList[index].id,
                                        ),
                                      )))),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: kMarginX * 3)
                            .add(EdgeInsets.only(
                          top: kMarginY * 2,
                        )),
                        child: AppButton(
                            size: MainAxisSize.max,
                            bgColor: ColorsApp.black,
                            text: 'valider'.tr,
                            onTap: () async {
                              produit.getInterestProduit();
                            }),
                      ),
                    ],
                  )),
                )));
  }
}
