import 'package:fahkapmobile/components/Button/AppIconButton.dart';
import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Widget/shoppingproductComponent.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingView extends StatelessWidget {
  ShoppingView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var functions = ViewFunctions();
    return GetBuilder<CartController>(builder: (_controller) {
      return Scaffold(
        body: _controller.getItems.length == 0
            ? Center(
                child: BigText(
                  text: 'Vide',
                  bolder: true,
                ),
              )
            : CustomScrollView(controller: _scrollController, slivers: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BigtitleText(text: 'Panier', bolder: true),
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

                  // expandedHeight: 300,
                  // pinned: true,
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) => ShoppingproductComponent(
                    cartM: _controller.getItems[index],
                  ),
                  childCount: _controller.getItems.length,
                ))
              ]),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(color: ColorsApp.grey),
              padding: EdgeInsets.only(
                  left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: Get.size.width * 0.1,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    // margin: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Text(
                      '${_controller.totalPrix} XAF',
                      style: TextStyle(
                          fontFamily: 'orkney',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomBtn(
                    color: ColorsApp.greenLight,
                    title: 'Buy',
                    onTap: () {
                      _controller.getItems.length != 0
                          ? Get.toNamed(AppLinks.BUYSHOP)
                          : functions.snackBar(
                              'Panier',
                              'Ajouter des produits au panier',
                              ColorsApp.skyBlue);
                      ;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
