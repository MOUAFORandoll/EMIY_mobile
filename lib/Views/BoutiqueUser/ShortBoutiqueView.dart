import 'dart:io';

import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/commentForm.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/imageComp.dart';
import 'package:Fahkap/components/Widget/productBoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class ShortBoutiqueView extends StatelessWidget {
  ShortBoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  TextEditingController name = TextEditingController();
  TextEditingController titre = TextEditingController();
  TextEditingController quantite = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController description = TextEditingController();
  // Initial Selected Value
  // String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onTap: () => Get.back()),
            title: Text(
              'Short',
              style: TextStyle(color: Colors.black),
            ),
            actions: [],
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            // Container(
            //   decoration: BoxDecoration(color: ColorsApp.grey),
            //   padding: EdgeInsets.only(
            //       left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
            //   alignment: Alignment.topLeft,
            //   child: smallText(
            //     text: 'Nom Boutique',
            //   ),
            // ),
            Container(
                decoration: BoxDecoration(color: ColorsApp.grey),
                padding: EdgeInsets.only(
                    left: kMdWidth / 6, right: kMdWidth / 6, top: 6, bottom: 6),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      smallText(
                        text: !_controller.addShoort ? 'Liste' : 'Nouveau',
                      ),
/*                       _controller.categoryList.length != 0
                          ? */
                      CustomBtn(
                        color: ColorsApp.greenLight,
                        title:
                            _controller.addShoort ? 'Retour' : 'Ajouter Short',
                        onTap: () {
                          _controller.chageStateShort(!_controller.addShoort);
                        },
                      ) /* 
                          : Container() */
                    ])),
            !_controller.addShoort
                ? _controller.isLoadedShort == 0
                    ? Shimmer.fromColors(
                        baseColor: Colors.blueGrey,
                        highlightColor: Colors.greenAccent,
                        child: Container(
                            // margin: EdgeInsets.symmetric(horizontal: kMarginX),
                            child: SingleChildScrollView(
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (_ctx, index) => Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: kMdHeight / 9,
                                                  // width: kMdWidth,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: kMarginX,
                                                      vertical: kMarginY),
                                                  width: Get.width / 3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8)),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/error.gif"),
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Colors.blue,
                                                                BlendMode
                                                                    .colorBurn)),
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: kMarginX,
                                                      vertical: kMarginY),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        // width: kSmWidth * .6,

                                                        child: Text('Nom : ',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: ColorsApp
                                                                    .greenLight,
                                                                fontSize: 12)),
                                                      ),
                                                    ],
                                                  ))
                                            ])))))
                    : _controller.listShortBoutique.length == 0
                        ? Center(child: Text('Aucun Produit'))
                        : SingleChildScrollView(
                            child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _controller.listShortBoutique.length,
                            itemBuilder: (_ctx, index) {
                              return Text(
                                  _controller.listShortBoutique[index].titre);
                              /* ProductBoutiqueComponent(
                                  produit:
                                      _controller.listShortBoutique[index]); */
                            },
                          ))
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        FormComponent2(
                            icon: Icons.account_circle,
                            type: 0,
                            controller: titre,
                            enabled: true,
                            titre: 'Titre',
                            hint: "Iphone 11"),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text('Description'),
                        ),
                        TextFormField(
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
                          maxLengthEnforced: false,
                          maxLength: 10,
                          maxLines: 10,
                          decoration: new InputDecoration(
                            fillColor: ColorsApp.skyBlue,
                            counter: Offstage(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: ColorsApp.bleuLight,
                                )),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(
                            //     color: ColorsApp.skyBlue,
                            //   ),
                            // ),
                            contentPadding: EdgeInsets.only(
                              left: 12,
                              bottom: 10,
                              top: 10,
                              right: 12,
                            ),
                            hintText: 'Entrer une description',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'orkney',
                            ),
                            // suffixIcon: InkWell(
                            //   onTap: () => onTap,
                            //   child: Icon(
                            //     icon,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                          ),
                        ),
                        // _controller.listImgProduits.length != 0
                        //     ? smallText(
                        //         text: 'Listes images',
                        //       )
                        //     : Container(),
                        // _controller.listImgProduits.length != 0
                        //     ? Container(
                        //         height: kSmHeight * 2,
                        //         margin: EdgeInsets.symmetric(
                        //             vertical: kMarginY * .1),
                        //         child: ListView.builder(
                        //           itemCount: _controller.listImgProduits.length,
                        //           scrollDirection: Axis.horizontal,
                        //           itemBuilder: (_ctx, index) =>
                        //               _controller.listImgProduits[index] != null
                        //                   ? ImageComp(
                        //                       file: _controller
                        //                           .listImgProduits[index],
                        //                       index: index)
                        //                   : Container(),
                        //         ),
                        //       )
                        //     : Container(),
                        Container(
                            decoration: BoxDecoration(color: ColorsApp.grey),
                            child: CustomBtn(
                              color: ColorsApp.greenLight,
                              title: 'Selectionner video',
                              onTap: () {
                                _controller.getVideo();
                              },
                            )),
                        Container(
                            decoration: BoxDecoration(color: ColorsApp.grey),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // smallText(
                                  //   text: _controller.Boutique.titre,
                                  // ),
                                  CustomBtn(
                                    color: ColorsApp.greenLight,
                                    title: 'Ajouter Short',
                                    onTap: () async {
                                      // var key = await _controller.s.getKey();
                                      Map<String, Object> dataS = {
                                        // 'keySecret': key,
                                        'titre': titre.text,
                                        'description': description.text,
                                        'codeBoutique':
                                            _controller.Boutique.codeBoutique,
                                      };

                                      _controller.videoShort.forEach((e) {
                                        dataS.addAll({
                                          "file": MultipartFile(
                                            e.path,
                                            filename: "video.mp4",
                                          )
                                        });
                                      });
                                      FormData data = new FormData(dataS);

                                      await _controller.addShort(data);
                                      // _controller.chageState(!_controller.addShoort);
                                    },
                                  )
                                ])),
                      ],
                    ))),
          ])));
    });
  }
}
