import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/productComponent0.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
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
                  await _commande.getProduitForCommandes(id);
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
                      decoration: BoxDecoration(
                          color: ColorsApp.grey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
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
              ? AppLoading()
              : ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: _commande.produitList.length,
                  itemBuilder: (_ctx, x) =>
                      ProductComponent(produit: _commande.produitList[x])));

      // Builds 1000 ListTiles
    });
  }
}
