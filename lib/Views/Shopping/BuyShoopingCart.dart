import 'dart:async';

import 'package:fahkapmobile/components/Button/IconButtonF.dart';
import 'package:fahkapmobile/components/Form/formComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Widget/LivreurComponent.dart';
import 'package:fahkapmobile/components/Widget/productBuyComponent.dart';
import 'package:fahkapmobile/controller/BuyShopController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:fahkapmobile/model/data/TrajetModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';

// import 'package:cinetpay/cinetpay.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/database/DataBase.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';

class BuyShoopingCart extends StatelessWidget {
  BuyShoopingCart({Key? key}) : super(key: key);

  int counter = 0;
  String selectedPlace = '0';
  String selectedPlaceId = '0';

  String message = '';
  Color color = ColorsApp.skyBlue;

  bool select = false;
  bool finish = false;
  bool ok = false;
  List<TrajetModel> listTrajet = [];

  bool _loading = false;

  @override
  void initState() {}

  ViewFunctions functions = new ViewFunctions();

  int _index = 0;
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.find<BuyShopController>().onInit();
    Get.find<ManagerController>().getLocalU();
    return GetBuilder<BuyShopController>(builder: (_Bcontroller) {
      return GetBuilder<CartController>(builder: (_controller) {
        return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onTap: () => Get.back()),
              title: Text(
                _Bcontroller.state == 0
                    ? 'Votre lieux de livraison'
                    : _Bcontroller.state == 1
                        ? "Choisissez un coursier"
                        : _Bcontroller.state == 2
                            ? "Entrer vos informations "
                            : "Terminer",
                style: TextStyle(color: Colors.black),
              ),
              foregroundColor: Colors.red,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            bottomNavigationBar: Container(
              height: kMarginY * 8,
              padding: EdgeInsets.symmetric(horizontal: kMarginX),
              decoration: BoxDecoration(
                color: ColorsApp.greySecond,
                // borderRadius: BorderRadius.all(
                //   Radius.circular(12),
                // ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtonF(
                        icon: Icons.skip_previous_rounded,
                        inconSize: 30.0,
                        color: ColorsApp.bleuLight,
                        onTap: () => _Bcontroller.stateChange(false)),
                    IconButtonF(
                        icon: Icons.skip_next_rounded,
                        inconSize: 30.0,
                        color: ColorsApp.bleuLight,
                        onTap: () async {
                          var user = Get.find<ManagerController>();
                          if (_Bcontroller.state == 0) {
                            _Bcontroller.stateChange(true);
                          } else if (_Bcontroller.state == 1) {
                            if (_Bcontroller.isLivreur == 0) {
                              functions.snackBar('Achat',
                                  'Selectionner un livreur', ColorsApp.red);
                            } else {
                              _Bcontroller.stateChange(true);
                            }
                          } else if (_Bcontroller.state == 2) {
                            if ((nom.text.isEmpty ||
                                prenom.text.isEmpty ||
                                phone.text.isEmpty)) {
                              functions.snackBar(
                                  'Achat',
                                  'Veuillez remplir tous les champs',
                                  ColorsApp.red);
                              return;
                            } else {
                              _Bcontroller.stateChange(true);
                            }
                          } else if (_Bcontroller.state == 3) {
                            if (nom.text.isNotEmpty &&
                                prenom.text.isNotEmpty &&
                                phone.text.isNotEmpty &&
                                _Bcontroller.isLivreur != 0) {
                              var data = {
                                'nom': nom.text,
                                'prenom': prenom.text,
                                'phone': phone.text,
                                'idModePaiement': 1,
                                'idLivreur': _Bcontroller.isLivreur,
                                'listProduits': _controller.getListPinCart(),
                                'ville': user.ville,
                                'longitude': user.longitude,
                                'latitude': user.latitude,
                              };
                              print(data);
                              await _Bcontroller.buyCart(data);
                            } else {
                              functions.snackBar(
                                  'Achat',
                                  'Veuillez verifier vos informations',
                                  ColorsApp.red);
                            }
                            // _Bcontroller.stateChange(true);
                          }
                        }),
                  ]),
            ),
            body: Stack(children: [
              _Bcontroller.state == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: kMarginX),
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
/*                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(child: Text('Nom')),
                                Container(
                                  // margin: EdgeInsets.only(left: Get.width * .008),
                                  child: Text('Prix ',
                                      style: TextStyle(fontSize: 15)),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(left: Get.width * .008),
                                  child: Text('Quantity',
                                      style: TextStyle(fontSize: 15)),
                                ),
                                Container(
                                  // margin: EdgeInsets.only(left: Get.width * .008),
                                  child: Text('Total (XAF)',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ]),
                          SingleChildScrollView(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _controller.getItems.length,
                                  itemBuilder: (_ctx, index) =>
                                      ProductBuyComponent(
                                          cartModel:
                                              _controller.getItems[index])))
                      */
                          InkWell(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: Get.height * .05,
                                      left: Get.width * .01,
                                      right: Get.width * .01,
                                      bottom: Get.height * .009),
                                  padding: EdgeInsets.all(Get.height * .02),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorsApp.bleuLight),
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
                                // _controller.setLivreur(livreur.id);
                              }),
                          InkWell(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: Get.height * .05,
                                      left: Get.width * .01,
                                      right: Get.width * .01,
                                      bottom: Get.height * .009),
                                  padding: EdgeInsets.all(Get.height * .02),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorsApp.bleuLight),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Selectionne point de livraison',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Icon(Icons.my_location)
                                    ],
                                  )),
                              onTap: () {
                                Get.bottomSheet(Container(
                                    height: kMdHeight * 8,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: SingleChildScrollView(
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 50,
                                            itemBuilder: (_ctx, index) =>
                                                Text('iii')))));
                              })
                        ],
                      )))
                  : _Bcontroller.state == 1
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: kMarginX),
                          child: SingleChildScrollView(
                              child: _Bcontroller.isLoaded == 1
                                  ? Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SingleChildScrollView(
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: _Bcontroller
                                                    .livreurList.length,
                                                itemBuilder: (_ctx, index) =>
                                                    LivreurComponent(
                                                        livreur: _Bcontroller
                                                                .livreurList[
                                                            index])))
                                      ],
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            color: ColorsApp.bleuLight),
                                      ))))
                      : _Bcontroller.state == 2
                          ? Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: kMarginX),
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: Get.size.height * .025,
                                          bottom: Get.size.height * .025),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white),
                                      // padding: EdgeInsets.only(
                                      //   top: 25,
                                      // ),
                                      child: Column(
                                        children: [
                                          FormComponent(
                                              icon: Icons.account_circle,
                                              type: 0,
                                              controller: nom,
                                              enabled: true,
                                              hint: "Nom"),
                                          FormComponent(
                                              icon: Icons.account_circle,
                                              type: 0,
                                              controller: prenom,
                                              enabled: true,
                                              hint: "Prenom"),
                                          FormComponent(
                                              icon: Icons.call,
                                              type: 0,
                                              controller: phone,
                                              enabled: true,
                                              hint: "Phone"),
                                          // FormComponent(
                                          //   icon: Icons.lock,
                                          //   type: 1,
                                          //   controller: pass,
                                          //   enabled: true,
                                          //   hint: "Password",
                                          // )
                                        ],
                                      )),
                                ],
                              )))
                          : SingleChildScrollView(
                              child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Text('Valider Paiement'),
                                    ))
                              ],
                            ))
            ]));
      });
    });
  }
}
