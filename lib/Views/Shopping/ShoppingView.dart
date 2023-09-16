import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/shoppingproduitComponent.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
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
          body: SafeArea(
              child: CustomScrollView(controller: _scrollController, slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
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
                        margin: EdgeInsets.only(top: Get.height * .010),
                        padding: EdgeInsets.only(
                            left: Get.width * .030, right: Get.width * .030),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Container(
                              //   child: AppTitleRight(
                              //       title: 'Panier',
                              //       description: 'Votre panier',
                              //       icon: Assets.shoppingCart),
                              //   margin: EdgeInsets.only(
                              //       right: MediaQuery.of(context).size.width *
                              //           .005),
                              // ),
                              Container(
                                  // margin: EdgeInsets.only(left: kMarginX),
                                  child: Text(
                                'My Shopping Bag',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kMdText,
                                    fontFamily: 'Lato',
                                    // color: ColorsApp.white,
                                    fontWeight: FontWeight.w700),
                              )),
                              IconButtonF(
                                  icon: Icons.delete_forever,
                                  color: Colors.red,
                                  onTap: () {
                                    _controller.deleteAll();
                                  })
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
              (context, index) => _controller.getItems.length == 0
                  ? Center(
                      child: BigText(
                        text: 'Vide',
                        bolder: true,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: ColorsApp.white,
                      ),
                      child: SingleChildScrollView(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _controller.getItems.length,
                              // controller: _controller,
                              itemBuilder: (_, index) =>
                                  ShoppingproduitComponent(
                                    cartM: _controller.getItems[index],
                                  ))),
                    ),
              childCount: 1,
            ))
          ])),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: ColorsApp.greySearch,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                                : functions.snackBar('Panier',
                                    'Ajouter des produits au panier', false);
                            ;
                          },
                        ))
                  ],
                )
              ],
            ),
          ));
    });
  }
}
