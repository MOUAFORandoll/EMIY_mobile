import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/components/Widget/productForCatComponent.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductCategoryView extends StatelessWidget {
  ProductCategoryView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    print(Get.parameters);

    Get.find<ProductController>().getCategoryProduit(Get.parameters['id']);
    return Scaffold(
      body: CustomScrollView(controller: _scrollController, slivers: [
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorsApp.bleuLight,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButtonF(
                  icon: Icons.close,
                  color: ColorsApp.black,
                  onTap: () {
                    Get.back();
                  },
                ),
                BigtitleText(
                    text: Get.parameters['libelle'].toString(), bolder: true),
              ],
            )),

        SliverList(
          // Use a delegate to build items as they're scrolled on screen.
          delegate: SliverChildBuilderDelegate(
            // The builder function returns a ListTile with a title that
            // displays the index of the current item.
            (context, index) => GetBuilder<ProductController>(
                builder: (_category) => _category.isLoadedPC == 0
                    ? Shimmer.fromColors(
                        baseColor: Colors.blueGrey,
                        highlightColor: Colors.greenAccent,
                        child: SizedBox(
                          height: kMdHeight,
                          child: Stack(
                            children: [
                              GridView.builder(
                                padding: const EdgeInsets.all(20),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20.0,
                                        mainAxisSpacing: 50.0),
                                itemCount: 10,
                                itemBuilder: (_ctx, index) => Container(
                                  height: kMdHeight * 2,
                                  width: kMdWidth * 1.1,
                                  margin: EdgeInsets.only(right: kMarginX),
                                  decoration: BoxDecoration(
                                      color: ColorsApp.greySecond,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: kMdHeight * .115,
                                            width: Get.width * .5,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image:
                                                  AssetImage('assets/logo.png'),
                                            ))),
                                        Container(
                                          width: kSmWidth * .6,
                                          margin: EdgeInsets.only(
                                              top: Get.height * .005,
                                              left: Get.width * .008),
                                          child: Text('produit.titre',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: ColorsApp.black,
                                                  fontSize: 12)),
                                        ),
                                        // Container(
                                        //   width: kSmWidth * .6,
                                        //   margin: EdgeInsets.only(
                                        //       top: Get.height * .005,
                                        //       left: Get.width * .008),
                                        //   child: Text('XAF ' + '1000',
                                        //       overflow: TextOverflow.ellipsis,
                                        //       style: TextStyle(
                                        //           color: Colors.red,
                                        //           fontSize: 12,
                                        //           fontWeight: FontWeight.bold)),
                                        // ),
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ))
                    : _category.isLoadedPC == 1
                        ? (_category.produitcategoryList.length != 0)
                            ? SizedBox(
                                height: kMdHeight,
                                child: Stack(
                                  children: [
                                    GridView.builder(
                                        padding: const EdgeInsets.all(20),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20.0,
                                                mainAxisSpacing: 70.0),
                                        itemCount: _category
                                            .produitcategoryList.length,
                                        itemBuilder: (_ctx, index) =>
                                            ProductForCatComponent(
                                                produit: _category
                                                    .produitcategoryList[index],
                                                index: index))
                                  ],
                                ),
                              )
                            : Container(
                                height: kMdHeight * .6,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text('Aucun Produit'),
                                ))
                        : Container(
                            height: kMdHeight * .6,
                            alignment: Alignment.center,
                            child: Center(
                              child: Text('Error'),
                            ))),

            // Builds 1000 ListTiles
            childCount: 1,
          ),
        )
      ]),
    );
  }
}
