import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText0.dart';
import 'package:Fahkap/components/Widget/BoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/app_empty.dart';
import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/components/Widget/productComponentAll.dart';
import 'package:Fahkap/components/Widget/productForCatComponent.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/controller/categoryBoutiqueController.dart';
import 'package:Fahkap/controller/productController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ListProduitsView extends StatelessWidget {
  ListProduitsView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    print(Get.parameters);
    Get.find<ProductController>().getProduitAll();

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
          title: BigtitleText0(text: 'Liste des produits', bolder: true),
        ),
        body: GetBuilder<ProductController>(builder: (prods) {
          return RefreshIndicator(
            color: ColorsApp.skyBlue,
            onRefresh: () async {
              await Get.find<ProductController>().getProduitAll();
              ;
            },
            child: prods.isLoadedPAll == 0
                ? AppLoading()
                : (prods.produitListAll.length != 0)
                    ? StaggeredGridView.countBuilder(
                        physics: ScrollPhysics(),
                        crossAxisCount: 4,
                        itemCount: prods.produitListAll.length,
                        itemBuilder: (_ctx, index) => ProductComponentAll(
                            type: 1,
                            produit: prods.produitListAll[index],
                            index: index),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(2, index.isEven ? 3 : 2),
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 4.0,

                        //   GridView.builder(
                        //       physics:
                        //           NeverScrollableScrollPhysics(),
                        //       gridDelegate:
                        //           const SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisCount: 2,
                        //               crossAxisSpacing:
                        //                   10.0,
                        //               mainAxisSpacing:
                        //                   50.0),
                        //       itemCount:
                        //           prods.produitList.length,
                        //       itemBuilder: (_ctx, index) =>
                        //           ProductComponentAll(
                        //               produit:
                        //                   prods.produitList[
                        //                       index],
                        //               index: index)),
                      )
                    : Container(
                        height: kHeight,
                        child: AppEmpty(title: 'Aucun Produit')),

            // Builds 1000 ListTiles
          );
        }));
  }
}
