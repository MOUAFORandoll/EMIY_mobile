// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/commentForm.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/model/data/BoutiqueUserModel.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommandeComponent extends StatelessWidget {
  CommandeModel commande;

  CommandeComponent({required this.commande});

  @override
  Widget build(BuildContext context) {
    TextEditingController titre = TextEditingController();
    TextEditingController quantite = TextEditingController();
    TextEditingController prix = TextEditingController();
    TextEditingController description = TextEditingController();

    // titre.text = commande.titre;
    // quantite.text = commande.quantite.toString();
    // prix.text = commande.prix.toString();
    // description.text = commande.description;
    return Stack(
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
                            //           decorationColor: Colors.black,
                            //           decorationThickness: 2.85,
                            //           color: Colors.black,
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
    );
  }
}
