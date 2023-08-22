import 'dart:io';

import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_boutique_options.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Widget/app_title_right.dart';

class BoutiqueUserView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(builder: (_bcontroller) {
      return /* Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: AppBackButton(),
              actions: [
                Container(
                    margin: EdgeInsets.only(top: Get.height * .020),
                    padding: EdgeInsets.only(
                        left: Get.width * .030, right: Get.width * .030),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: AppTitleRight(
                                title: 'yboutique'.tr,
                                description: 'ysboutique'.tr,
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ])),
              ]),
          body:  */
          CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          leading: Container(),
          elevation: 0,
          // Provide a standard title.
          // title: Text('title'),
          // Allows the user to reveal the app bar if they begin scrolling
          // back up the list of items.
          floating: true,
          // Display a placeholder widget to visualize the shrinking size.
          flexibleSpace: Container(
              margin: EdgeInsets.only(left: 0),
              padding: EdgeInsets.only(
                  left: Get.width * .030, right: Get.width * .030),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: kSmHeight / 1.2,
                      margin: EdgeInsets.symmetric(vertical: kMarginY),
                      child: ListView.builder(
                          itemCount: _bcontroller.contentBoutique.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_ctx, index) => AppBoutiqueOption(
                              title: _bcontroller.contentBoutique[index],
                              select: _bcontroller.i == index,
                              onTap: () async {
                                // if (index == 0) {
                                //   await _bcontroller.getListProduitForBoutique();
                                // }
                                await _bcontroller.setBoutiqueContent(index);
                              })),
                    ),
                  ],
                ),
              )

              /*   onTap: () => filterDest() */
              ),
          // Make the initial height of the SliverAppBar larger than normal.
          expandedHeight: 60,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => _bcontroller.boutiqueContent(),
          childCount: 1,
        ))
      ]);
    });
  }
}
