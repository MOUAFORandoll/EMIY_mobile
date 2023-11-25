// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/model/data/CommandeBoutiqueModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class CommandeBoutiqueComponent extends StatelessWidget {
  CommandeBoutiqueModel commande;
  var height;

  CommandeBoutiqueComponent({required this.commande, this.height});

  @override
  Widget build(BuildContext context) {
    // titre.text = commande.titre;
    // quantite.text = commande.quantite.toString();
    // prix.text = commande.prix.toString();
    // description.text = commande.description;
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Stack(
        children: [
          InkWell(
            child: Container(
                height: kHeight * .2,
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
                          child: CachedNetworkImage(
                        height: kHeight * .2,
                        width: kWidth * .3,
                        fit: BoxFit.cover,
                        imageUrl: commande.photo.src,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.transparent, BlendMode.colorBurn)),
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
                                  AssetImage("assets/logo/logoNew.png"));
                        },
                      )),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: kMarginX, vertical: kMarginY),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: kWidth * .55,
                                child:
                                    Text('Commande : ' + commande.numCommande,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: ColorsApp.greenLight,
                                        )),
                              ),
                              Container(
                                width: kWidth * .55,
                                child: Text('Produit : ' + commande.titre,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsApp.greenLight,
                                    )),
                              ),
                              Container(
                                child: Text(
                                    'Prix : ' +
                                        commande.prix.toString() +
                                        ' XAF',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsApp.greenLight,
                                    )),
                              ),
                              Container(
                                child: Text(
                                    'Quantite : ' +
                                        commande.quantite.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsApp.greenLight,
                                    )),
                              ),
                              Container(
                                child: Text('Code : ' + commande.codeCommande,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsApp.greenLight,
                                    )),
                              ),
                              Container(
                                  child: Text('Date : ' + commande.date,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ColorsApp.greenLight,
                                      ))),
                              Container(
                                child: Text('Status : ' + commande.status,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorsApp.greenLight,
                                    )),
                              ),
                              // Container(
                              //   // width: kSmWidth * .6,
                              //   child: Text('XAF ' + commande.prix.toString(),
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           decoration: TextDecoration.lineThrough,
                              //           decorationColor:  ColorsApp.black,
                              //           decorationThickness: 2.85,
                              //           color:  ColorsApp.black,
                              //            ,
                              //        )),
                              // )
                            ],
                          )),
                    ]) /* ) */),
            onTap: () {
              if (commande.status == 'En cours') {
                Get.bottomSheet(Container(
                    decoration: BoxDecoration(
                        color: ColorsApp.grey,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    padding: EdgeInsets.symmetric(horizontal: kSmWidth * .07),
                    height: 800,
                    child: SingleChildScrollView(
                        child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                          QrImageView(
                            data: commande.codeCommande +
                                '@' +
                                _controller.Boutique.codeBoutique,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ]))));
              } else {
                //print('deja recup');
              }
            },
          ),
          // Positioned(
          //     left: Get.width 8,
          //     top: Get.height * .02,
          //     child: InkWell(
          //         child: Icon(Icons.close, color: Colors.white),
          //         onTap: () async {
          //           var data = {
          //             'idProduit': produit.id,
          //           };
          //           await _controller.deletteProduit(data);
          //         }))
        ],
      );
    });
  }
}
