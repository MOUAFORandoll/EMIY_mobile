// ignore: must_be_immutable 
import 'package:EMIY/model/data/CommandeModel.dart'; 
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart'; 
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommandeComponent extends StatelessWidget {
  CommandeModel commande;

  CommandeComponent({required this.commande});

  @override
  Widget build(BuildContext context) { 

    // titre.text = commande.titre;
    // quantite.text = commande.quantite.toString();
    // prix.text = commande.prix.toString();
    // description.text = commande.description;
    return Container(
        child: Stack(
      children: [
        InkWell(
          child: Container(
              height: kMdHeight / 8,
              // width: kMdWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: kMarginX, vertical: kMarginY),
              decoration: BoxDecoration(
                  color: ColorsApp.greyFirst,
                  borderRadius: BorderRadius.circular(8)),
              child: /* SingleChildScrollView(
              child: */
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: kMarginX, vertical: kMarginY),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // width: kSmWidth * .6,

                              child: Text(
                                  'Code Commande : ' + commande.codeCommande,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: ColorsApp.greenLight,
                                      fontSize: 12)),
                            ),
                            Container(
                              // width: kSmWidth * .6,

                              child: Text(
                                  'Code Client : ' + commande.codeClient,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: ColorsApp.greenLight,
                                      fontSize: 12)),
                            ),
                            // Container(
                            //   // width: kSmWidth * .6,

                            //   child: Text('Etape : ' + commande.etape,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           color: ColorsApp.greenLight,
                            //           fontSize: 12)),
                            // ),

                            Container(
                              child: Text('Date : ' + commande.date,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ),
                            // Container(
                            //   child: Text(
                            //       'Prix : ' +
                            //           commande.prix.toString() +
                            //           ' XAF',
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           color: Colors.red,
                            //           fontWeight: FontWeight.bold)),
                            // ),
                            // Container(
                            //   child: Text(
                            //       'Quantite : ' +
                            //           commande.quantite.toString(),
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           color: Colors.red,
                            //           fontWeight: FontWeight.bold)),
                            // ),
                            // Container(
                            //   child: Text('Code : ' + commande.codeCommande,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           color: Colors.red,
                            //           fontWeight: FontWeight.bold)),
                            // ),
                            // Container(
                            //   child: Text('Date : ' + commande.date,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           color: Colors.red,
                            //           fontWeight: FontWeight.bold)),
                            // ),
                            // // Container(
                            //   // width: kSmWidth * .6,
                            //   child: Text('XAF ' + commande.prix.toString(),
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           decoration: TextDecoration.lineThrough,
                            //           decorationColor:  ColorsApp.black,
                            //           decorationThickness: 2.85,
                            //           color:  ColorsApp.black,
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.bold)),
                            // )
                          ],
                        )),
                  ]) /* ) */),
          onTap: () {
            Get.toNamed(AppLinks.PRODUCT_FOR_COMMANDE +
                '?id=${commande.id}&code=${commande.codeCommande} ');
          },
        ),
      ],
    ));
  }
}
