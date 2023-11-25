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
      return Scaffold(
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
                                title: 'yboutique'.tr +
                                    ' ' +
                                    _bcontroller.Boutique.titre,
                                description: 'ysboutique'.tr,
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ])),
              ]),
          body: CustomScrollView(controller: _scrollController, slivers: [
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(top: kMarginY * 2), child: Text('')),
            ),
            SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.0,
                    mainAxisExtent: 140,
                    mainAxisSpacing: 0.0),
                itemCount: _bcontroller.contentBoutique.length,
                itemBuilder: (_ctx, index) => AppBoutiqueOption(
                    title: _bcontroller.contentBoutique[index],
                    index:   index,
                    onTap: () async {
                      await _bcontroller.setBoutiqueContent(index);
                    })),
          ]));
    });
  }
}
