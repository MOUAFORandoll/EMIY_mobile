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
import 'package:fahkapmobile/components/Widget/productForBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/productForCatComponent.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/categoryBoutiqueController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BoutiqueView extends StatelessWidget {
  BoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    print(Get.parameters);

    Get.find<CategoryBoutiqueController>()
        .getDataForBoutique(Get.parameters['codeBoutique']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorsApp.black,
          ),
          onTap: () {
            Get.back();
          },
        ),
        title: BigtitleText(
            text: Get.parameters['nomBoutique'].toString(), bolder: true),
      ),
      body: RefreshIndicator(
          color: ColorsApp.skyBlue,
          onRefresh: () async {
            Get.find<CategoryBoutiqueController>()
                .getDataForBoutique(Get.parameters['codeBoutique']);
          },
          child: GetBuilder<CategoryBoutiqueController>(
              builder: (_bscontroler) => _bscontroler.isLoadedPB == 0
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
                  : _bscontroler.isLoadedPB == 1
                      ? (_bscontroler.produitBoutiqueList.length != 0)
                          ? SingleChildScrollView(
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(20),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0),
                                  itemCount:
                                      _bscontroler.produitBoutiqueList.length,
                                  itemBuilder: (_ctx, index) =>
                                      ProductForBoutiqueComponent(
                                          produit: _bscontroler
                                              .produitBoutiqueList[index],
                                          index: index)),
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
                          )))),

      // Builds 1000 ListTiles
    );
  }
}
