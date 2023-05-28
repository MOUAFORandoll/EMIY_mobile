// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/model/data/CommandeModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductComponent extends StatelessWidget {
  Produit produit;

  ProductComponent({required this.produit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          // height: kMdHeight * 1.2,
          width: kMdWidth * .06,
          // padding: EdgeInsets.all(kMarginX),
          margin:
              EdgeInsets.only(right: kMarginX, left: kMarginX, top: kMarginY),
          decoration: BoxDecoration(
              color: ColorsApp.greyFirst,
              borderRadius: BorderRadius.circular(8)),
          child: /* SingleChildScrollView(
              child: */
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: ColorsApp.greySecond,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          height: kMdHeight * .10,
                          width: Get.width * .3,
                          fit: BoxFit.cover,
                          imageUrl: produit.photo.src,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  /* colorFilter: ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn) */
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) {
                            return Container(
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: ColorsApp.skyBlue,
                              )),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return CircleAvatar(
                                backgroundColor: ColorsApp.skyBlue,
                                radius: 50,
                                backgroundImage:
                                    AssetImage("assets/images/error.gif"));
                          },
                        )),
                    // Positioned(
                    //   top: 0,
                    //   left: Get.height * .158,
                    //   child: Container(
                    //     padding: EdgeInsets.all(6),
                    //     decoration: BoxDecoration(
                    //         gradient: GradientApp.blueG,
                    //         borderRadius: BorderRadius.only(
                    //             bottomLeft: Radius.circular(10),
                    //             topRight: Radius.circular(10))),
                    //     child: Icon(Icons.shopping_cart_outlined,
                    //         color: Colors.red),
                    //   ),
                    // )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: kSmWidth * .6,
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: Text('Nom : ' + produit.titre,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ColorsApp.greenLight, fontSize: 12)),
                    ),
                    Container(
                      width: kSmWidth * .6,
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: Text('Quantite : ' + produit.quantite.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: kSmWidth * .6,
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: Text('Status : ' + produit.status,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: kSmWidth * .6,
                      margin: EdgeInsets.only(
                          top: Get.height * .005, left: Get.width * .008),
                      child: Text('XAF ' + produit.prix.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black,
                              decorationThickness: 2.85,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ]) /* ) */),
      onTap: () {
        // if (produit.status == 'En cours') {
        //   Get.bottomSheet(
        //     Container(
        //       padding: EdgeInsets.symmetric(horizontal: kSmWidth * .07),
        //       height: 800,
        //       color: ColorsApp.grey,
        //       child: SingleChildScrollView(
        //           child: Column(
        //         // mainAxisSize: MainAxisSize.min,
        //         children: [
        //           FormComponent2(
        //               icon: Icons.account_circle,
        //               type: 0,
        //               controller: codeBoutique,
        //               enabled: true,
        //               titre: 'Code boutique',
        //               hint: "XXXXX"),
        //           FormComponent2(
        //               icon: Icons.account_circle,
        //               type: 0,
        //               controller: codeCommande,
        //               enabled: true,
        //               titre: 'Code Commande',
        //               hint: "XXXXX"),
        //           GetBuilder<CommandeController>(builder: (_commande) {
        //             return CustomBtn(
        //               color: ColorsApp.greenLight,
        //               title: 'Valider',
        //               onTap: () async {
        //                 var data = {
        //                   'codeCommande': codeCommande.text,
        //                   'codeBoutique': codeBoutique.text,
        //                   'codeProduitPanier': produit.codeProduit,
        //                   'keySecret': 0056 // _commande.getKey()
        //                 };
        //                 //print(data);
        //                 // await _commande.validateProduit(data);
        //                 // // _controller.chageState(!_controller.addProduct);
        //               },
        //             );
        //           })
        //         ],
        //       )),
        //     ),
        //   );
        // } else {
        //   //print('deja recup');
        // }
        // Get.toNamed(AppLinks.PRODUCT +
      },
    );
  }
}
