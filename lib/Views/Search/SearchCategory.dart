import 'package:EMIY/components/Form/home_search_field.dart';
import 'package:EMIY/components/Form/search_field.dart';
import 'package:EMIY/components/Widget/BoutiqueComponentHomeN.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/categoryComponentSearch.dart';
import 'package:EMIY/components/Widget/icon_svg.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/searchController.dart';
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

class SearchCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(builder: (search) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child:
              /*  search.isLoadedSupp == 0
                          ? ShimmerProduit()
                          : */
              ListView.builder(
            controller: search.controllerT,
            itemCount: search.categoryList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_ctx, index) => CategoryComponentSearch(
              category: search.categoryList[index],
            ),
          ));
      /*   search.loaddata == true
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: CircularProgressIndicator())
                          : Container() */
    });
  }
}/* 
   Container(
                                          height: kSmHeight * 1.3,
                                          margin: EdgeInsets.symmetric(
                                              vertical: kMarginY),
                                          child: ListView.builder(
                                            itemCount:
                                                categorys.categoryList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (_ctx, index) =>
                                                CategoryComponent(
                                              category:
                                                  categorys.categoryList[index],
                                            ),
                                          ),
                                        ), */