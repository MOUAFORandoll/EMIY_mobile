import 'package:EMIY/components/Button/AppIconButton.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Widget/shoppingproduitComponent.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Button/app_button.dart';
import '../../components/Widget/EmptyShopComponent.dart';

class ShoppingViewNext extends StatelessWidget {
  ShoppingViewNext({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var functions = ViewFunctions();
    return GetBuilder<CartController>(builder: (_controller) {
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
                          // Container(
                          //     // margin: EdgeInsets.only(left: kMarginX),
                          //     child: Text(
                          //   'My Shopping Bag',
                          //   overflow: TextOverflow.ellipsis,
                          //   style: TextStyle(
                          //       fontSize: kBasics,
                          //       fontFamily: 'Lato',
                          //       color: ColorsApp.primaryText,
                          //       fontWeight: FontWeight.w700),
                          // )),
                          BigtitleText(text: 'My Shopping Bag', bolder: true),
                        ])),
              ]),
          body: CustomScrollView(controller: _scrollController, slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) => _controller.getItems.length == 0
                  ? EmptyShopComponent(type: 1)
                  : SingleChildScrollView(
                      child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _controller.getItems.length,
                      // controller: _controller,
                      itemBuilder: (_, index) => ShoppingproduitComponent(
                        cartM: _controller.getItems[index],
                      ),
                    )),
              childCount: 1,
            ))
          ]),
          bottomNavigationBar: _controller.getItems.length == 0
              ? null
              : Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.greySearch,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: kMarginX,
                    horizontal: kMarginY,
                    // top: kMdHeight / 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  // width: Get.size.width * 0.1,

                                  margin: EdgeInsets.only(
                                    bottom: 2,
                                  ),
                                  child: Text(
                                    'Nombre de produits : ${_controller.getItems.length}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: ColorsApp.black,
                                    ),
                                  )),
                              Container(
                                  width: Get.size.width * 0.65,
                                  child: Text(
                                    'Montant du panier :  ${_controller.totalPrix} XAF',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: ColorsApp.black,
                                        fontSize: 11),
                                  )),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: kMarginY),
                              child: AppButton(
                               
                                size: MainAxisSize.max,
                                bgColor: ColorsApp.skyBlue,
                                text: 'Buy',
                                onTap: () {
                                  _controller.getItems.length != 0
                                      ? Get.toNamed(AppLinks.BUYSHOP)
                                      : functions.snackBar(
                                          'Panier',
                                          'Ajouter des produits au panier',
                                          false);
                                  ;
                                },
                              ))
                        ],
                      )
                    ],
                  )));
    });
  }
}
