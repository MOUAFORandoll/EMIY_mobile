import 'package:EMIY/Views/Search/SearchBoutique.dart';
import 'package:EMIY/Views/Search/SearchCategory.dart';
import 'package:EMIY/Views/Search/SearchProduit.dart';
import 'package:EMIY/Views/Search/SearchShort.dart';
import 'package:EMIY/components/Form/search_field.dart';
import 'package:EMIY/components/Widget/BoutiqueComponentHome.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/categoryComponent2.dart';
import 'package:EMIY/components/Widget/seacrhIngCompo.dart';
import 'package:EMIY/controller/MySearchController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/BoutiqueComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/produitComponentAll.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SearchView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(builder: (searchCont) {
      return DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: null,
                automaticallyImplyLeading: false,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blue,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                      KSearchField(),
                      InkWell(
                          child: Icon(
                            Icons.search,
                            color: ColorsApp.secondBlue,
                          ),
                          onTap: () {
                            searchCont.clearSearch();
                            searchCont.searchForCont();
                          }),
                    ]),
              ),
              body: searchCont.controllerField.text.isEmpty ||
                      searchCont.search == 0 ||
                      searchCont.search == 3
                  ? Container()
                  : searchCont.search == 1 && searchCont.search != 2
                      ? ShimmerProduit()
                      : NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return [
                              SliverPersistentHeader(
                                delegate: _SliverAppBarDelegate(
                                  TabBar(
                                    controller:
                                        DefaultTabController.of(context),
                                    onTap: (index) => searchCont.setType(index),
                                    tabs: [
                                      Tab(text: 'Produits'),
                                      Tab(text: 'Boutiques'),
                                      Tab(text: 'Categories'),
                                      Tab(text: 'Short'),
                                    ],
                                  ),
                                ),
                                pinned: true,
                              ),
                            ];
                          },
                          body: TabBarView(
                            children: [
                              // Contents of Tab 1
                              SearchProduit(),
                              SearchBoutique(),
                              SearchCategory(),
                              SearchShort(),
                            ],
                          ),
                        )));
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:EMIY/components/Button/btnCatList.dart';
// import 'package:EMIY/components/Button/btnCatListPV.dart';
// import 'package:EMIY/components/Button/button.dart';
// import 'package:EMIY/components/Form/formComponent2.dart';
// import 'package:EMIY/components/Form/text_field.dart';
// import 'package:EMIY/components/Text/bigText.dart';
// import 'package:EMIY/components/Text/bigtitleText.dart';
// import 'package:EMIY/components/Widget/BoutiqueComponent.dart';
// import 'package:EMIY/components/Widget/categoryComponent.dart';
// import 'package:EMIY/components/Widget/produitComponent.dart';
// import 'package:EMIY/components/Text/smallText.dart';
// import 'package:EMIY/components/Text/titleText.dart';
// import 'package:EMIY/components/Widget/produitComponentAll.dart';
// import 'package:EMIY/controller/categoryBoutiqueController.dart';
// import 'package:EMIY/controller/categoryController.dart';
// import 'package:EMIY/controller/produitController.dart';
// import 'package:EMIY/styles/colorApp.dart';
// import 'package:EMIY/styles/textStyle.dart';
// import 'package:EMIY/utils/Services/routing.dart';
// import 'package:EMIY/utils/functions/viewFunctions.dart';
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

//     // Get.find<ProduitController>().getPopularProduit();
//     //  Get.find<CategoryController>().getCategory();
//     return GetBuilder<ProduitController>(builder: (prods) {
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
//                               itemBuilder: (_ctx, index) => ProduitComponentAll(
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
