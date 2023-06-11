// import 'package:EMIY/components/Button/IconButtonF.dart';
// import 'package:EMIY/components/Button/btnCatList.dart';
// import 'package:EMIY/components/Button/btnCatListPV.dart';
// import 'package:EMIY/components/Button/button.dart';
// import 'package:EMIY/components/Form/formComponent2.dart';
// import 'package:EMIY/components/Text/bigText.dart';
// import 'package:EMIY/components/Text/bigtitleText.dart';
// import 'package:EMIY/components/Widget/BoutiqueComponent.dart';
// import 'package:EMIY/components/Widget/categoryComponent.dart';
// import 'package:EMIY/components/Widget/categoryComponent2.dart';
// import 'package:EMIY/components/Widget/productComponent.dart';
// import 'package:EMIY/components/Text/smallText.dart';
// import 'package:EMIY/components/Text/titleText.dart';
// import 'package:EMIY/controller/boutiqueController.dart';
// import 'package:EMIY/controller/categoryController.dart';
// import 'package:EMIY/controller/CategoryBoutiqueController.dart';
// import 'package:EMIY/styles/colorApp.dart';
// import 'package:EMIY/styles/textStyle.dart';
// import 'package:EMIY/utils/functions/viewFunctions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

// class ListBoutiqueView extends StatelessWidget {
//   ListBoutiqueView({Key? key}) : super(key: key);
//   ScrollController _scrollController = new ScrollController();

//   @override
//   Widget build(BuildContext context) { 
    
//     Get.find<CategoryBoutiqueController>().getCategoryBoutique(Get.parameters['id']);
//     return Scaffold(
//         body: RefreshIndicator(
//       color: ColorsApp.skyBlue,
//       onRefresh: () async {
//         await     Get.find<CategoryBoutiqueController>()
//             .getCategoryBoutique(Get.parameters['id']);
//       },
//       child: CustomScrollView(controller: _scrollController, slivers: [
//         // Add the app bar to the CustomScrollView.
//         SliverAppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           // Provide a standard title.
//           // title: Text('title'),
//           // Allows the user to reveal the app bar if they begin scrolling
//           // back up the list of items.
//           floating: true,
//           // Display a placeholder widget to visualize the shrinking size.
//           flexibleSpace: InkWell(
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 Container(
//                     margin: EdgeInsets.only(top: Get.height * .030),
//                     padding: EdgeInsets.only(
//                         left: Get.width * .030, right: Get.width * .030),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           BigtitleText(text: 'Les Boutiques', bolder: true),
//                           // Container(
//                           //     child: InkWell(
//                           //         child: Icon(Icons.search),
//                           //         onTap: () => Scaffold.of(context).openDrawer())
//                           //     // padding: EdgeInsets.only(right: 10),
//                           //     ),
//                         ])),
//               ]),
//             ),
//             /*   onTap: () => filterDest() */
//           ),
//           // Make the initial height of the SliverAppBar larger than normal.
//           expandedHeight: 60,
//         ),
//         SliverList(
//           // Use a delegate to build items as they're scrolled on screen.
//           delegate: SliverChildBuilderDelegate(
//             // The builder function returns a ListTile with a title that
//             // displays the index of the current item.
//             (context, index) => GetBuilder<CategoryBoutiqueController>(
//                 builder: (_lbcontroller) => _lbcontroller.isLoaded == 0
//                     ? Shimmer.fromColors(
//                         baseColor: Colors.blueGrey,
//                         highlightColor: Colors.greenAccent,
//                         child: SizedBox(
//                           height: kMdHeight,
//                           child: Stack(
//                             children: [
//                               GridView.builder(
//                                 padding: const EdgeInsets.all(20),
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         crossAxisSpacing: 20.0,
//                                         mainAxisSpacing: 50.0),
//                                 itemCount: 10,
//                                 itemBuilder: (_ctx, index) => Container(
//                                   height: kMdHeight * 2,
//                                   width: kMdWidth * 1.1,
//                                   margin: EdgeInsets.only(right: kMarginX),
//                                   decoration: BoxDecoration(
//                                       color: ColorsApp.greySecond,
//                                       borderRadius: BorderRadius.circular(8)),
//                                   child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                             height: kMdHeight * .115,
//                                             width: Get.width * .5,
//                                             decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                               image:
//                                                   AssetImage('assets/logo.png'),
//                                             ))),
//                                         Container(
//                                           width: kSmWidth * .6,
//                                           margin: EdgeInsets.only(
//                                               top: Get.height * .005,
//                                               left: Get.width * .008),
//                                           child: Text('produit.titre',
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                   color: ColorsApp.black,
//                                                   fontSize: 12)),
//                                         ),
//                                         // Container(
//                                         //   width: kSmWidth * .6,
//                                         //   margin: EdgeInsets.only(
//                                         //       top: Get.height * .005,
//                                         //       left: Get.width * .008),
//                                         //   child: Text('XAF ' + '1000',
//                                         //       overflow: TextOverflow.ellipsis,
//                                         //       style: TextStyle(
//                                         //           color: Colors.red,
//                                         //           fontSize: 12,
//                                         //           fontWeight: FontWeight.bold)),
//                                         // ),
//                                       ]),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ))
//                     : (_lbcontroller.BoutiquecategoryList.length != 0)
//                         ? SingleChildScrollView(
//                             child: GridView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 padding: const EdgeInsets.all(5),
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         crossAxisSpacing: 10.0,
//                                         mainAxisSpacing: 10.0),
//                                 itemCount: _lbcontroller.BoutiquecategoryList.length,
//                                 itemBuilder: (_ctx, index) => BoutiqueComponent(
//                                       boutique:
//                                           _lbcontroller.BoutiquecategoryList[index],
//                                     )))
//                         : Container(
//                             height: kMdHeight * .6,
//                             alignment: Alignment.center,
//                             child: Center(
//                               child: Text('Aucune boutique'),
//                             ))),

//             // Builds 1000 ListTiles
//             childCount: 1,
//           ),
//         )
//       ]),
//     ));
//   }
// }
