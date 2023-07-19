// import 'package:EMIY/components/Button/IconButtonF.dart';
// import 'package:EMIY/components/Button/btnCatList.dart';
// import 'package:EMIY/components/Button/btnCatListPV.dart';
// import 'package:EMIY/components/Button/button.dart';
// import 'package:EMIY/components/Form/formComponent2.dart';
// import 'package:EMIY/components/Text/bigText.dart';
// import 'package:EMIY/components/Text/bigtitleText0.dart';
// import 'package:EMIY/components/Widget/BoutiqueComponent.dart';
// import 'package:EMIY/components/Widget/app_empty.dart';
// import 'package:EMIY/components/Widget/app_loading.dart';
// import 'package:EMIY/components/Widget/categoryComponent.dart';
// import 'package:EMIY/components/Widget/productComponent.dart';
// import 'package:EMIY/components/Text/smallText.dart';
// import 'package:EMIY/components/Text/titleText.dart';
// import 'package:EMIY/components/Widget/productComponentAll.dart';
// import 'package:EMIY/components/Widget/productForCatComponent.dart';
// import 'package:EMIY/controller/boutiqueController.dart';
// import 'package:EMIY/controller/categoryController.dart';
// import 'package:EMIY/controller/categoryBoutiqueController.dart';
// import 'package:EMIY/controller/productController.dart';
// import 'package:EMIY/styles/colorApp.dart';
// import 'package:EMIY/styles/textStyle.dart';
// import 'package:EMIY/utils/functions/viewFunctions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

// class ListProduitsView0 extends StatelessWidget {
//   ListProduitsView0({Key? key}) : super(key: key);
//   ScrollController _scrollController = new ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     //print(Get.parameters);
//     Get.find<ProductController>().getProduitAll();

//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: InkWell(
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: ColorsApp.black,
//             ),
//             onTap: () {
//               Get.back();
//             },
//           ),
//           title: BigtitleText0(text: 'Liste des produits', bolder: true),
//         ),
//         body: GetBuilder<ProductController>(builder: (prods) {
//           return RefreshIndicator(
//             color: ColorsApp.skyBlue,
//             onRefresh: () async {
//               await Get.find<ProductController>().getProduitAll();
//               ;
//             },
//             child: prods.isLoadedPAll == 0
//                 ? AppLoading()
//                 : (prods.produitListAll.length != 0)
//                     ? StaggeredGridView.countBuilder(
//                         physics: ScrollPhysics(),
//                         crossAxisCount: 4,
//                         itemCount: prods.produitListAll.length,
//                         itemBuilder: (_ctx, index) => ProductComponentAll(
//                             type: 1,
//                             produit: prods.produitListAll[index],
//                             index: index),
//                         staggeredTileBuilder: (int index) =>
//                             new StaggeredTile.count(2, index.isEven ? 3 : 2),
//                         mainAxisSpacing: 2.0,
//                         crossAxisSpacing: 4.0,

//                         //   GridView.builder(
//                         //       physics:
//                         //           NeverScrollableScrollPhysics(),
//                         //       gridDelegate:
//                         //           const SliverGridDelegateWithFixedCrossAxisCount(
//                         //               crossAxisCount: 2,
//                         //               crossAxisSpacing:
//                         //                   10.0,
//                         //               mainAxisSpacing:
//                         //                   50.0),
//                         //       itemCount:
//                         //           prods.produitList.length,
//                         //       itemBuilder: (_ctx, index) =>
//                         //           ProductComponentAll(
//                         //               produit:
//                         //                   prods.produitList[
//                         //                       index],
//                         //               index: index)),
//                       )
//                     : Container(
//                         height: kHeight,
//                         child: AppEmpty(title: 'Aucun Produit')),

//             // Builds 1000 ListTiles
//           );
//         }));
//   }
// }
