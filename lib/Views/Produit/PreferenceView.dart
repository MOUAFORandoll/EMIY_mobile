import 'package:EMIY/components/Text/TextBackSpace.dart';
import 'package:EMIY/components/Widget/ShimmerProduit.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/produitForBoutiqueComponent.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/Widget/app_empty.dart';

class PreferenceView extends StatelessWidget {
  PreferenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    return GetBuilder<ProduitController>(
      builder: (_controler) => Scaffold(
          backgroundColor: ColorsApp.bg,
          body: SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: ColorsApp.bg,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Mes favories',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'Lato', fontWeight: FontWeight.w600),
                  ),
                  leading: Container(
                      child: InkWell(
                    child: Container(
                      margin: EdgeInsets.zero,
                      // padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(

                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Icon(Icons.arrow_back_ios_new,
                          color: ColorsApp.black, size: 25.0),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  )),
                  // flexibleSpace: FlexibleSpaceBar(
                  //     background: Container(
                  //         decoration: BoxDecoration(
                  //           color: ColorsApp.bg,
                  //         ),
                  //         child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Container(
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       margin:
                  //                           EdgeInsets.only(left: kWidth * .010),
                  //                       child: TextBackSpace(
                  //                         text: 'Mes Favories',
                  //                         // bolder: true,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ]))),

                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _controler.isLoadedPB == 0
                        ? Container(
                            // height: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: kMarginX),
                            child: ShimmerProduit())
                        : Container(
                            // height: double.maxFinite,
                            margin: EdgeInsets.symmetric(
                                vertical: kMarginY * .2, horizontal: kMarginX),
                            child: _controler.isLoadedPB == 1
                                ? (_controler.preferenceList.length != 0)
                                    ? SingleChildScrollView(
                                        child: GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: kMarginX),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 20.0,
                                                    childAspectRatio: 0.7,
                                                    mainAxisSpacing: 20.0),
                                            itemCount: _controler
                                                .preferenceList.length,
                                            itemBuilder: (_ctx, index) =>
                                                ProduitForBoutiqueComponent(
                                                    produit: _controler
                                                        .preferenceList[index],
                                                    type: 'favorite',
                                                    index: index)))
                                    : Container(
                                        height: kHeight,
                                        child: AppEmpty(title: 'Aucun Produit'))
                                : Container(
                                    height: kMdHeight * .6,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Text('Error'),
                                    ))),
                    childCount: 1,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
