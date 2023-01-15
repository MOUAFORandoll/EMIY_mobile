import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fahkapmobile/Views/BoutiqueUser/BoutiqueUserView.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/components/Form/formComponent2.dart';
import 'package:fahkapmobile/components/Text/bigText.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/Services/storageService2.dart';
import 'package:fahkapmobile/utils/database/DataBase.dart';
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
import 'package:shimmer/shimmer.dart';

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

  TextEditingController name = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();
  // TextEditingController adresse = TextEditingController();
  TextEditingController email = TextEditingController();
  bool udateAdd = false;
  bool udatePass = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<ManagerController>(builder: (_manager) {
      print(_manager.User);
      // ignore: unnecessary_null_comparison
      if (_manager.User != null) {
        name.text = _manager.User.nom;
        prenom.text = _manager.User.prenom.toString();
        phone.text = _manager.User.phone.toString();
        email.text = _manager.User.email;
      }
      return CustomScrollView(controller: _scrollController, slivers: [
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
            child: GetBuilder<BoutiqueController>(
              builder: (_controller) => SingleChildScrollView(
                  child: Column(children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child:
                              BigText(text: "Profile", bolder: _manager.state),
                          onTap: () => _manager.chageState(true),
                        ),
                        _controller.isLoaded == 1
                            ? _controller.isExist
                                ? InkWell(
                                    child: BigText(
                                        text: "Boutique",
                                        bolder: !_manager.state),
                                    onTap: () => _manager.chageState(false),
                                  )
                                : Container()
                            : _controller.isLoaded == 2
                                ? Container()
                                : Container(
                                    child: SpinKitCircle(
                                    color: ColorsApp.bleuLight,
                                  )),
                      ],
                    ),
                    margin: EdgeInsets.only(
                      top: Get.height * .030,
                      // left: kMarginX,
                      // right: kMarginX,
                    )),
                /*  _controller.isExist
                    ? Container(width: 0, height: 0)
                    :  */
                InkWell(
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 2, bottom: 2),
                      margin: EdgeInsets.only(bottom: 5, top: 8),
                      decoration: BoxDecoration(color: ColorsApp.grey),
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            smallText(
                                al: true,
                                width: kSmWidth,
                                text: 'Historique de vos achats',
                                size: 16),
                            Container(
                                margin: EdgeInsets.only(
                                    top: Get.height * .005,
                                    left: Get.width * .008),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  // color: Colors.white,
                                )),
                          ])),
                  onTap: () => Get.toNamed(AppLinks.COMMANDE_FOR_USER),
                ),
              ])),
            ),
            /*   onTap: () => filterDest() */
          ),
          // Make the initial height of the SliverAppBar larger than normal.
          expandedHeight: 95,
        ),
        SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
          // The builder function returns a ListTile with a title that
          // displays the index of the current item.
          (context, index) => _manager.state
              ? _manager.isLoaded == 0
                  ? Shimmer.fromColors(
                      baseColor: Colors.blueGrey,
                      highlightColor: Colors.greenAccent,
                      child: Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Column(children: <Widget>[
                            InfoComponent(title: Text("First name"), value: ''),
                            InfoComponent(title: Text("Last name"), value: ''),
                            InfoComponent(
                                title: Text("Phone number"), value: ''),
                            InfoComponent(title: Text("Email"), value: ''),
                            InfoComponent(
                              title: Row(children: [
                                Text("Password"),
                                // Container(
                                //     child: Icon(FontAwesomeIcons.pen,
                                //         size: 12, color: Color(0xFFCFD6D6)),
                                //     margin: EdgeInsets.only(left: 10))
                              ]),
                              value: "*****",
                            ),
                            CustomBtn(
                              color: ColorsApp.greenLight,
                              title: 'Mettre a jour',
                              onTap: () async {},
                            )
                          ])))
                  : RefreshIndicator(
                      color: ColorsApp.skyBlue,
                      onRefresh: () async {
                        await Get.find<ManagerController>().getKeyU();

                        await Get.find<ManagerController>().getUser();

                        await Get.find<ManagerController>().getKeyU();
                        ;
                      },
                      child: Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: !_manager.userP && _manager.User != null
                              ? Column(children: <Widget>[
                                  InfoComponent(
                                      title: Text("First name"),
                                      value: _manager.User.nom),
                                  InfoComponent(
                                      title: Text("Last name"),
                                      value: _manager.User.prenom),
                                  InfoComponent(
                                      title: Text("Phone number"),
                                      value: _manager.User.phone),
                                  InfoComponent(
                                      title: Text("Email"),
                                      value: _manager.User.email),
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
                                  InfoComponent(
                                    title: Row(children: [
                                      Text("Password"),
                                      // Container(
                                      //     child: Icon(FontAwesomeIcons.pen,
                                      //         size: 12, color: Color(0xFFCFD6D6)),
                                      //     margin: EdgeInsets.only(left: 10))
                                    ]),
                                    value: "*****",
                                  ),
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
                                          color: ColorsApp.grey,
                                          child: SingleChildScrollView(
                                              child: Column(
                                            // mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FormComponent2(
                                                  icon: Icons.account_circle,
                                                  type: 0,
                                                  controller: name,
                                                  enabled: true,
                                                  titre: 'Nom',
                                                  hint: ""),
                                              FormComponent2(
                                                  icon: Icons.account_circle,
                                                  type: 0,
                                                  controller: prenom,
                                                  enabled: true,
                                                  titre: 'Prenom',
                                                  hint: ""),
                                              FormComponent2(
                                                  icon: Icons.account_circle,
                                                  type: 0,
                                                  controller: phone,
                                                  kType: TextInputType.number,
                                                  enabled: true,
                                                  titre: 'phone',
                                                  hint: " "),
                                              // FormComponent2(
                                              //     icon: Icons.account_circle,
                                              //     type: 0,
                                              //     controller: adresse,
                                              //     // kType: TextInputType.number,
                                              //     enabled: true,
                                              //     titre: 'adresse',
                                              //     hint: " "),
                                              FormComponent2(
                                                  icon: Icons.account_circle,
                                                  type: 0,
                                                  controller: email,
                                                  // kType: TextInputType.number,
                                                  enabled: true,
                                                  titre: 'email',
                                                  hint: " "),
                                              CustomBtn(
                                                  color: ColorsApp.greenLight,
                                                  title: 'Mettre a jour',
                                                  onTap: () async {
                                                    var data = {
                                                      'keySecret':
                                                          new GetStorage().read(
                                                              'keySecret'),
                                                      'nom': name.text,
                                                      'prenom': prenom.text,
                                                      'phone': phone.text,
                                                      'email': email.text,
                                                    };
                                                    print(data);
                                                    await _manager
                                                        .updateUser(data);
                                                  })
                                            ],
                                          )),
                                        ),
                                      );
                                    },
                                  ),
                                  Center(
                                      child: CustomBtn(
                                          color: ColorsApp.red,
                                          title: 'Deconneter',
                                          onTap: () {
                                            Get.find<StorageService>()
                                                .deleteStorage();
                                            Get.find<DB>().deleteAll();
                                            Get.toNamed(AppLinks.LOGIN);
                                          })),
                                ])
                              : Column(
                                  children: [
                                    Center(
                                        child: CustomBtn(
                                            color: ColorsApp.greenLight,
                                            title: 'Se Connecter',
                                            onTap: () {
                                              Get.toNamed(AppLinks.LOGIN);
                                            })),
                                    Center(
                                      child: CustomBtn(
                                          color: ColorsApp.greenLight,
                                          title: 'Creer compte',
                                          onTap: () {
                                            Get.toNamed(AppLinks.REGISTER);
                                          }),
                                    )
                                  ],
                                )))
              : BoutiqueUserView(),

          childCount: 1,
        ))
      ]);
    });
  }
  // Builds 1000 ListTiles

}
