import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
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
          body: CustomScrollView(controller: _scrollController, slivers: [
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
                        margin: EdgeInsets.only(top: Get.height * .020),
                        padding: EdgeInsets.only(
                            left: Get.width * .030, right: Get.width * .030),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigtitleText(text: 'Panier', bolder: true),
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
                  : SingleChildScrollView(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _controller.getItems.length,
                          // controller: _controller,
                          itemBuilder: (_, index) => ShoppingproductComponent(
                                cartM: _controller.getItems[index],
                              ))),
              childCount: 1,
            ))
          ]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              gradient: GradientApp.blueG,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            padding: EdgeInsets.only(
                left: kMdWidth / 8,
                right: kMdWidth / 8,
                // top: kMdHeight / 20,
                bottom: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    // width: Get.size.width * 0.1,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                      bottom: 2,
                      top: kMdHeight / 20,
                    ),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Nombre de produits : ',
                            style: TextStyle(
                                fontFamily: 'orkney',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${_controller.getItems.length}',
                            style: TextStyle(
                                fontFamily: 'orkney',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                Container(
                    // width: Get.size.width * 0.1,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 2),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Montant du panier :',
                            style: TextStyle(
                                fontFamily: 'orkney',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${_controller.totalPrix} XAF',
                            style: TextStyle(
                                fontFamily: 'orkney',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                // Container(
                //     // width: Get.size.width * 0.1,
                //     alignment: Alignment.center,
                //     padding: EdgeInsets.all(10),
                //     margin: EdgeInsets.only(bottom: 2),
                //     decoration: new BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Colors.white,
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Container(
                //           child: Text(
                //             'Frais de livraison :',
                //             style: TextStyle(
                //                 fontFamily: 'orkney',
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //         Container(
                //           child: Text(
                //             '1000 XAF',
                //             style: TextStyle(
                //                 fontFamily: 'orkney',
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ],
                //     )),
                Container(
                    // width: Get.size.width * 0.1,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 2),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Total ',
                            style: TextStyle(
                                fontFamily: 'orkney',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            ' ${_controller.totalPrix} XAF',
                            style: TextStyle(
                                fontFamily: 'orkney',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBtn(
                      color: ColorsApp.greenLight,
                      title: 'Buy',
                      onTap: () {

                        _controller.getItems.length != 0
                            ? Get.toNamed(AppLinks.BUYSHOP)
                            : functions.snackBar(
                                'Panier',
                                'Ajouter des produits au panier',
                                false);
                        ;
                      },
                    )
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
