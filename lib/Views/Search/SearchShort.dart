import 'package:EMIY/components/Form/home_search_field.dart';
import 'package:EMIY/components/Form/search_field.dart';
import 'package:EMIY/components/Widget/BoutiqueComponentHomeN.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/icon_svg.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/produitComponentAll.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/Button/app_button.dart';

class SearchShort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
        builder: (generalController) =>
            GetBuilder<ProduitController>(builder: (prods) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      prods.isLoadedSupp == 0
                          ? ShimmerProduit()
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
// controller: search.controllerT,

                              // Ratio largeur/hauteur pour chaque élément
                              // controller: prods.controllerT,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: kMarginX / 13,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: prods.produitSupplementaire.length,
                              itemBuilder: (_ctx, index) => ProduitComponentAll(
                                  produit: prods.produitSupplementaire[index],
                                  index: index,
                                  type: 'supplementaire')),
                      prods.loaddata == true
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: CircularProgressIndicator())
                          : Container()
                    ],
                  ),
                ),
              );
            }));
  }
}
