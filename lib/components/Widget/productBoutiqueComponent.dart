// ignore: must_be_immutable
import 'package:Fahkap/components/Widget/app_input.dart';
import 'package:Fahkap/components/Widget/imageComp.dart';
import 'package:Fahkap/components/Widget/imageCompAdd.dart';
import 'package:Fahkap/components/Widget/imageCompUpdate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/commentForm.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/model/data/BoutiqueUserModel.dart';
import 'package:Fahkap/model/data/ProduitBoutiqueModel.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

import '../../utils/Services/validators.dart';

// ignore: must_be_immutable
class ProductBoutiqueComponent extends StatelessWidget {
  ProduitBoutiqueModel produit;
  var height;

  ProductBoutiqueComponent({required this.produit, this.height});

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
                                  AssetImage("assets/images/error.gif"));
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
                                // width: kSmWidth * .6,

                                child: Text('Nom : ' + produit.titre,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
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
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Container(
                                child: Text(
                                    'Quantite : ' + produit.quantite.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Container(
                                child: Text('Ajout : ' + produit.date,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),
                              ),
                              // Container(
                              //   // width: kSmWidth * .6,
                              //   child: Text('XAF ' + produit.prix.toString(),
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           decoration: TextDecoration.lineThrough,
                              //           decorationColor: Colors.black,
                              //           decorationThickness: 2.85,
                              //           color: Colors.black,
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w600)),
                              // )
                            ],
                          )),
                    ]) /* ) */),
            onTap: () {
              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.symmetric(horizontal: kSmWidth * .07),
                  // height: 800,
                  decoration: BoxDecoration(
                      color: ColorsApp.grey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: SingleChildScrollView(
                      child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      produit.images.length != 0
                          ? Container(
                              height: kSmHeight * 2,
                              margin:
                                  EdgeInsets.symmetric(vertical: kMarginY * .1),
                              child: ListView.builder(
                                itemCount: produit.images.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_ctx, index) {
                                  return Row(
                                    children: [
                                      produit.images[index] != null
                                          ? imageCompUpdate(
                                              image: produit.images[index],
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: kMarginY,
                        ),
                        child: AppInput(
                          controller: titre,
                          label: 'lbnameprod'.tr,
                          validator: (value) {
                            return Validators.isValidUsername(value!);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: kMarginY,
                        ),
                        child: AppInput(
                          controller: quantite,
                          label: 'lbnqteprod'.tr,
                          validator: (value) {
                            return Validators.usNumeriqValid(value!);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: kMarginY,
                        ),
                        child: AppInput(
                          controller: prix,
                          label: 'lbprixprod'.tr,
                          validator: (value) {
                            return Validators.usNumeriqValid(value!);
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: kMarginY,
                        ),
                        child: TextFormField(
                          onChanged: (String value) {
                            // if (onChange != null) onChange!(value);
                          },
                          controller: description,
                          validator: (value) {
                            return value!.isEmpty
                                ? "veillez remplir se champs"
                                : null;
                          },
                          // keyboardType: type,
                          // obscureText: obscureText!,

                          maxLines: 10,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsApp.orange, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              //  borderSide : BorderSide(color:Colors.blue,width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorStyle: TextStyle(
                              fontSize: 8,
                              fontFamily: 'Montserrat',
                            ),
                            labelStyle: TextStyle(
                              color: ColorsApp.orange, fontFamily: 'Montserrat',
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
                              fontFamily: 'orkney',
                            ),
                          ),
                        ),
                      ),

                      // _controller.listImgProduits.length != 0
                      //     ? smallText(
                      //         text: 'Listes images',
                      //       )
                      //     : Container(),
                      // _controller.listImgProduits.length != 0
                      //     ? Container(
                      //         height: kSmHeight,
                      //         margin:
                      //             EdgeInsets.symmetric(vertical: kMarginY * .1),
                      //         child: ListView.builder(
                      //           itemCount: _controller.listImgProduits.length,
                      //           scrollDirection: Axis.horizontal,
                      //           itemBuilder: (_ctx, index) => ImageComp(
                      //               file: _controller.listImgProduits[index],
                      //               index: index),
                      //         ),
                      //       )
                      //     : Container(),
                      // Container(
                      //     decoration: BoxDecoration(color: ColorsApp.grey),
                      //     child: CustomBtn(
                      //       color: ColorsApp.greenLight,
                      //       title: 'Selectionner image',
                      //       onTap: () {
                      //         _controller.getImage();
                      //       },
                      //     )),
                      // Container(
                      //     decoration: BoxDecoration(color: ColorsApp.grey),
                      //     child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           // smallText(
                      //           //   text: _controller.Boutique.titre,
                      //           // ),
                      //           CustomBtn(
                      //             color: ColorsApp.greenLight,
                      //             title: _controller.addProduct
                      //                 ? 'Retour'
                      //                 : 'Ajouter Produit',
                      //             onTap: () {
                      //               _controller
                      //                   .chageState(!_controller.addProduct);
                      //             },
                      //           )
                      //         ])),
                      CustomBtn(
                        color: ColorsApp.greenLight,
                        title: 'Mettre a jour',
                        onTap: () async {
                          var data = {
                            'idProduit': produit.id,
                            'titre': titre.text,
                            'quantite': quantite.text,
                            'prixUnitaire': prix.text,
                            'description': description.text
                          };
                          print(data);
                          await _controller.updateProduit(data);
                          // _controller.chageState(!_controller.addProduct);
                        },
                      )
                    ],
                  )),
                ),
                // isScrollControlled: true,

                // barrierColor: Colors.red[50],
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                //     side: BorderSide(
                //       width: 1, /*  color: ColorsApp.greySecond */
                //     )),
                // enableDrag: false,
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
