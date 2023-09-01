import 'dart:io';

import 'package:EMIY/components/Widget/MyBoutiqueComponent.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_boutique_options.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Widget/app_title_right.dart';

class MesBoutiquesView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(builder: (_bcontroller) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          // margin: EdgeInsets.only(top: kMarginY),
          // height: kHeight / 2.2,
          // constraints: BoxConstraints(maxHeight: kHeight / 2),
          // decoration: BoxDecoration(
          //     color: AppColors.red, borderRadius: BorderRadius.circular(20)),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 8.0,
              //   childAspectRatio: 1.1,
              //   mainAxisSpacing: 15.0,
              // ),
              itemCount: _bcontroller.listBoutiques.length,
              itemBuilder: (_ctx, index) => InkWell(
                    child: MyBoutiqueComponent(
                      boutique: _bcontroller.listBoutiques[index],
                    ),
                    onTap: () => _bcontroller
                        .selectBoutique(_bcontroller.listBoutiques[index]),
                  )));
      ;
    });
  }
}
