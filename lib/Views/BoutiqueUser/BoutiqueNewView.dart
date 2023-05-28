import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Button/themeButton.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';

import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';

class BoutiqueNewView extends StatefulWidget {
  BoutiqueNewView({Key? key}) : super(key: key);

  @override
  _BoutiqueNewViewState createState() => _BoutiqueNewViewState();
}

class _BoutiqueNewViewState extends State<BoutiqueNewView> {
  TextEditingController titre = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validator = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Scaffold(
          body: CustomScrollView(
              // controller: _scrollController,
              slivers: [
            // Add the app bar to the CustomScrollView.
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.zero,
                      // padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(

                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 25.0),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              )),
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      decoration: BoxDecoration(
                        gradient: GradientApp.blueG,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: kMdHeight * .08,
                                width: kMdWidth * 1.2,
                                // margin: EdgeInsets.symmetric(
                                //     horizontal: kMarginX * 10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  //  Border.all(color: borderColor),
                                  color: Colors.white,

                                  // gradient: GradientApp.blueG,
                                ),
                                child: Text(
                                  'Boutique'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ]))),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 2, bottom: 3),
                                  height: 3,
                                  width: kMdWidth * .5,
                                  decoration: BoxDecoration(
                                      gradient: GradientApp.blueG,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Container())
                            ])
                      ])),
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  width: double.maxFinite,
                ),
              ),
              expandedHeight: 120,
              pinned: true,
            ),
            SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(children: [
                    SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Creer votre boutique !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: Get.size.height * .02,
                                  bottom: Get.size.height * .025),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  FormComponent(
                                      icon: Icons.stairs,
                                      type: 0,
                                      controller: titre,
                                      enabled: true,
                                      hint: "Titre"),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Text('Categorie',
                                        style: TextStyle(
                                          color: ColorsApp.bleuLight,
                                        )),
                                  ),
                                  _controller.isLoadedC == 0
                                      ? CircularProgressIndicator(
                                          color: Colors.blueAccent,
                                        )
                                      : Container(
                                          width: Get.width,
                                          // margin:
                                          //     EdgeInsets.symmetric(vertical: 5),
                                          padding: EdgeInsets.only(
                                            left: Get.width * .08,
                                            right: Get.width * .08,
                                          ),
                                          decoration: BoxDecoration(
                                              color: ColorsApp.skyBlue,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton(
                                                // Initial Value
                                                value:
                                                    _controller.categorySelect,
                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),

                                                // Array list of items
                                                items: _controller.categoryList
                                                    .map((item) {
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item.libelle),
                                                  );
                                                }).toList(),
                                                // After selecting the desired option,it will
                                                // change button value to selected value
                                                onChanged: (newValue) {
                                                  _controller
                                                      .secelctCate(newValue);
                                                  // setState(() {
                                                  //   dropdownvalue = newValue!;
                                                  // });
                                                },
                                              ))),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Text('Description',
                                        style: TextStyle(
                                          color: ColorsApp.bleuLight,
                                        )),
                                  ),
                                  TextFormField(
                                    controller: description,

                                    // keyboardType: type,
                                    // obscureText: obscureText!,
                                    // maxLengthEnforced: false,

                                    maxLines: 10,
                                    decoration: new InputDecoration(
                                      fillColor: ColorsApp.skyBlue,
                                      // counter: Offstage(),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: ColorsApp.skyBlue,
                                          )),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: ColorsApp.skyBlue,
                                        ),
                                      ),
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
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Text('Localisation',
                                        style: TextStyle(
                                          color: ColorsApp.bleuLight,
                                        )),
                                  ),
                                  InkWell(
                                      child: Container(
                                          padding:
                                              EdgeInsets.all(Get.height * .02),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: ColorsApp.skyBlue),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Mon Emplacement actuel',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Icon(Icons.location_pin)
                                            ],
                                          )),
                                      onTap: () {
                                        _controller.getLocalU();
                                      }),
                                ],
                              )),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text('Couverture',
                                style: TextStyle(
                                  color: ColorsApp.bleuLight,
                                )),
                          ),
                          InkWell(
                              onTap: () => _controller.getImageBoutiqueGallery(),
                              child: !_controller.isImage
                                  ? Container(
                                      height: kMdHeight * .3,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          gradient: GradientApp.blueG,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Icon(
                                        Icons.add,
                                        size: 50,
                                        color: Colors.white,
                                      ))
                                  : Container(
                                      margin: EdgeInsets.only(right: 5),
                                      height: kMdHeight * .3,
                                      width: Get.width,
                                      child: Image.file(
                                        _controller.boutiqueImage,
                                        fit: BoxFit.cover,
                                      ),
                                    )),

                          Button(
                              borderRadius: 15.0,
                              width: Get.size.height * .8,
                              margin: EdgeInsets.only(
                                top: Get.size.height * .025,
                                bottom: Get.size.height * .025,
                              ),
                              height: Get.size.height * .08,
                              loaderColor: Colors.white,
                              title: "Creer",
                              textColor: Colors.white,
                              itemColor: Colors.blue,
                              borderColor: Colors.transparent,
                              state: validator,
                              enabled: true,
                              onTap: () async {
                                var data = {
                                  'titre': titre.text,

                                  'description': description.text,
                                  'category': _controller.categorySelect.id,
                                  // 'email': email.text,
                                };
                                await _controller.newBoutique( );
                                if (_controller.isOk) {
                                  // Get.offNamedUntil(AppLinks.FIRST, (route) => false);
                                }
                              }),
                          // Center(
                          //   child: TextButton(
                          //     style: ButtonStyle(alignment: Alignment.center),
                          //     child: Text('recuperer boutique ?'),
                          //     onPressed: () {
                          //       Get.toNamed(AppLinks.FORGOT);
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ))
                  ])),
              childCount: 1,
            ))
          ]));
    });
  }
}
