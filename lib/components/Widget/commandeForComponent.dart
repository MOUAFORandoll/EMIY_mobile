// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Form/commentForm.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/CommandeBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommandeBoutiqueComponent extends StatelessWidget {
  CommandeBoutiqueModel commande;
  var height;

  CommandeBoutiqueComponent({required this.commande, this.height});

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
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Stack(
        children: [
          InkWell(
            child: Container(
                height: kMdHeight / 6,
                // width: kMdWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: kMarginX, vertical: kMarginY),
                decoration: BoxDecoration(
                    color: ColorsApp.skyBlue,
                    borderRadius: BorderRadius.circular(8)),
                child: /* SingleChildScrollView(
              child: */
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Container(
                          child: CachedNetworkImage(
                        height: kMdHeight / 6,
                        width: Get.width / 3,
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
                                      Colors.red, BlendMode.colorBurn)),
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

                                child: Text('Nom : ' + commande.titre,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorsApp.greenLight,
                                        fontSize: 12)),
                              ),
                              Container(
                                child: Text(
                                    'Prix : ' +
                                        commande.prix.toString() +
                                        ' XAF',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                child: Text(
                                    'Quantite : ' +
                                        commande.quantite.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                child: Text('Code : ' + commande.codeCommande,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                child: Text('Date : ' + commande.date,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
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
                          )),
                    ]) /* ) */),
            onTap: () {
              // Get.bottomSheet(
              //   Container(
              //     padding: EdgeInsets.symmetric(horizontal: kSmWidth * .07),
              //     // height: 800,
              //     color: ColorsApp.grey,
              //     child: SingleChildScrollView(
              //         child: Column(
              //       // mainAxisSize: MainAxisSize.min,
              //       children: [
              //         FormComponent2(
              //             icon: Icons.account_circle,
              //             type: 0,
              //             controller: titre,
              //             enabled: true,
              //             titre: 'Nom du commande',
              //             hint: "Iphone 11"),
              //         FormComponent2(
              //             icon: Icons.account_circle,
              //             type: 0,
              //             controller: quantite,
              //             enabled: true,
              //             titre: 'Quantite',
              //             kType: TextInputType.number,
              //             hint: "10"),
              //         FormComponent2(
              //             icon: Icons.account_circle,
              //             type: 0,
              //             controller: prix,
              //             kType: TextInputType.number,
              //             enabled: true,
              //             titre: 'Prix',
              //             hint: "1500"),
              //         // CommentForm(
              //         //   titre: 'Description',
              //         //   controller: description,
              //         //   width: kMdWidth * 4,
              //         // ),
              //         Container(
              //           alignment: Alignment.topLeft,
              //           margin: EdgeInsets.symmetric(vertical: 5),
              //           child: Text('Description'),
              //         ),
              //         TextFormField(
              //           onChanged: (String value) {
              //             // if (onChange != null) onChange!(value);
              //           },
              //           controller: description,
              //           validator: (value) {
              //             return value!.isEmpty
              //                 ? "veillez remplir se champs"
              //                 : null;
              //           },
              //           // keyboardType: type,
              //           // obscureText: obscureText!,
              //           maxLengthEnforced: false,
              //           maxLength: 10,
              //           maxLines: 10,
              //           decoration: new InputDecoration(
              //             fillColor: ColorsApp.skyBlue,
              //             counter: Offstage(),
              //             focusedBorder: OutlineInputBorder(
              //                 borderRadius: BorderRadius.circular(10.0),
              //                 borderSide: BorderSide(
              //                   color: ColorsApp.grey,
              //                 )),
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10),
              //               borderSide: BorderSide(
              //                 color: Colors.black.withOpacity(.4),
              //               ),
              //             ),
              //             contentPadding: EdgeInsets.only(
              //               left: 12,
              //               bottom: 10,
              //               top: 10,
              //               right: 12,
              //             ),
              //             hintText: 'Entrer une description',
              //             hintStyle: TextStyle(
              //               color: Colors.grey,
              //               fontFamily: 'orkney',
              //             ),
              //             // suffixIcon: InkWell(
              //             //   onTap: () => onTap,
              //             //   child: Icon(
              //             //     icon,
              //             //     color: Colors.grey,
              //             //   ),
              //             // ),
              //           ),
              //         ),

              //         // _controller.listImgcommandes.length != 0
              //         //     ? smallText(
              //         //         text: 'Listes images',
              //         //       )
              //         //     : Container(),
              //         // _controller.listImgcommandes.length != 0
              //         //     ? Container(
              //         //         height: kSmHeight,
              //         //         margin:
              //         //             EdgeInsets.symmetric(vertical: kMarginY * .1),
              //         //         child: ListView.builder(
              //         //           itemCount: _controller.listImgcommandes.length,
              //         //           scrollDirection: Axis.horizontal,
              //         //           itemBuilder: (_ctx, index) => ImageComp(
              //         //               file: _controller.listImgcommandes[index],
              //         //               index: index),
              //         //         ),
              //         //       )
              //         //     : Container(),
              //         // Container(
              //         //     decoration: BoxDecoration(color: ColorsApp.grey),
              //         //     child: CustomBtn(
              //         //       color: ColorsApp.greenLight,
              //         //       title: 'Selectionner image',
              //         //       onTap: () {
              //         //         _controller.getImage();
              //         //       },
              //         //     )),
              //         // Container(
              //         //     decoration: BoxDecoration(color: ColorsApp.grey),
              //         //     child: Row(
              //         //         mainAxisAlignment: MainAxisAlignment.end,
              //         //         children: [
              //         //           // smallText(
              //         //           //   text: _controller.Boutique.titre,
              //         //           // ),
              //         //           CustomBtn(
              //         //             color: ColorsApp.greenLight,
              //         //             title: _controller.addProduct
              //         //                 ? 'Retour'
              //         //                 : 'Ajouter commande',
              //         //             onTap: () {
              //         //               _controller
              //         //                   .chageState(!_controller.addProduct);
              //         //             },
              //         //           )
              //         //         ])),
              //         CustomBtn(
              //           color: ColorsApp.greenLight,
              //           title: 'Update',
              //           onTap: () async {
              //             var data = {
              //               'idcommande': commande.id,
              //               'titre': titre.text,
              //               'quantite': quantite.text,
              //               'prixUnitaire': prix.text,
              //               'description': description.text
              //             };
              //             print(data);
              //             await _controller.updatecommande(data);
              //             // _controller.chageState(!_controller.addProduct);
              //           },
              //         )
              //       ],
              //     )),
              //   ),
              //    );
            },
          ),
          // Positioned(
          //     left: Get.width * .88,
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
