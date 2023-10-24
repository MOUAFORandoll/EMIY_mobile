import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText0.dart';
import 'package:EMIY/components/Widget/BoutiqueComponent.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/produitComponentAll.dart';
import 'package:EMIY/components/Widget/produitForCatComponent.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ListProduitsView extends StatelessWidget {
  ListProduitsView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
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
        body: GetBuilder<ProduitController>(builder: (prods) {
          return RefreshIndicator(
            color: ColorsApp.skyBlue,
            onRefresh: () async {
              //  prods .getListProduitBuyHomeSelect(homeComponentModel.type);
            },
            child: prods.isLoadedFromHome == 0
                ? ShimmerProduit()
                : SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: kMarginX / 12,
                      mainAxisSpacing: 10.0,
                    ),
                    // itemCount: prods.produitList.length,
                    // itemBuilder: (_ctx, index) =>
                    //     ProduitComponentAll(
                    //       key: ValueKey<int>(prods
                    //           .produitList[index].id),
                    //       produit:
                    //           prods.produitList[index],
                    //       index: index,
                    //     )),
                    // gridDelegate:
                    //     SliverGridDelegateWithMaxCrossAxisExtent(
                    //   maxCrossAxisExtent:
                    //       200.0, // Largeur maximale de chaque cellule
                    //   mainAxisSpacing:
                    //       10.0, // Espace vertical entre les cellules
                    //   crossAxisSpacing:
                    //       10.0, // Espace horizontal entre les cellules
                    //   childAspectRatio:
                    //       1.0, // Ratio largeur/hauteur des cellules
                    // ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => ProduitComponentAll(
                        key: ValueKey<int>(prods.produitListFromHome[index].id),
                        produit: prods.produitListFromHome[index],
                        index: index,
                      ),

                      childCount: prods.produitListFromHome
                          .length, // Nombre total de cellules dans la grille
                    ),
                  ),

            // Builds 1000 ListTiles
          );
        }));
  }
}
