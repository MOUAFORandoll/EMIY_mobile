import 'package:EMIY/components/Widget/BoutiqueCircleComponent.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAbonnementView extends StatelessWidget {
  UserAbonnementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(
      builder: (_bcontroller) => _bcontroller.isAbUseLoad == 0
          ? AppLoading()
          : (_bcontroller.listAbonnememtUser.length != 0)
              ? SingleChildScrollView(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: kMarginX),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          childAspectRatio: 0.70,
                          mainAxisSpacing: 10.0),
                      itemCount: _bcontroller.listAbonnememtUser.length,
                      itemBuilder: (_ctx, index) => BoutiqueCircleComponent(
                            boutique: _bcontroller.listAbonnememtUser[index],
                          )))
              : AppEmpty(title: 'Aucun Abonnement'),
    );
  }
}
