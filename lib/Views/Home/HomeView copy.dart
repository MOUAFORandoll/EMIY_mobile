// import 'package:EMIY/components/Widget/app_loading.dart';
// import 'package:EMIY/controller/GeneralController.dart';
// import 'package:EMIY/controller/CommandeController.dart';
// import 'package:EMIY/controller/ShortController.dart';
// import 'package:EMIY/controller/managerController.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:EMIY/Views/Search/SearchView.dart';
// import 'package:EMIY/components/Button/btnCatList.dart';
// import 'package:EMIY/components/Button/btnCatListPV.dart';
// import 'package:EMIY/components/Button/button.dart';
// import 'package:EMIY/components/Form/formComponent2.dart';
// import 'package:EMIY/components/Form/text_field.dart';
// import 'package:EMIY/components/Text/bigText.dart';
// import 'package:EMIY/components/Text/bigtitleText.dart';
// import 'package:EMIY/components/Widget/BoutiqueComponentHome.dart';
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
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

// class HomeView extends StatelessWidget {
//   HomeView({Key? key}) : super(key: key);
//   ScrollController _scrollController = new ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController controllerField = TextEditingController();

//     // Get.find<ProduitController>().getPopularProduit();
//     //  Get.find<CategoryController>().getCategory();
//     return GetBuilder<ProduitController>(builder: (prods) {
//       return RefreshIndicator(
//           color: ColorsApp.skyBlue,
//           onRefresh: () async {
//             //print('****debut');
//             await Get.find<CategoryBoutiqueController>().getCategory();
//             await Get.find<CategoryBoutiqueController>().getListBoutiques();

//             await Get.find<CommandeController>().getListCommandes();
//             await Get.find<ManagerController>().getKeyU();
//             await Get.find<ManagerController>().getLocalU();
//             await Get.find<ManagerController>().getUser();
//             await Get.find<ShortController>().getListForYouShort();

//             //print('****mid');

//             await prods.getPopularProduit();
//             //print('****fin');
//           },
//           child: CustomScrollView(
//               controller: Get.find<GeneralController>().scrollcontroller,
//               slivers: [
//                 SliverAppBar(
//                   backgroundColor: Colors.white,

//                   elevation: 0,
//                   // Provide a standard title.
//                   // title: Text('title'),
//                   // Allows the user to reveal the app bar if they begin scrolling
//                   // back up the list of items.
//                   floating: true,
//                   // Display a placeholder widget to visualize the shrinking size.
//                   flexibleSpace: Container(
//                       margin: EdgeInsets.only(top: Get.height * .030, left: 0),
//                       padding: EdgeInsets.only(
//                           left: Get.width * .030, right: Get.width * .030),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             BigtitleText(text: 'Home', bolder: true),
//                             InkWell(
//                                 child: Container(
//                                     // margin: EdgeInsets.only(right: 10),
//                                     padding: EdgeInsets.all(kMarginX / 3),
//                                     // margin: EdgeInsets.only(right: kMarginX),
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.blue, width: 2),
//                                         borderRadius:
//                                             BorderRadius.circular(30)),
//                                     child: Icon(
//                                       Icons.amp_stories,
//                                       color: Colors.red,
//                                     )),
//                                 onTap: () {
//                                   Get.find<ShortController>().getListForYouShort();

//                                   Get.toNamed(AppLinks.SHORT);
//                                 })
//                           ])

//                       /*   onTap: () => filterDest() */
//                       ),
//                   // Make the initial height of the SliverAppBar larger than normal.
//                   expandedHeight: 60,
//                 ),
//                 SliverList(
//                     delegate: SliverChildBuilderDelegate(

