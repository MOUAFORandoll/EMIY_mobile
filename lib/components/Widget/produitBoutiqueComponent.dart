// ignore: must_be_immutable
import 'package:EMIY/components/Widget/app_input_new.dart';
import 'package:EMIY/components/Widget/imageCompAdd.dart';
import 'package:EMIY/components/Widget/imageCompUpdate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/model/data/ProduitBoutiqueModel.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

import '../../utils/Services/validators.dart';

// ignore: must_be_immutable
class ProduitBoutiqueComponent extends StatelessWidget {
  ProduitBoutiqueModel produit;
  var height;

  ProduitBoutiqueComponent({required this.produit, this.height});

  @override
  Widget build(BuildContext context) {
    TextEditingController titre = TextEditingController();
    TextEditingController quantite = TextEditingController();
    TextEditingController prix = TextEditingController();
    TextEditingController description = TextEditingController();

    titre.text = produit.titre;
    quantite.text = produit.quantite.toString();
    prix.text = produit.prix.toString();
    description.text = produit.description;
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Stack(
        children: [
          InkWell(
            child: Container(
                height: kMdHeight / 8,
                // width: kMdWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: kMarginX, vertical: kMarginY),
                decoration: BoxDecoration(
                    color: ColorsApp.grey, // gradient: GradientApp.blueG,
                    borderRadius: BorderRadius.circular(8)),
                child: /* SingleChildScrollView(
              child: */
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Container(
                          child: CachedNetworkImage(
                        height: kMdHeight / 8,
                        width: Get.width / 3,
                        fit: BoxFit.cover,
                        imageUrl: produit.images[0].src,
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
                                width: kSmWidth * .8,
                                child: Text('Nom : ' + produit.titre,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorsApp.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11)),
                              ),
                              Container(
                                child: Text(
                                    'Prix : ' +
                                        produit.prix.toString() +
                                        ' XAF',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorsApp.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Container(
                                child: Text(
                                    'Quantite : ' + produit.quantite.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorsApp.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Container(
                                child: Text('Ajout : ' + produit.date,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorsApp.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                              // Container(
                              //   // width: kSmWidth * .6,
                              //   child: Text('XAF ' + produit.prix.toString(),
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           decoration: TextDecoration.lineThrough,
                              //           decorationColor:  ColorsApp.black,
                              //           decorationThickness: 2.85,
                              //           color:  ColorsApp.black,
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w600)),
                              // )
                            ],
                          )),
                    ]) /* ) */),
            onTap: () {
              Get.bottomSheet(
                Container(
                    margin: EdgeInsets.only(
                      top: kMarginY * 8,
                    ),
                    decoration: BoxDecoration(
                        color: ColorsApp.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    height: 800,
                    padding: EdgeInsets.symmetric(horizontal: kMarginX),
                    child: Column(
                      children: [
                        // _controller.listImgProduits.length != 0
                        //     ? smallText(
                        //         text: 'Listes images',
                        //       )
                        //     : Container(),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: Text(
                                    'Annuler',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Enregistrer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      color: ColorsApp.skyBlue,
                                    ),
                                  ),
                                  onPressed: () async {
                                    var data = {
                                      'idProduit': produit.id,
                                      'titre': titre.text,
                                      'quantite': quantite.text,
                                      'prixUnitaire': prix.text,
                                      'description': description.text
                                    };
                                    //print(data);
                                    await _controller.updateProduit(data);
                                    // Get.back(closeOverlays: true);
                                  },
                                )
                              ]),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: kMarginY * 1.5,
                              ),
                              child: AppInputNew(
                                icon: Icon(Icons.label),
                                controller: titre,
                                label: 'lbnameprod'.tr,
                                validator: (value) {
                                  return Validators.isValidUsername(value!);
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: kMarginY,
                              ),
                              child: AppInputNew(
                                textInputType: TextInputType.number,
                                controller: prix,
                                icon: Icon(Icons.monetization_on),
                                label: 'lbprixprod'.tr,
                                validator: (value) {
                                  return Validators.usNumeriqValid(value!);
                                },
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                  top: kMarginY,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text('Stock')),
                            Container(
                                margin: EdgeInsets.only(
                                  top: kMarginY,
                                ),
                                height: kHeight * .06,
                                padding: EdgeInsets.symmetric(
                                    vertical: kMarginY, horizontal: kMarginX),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorsApp.greySearch),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Disponible'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            child: Icon(Icons.remove),
                                            onTap: () {
                                              quantite.text =
                                                  (int.parse(quantite.text) - 1)
                                                      .toString();
                                            }),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: ColorsApp.greySecond),
                                          width: kMdWidth / 2,
                                          // height: 35,
                                          // alignment: Alignment.center,
                                          child: AppInputNew(
                                            controller: quantite,
                                            label: '',
                                            // border: true,
                                            alignStart: false,
                                            textInputType: TextInputType.number,
                                            validator: (value) {
                                              return Validators.usNumeriqValid(
                                                  value!);
                                            },
                                          ),
                                        ),
                                        InkWell(
                                            child: Icon(Icons.add),
                                            onTap: () {
                                              quantite.text =
                                                  (int.parse(quantite.text) + 1)
                                                      .toString();
                                            })
                                      ],
                                    )
                                  ],
                                )),
                            produit.images.length != 0
                                ? Container(
                                    height: kSmHeight * 2,
                                    margin: EdgeInsets.symmetric(
                                        vertical: kMarginY * .3),
                                    child: ListView.builder(
                                      itemCount: produit.images.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_ctx, index) {
                                        return Row(
                                          children: [
                                            produit.images[index] != null
                                                ? imageCompUpdate(
                                                    image:
                                                        produit.images[index],
                                                  )
                                                : Container(),
                                            index == produit.images.length - 1
                                                ? ImageCompAdd(id: produit.id)
                                                : Container()
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(
                                top: kMarginY,
                              ),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: ColorsApp.greySecond)
                                  // color: (color == null) ? ColorsApp.blue : color,
                                  ),
                              child: TextFormField(
                                controller: description,
                                onChanged: (String value) {},
                                validator: (value) {
                                  return Validators.isValidUsername(value!);
                                },
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                ),
                                maxLines: 10,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorsApp.skyBlue, width: 2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorsApp.greySearch),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorStyle: TextStyle(
                                    fontSize: 8,
                                    fontFamily: 'Lato',
                                  ),
                                  labelStyle: TextStyle(
                                    color: ColorsApp.black,
                                    fontFamily: 'Lato',
                                    // fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  labelText: 'lbdescprod'.tr,
                                  fillColor: ColorsApp.skyBlue,
                                  counter: Offstage(),
                                  hintText: 'lbdescprod'.tr,
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                decoration:
                                    BoxDecoration(color: ColorsApp.grey),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // smallText(
                                      //   text: _controller.Boutique.titre,
                                      // ),
                                      // CustomBtn(
                                      //   color: ColorsApp.greenLight,
                                      //   title: 'Ajouter Produit',
                                      //   onTap: () async {
                                      //     await _controller.ajouterProduit();
                                      //     // _controller.chageState(!_controller.addProduit);
                                      //   },
                                      // )
                                    ])),
                          ],
                        )))
                      ],
                    )),
                isScrollControlled: true,
                // isDismissible: true,
              );

              // Get.toNamed(AppLinks.PRODUCT +
              //     '?index=${index}&type=0&id=${produit.id}&titre=${produit.titre}&description=${produit.description}&image=${ApiUrl.baseUrl}/images/produits/${produit.images[0].src}');
            },
          ),
          Positioned(
              left: Get.width * .88,
              top: Get.height * .02,
              child: InkWell(
                  child: Icon(Icons.close, color: Colors.white),
                  onTap: () async {
                    var data = {
                      'idProduit': produit.id,
                    };
                    await _controller.deletteProduit(data);
                  }))
        ],
      );
    });
  }
}
