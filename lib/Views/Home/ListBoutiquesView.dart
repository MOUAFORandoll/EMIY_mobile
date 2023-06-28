import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText0.dart';
import 'package:EMIY/components/Widget/BoutiqueComponent.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/productComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/productForCatComponent.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/productController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ListBoutiquesView extends StatelessWidget {
  ListBoutiquesView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    //print(Get.parameters);
    // Get.find<CategoryBoutiqueController>().getListBoutiques();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorsApp.black,
            ),
            onTap: () {
              Get.back();
            },
          ),
          title: BigtitleText0(text: 'Liste des boutiques', bolder: true),
        ),
        body: RefreshIndicator(
          color: ColorsApp.skyBlue,
          onRefresh: () async {
            await Get.find<CategoryBoutiqueController>().getListBoutiques();
            ;
          },
          child: CustomScrollView(controller: _scrollController, slivers: [
            // SliverAppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   // Provide a standard title.
            //   // title: Text('title'),
            //   // Allows the user to reveal the app bar if they begin scrolling
            //   // back up the list of items.
            //   floating: true,
            //   // Display a placeholder widget to visualize the shrinking size.
            //   flexibleSpace: InkWell(
            //     child: SingleChildScrollView(
            //       child: Column(children: [
            //         Container(
            //             margin: EdgeInsets.only(top: Get.height * .030),
            //             padding: EdgeInsets.only(
            //                 left: Get.width * .030, right: Get.width * .030),
            //             child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   BigtitleText0(text: 'Les Boutiques', bolder: true),
            //                   // Container(
            //                   //     child: InkWell(
            //                   //         child: Icon(Icons.search),
            //                   //         onTap: () => Scaffold.of(context).openDrawer())
            //                   //     // padding: EdgeInsets.only(right: 10),
            //                   //     ),
            //                 ])),
            //       ]),
            //     ),
            //     /*   onTap: () => filterDest() */
            //   ),
            //   // Make the initial height of the SliverAppBar larger than normal.
            //   expandedHeight: 60,
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => GetBuilder<CategoryBoutiqueController>(
                  builder: (_lbcontroller) => _lbcontroller.gA == 0
                      ? AppLoading()
                      : (_lbcontroller.ListBoutiqueF.length != 0)
                          ? SingleChildScrollView(
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(5),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0),
                                  itemCount: _lbcontroller.ListBoutiqueF.length,
                                  itemBuilder: (_ctx, index) =>
                                      BoutiqueComponent(
                                        boutique:
                                            _lbcontroller.ListBoutiqueF[index],
                                      )))
                          : AppEmpty(title: 'Aucune boutique'),
                ),

                // Builds 1000 ListTiles
                childCount: 1,
              ),
            )
          ]),
        ));
  }
}