//                   (context, index) => GetBuilder<CategoryBoutiqueController>(
//                       builder: (categorys) {
//                     return categorys.isLoadedCat == 0 || prods.isLoadedP == 0
//                         ? AppLoading()
//                         : Container(
//                             margin: EdgeInsets.symmetric(horizontal: kMarginX),
//                             child: SingleChildScrollView(
//                                 child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 titleText(text: 'Categorie'),
//                                 Container(
//                                   height: kSmHeight,
//                                   margin: EdgeInsets.symmetric(
//                                       vertical: kMarginY * .2),
//                                   child: ListView.builder(
//                                     itemCount: categorys.categoryList.length,
//                                     scrollDirection: Axis.horizontal,
//                                     itemBuilder: (_ctx, index) =>
//                                         CategoryComponent(
//                                       category: categorys.categoryList[index],
//                                     ),
//                                   ),
//                                 ),
//                                 categorys.ListBoutiqueF.length != 0
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           titleText(
//                                               text: 'Boutique Populaire(s)'),
//                                           Container(
//                                               margin: EdgeInsets.only(
//                                                   top: Get.height * .005,
//                                                   left: Get.width * .008),
//                                               child: InkWell(
//                                                   child: Icon(
//                                                     Icons
//                                                         .arrow_forward_ios_outlined,
//                                                     // color: Colors.white,
//                                                   ),
//                                                   onTap: () {
//                                                     Get.toNamed(AppLinks
//                                                         .BOUTIQUE_READ_ALL);
//                                                   })),
//                                         ],
//                                       )
//                                     : Container(),
//                                 categorys.ListBoutiqueF.length != 0
//                                     ? Container(
//                                         height: kMdHeight * .30,
//                                         margin: EdgeInsets.symmetric(
//                                             vertical: kMarginY * .2),
//                                         child: ListView.builder(
//                                             scrollDirection: Axis.horizontal,
//                                             itemCount: categorys
//                                                         .ListBoutiqueF.length <
//                                                     5
//                                                 ? categorys.ListBoutiqueF.length
//                                                 : 5,
//                                             itemBuilder: (_ctx, index) =>
//                                                 BoutiqueComponentHome(
//                                                   boutique: categorys
//                                                       .ListBoutiqueF[index],
//                                                 )),
//                                       )
//                                     : Container(),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     titleText(text: 'Best Selling'),
//                                     Container(
//                                         margin: EdgeInsets.only(
//                                             top: Get.height * .005,
//                                             left: Get.width * .008),
//                                         child: InkWell(
//                                             child: Icon(
//                                               Icons.arrow_forward_ios_outlined,
//                                               // color: Colors.white,
//                                             ),
//                                             onTap: () {
//                                               Get.toNamed(
//                                                   AppLinks.PRODUCT_READ_ALL);
//                                             })),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                     height:
//                                         MediaQuery.of(context).size.height * 2,
//                                     child: Stack(
//                                       children: [
//                                         StaggeredGridView.countBuilder(
//                                           physics:
//                                               NeverScrollableScrollPhysics(),
//                                           shrinkWrap: false,
//                                           crossAxisCount: 4,
//                                           itemCount: prods.produitList.length,
//                                           itemBuilder: (_ctx, index) =>
//                                               ProduitComponentAll(
//                                                   produit:
//                                                       prods.produitList[index],
//                                                   index: index),
//                                           staggeredTileBuilder: (int index) =>
//                                               new StaggeredTile.count(
//                                                   2, index.isEven ? 3 : 2),
//                                           mainAxisSpacing: 2.0,
//                                           crossAxisSpacing: 4.0,
//                                         ),
//                                         //   GridView.builder(
//                                         //       physics:
//                                         //           NeverScrollableScrollPhysics(),
//                                         //       gridDelegate:
//                                         //           const SliverGridDelegateWithFixedCrossAxisCount(
//                                         //               crossAxisCount: 2,
//                                         //               crossAxisSpacing:
//                                         //                   10.0,
//                                         //               mainAxisSpacing:
//                                         //                   50.0),
//                                         //       itemCount:
//                                         //           prods.produitList.length,
//                                         //       itemBuilder: (_ctx, index) =>
//                                         //           ProduitComponentAll(
//                                         //               produit:
//                                         //                   prods.produitList[
//                                         //                       index],
//                                         //               index: index)),
//                                       ],
//                                     )),
//                               ],
//                             )),
//                           );
//                   }),
//                   childCount: 1,
//                 ))
//               ]));
//     });
//   }
// }
