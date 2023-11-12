import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent2.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatelessWidget {
  CategoryView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryBoutiqueController>(builder: (categorys) {
      return RefreshIndicator(
          color: ColorsApp.skyBlue,
          onRefresh: () async {
            //print('****debut');
            await Get.find<CategoryBoutiqueController>().getCategory();
            //print('****mid');

            //print('****fin');
          },
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMarginX),
              child: CustomScrollView(controller: _scrollController, slivers: [
                SliverAppBar(
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
                            margin: EdgeInsets.only(top: Get.height * .030),
                            padding: EdgeInsets.only(
                                left: Get.width * .030,
                                right: Get.width * .030),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigtitleText(text: 'Category', bolder: true),
                                  // Container(
                                  //   child: AppTitleRight(
                                  //       title: 'Category',
                                  //       description: 'liste des categories',
                                  //       icon: null),
                                  //   margin: EdgeInsets.only(
                                  //       right:
                                  //           MediaQuery.of(context).size.width *
                                  //               .005),
                                  // ),
                                  // Container(
                                  //     child: InkWell(
                                  //         child: Icon(Icons.search),
                                  //         onTap: () => Scaffold.of(context).openDrawer())
                                  //     // padding: EdgeInsets.only(right: 10),
                                  //     ),
                                ])),
                      ]),
                    ),
                    /*   onTap: () => filterDest() */
                  ),
                  // Make the initial height of the SliverAppBar larger than normal.
                  expandedHeight: 60,
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => categorys.isLoadedCat == 0
                      ? AppLoading()
                      : Container(
                          child: Column(
                            children: [
                              InkWell(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ColorsApp.greySecond,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          vertical: kMarginY * 3),
                                      height: kToolbarHeight / 1.7,
                                      // width: kWidth * .75,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Rechercher",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: kBasics,
                                            ),
                                          )),
                                          InkWell(
                                              child: Icon(
                                                Icons.search,
                                                color: Colors.blue,
                                              ),
                                              onTap: () {}),
                                        ],
                                      )),
                                  onTap: () {
                                    // Get.toNamed(AppLinks.SEARCH);
                                  }),
                              SingleChildScrollView(
                                  child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 20.0,
                                              childAspectRatio: 0.8,
                                              mainAxisSpacing: 20.0),
                                      itemCount: categorys.categoryList.length,
                                      itemBuilder: (_ctx, index) =>
                                          CategoryComponent2(
                                            category:
                                                categorys.categoryList[index],
                                          ))),
                            ],
                          ),
                        ),

                  childCount: 1,
                ))
              ])));
    });
  }
}
