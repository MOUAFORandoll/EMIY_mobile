import 'dart:io';

import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/commentForm.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Widget/app_bar_custom.dart';
import 'package:Fahkap/components/Widget/app_empty.dart';
import 'package:Fahkap/components/Widget/app_input.dart';
import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/components/Widget/app_short_add.dart';
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
import 'package:Fahkap/utils/Services/validators.dart';
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
                // Get.bottomSheet(
                //   Observer(
                //       builder: (_) => Container(
                //           height: kHeight,
                //           color: Colors.white,
                //           child: Stack(
                //             children: [
                //                Positioned(
                //                   top: 30,
                //                   left: 0,
                //                   child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Container(
                //                             child: IconButtonF0(
                //                           color: Colors.black,
                //                           icon: Icons.close,
                //                           onTap: () {
                //                             Get.back();
                //                           },
                //                         )),
                //                         Container(
                //                             child: Text('Ajouter votre short'))
                //                       ])),
                //             ],
                //           ))),
                //   isScrollControlled: true,
                //   isDismissible: true,
                // );
                _controller.chageStateShort(!_controller.addShoort);
              },
            )),
        _controller.addShoort
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: kMarginX),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    _controller.videoShort.length == 0
                        ? Container(child: AppShortAdd())
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final videoPlayerWidth = constraints.maxWidth;
                              final videoPlayerHeight = videoPlayerWidth /
                                  _controller
                                      .videoPlayerController.value.aspectRatio;

                              return GestureDetector(
                                onTap: _controller.playPauseVideo,
                                onDoubleTap: _controller.getVideo,
                                child: AspectRatio(
                                  aspectRatio: 4 / 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorsApp.greySecond,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: VideoPlayer(
                                        _controller.videoPlayerController),
                                  ),
                                ),
                              );
                            },
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY,
                      ),
                      child: AppInput(
                        controller: _controller.titreShort,
                        label: 'lbtitleshort'.tr,
                        validator: (value) {
                          return Validators.isValidUsername(value!);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text('Description'),
                    ),
                    TextFormField(
                      onChanged: (String value) {
                        // if (onChange != null) onChange!(value);
                      },
                      controller: _controller.descriptionShort,
                      validator: (value) {
                        return value!.isEmpty
                            ? "veillez remplir se champs"
                            : null;
                      },
                      // keyboardType: type,
                      // obscureText: obscureText!,
                      // maxLengthEnforced: false,

                      maxLines: 10,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),

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
                          color: ColorsApp.orange,
                          fontFamily: 'Montserrat',
                          // fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                        labelText: 'lbdescshort'.tr,
                        fillColor: ColorsApp.skyBlue,
                        counter: Offstage(),
                        hintText: 'lbdescshort'.tr,
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'orkney',
                        ),
                      ),
                    ),
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

                                  await _controller.addShort();
                                  // _controller.chageState(!_controller.addShoort);
                                },
                              )
                            ])),
                  ],
                )))
            : _controller.isLoadedShort == 0
                ? AppLoading()
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
      ]));
    });
  }
}
