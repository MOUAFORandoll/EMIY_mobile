import 'dart:io';

import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Widget/app_bar_custom.dart';
import 'package:EMIY/components/Widget/app_input_new.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_short_add.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/model/data/ProduitBoutiqueModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/validators.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class ShortBoutiqueView extends StatelessWidget {
  ShortBoutiqueView({Key? key}) : super(key: key);

  // Initial Selected Value
  // String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: kMarginX),
          child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            AppBarCustom(
              title: 'Vos shorts',
              titleBtn: !_controller.addShoort ? 'Ajouter' : 'Retour',
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
                      child: Column(children: [
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
                                  child: Text('Annuler'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text('Ajouter'),
                                  onPressed: () async {
                                    await _controller.addShort();
                                    // _controller.chageState(!_controller.addProduit);
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
                                controller: _controller.titreShort,
                                label: 'lbtitleshort'.tr,
                                icon: Icon(Icons.label),
                                validator: (value) {
                                  return Validators.isValidUsername(value!);
                                },
                              ),
                            ),
                            GetBuilder<BoutiqueController>(
                              builder: (_Ncontroller) => _Ncontroller
                                          .videoShort.length ==
                                      0
                                  ? Container(child: AppShortAdd())
                                  : LayoutBuilder(
                                      builder: (context, constraints) {
                                        final videoPlayerWidth =
                                            constraints.maxWidth;
                                        final videoPlayerHeight =
                                            videoPlayerWidth /
                                                _Ncontroller
                                                    .videoPlayerController
                                                    .value
                                                    .aspectRatio;

                                        return GestureDetector(
                                          onTap: _Ncontroller.playPauseVideo,
                                          onDoubleTap: _Ncontroller.getVideo,
                                          child: AspectRatio(
                                            aspectRatio: 4 / 4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ColorsApp.greySecond,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: VideoPlayer(_Ncontroller
                                                  .videoPlayerController),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            GetBuilder<BoutiqueController>(
                                builder: (_ccontroller) => Container(
                                      child: Text(
                                        '${_ccontroller.listProduitSelect.length} Produits selectionnees',
                                      ),
                                    )),
                            CustomBtn(
                                color: ColorsApp.secondBlue,
                                title: 'Selectionner Produit',
                                onTap: () async {
                                  selectProduit();
                                }),
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
                                controller: _controller.descriptionShort,
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
                          ],
                        )))
                      ])),
                  isScrollControlled: true,
                  // isDismissible: true,
                );

                // _controller.chageStateShort(!_controller.addShoort);
              },
            ),
            _controller.isLoadedShort == 0
                ? AppLoading()
                : _controller.listShortBoutique.length == 0
                    ? Center(child: Text('Aucun Produit'))
                    : SingleChildScrollView(
                        child: /* ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _controller.listShortBoutique.length,
                    itemBuilder: (_ctx, index) {
                      return Text(_controller.listShortBoutique[index].titre);
                      /* ProduitBoutiqueComponent(
                                  produit:
                                      _controller.listShortBoutique[index]); */
                    },
                  ) */

                            Container(
                        margin: EdgeInsets.only(top: kMarginY),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 1.0,
                                    mainAxisSpacing: 10.0),
                            itemCount: 40,
                            itemBuilder: (_ctx, index) => ShortComponent()),
                      ))
          ])));
    });
  }
}

selectProduit() {
  Get.bottomSheet(
    GetBuilder<BoutiqueController>(
        builder: (_controller) => Container(
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
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text('Annuler'),
                        onPressed: () {
                          Get.back(closeOverlays: true);
                        },
                      ),
                      TextButton(
                        child: Text('Terminer'),
                        onPressed: () {
                          Get.back();

                          // _controller.chageState(!_controller.addProduit);
                        },
                      )
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(top: kMarginY),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 7.0),
                    itemCount: _controller.produitBoutiqueList.length,
                    itemBuilder: (_ctx, index) => InkWell(
                        onTap: () => _controller.selectProduit(
                            _controller.produitBoutiqueList[index]),
                        child: SelectProduitForShortComponent(
                            selected: _controller.isSelected(
                                _controller.produitBoutiqueList[index]),
                            produit: _controller.produitBoutiqueList[index]))),
              )
            ])))),
    isScrollControlled: true,
    // isDismissible: true,
  );

  // _controller.chageStateShort(!_controller.addShoort);
}

class ShortComponent extends StatelessWidget {
  const ShortComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: kMdHeight / 4,
        // width: kMdWidth * 1.1,
        alignment: Alignment.center,
        // padding: EdgeInsets.all(kMarginX),
        margin: EdgeInsets.symmetric(horizontal: kMarginX / 2),
        decoration: BoxDecoration(
            color: ColorsApp.greySecond,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage('assets/logo/logoNew.png'),
              ))),
            ]));
  }
}

class SelectProduitForShortComponent extends StatelessWidget {
  ProduitBoutiqueModel produit;
  bool selected;
  SelectProduitForShortComponent(
      {required this.produit, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: kMdHeight * 2,

        // padding: EdgeInsets.all(kMarginX),
        margin: EdgeInsets.only(right: kMarginX),
        decoration: BoxDecoration(
            color: ColorsApp.greySecond,
            borderRadius: BorderRadius.circular(8)),
        child: /* SingleChildScrollView(
              child: */
            Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        height: kHeight * .12,
                        // width: Get.width * .5,
                        fit: BoxFit.cover,
                        imageUrl: produit.images[0].src,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
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
                  if (selected)
                    Positioned(
                        top: 3,
                        left: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsApp.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 50,
                          width: 50,
                        )),
                ],
              ),
              Container(
                width: kSmWidth * .6,
                margin: EdgeInsets.only(
                    top: Get.height * .005, left: Get.width * .008),
                child: Text(produit.titre,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: ColorsApp.secondBlue, fontSize: 12)),
              ),
            ]));
  }
}
