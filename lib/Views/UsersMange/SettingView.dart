// ignore_for_file: must_be_immutable

import 'package:EMIY/components/Button/uploadImage.dart';
import 'package:EMIY/components/Widget/app_input_new.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:EMIY/components/Widget/settingComponent.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/Services/validators.dart';

class SettingView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.google.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.google.com/'));
  // final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.bg,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: ColorsApp.bg,
              automaticallyImplyLeading: false,
              title: Text(
                'setting'.tr,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600),
              ),
              leading: Container(
                  child: InkWell(
                child: Container(
                  margin: EdgeInsets.zero,
                  // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(

                      // borderRadius: BorderRadius.circular(20),
                      ),
                  child: Icon(Icons.arrow_back_ios_new,
                      color: ColorsApp.black, size: 25.0),
                ),
                onTap: () {
                  Get.back();
                },
              )),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                    margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        SettingComponent(
                            title: 'Sombre',
                            action: GetBuilder<GeneralController>(
                                builder: (actionControl) => Switch(
                                    value: actionControl.dark,
                                    onChanged: (val) {
                                      actionControl.changeTheme();
                                    })),
                            onTap: () {}),
                        SettingComponent(
                            title: "Langue de l'application",
                            action: Container(
                              // width: kSmWidth * .6,
                              // margin: EdgeInsets.only(
                              //     top: Get.height * .005,
                              //     left: Get.width * .008),
                              height: 1500,
                              child: GetBuilder<GeneralController>(
                                builder: (actionControl) =>
                                    DropdownButton<String>(
                                        value: actionControl.lang.value,
                                        icon: Container(
                                          // padding: EdgeInsets.only(top: 4),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Color(0xff1A90FF),
                                          ),
                                        ),
                                        iconSize: 25,
                                        underline: SizedBox(),
                                        style: TextStyle(
                                            color: Color(
                                              0xff1A90FF,
                                            ),
                                            fontSize: 20),
                                        onChanged: (newValue) {
                                          actionControl
                                              .updateLanguage(newValue ?? '');
                                        },
                                        items: <String>[
                                          ...actionControl.locale
                                              .map((e) => e['name'])
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Center(
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  color: Color(0xff1A90FF),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList()),
                              ),
                            ),
                            onTap: () {}),
                        GetBuilder<BoutiqueController>(
                            builder: (_controller) => SettingComponent(
                                title: 'Creer une boutique',
                                action: InkWell(
                                    child:
                                        Icon(Icons.arrow_forward_ios_outlined)),
                                onTap: () {
                                  Get.find<BoutiqueController>().getCategory();
                                  Get.bottomSheet(
                                    GetBuilder<BoutiqueController>(
                                        builder: (_bcontroller) => Container(
                                            margin: EdgeInsets.only(
                                              top: kMarginY * 8,
                                            ),
                                            decoration: BoxDecoration(
                                                color: ColorsApp.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                            height: 800,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: kMarginX),
                                            child: Column(children: [
                                              // _controller.listImgProduits.length != 0
                                              //     ? smallText(
                                              //         text: 'Listes images',
                                              //       )
                                              //     : Container(),
                                              Container(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton(
                                                        child: Text('Annuler'),
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Creer'),
                                                        onPressed: () async {
                                                          await _controller
                                                              .newBoutique();
                                                          // _controller.chageState(!_controller.addProduit);
                                                        },
                                                      )
                                                    ]),
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                    child: Column(children: [
                                                  Text(
                                                    "Creer votre boutique !",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: kMarginY * 1.5,
                                                    ),
                                                    child: AppInputNew(
                                                      controller:
                                                          _controller.name,
                                                      icon: Icon(Icons.label),
                                                      label: 'Titre'.tr,
                                                      validator: (value) {
                                                        return Validators
                                                            .isValidUsername(
                                                                value!);
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Text('Categorie',
                                                        style: TextStyle(
                                                          color: ColorsApp
                                                              .secondBlue,
                                                        )),
                                                  ),
                                                  _controller.isLoadedC == 0
                                                      ? CircularProgressIndicator(
                                                          color:
                                                              Colors.blueAccent,
                                                        )
                                                      : Container(
                                                          width: Get.width,
                                                          // margin:
                                                          //     EdgeInsets.symmetric(vertical: 5),
                                                          padding:
                                                              EdgeInsets.only(
                                                            left:
                                                                Get.width * .08,
                                                            right:
                                                                Get.width * .08,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: ColorsApp
                                                                  .skyBlue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: ButtonTheme(
                                                              alignedDropdown:
                                                                  true,
                                                              child:
                                                                  DropdownButton(
                                                                // Initial Value
                                                                value: _bcontroller
                                                                    .categorySelect,
                                                                // Down Arrow Icon
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),

                                                                // Array list of items
                                                                items: _bcontroller
                                                                    .categoryList
                                                                    .map(
                                                                        (item) {
                                                                  return DropdownMenuItem(
                                                                    value: item,
                                                                    child: Text(
                                                                        item.libelle),
                                                                  );
                                                                }).toList(),
                                                                // After selecting the desired option,it will
                                                                // change button value to selected value
                                                                onChanged:
                                                                    (newValue) {
                                                                  _bcontroller
                                                                      .secelctCate(
                                                                          newValue);
                                                                  // setState(() {
                                                                  //   dropdownvalue = newValue!;
                                                                  // });
                                                                },
                                                              ))),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Text(
                                                        'Localisation : Ou se trouve votre boutique ?',
                                                        style: TextStyle(
                                                          color: ColorsApp
                                                              .secondBlue,
                                                        )),
                                                  ),
                                                  InkWell(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  Get.height *
                                                                      .02),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: ColorsApp
                                                                  .greySecond),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                'Mon Emplacement actuel',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Icon(Icons
                                                                  .location_pin)
                                                            ],
                                                          )),
                                                      onTap: () {
                                                        _controller.getLocalU();
                                                      }),
                                                  GetBuilder<
                                                          BoutiqueController>(
                                                      builder: (_Ncontroller) =>
                                                          _Ncontroller.isImage
                                                              ? Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              5),
                                                                  height:
                                                                      kMdHeight *
                                                                          .3,
                                                                  width:
                                                                      Get.width,
                                                                  child: Image
                                                                      .file(
                                                                    _controller
                                                                        .boutiqueImage,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                )
                                                              : Container()),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                        top: kMarginY,
                                                      ),
                                                      // decoration: BoxDecoration(color: ColorsApp.grey),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          UploadImage(
                                                            color: ColorsApp
                                                                .skyBlue,
                                                            title:
                                                                'Appareil photo',
                                                            icon: Icons
                                                                .camera_alt,
                                                            onTap: () {
                                                              _controller
                                                                  .getImageBoutiqueCamera();
                                                            },
                                                          ),
                                                          UploadImage(
                                                            color: ColorsApp
                                                                .skyBlue,
                                                            icon: Icons.photo,
                                                            title: 'Galerie',
                                                            onTap: () {
                                                              _controller
                                                                  .getImageBoutiqueGallery();
                                                            },
                                                          )
                                                        ],
                                                      )),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: kMarginY,
                                                    ),
                                                    decoration: new BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: ColorsApp
                                                                .greySecond)
                                                        // color: (color == null) ? ColorsApp.blue : color,
                                                        ),
                                                    child: TextFormField(
                                                      controller: _controller
                                                          .descriptionBoutique,
                                                      onChanged:
                                                          (String value) {},
                                                      validator: (value) {
                                                        return Validators
                                                            .isValidUsername(
                                                                value!);
                                                      },
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        fontFamily: 'Lato',
                                                      ),
                                                      maxLines: 10,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: ColorsApp
                                                                  .skyBlue,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: ColorsApp
                                                                  .greySearch),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorStyle: TextStyle(
                                                          fontSize: 8,
                                                          fontFamily: 'Lato',
                                                        ),
                                                        labelStyle: TextStyle(
                                                          color:
                                                              ColorsApp.black,
                                                          fontFamily: 'Lato',
                                                          // fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                        labelText:
                                                            'parlez nous de votre boutique'
                                                                .tr,
                                                        fillColor:
                                                            ColorsApp.skyBlue,
                                                        counter: Offstage(),
                                                        hintText:
                                                            'parlez nous de votre boutique'
                                                                .tr,
                                                        alignLabelWithHint:
                                                            true,
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              ColorsApp.grey),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
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
                                                ])),
                                              )
                                            ]))),
                                    isScrollControlled: true,
                                    // isDismissible: true,
                                  );

                                  // Get.toNamed(AppLinks.BOUTIQUE_NEW);
                                })),
                        SettingComponent(
                            title: 'Payer loyer boutique',
                            action: InkWell(
                                child: Icon(Icons.arrow_forward_ios_outlined)),
                            onTap: () {
                              ViewFunctions().showIndisponible();
                              // Get.toNamed(AppLinks.BOUTIQUE_LOYER);
                            }),
                        SettingComponent(
                            title: 'Politique de confidentialite',
                            action: InkWell(
                              child: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                    margin: EdgeInsets.only(
                                      top: kMarginY * 6,
                                    ),
                                    decoration: BoxDecoration(
                                        color: ColorsApp.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    height: 800,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kMarginX,
                                        vertical: kMarginY),
                                    child: Stack(children: [
                                      // WebView(
                                      //   initialUrl: 'www.google.cm',
                                      //   javascriptMode: JavascriptMode.unrestricted,
                                      //   onPageStarted: (String url) {},
                                      //   onPageFinished: (String url) {},
                                      // ),
                                      WebViewWidget(controller: controller),
                                    ])),
                                isScrollControlled: true,
                              );
                              // Get.toNamed(AppLinks.POLITIQUE);
                            }),
                        SettingComponent(
                            title: "Aide et assistance",
                            action: InkWell(
                              child: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            onTap: () {
                              ViewFunctions().showIndisponible();
                              // Get.toNamed(AppLinks.HELP);
                            }),
                      ],
                    )),
                childCount: 1,
              ),
            ),
          ],
        ));
  }
}
