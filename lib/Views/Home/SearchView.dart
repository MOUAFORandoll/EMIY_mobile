import 'package:Fahkap/components/Form/search_field.dart';
import 'package:Fahkap/components/Widget/BoutiqueComponentHome.dart';
import 'package:Fahkap/components/Widget/categoryComponent2.dart';
import 'package:Fahkap/components/Widget/seacrhIngCompo.dart';
import 'package:Fahkap/controller/searchController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/BoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/components/Widget/productComponentAll.dart';
import 'package:Fahkap/controller/categoryBoutiqueController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/controller/productController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    // Get.find<ProductController>().getPopularProduit();
    //  Get.find<CategoryController>().getCategory();
    return GetBuilder<SearchController>(builder: (searchCont) {
      return CustomScrollView(controller: _scrollController, slivers: [
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
          pinned: true,
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
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KSearchField(
                        controllerField: searchCont.controllerField,
                        prefix: null,
                        /* onChange: searchCont.searchProduit */
                      ),
                      InkWell(
                          child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.search,
                                color: Colors.blue,
                              )),
                          onTap: () {
                            Get.back();
                            // Créez une référence au noeud de focus actif
                          

                            searchCont.searchForCont();
                          })
                    ]),
                // !searchCont.searchPro
                //     ? Column(children: [
                //         SeacrhIngCompo(
                //           title: 'Produit',
                //           onTap: () {
                //             searchCont.searchType(0);
                //           },
                //         ),
                //         SeacrhIngCompo(
                //           title: 'Boutique',
                //           onTap: () {
                //             searchCont.searchType(1);
                //           },
                //         ),
                //         SeacrhIngCompo(
                //           title: 'Category',
                //           onTap: () {
                //             searchCont.searchType(2);
                //           },
                //         ),
                //       ])
                //     : Container()
              ])

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
                (context, index) => SingleChildScrollView(
                      child: searchCont.searchPro
                          ? Container(
                              width: 15,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              // decoration: new BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: ColorsApp.blue),
                              child: SpinKitCircle(
                                color: Colors.blue,
                                size: 40,
                              ),
                            )
                          : GridView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0),
                              itemCount: searchCont.listResultSeaarch.length,
                              itemBuilder: (_ctx, index) =>
                                  searchCont.tsearch == 0
                                      ? ProductComponentAll(
                                          produit: searchCont
                                              .listResultSeaarch[index],
                                          index: index,
                                          type: 'search')
                                      : searchCont.tsearch == 1
                                          ? BoutiqueComponent(
                                              boutique: searchCont
                                                  .listResultSeaarch[index],
                                            )
                                          : CategoryComponent2(
                                              category: searchCont
                                                  .listResultSeaarch[index],
                                            )),
                    ),
                /*  ],
                                  ) */

                childCount: 1))
      ]);
    });
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:Fahkap/components/Button/btnCatList.dart';
// import 'package:Fahkap/components/Button/btnCatListPV.dart';
// import 'package:Fahkap/components/Button/button.dart';
// import 'package:Fahkap/components/Form/formComponent2.dart';
// import 'package:Fahkap/components/Form/text_field.dart';
// import 'package:Fahkap/components/Text/bigText.dart';
// import 'package:Fahkap/components/Text/bigtitleText.dart';
// import 'package:Fahkap/components/Widget/BoutiqueComponent.dart';
// import 'package:Fahkap/components/Widget/categoryComponent.dart';
// import 'package:Fahkap/components/Widget/productComponent.dart';
// import 'package:Fahkap/components/Text/smallText.dart';
// import 'package:Fahkap/components/Text/titleText.dart';
// import 'package:Fahkap/components/Widget/productComponentAll.dart';
// import 'package:Fahkap/controller/categoryBoutiqueController.dart';
// import 'package:Fahkap/controller/categoryController.dart';
// import 'package:Fahkap/controller/productController.dart';
// import 'package:Fahkap/styles/colorApp.dart';
// import 'package:Fahkap/styles/textStyle.dart';
// import 'package:Fahkap/utils/Services/routing.dart';
// import 'package:Fahkap/utils/functions/viewFunctions.dart';
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
