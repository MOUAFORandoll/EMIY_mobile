import 'dart:io';

import 'package:EMIY/components/Button/AppIconButton.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/commentForm.dart';
import 'package:EMIY/components/Form/formComponent.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Widget/app_bar_custom.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_input.dart';
import 'package:EMIY/components/Widget/app_input_new.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_short_add.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Widget/imageComp.dart';
import 'package:EMIY/components/Widget/productBoutiqueComponent.dart';
import 'package:EMIY/components/Widget/shoppingproductComponent.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class ShortBoutiqueView extends StatelessWidget {
  ShortBoutiqueView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  // Initial Selected Value
  // String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: kMarginX),
            child: AppBarCustom(
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
                                    // _controller.chageState(!_controller.addProduct);
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
                                  fontFamily: 'Montserrat',
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
                                    fontFamily: 'Montserrat',
                                  ),
                                  labelStyle: TextStyle(
                                    color: ColorsApp.black,
                                    fontFamily: 'Montserrat',
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
                          ],
                        )))
                      ])),
                  isScrollControlled: true,
                  // isDismissible: true,
                );

                // _controller.chageStateShort(!_controller.addShoort);
              },
            )),
        _controller.isLoadedShort == 0
            ? AppLoading()
            : _controller.listShortBoutique.length == 0
                ? Center(child: Text('Aucun Produit'))
                : SingleChildScrollView(
                    child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _controller.listShortBoutique.length,
                    itemBuilder: (_ctx, index) {
                      return Text(_controller.listShortBoutique[index].titre);
                      /* ProductBoutiqueComponent(
                                  produit:
                                      _controller.listShortBoutique[index]); */
                    },
                  ))
      ]));
    });
  }
}
