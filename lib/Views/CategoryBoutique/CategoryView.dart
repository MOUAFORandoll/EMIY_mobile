import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/categoryComponent2.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/controller/categoryBoutiqueController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatelessWidget {
  CategoryView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryBoutiqueController>(builder: (categorys) {
      return Scaffold(
          body: RefreshIndicator(
              color: ColorsApp.skyBlue,
              onRefresh: () async {
                //print('****debut');
                await Get.find<CategoryBoutiqueController>().getCategory();
                //print('****mid');

                //print('****fin');
              },
              child: CustomScrollView(controller: _scrollController, slivers: [
                // Add the app bar to the CustomScrollView.
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // BigtitleText(text: 'Category', bolder: true),
                                  Container(
                                    child: AppTitleRight(
                                        title: 'Category',
                                        description: 'liste des categories',
                                        icon: null),
                                    margin: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .005),
                                  ),
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
                // SliverList(
                //         // Use a delegate to build items as they're scrolled on screen.
                //         delegate: SliverChildBuilderDelegate(
                //   // The builder function returns a ListTile with a title that
                //   // displays the index of the current item.
                //   (context, index) =>

                SliverList(

                    // Use a delegate to build items as they're scrolled on screen.
                    delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => categorys.isLoadedCat == 0
                      ? AppLoading()
                      : SingleChildScrollView(
                          child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding:
                                  EdgeInsets.symmetric(horizontal: kMarginX),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20.0,
                                      childAspectRatio: 0.8,
                                      mainAxisSpacing: 20.0),
                              itemCount: categorys.categoryList.length,
                              itemBuilder: (_ctx, index) => CategoryComponent2(
                                    category: categorys.categoryList[index],
                                  ))),

                  childCount: 1,
                ))
              ])));
    });
  }
}
