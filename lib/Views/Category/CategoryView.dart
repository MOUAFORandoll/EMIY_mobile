import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent2.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatelessWidget {
  CategoryView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (categorys) {
      return CustomScrollView(controller: _scrollController, slivers: [
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
                        left: Get.width * .030, right: Get.width * .030),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigtitleText(text: 'Category', bolder: true),
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
          (context, index) => categorys.isLoaded == 0
              ? Shimmer.fromColors(
                  baseColor: Colors.blueGrey,
                  highlightColor: Colors.greenAccent,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: kMarginX),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (_ctx, index) => Container(
                              height: kSmHeight * 2,
                              width: kSmWidth,
                              padding: EdgeInsets.all(kMarginX),
                              margin: EdgeInsets.symmetric(
                                  vertical: kMarginY, horizontal: kMarginX),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        // margin: EdgeInsets.only(
                                        //     top: Get.height * .005, left: Get.width * .008),
                                        child: Icon(
                                          Icons.no_backpack,
                                          color: Colors.white,
                                        )),
                                    Container(
                                      width: kSmWidth * .6,
                                      alignment: Alignment.center,
                                      // margin: EdgeInsets.only(
                                      //     top: Get.height * .005, left: Get.width * .008),
                                      child: Text('',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                    ),
                                  ])))))
              : CategoryComponent2(
                  category: categorys.categoryList[index],
                ),

          childCount: categorys.categoryList.length,
        ))
      ]);
    });
  }
}
