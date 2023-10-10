import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/BoutiqueCircleComponent.dart';
import 'package:EMIY/components/Widget/BoutiqueComponent.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/produitForCatComponent.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/styles/theme.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/components/Widget/ShimmerBoxBoutique.dart';
import 'package:shimmer/shimmer.dart';

class BoutiqueCategoryView extends StatelessWidget {
  BoutiqueCategoryView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    //print(Get.parameters);
    Get.find<CategoryBoutiqueController>()
        .getCategoryBoutique(Get.parameters['id']);

    return Scaffold(
        body: RefreshIndicator(
            color: ColorsApp.skyBlue,
            onRefresh: () async {
              await Get.find<CategoryBoutiqueController>()
                  .getCategoryBoutique(Get.parameters['id']);
            },
            child: SafeArea(
              child: CustomScrollView(controller: _scrollController, slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  // Provide a standard title.
                  // title: Text('title'),
                  // Allows the user to reveal the app bar if they begin scrolling
                  // back up the list of items.
                  floating: true,
                  // Display a placeholder widget to visualize the shrinking size.
                  flexibleSpace: InkWell(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                            // margin: EdgeInsets.only(top: Get.height * .030),
                            padding: EdgeInsets.only(
                                left: Get.width * .030,
                                right: Get.width * .030),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppBackButton(),
                                  Container(
                                    child: AppTitleRight(
                                        title: 'Categorie',
                                        description: Get.parameters['libelle']
                                            .toString(),
                                        icon: null),
                                    margin: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .005),
                                  ),
                                ])),
                      ]),
                    ),
                  ),
                  // Make the initial height of the SliverAppBar larger than normal.
                  expandedHeight: 60,
                ),
                SliverToBoxAdapter(
                    child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: ColorsApp.grey,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffDDDDDD),
                                blurRadius: 0, // Soften the shaodw
                                spreadRadius: 0,
                                offset: Offset(-1.2, 1.8),
                              )
                            ]),
                        margin: EdgeInsets.symmetric(
                            vertical: kMarginY, horizontal: kMarginX),
                        padding: EdgeInsets.symmetric(
                            vertical: kMarginY, horizontal: kMarginX),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Text(Get.parameters['libelle']!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TexteStyle()
                                        .bprimaryBigTextStyle
                                        .apply(color: Colors.white))),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: kMarginY,
                                  ),
                                  child: Text(Get.parameters['description']!,
                                      style: TexteStyle().secondaryTextStyle),
                                )),
                              ],
                            ),
                            Container(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                    Get.parameters['nombreBoutique']! +
                                        ' Boutique(s)',
                                    overflow: TextOverflow.ellipsis,
                                    style: TexteStyle().secondaryTextStyle)),
                          ],
                        ))),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => GetBuilder<CategoryBoutiqueController>(
                      builder: (_lbcontroller) => _lbcontroller.isLoadedP == 0
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
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
                          : (_lbcontroller.ListBoutique.length != 0)
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: SingleChildScrollView(
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),

                                          // Ratio largeur/hauteur pour chaque élément
                                          // controller: search.controllerT,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 10.0,
                                                  childAspectRatio: 0.70,
                                                  mainAxisSpacing: 10.0),
                                          itemCount:
                                              _lbcontroller.ListBoutique.length,
                                          itemBuilder: (_ctx, index) =>
                                              BoutiqueCircleComponent(
                                                boutique: _lbcontroller
                                                    .ListBoutique[index],
                                              ))))
                              : AppEmpty(title: 'Aucune boutique'),
                    ),

                    // Builds 1000 ListTiles
                    childCount: 1,
                  ),
                )
              ]),
            )));
  }
}
