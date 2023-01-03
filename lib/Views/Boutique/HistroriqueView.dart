import 'package:fahkapmobile/components/Button/btnCatList.dart';
import 'package:fahkapmobile/components/Button/btnCatListPV.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent.dart';
import 'package:fahkapmobile/components/Widget/categoryComponent2.dart';
import 'package:fahkapmobile/components/Widget/commandeForComponent.dart';
import 'package:fahkapmobile/components/Widget/productBoutiqueComponent.dart';
import 'package:fahkapmobile/components/Widget/productComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HistoriqueCommandeView extends StatelessWidget {
  HistoriqueCommandeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Get.find<BoutiqueController>().getListHCommandeForBoutique();
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onTap: () => Get.back()),
            title: Text(
              'Historiques de vos ventes',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              InkWell(
                child: Icon(Icons.search, color: Colors.red),
              )
            ],
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                decoration: BoxDecoration(color: ColorsApp.grey),
                padding: EdgeInsets.only(
                    left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // smallText(
                      //   text: 'Categorie',
                      // ),
                      // CustomBtn(
                      //   color: ColorsApp.greenLight,
                      //   title: _controller.addProduct
                      //       ? 'Retour'
                      //       : 'Ajouter Produit',
                      //   onTap: () {
                      //     _controller.chageState(!_controller.addProduct);
                      //   },
                      // )
                    ])),
            _controller.isLoadedPH == 0
                ? Shimmer.fromColors(
                    baseColor: Colors.blueGrey,
                    highlightColor: Colors.greenAccent,
                    child: SingleChildScrollView(
                        child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (_ctx, index) {
                        return Container(
                            height: kMdHeight / 6,
                            // width: kMdWidth,
                            margin: EdgeInsets.symmetric(
                                horizontal: kMarginX, vertical: kMarginY),
                            decoration: BoxDecoration(
                                color: ColorsApp.skyBlue,
                                borderRadius: BorderRadius.circular(8)),
                            child:
                                /* SingleChildScrollView(
              child: */
                                Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Container(
                                      height: kMdHeight / 6,
                                      width: Get.width / 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/error.gif"),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.red,
                                                BlendMode.colorBurn)),
                                      )),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: kMarginX,
                                          vertical: kMarginY),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // width: kSmWidth * .6,

                                            child: Text('Nom : ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: ColorsApp.greenLight,
                                                    fontSize: 12)),
                                          ),
                                          Container(
                                            child: Text('Prix : ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            child: Text('Quantite : ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            child: Text('Code : ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            child: Text('Date : ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          // Container(
                                          //   // width: kSmWidth * .6,
                                          //   child: Text('XAF ' + commande.prix.toString(),
                                          //       overflow: TextOverflow.ellipsis,
                                          //       style: TextStyle(
                                          //           decoration: TextDecoration.lineThrough,
                                          //           decorationColor: Colors.black,
                                          //           decorationThickness: 2.85,
                                          //           color: Colors.black,
                                          //           fontSize: 12,
                                          //           fontWeight: FontWeight.bold)),
                                          // )
                                        ],
                                      ))
                                ]));
                      },
                    )))
                :  _controller.HcommandeBoutiqueList.length == 0
                    ? Center(child: Text('Aucune commande'))
                    : SingleChildScrollView(
                    child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _controller.HcommandeBoutiqueList.length,
                    itemBuilder: (_ctx, index) {
                      return CommandeBoutiqueComponent(
                          commande: _controller.HcommandeBoutiqueList[index]);
                    },
                  ))
          ])));
    });
  }
}
