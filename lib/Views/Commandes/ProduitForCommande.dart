import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Text/titleText.dart';
import 'package:fahkapmobile/components/Widget/productComponent0.dart';
import 'package:fahkapmobile/controller/CommandeController.dart';
import 'package:fahkapmobile/model/data/CommandeModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProduitForCommande extends StatelessWidget {
  ProduitForCommande({required this.id, required this.code});
  int id;
  String code;

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Get.find<CommandeController>().getProduitForCommandes(id);
    return GetBuilder<CommandeController>(builder: (_commande) {
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
            title: BigtitleText(text: 'Comm: ${code} ', bolder: true),
            actions: [
              InkWell(
                child: Container(
                  child: Icon(Icons.cached),
                  margin: EdgeInsets.only(right: 15),
                ),
                onTap: () async {
                  Get.defaultDialog(
                      title: 'En cours',
                      barrierDismissible: false,
                      content: SizedBox(
                          // height: Get.size.height * .02,
                          // width: Get.size.width * .02,
                          child: Center(
                              child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ))));
                  await _commande.getProduitForCommandes(id);
                  Get.back();
                },
              ),
              InkWell(
                child: Container(
                  child: Icon(Icons.refresh),
                  margin: EdgeInsets.only(right: 15),
                ),
                onTap: () async {
                  Get.bottomSheet(Container(
                      padding: EdgeInsets.symmetric(horizontal: kSmWidth * .07),
                      height: 800,
                      color: ColorsApp.grey,
                      child: SingleChildScrollView(
                          child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                            QrImage(
                              data: _commande.commandeSelect.codeClient,
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ]))));
                },
              )
            ],
          ),
          body: _commande.isLoadedP == false
              ? Shimmer.fromColors(
                  baseColor: Colors.blueGrey,
                  highlightColor: Colors.greenAccent,
                  child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (_ctx, x) => Container(
                        // height: kMdHeight * 1.2,
                        width: kMdWidth * .06,
                        // padding: EdgeInsets.all(kMarginX),
                        margin: EdgeInsets.only(
                            right: kMarginX, left: kMarginX, top: kMarginY),
                        decoration: BoxDecoration(
                            color: ColorsApp.greySecond,
                            borderRadius: BorderRadius.circular(8)),
                        child:
                            /* SingleChildScrollView(
              child: */
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorsApp.greySecond,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: kMdHeight * .10,
                                  width: Get.width * .3,
                                )
                              ]),
                              Column(
                                children: [
                                  Container(
                                    width: kSmWidth * .6,
                                    margin: EdgeInsets.only(
                                        top: Get.height * .005,
                                        left: Get.width * .008),
                                    child: Text('Nom : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: ColorsApp.greenLight,
                                            fontSize: 12)),
                                  ),
                                  Container(
                                    width: kSmWidth * .6,
                                    margin: EdgeInsets.only(
                                        top: Get.height * .005,
                                        left: Get.width * .008),
                                    child: Text('Quantite : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    width: kSmWidth * .6,
                                    margin: EdgeInsets.only(
                                        top: Get.height * .005,
                                        left: Get.width * .008),
                                    child: Text('Status : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              )
                            ])),
                  ))
              : ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: _commande.produitList.length,
                  itemBuilder: (_ctx, x) =>
                      ProductComponent(produit: _commande.produitList[x])));

      // Builds 1000 ListTiles
    });
  }
}
