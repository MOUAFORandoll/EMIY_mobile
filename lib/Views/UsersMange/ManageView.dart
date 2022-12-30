import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fahkapmobile/Views/Boutique/BoutiqueView.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Widget/infoComponent.dart';
// import 'package:fahkapmobile/components/informationComponent.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';
import 'package:fahkapmobile/utils/provider/refresh_token.dart';

// ignore: must_be_immutable
class ManageView extends StatefulWidget {
  var accessToken;
  ManageView({this.accessToken});
  @override
  _ManageViewState createState() => _ManageViewState();
}

class _ManageViewState extends State<ManageView> {
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
  File images = File("");
/* 
  member membre = member(numCni: "0", cniRep: "");
  */
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _newpasswordController = TextEditingController();
  bool udateAdd = false;
  bool udatePass = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<ManagerController>(
        builder:
            (_manager) =>
                CustomScrollView(controller: _scrollController, slivers: [
                  // Add the app bar to the CustomScrollView.
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    // Provide a standard title.
                    // title: Text('title'),
                    // Allows the user to reveal the app bar if they begin scrolling
                    // back up the list of items.
                    floating: true,
                    // Display a placeholder widget to visualize the shrinking size.
                    flexibleSpace: InkWell(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: BigText(
                                        text: "Profile image",
                                        bolder: _manager.state),
                                    onTap: () => _manager.chageState(true),
                                  ),
                                  GetBuilder<BoutiqueController>(
                                      builder: (_controller) => _controller
                                                  .isLoaded ==
                                              1
                                          ? _controller.isExist
                                              ? InkWell(
                                                  child: BigText(
                                                      text: "Boutique",
                                                      bolder: !_manager.state),
                                                  onTap: () => _manager
                                                      .chageState(false),
                                                )
                                              : Container()
                                          : _controller.isLoaded == 2
                                              ? Container()
                                              : Container(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: ColorsApp.bleuLight,
                                                ))),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                top: Get.height * .030,
                                // left: kMarginX,
                                // right: kMarginX,
                              )),
                        ]),
                      ),
                      /*   onTap: () => filterDest() */
                    ),
                    // Make the initial height of the SliverAppBar larger than normal.
                    expandedHeight: 60,
                  ),
                  SliverList(
                      // Use a delegate to build items as they're scrolled on screen.
                      delegate: SliverChildBuilderDelegate(
                    // The builder function returns a ListTile with a title that
                    // displays the index of the current item.
                    (context, index) => _manager.state
                        ? Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Column(children: <Widget>[
                              InfoComponent(
                                  title: Text("First name"), value: "Nom"),
                              InfoComponent(
                                  title: Text("Last name"), value: "Prenom"),
                              InfoComponent(
                                  title: Text("Phone number"), value: "Aucun"),
                              InfoComponent(
                                  title: Row(children: [
                                    Text("Adress"),
                                    Container(
                                        child: Icon(FontAwesomeIcons.pen,
                                            size: 12, color: Color(0xFFCFD6D6)),
                                        margin: EdgeInsets.only(left: 10))
                                  ]),
                                  value: "addresse",
                                  onTap: () {
                                    print("eeeeeeeeee");
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            StatefulBuilder(
                                              builder: (BuildContext context,
                                                      StateSetter setState) =>
                                                  Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)), //this right here
                                                child: Container(
                                                  height: 180,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0,
                                                          top: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          'Votre adresse',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: 10.0,
                                                            bottom: 10.0,
                                                            left: 8),
                                                      ),
                                                      SizedBox(
                                                          child: TextFormField(
                                                        onChanged: (value) {},
                                                        controller:
                                                            _addressController,
                                                        validator: (value) {
                                                          if (value == "") {
                                                            return "veillez remplir se champs";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "ville",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      )),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                  'CANCEl',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                                onPressed: () {
                                                                  _addressController
                                                                      .clear();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              Button(
                                                                  title:
                                                                      'Update',
                                                                  enabled: true,
                                                                  state:
                                                                      udateAdd,
                                                                  onTap:
                                                                      () async {
                                                                    if (_addressController
                                                                        .text
                                                                        .isNotEmpty) {
                                                                      setState(
                                                                          () {
                                                                        udateAdd =
                                                                            true;
                                                                      });

                                                                      try {
                                                                        var payload =
                                                                            Jwt.parseJwt(widget.accessToken);
                                                                        String
                                                                            userid =
                                                                            payload["id"].toString();
                                                                        var body =
                                                                            {
                                                                          "adress":
                                                                              _addressController.text
                                                                        };
                                                                        print(
                                                                            '${ApiUrl.baseUrl}/api/membres/$userid        ${body}');
                                                                        var dio =
                                                                            await CustomDio().getApiClient();
                                                                        final response = await dio.patch(
                                                                            '${ApiUrl.baseUrl}/api/membres/$userid',
                                                                            data: json.encode(
                                                                                body),
                                                                            options:
                                                                                Options(headers: {
                                                                              "Content-Type": "application/merge-patch+json"
                                                                            }));
                                                                      } catch (e) {}
                                                                    } else {
                                                                      return 0;
                                                                    }
                                                                  },
                                                                  height: 40,
                                                                  width: 100,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  borderColor:
                                                                      ColorsApp
                                                                          .skyBlue,
                                                                  loaderColor:
                                                                      Colors
                                                                          .white),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                  }),
                              InfoComponent(
                                  title: Row(children: [
                                    Text("Password"),
                                    Container(
                                        child: Icon(FontAwesomeIcons.pen,
                                            size: 12, color: Color(0xFFCFD6D6)),
                                        margin: EdgeInsets.only(left: 10))
                                  ]),
                                  value: "*****",
                                  onTap: () {
                                    print("eeeeeeeeee");
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            StatefulBuilder(
                                                builder: (BuildContext context,
                                                        StateSetter setState) =>
                                                    Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)), //this right here
                                                        child: Container(
                                                          height: 300,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 8),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      'Ancien mot de passe',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    margin: EdgeInsets.only(
                                                                        top:
                                                                            10.0,
                                                                        bottom:
                                                                            10.0,
                                                                        left:
                                                                            8),
                                                                  ),
                                                                  SizedBox(
                                                                      child:
                                                                          TextFormField(
                                                                    onChanged:
                                                                        (value) {},
                                                                    controller:
                                                                        _passwordController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "veillez remplir se champs";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    obscureText:
                                                                        false,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "*****",
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  )),
                                                                  Container(
                                                                    child: Text(
                                                                      'Nouveau mot de passe',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    margin: EdgeInsets.only(
                                                                        top:
                                                                            10.0,
                                                                        bottom:
                                                                            10.0,
                                                                        left:
                                                                            8),
                                                                  ),
                                                                  SizedBox(
                                                                      child:
                                                                          TextFormField(
                                                                    onChanged:
                                                                        (value) {},
                                                                    controller:
                                                                        _newpasswordController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                          "") {
                                                                        return "veillez remplir se champs";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    obscureText:
                                                                        false,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "*****",
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                  )),
                                                                  Container(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          TextButton(
                                                                            child:
                                                                                const Text(
                                                                              'CANCEl',
                                                                              style: TextStyle(color: Colors.red),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              _newpasswordController.clear();

                                                                              _passwordController.clear();

                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          Button(
                                                                              title: 'Update',
                                                                              enabled: true,
                                                                              state: udatePass,
                                                                              onTap: () async {},
                                                                              height: 40,
                                                                              width: 100,
                                                                              textColor: Colors.white,
                                                                              borderColor: ColorsApp.skyBlue,
                                                                              loaderColor: Colors.white),
                                                                        ],
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ))));
                                  })
                            ]))
                        : BoutiqueView(),

                    childCount: 1,
                  ))
                ]));
  }
  // Builds 1000 ListTiles

}
