import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/app_back_button.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Button/app_button.dart';

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
                          Container(
                            child: AppTitleRight(
                                title: 'Panier',
                                description: 'Votre panier',
                                icon: Assets.shoppingCart),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ])),
              ]),
          body: CustomScrollView(controller: _scrollController, slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) => _controller.getItems.length == 0
                  ? Center(
                      child: BigText(
                        text: 'Vide',
                        bolder: true,
                      ),
                    )
                  : SingleChildScrollView(
                      child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _controller.getItems.length,
                      // controller: _controller,
                      itemBuilder: (_, index) => ShoppingproductComponent(
                        cartM: _controller.getItems[index],
                      ),
                    )),
              childCount: 1,
            ))
          ]),
          bottomNavigationBar: Container(
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
                                  fontFamily: 'orkney',
                                  fontSize: 11,
                                  color: Colors.black,
                                ),
                              )),
                          Container(
                              width: Get.size.width * 0.65,
                              child: Text(
                                'Montant du panier :  ${_controller.totalPrix} XAF',
                                style: TextStyle(
                                    fontFamily: 'orkney',
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
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
                                  : functions.snackBar('Panier',
                                      'Ajouter des produits au panier', false);
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
