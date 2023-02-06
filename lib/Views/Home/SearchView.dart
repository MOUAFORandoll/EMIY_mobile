import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Form/text_field.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/BoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/components/Widget/productComponentAll.dart';
import 'package:fahkapmobile/controller/categoryBoutiqueController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    // Get.find<ProductController>().getPopularProduit();
    //  Get.find<CategoryController>().getCategory();
    return GetBuilder<ProductController>(builder: (prods) {
      return CustomScrollView(controller: _scrollController, slivers: [
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // Provide a standard title.
          // title: Text('title'),
          // Allows the user to reveal the app bar if they begin scrolling
          // back up the list of items.
          //   floating: true,
          // Display a placeholder widget to visualize the shrinking size.
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: kMarginX),
            padding: EdgeInsets.only(
                left: Get.width * .030, right: Get.width * .030),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KTextField(
                      controllerField: controllerField,
                      onChange: prods.searchProduit),
                  InkWell(
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                      onTap: () {
                        Get.back();
                        controllerField.text = '';
                        // prods.searchProButtom();
                      })
                ]),

            /*   onTap: () => filterDest() */
          ),
          // Make the initial height of the SliverAppBar larger than normal.
          expandedHeight: 60,
        ),

        SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => GetBuilder<CategoryBoutiqueController>(
                        builder: (categorys) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: kMarginX),
                        child: SingleChildScrollView(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: kMarginX),
                                    child: titleText(
                                      text: 'Result',
                                    )),
                                //   Container(
                                //       margin: EdgeInsets.only(
                                //           top: Get.height * .005,
                                //           left: Get.width * .008),
                                //       child: Icon(
                                //         Icons
                                //             .arrow_forward_ios_outlined,
                                //         // color: Colors.white,
                                //       )),
                              ],
                            ),
                            SizedBox(
                                height: kMdHeight,
                                child: Stack(
                                  children: [
                                    GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 50.0),
                                        itemCount: prods.produitList.length,
                                        itemBuilder: (_ctx, index) =>
                                            ProductComponentAll(
                                                produit:
                                                    prods.produitList[index],
                                                index: index)),
                                  ],
                                )),
                          ],
                        )),
                      );
                    }),
                childCount: 1))
      ]);
    });
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fahkapmobile/components/Button/btnCatList.dart';
// import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
// import 'package:fahkapmobile/components/Button/button.dart';
// import 'package:fahkapmobile/components/Form/formComponent2.dart';
// import 'package:fahkapmobile/components/Form/text_field.dart';
// import 'package:fahkapmobile/components/Text/bigText.dart';
// import 'package:fahkapmobile/components/Text/bigtitleText.dart';
// import 'package:fahkapmobile/components/Widget/BoutiqueComponent.dart';
// import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
// import 'package:fahkapmobile/components/Widget/productComponent.dart';
// import 'package:fahkapmobile/components/Text/smallText.dart';
// import 'package:fahkapmobile/components/Text/titleText.dart';
// import 'package:fahkapmobile/components/Widget/productComponentAll.dart';
// import 'package:fahkapmobile/controller/categoryBoutiqueController.dart';
// import 'package:fahkapmobile/controller/categoryController.dart';
// import 'package:fahkapmobile/controller/productController.dart';
// import 'package:fahkapmobile/styles/colorApp.dart';
// import 'package:fahkapmobile/styles/textStyle.dart';
// import 'package:fahkapmobile/utils/Services/routing.dart';
// import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

// class SearchView extends StatelessWidget {
//   SearchView({Key? key}) : super(key: key);
//   ScrollController _scrollController = new ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController controllerField = TextEditingController();

//     // Get.find<ProductController>().getPopularProduit();
//     //  Get.find<CategoryController>().getCategory();
//     return GetBuilder<ProductController>(builder: (prods) {
//       return Scaffold(
//           //   appBar: AppBar(
//           //     backgroundColor: Colors.transparent,
//           //     elevation: 0,
//           //     title: Row(children: [
//           //       KTextField(
//           //           controllerField: controllerField,
//           //           onChange: prods.searchProduit),
//           //       InkWell(
//           //           child: Container(
//           //               child: Icon(
//           //             Icons.close,
//           //             color: Colors.red,
//           //           )),
//           //           onTap: () {
//           //             Get.back();
//           //             controllerField.text = '';
//           //             // prods.searchProButtom();
//           //           })
//           //     ]),
//           //   ),
//           body: GetBuilder<CategoryBoutiqueController>(builder: (categorys) {
//         return Container(
//             margin: EdgeInsets.symmetric(horizontal: kMarginX),
//             child: Stack(children: [
//               Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   margin: EdgeInsets.symmetric(vertical: kMarginX),
//                   child: Row(children: [
//                     KTextField(
//                         controllerField: controllerField,
//                         onChange: prods.searchProduit),
//                     InkWell(
//                         child: Container(
//                             child: Icon(
//                           Icons.close,
//                           color: Colors.red,
//                         )),
//                         onTap: () {
//                           Get.back();
//                           controllerField.text = '';
//                           // prods.searchProButtom();
//                         })
//                   ])),
//               SingleChildScrollView(
//                   child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                           margin: EdgeInsets.symmetric(vertical: kMarginX),
//                           child: titleText(
//                             text: 'Result',
//                           )),
//                       //   Container(
//                       //       margin: EdgeInsets.only(
//                       //           top: Get.height * .005,
//                       //           left: Get.width * .008),
//                       //       child: Icon(
//                       //         Icons
//                       //             .arrow_forward_ios_outlined,
//                       //         // color: Colors.white,
//                       //       )),
//                     ],
//                   ),
//                   SizedBox(
//                       height: kMdHeight,
//                       child: Stack(
//                         children: [
//                           GridView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       crossAxisSpacing: 10.0,
//                                       mainAxisSpacing: 50.0),
//                               itemCount: prods.produitList.length,
//                               itemBuilder: (_ctx, index) => ProductComponentAll(
//                                   produit: prods.produitList[index],
//                                   index: index)),
//                         ],
//                       )),
//                 ],
//               )),
//             ]));
//       }));
//     });
//   }
// }
