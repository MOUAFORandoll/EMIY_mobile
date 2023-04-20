// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Button/themeButton.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/infoComponent.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:flutter/material.dart';

import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class ManageBoutiqueUserView extends StatefulWidget {
  const ManageBoutiqueUserView({Key? key}) : super(key: key);

  @override
  _ManageBoutiqueUserViewState createState() => _ManageBoutiqueUserViewState();
}

class _ManageBoutiqueUserViewState extends State<ManageBoutiqueUserView> {
  @override
  void initState() {
    super.initState();
  }

  bool ok = false;
  GetStorage box = GetStorage();
  @override
  void dispose() {
    super.dispose();
  }

  ScrollController _scrollController = new ScrollController();

  bool imgBool = true;
  TextEditingController titre = TextEditingController();
  TextEditingController description = TextEditingController();
  bool udateAdd = false;
  bool udatePass = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // ignore: unnecessary_null_comparison

    return GetBuilder<BoutiqueController>(builder: (_controller) {
      // if (_controller.Boutique != null) {
      //   titre.text = _controller.Boutique.titre;
      //   description.text = _controller.Boutique.description.toString();
      // }
      return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onTap: () => Get.back()),
            title: Text(
              'Gerer votre boutique',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              // InkWell(
              //   child: Icon(Icons.search, color: Colors.red),
              // )
            ],
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: CustomScrollView(controller: _scrollController, slivers: [
            // Add the app bar to the CustomScrollView.
            SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => _controller.isLoaded == 0
                  ? Shimmer.fromColors(
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.greenAccent,
                      child: Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Column(children: <Widget>[
                            InfoComponent(title: Text("Titre"), value: ''),
                            InfoComponent(
                                title: Text("Description"), value: ''),
                            // InfoComponent(
                            //     title: Text("Phone number"), value: ''),
                            // InfoComponent(title: Text("Email"), value: ''),
                            // InfoComponent(
                            //   title: Row(children: [
                            //     Text("Password"),
                            //     // Container(
                            //     //     child: Icon(FontAwesomeIcons.pen,
                            //     //         size: 12, color: Color(0xFFCFD6D6)),
                            //     //     margin: EdgeInsets.only(left: 10))
                            //   ]),
                            //   value: "*****",
                            // ),
                            CustomBtn(
                              color: ColorsApp.greenLight,
                              title: 'Mettre a jour',
                              onTap: () async {},
                            )
                          ])))
                  : Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(children: <Widget>[
                        InkWell(
                            onTap: () => _controller.updateImageBoutique(),
                            child: Container(
                              child: CachedNetworkImage(
                                height: kMdHeight * .3,
                                width: Get.width,
                                fit: BoxFit.cover,
                                imageUrl: _controller
                                    .Boutique
                                    .images[
                                        _controller.Boutique.images.length - 1]
                                    .src,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: ColorsApp.greySecond,
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.transparent,
                                              BlendMode.colorBurn)),
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
                                  return Container(
                                      height: kMdHeight * .15,
                                      width: Get.width * .5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage('assets/logo.png'),
                                      )));
                                },
                              ),
                            )),

                        InfoComponent(
                            title: Text("Titre"),
                            value: _controller.Boutique.titre),

                        // Container(
                        //     alignment: Alignment.topLeft,
                        //     child: Text("Information localisation :")),
                        InfoComponent(
                          title: Text("Ville"),
                          value: _controller.Boutique.localisation.ville,
                        ),

                        Container(
                            alignment: Alignment.topLeft,
                            child: Text("Description")),
                        Container(
                            // height: kMdHeight * .3,
                            alignment: Alignment.topLeft,
                            child: Text(
                              _controller.Boutique.description,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            )),
                        // InfoComponent(
                        //     title: Text("Email"), value: _controller.User.email),
                        // InfoComponent(
                        //   title: Row(children: [
                        //     Text("Adress"),
                        //     Container(
                        //         child: Icon(FontAwesomeIcons.pen,
                        //             size: 12, color: Color(0xFFCFD6D6)),
                        //         margin: EdgeInsets.only(left: 10))
                        //   ]),
                        //   value: "addresse",
                        // ),
                        // InfoComponent(
                        //   title: Row(children: [
                        //     Text("Password"),
                        //     // Container(
                        //     //     child: Icon(FontAwesomeIcons.pen,
                        //     //         size: 12, color: Color(0xFFCFD6D6)),
                        //     //     margin: EdgeInsets.only(left: 10))
                        //   ]),
                        //   value: "*****",
                        // ),
                        CustomBtn(
                          color: ColorsApp.greenLight,
                          title: 'Mettre a jour',
                          onTap: () async {
                            Get.bottomSheet(
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kSmWidth * .07,
                                    vertical: kSmHeight * .09),
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
                                    FormComponent2(
                                        icon: Icons.account_circle,
                                        type: 0,
                                        controller: titre,
                                        enabled: true,
                                        titre: 'Nom',
                                        hint: ""),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text('Description'),
                                    ),
                                    TextFormField(
                                      controller: description,

                                      // keyboardType: type,
                                      // obscureText: obscureText!,
                                      // maxLengthEnforced: false,
                                      maxLength: 10,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                      child: Text('Localisation'),
                                    ),
                                    InkWell(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: Get.height * .05,
                                                left: Get.width * .01,
                                                right: Get.width * .01,
                                                bottom: Get.height * .009),
                                            padding: EdgeInsets.all(
                                                Get.height * .02),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: ColorsApp.bleuLight),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Mon Emplacement actuel',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Icon(Icons.location_pin)
                                              ],
                                            )),
                                        onTap: () {
                                          _controller
                                              .updateLocalisationBoutique();
                                        }),
                                    // FormComponent2(
                                    //     icon: Icons.account_circle,
                                    //     type: 0,
                                    //     controller: phone,
                                    //     kType: TextInputType.number,
                                    //     enabled: true,
                                    //     titre: 'phone',
                                    //     hint: " "),
                                    // // FormComponent2(
                                    // //     icon: Icons.account_circle,
                                    // //     type: 0,
                                    // //     controller: adresse,
                                    // //     // kType: TextInputType.number,
                                    // //     enabled: true,
                                    // //     titre: 'adresse',
                                    // //     hint: " "),
                                    // FormComponent2(
                                    //     icon: Icons.account_circle,
                                    //     type: 0,
                                    //     controller: email,
                                    //     // kType: TextInputType.number,
                                    //     enabled: true,
                                    //     titre: 'email',
                                    //     hint: " "),
                                    CustomBtn(
                                        color: ColorsApp.greenLight,
                                        title: 'Mettre a jour',
                                        onTap: () async {
                                          var data = {
                                            'keySecret': new GetStorage()
                                                .read('keySecret'),
                                            'titre': titre.text,

                                            'description':
                                                description.text.isEmpty,
                                            'codeBoutique': _controller
                                                .Boutique.codeBoutique,
                                            // 'email': email.text,
                                          };
                                          print(data);
                                          await _controller
                                              .updateBoutique(data);
                                        })
                                  ],
                                )),
                              ),
                            );
                          },
                        )
                      ])),

              childCount: 1,
            ))
          ]));
    });
  }
  // Builds 1000 ListTiles

}
