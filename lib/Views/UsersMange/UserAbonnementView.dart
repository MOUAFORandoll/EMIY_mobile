import 'package:EMIY/components/Text/TextBackSpace.dart';
import 'package:EMIY/components/Widget/BoutiqueCircleComponent.dart';
import 'package:EMIY/components/Widget/ShimmerBoxBoutique.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAbonnementView extends StatelessWidget {
  UserAbonnementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(
        builder: (_bcontroller) => Scaffold(
            backgroundColor: ColorsApp.bg,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                backgroundColor: ColorsApp.bg,
                automaticallyImplyLeading: false,
                title: Text(
                  'Mes Abonnements',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Lato', fontWeight: FontWeight.w600),
                ),
                leading: Container(
                    child: InkWell(
                  child: Container(
                    margin: EdgeInsets.zero,
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(

                        // borderRadius: BorderRadius.circular(20),
                        ),
                    child: Icon(Icons.arrow_back_ios_new,
                        color: ColorsApp.black, size: 25.0),
                  ),
                  onTap: () {
                    Get.back();
                  },
                )),
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) => _bcontroller.isAbUseLoad == 0
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: SingleChildScrollView(
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),

                                // Ratio largeur/hauteur pour chaque élément
                                // controller: search.controllerT,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 20.0,
                                        // childAspectRatio: 2.70,
                                        mainAxisSpacing: 10.0),
                                itemCount: 9,
                                itemBuilder: (_ctx, index) =>
                                    ShimmerBoxBoutique())))
                    : (_bcontroller.listAbonnememtUser.length != 0)
                        ? SingleChildScrollView(
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding:
                                    EdgeInsets.symmetric(horizontal: kMarginX),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5.0,
                                        childAspectRatio: 0.70,
                                        mainAxisSpacing: 10.0),
                                itemCount:
                                    _bcontroller.listAbonnememtUser.length,
                                itemBuilder: (_ctx, index) =>
                                    BoutiqueCircleComponent(
                                      boutique: _bcontroller
                                          .listAbonnememtUser[index],
                                    )))
                        : AppEmpty(title: 'Aucun Abonnement'),
                childCount: 1,
              ))
            ])));
  }
}
