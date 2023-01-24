import 'dart:async';

import 'package:fahkapmobile/components/Form/formComponent.dart';
import 'package:fahkapmobile/components/Text/smallText.dart';
import 'package:fahkapmobile/components/Widget/LivreurComponent.dart';
import 'package:fahkapmobile/components/Widget/productBuyComponent.dart';
import 'package:fahkapmobile/controller/BuyShopController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
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

//  newSaveSql() async {
//     var send = await BuyShoopingCart().insert(newR);
//     print(send);
//   }
//   // ignore: must_call_super
//   getData() async {
//     await new ApiService().getListTrajet().then((value) {
//       setState(() {
//         // print(value);
//         listTrajet = value;
//         dropdownvalueD = listTrajet[0];
//         ok = true;
//       });
//     }).catchError((e) {
//       ViewFunctions().verifiedConnection();
//       Timer(Duration(seconds: 3), () {
//         // print('********************${counter}');
//         getData();
//       });
//       // getData();
//     });
//     ;
//   }

  bool _loading = false;

  // // ignore: must_call_super
  // buyBillet() async {
  //   var data = {
  //     "nom": nom.value.text,
  //     "prenom": prenom.value.text,
  //     "numero": phone.value.text,
  //     "idPlace": selectedPlaceId,
  //     "idModePaiement": 1,
  //   };

  //   Get.defaultDialog(
  //       title: 'En cours',
  //       content: SizedBox(
  //           // height: Get.size.height * .02,
  //           // width: Get.size.width * .02,
  //           child: Center(
  //               child: CircularProgressIndicator(
  //         color: Colors.blueAccent,
  //       ))));
  //   await new ApiService().buyBillet(data).then((value) {
  //     setState(() {
  //       finish = true;
  //       message = value['message'];

  //       color = value['color'];
  //     });
  //     // print(value['message']);
  //     // functions.snackBar('Reservation', 'cccccccccccc', ColorsApp.skyBlue, 2);
  //     Get.back();
  //   }).catchError((e) {
  //     setState(() {
  //       finish = true;
  //       message = 'Echec de Reservation ';
  //       color = ColorsApp.red;
  //     });
  //     // print(value['message']);
  //     // functions.snackBar('Reservation', 'cccccccccccc', ColorsApp.skyBlue, 2);

  //     // functions.snackBar('Reservation', 'Echec de Reservation ', Colors.red, 3);
  //     // Get.back(); // getData();
  //   });

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
    Get.find<BuyShopController>().getListLivreur();

    return GetBuilder<BuyShopController>(builder: (_Bcontroller) {
      return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onTap: () => Get.back()),
            title: Text(
              'Effectuer votre achat',
              style: TextStyle(color: Colors.black),
            ),
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: GetBuilder<CartController>(builder: (_controller) {
            return  
            Stack(children: [
              _controller.getItems.length != 0
                  ? Stepper(
                      type: StepperType.vertical,
                      currentStep: _Bcontroller.state,
                      onStepCancel: () {
                        _Bcontroller.stateChange(false);
                      },
                      onStepTapped: (int index) {
                        // print('index------------------' + widget.currentStep);
                      },
                      onStepContinue: () async {
                        // if (_Bcontroller.state == 0) {

                        // }

                        // if (_Bcontroller.isCurrent(0)) {
                        _Bcontroller.stateChange(true);
                        // }
                        // if (_Bcontroller.isCurrent(1) &&
                        //     _Bcontroller.current == 0) {
                        //   if (_Bcontroller.isLivreur == 0) {
                        //     functions.snackBar('Achat',
                        //         'Selectionner un livreur', ColorsApp.red);
                        //   } else {
                        //     _Bcontroller.stateChange(true);
                        //   }
                        // }
                        // if (_Bcontroller.isCurrent(2)) {
                        //   if ((nom.text.isEmpty ||
                        //           prenom.text.isEmpty ||
                        //           phone.text.isEmpty) &&
                        //       _Bcontroller.current != 2) {
                        //     functions.snackBar(
                        //         'Achat',
                        //         'Veuillez remplir tous les champs',
                        //         ColorsApp.red);
                        //     return;
                        //   } else {
                        //     _Bcontroller.stateChange(true);
                        //   }
                        // }
                        // if (_Bcontroller.isCurrent(0)) {
                        //   _Bcontroller.stateChangeX(1);
                        // }
                        // ;
                        // if (_Bcontroller.isCurrent(1)) {
                        //   _Bcontroller.stateChangeX(2);
                        // }
                        // ;
                        // if (_Bcontroller.isCurrent(2)) {
                        //   _Bcontroller.stateChangeX(3);
                        // }
                        // ;

                        // print(_Bcontroller.isCurrent(3));
                        // if (_Bcontroller.isCurrent(3)) {
                        // if (nom.text.isEmpty ||
                        //     prenom.text.isEmpty ||
                        //     phone.text.isEmpty ||
                        //     _Bcontroller.isLivreur == 0) {
                        //   if (_Bcontroller.isLivreur == 0) {
                        //     functions.snackBar('Achat',
                        //         'Selectionner un livreur', ColorsApp.red);
                        //   } else {
                        //     functions.snackBar(
                        //         'Achat',
                        //         'Veuillez remplir tous les champs',
                        //         ColorsApp.red);
                        //   }
                        // }
                        // var listProd = await _controller.getListPinCart();

                        // print(listProd);
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
                          };
                          print(data);
                          await _Bcontroller.buyCart(data);
                        } else {}
                      },
                      steps: [
                        Step(
                            isActive: _Bcontroller.isCurrent(0),
                            title: const Text('Informations commande'),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                cartModel: _controller
                                                    .getItems[index])))
                              ],
                            )),
                        // isActive: (selectedPlace != "0"),
                        // state: (selectedPlace != "0")
                        //     ? StepState.complete
                        //     : StepState.editing),
                        Step(
                            title: const Text('Choix du livreur'),
                            isActive: _Bcontroller.isCurrent(1),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _Bcontroller.isLoaded == 1
                                    ? SingleChildScrollView(
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                _Bcontroller.livreurList.length,
                                            itemBuilder: (_ctx, index) =>
                                                LivreurComponent(
                                                    livreur: _Bcontroller
                                                        .livreurList[index])))
                                    : CircularProgressIndicator(
                                        color: ColorsApp.bleuLight)
                              ],
                            )),
                        Step(
                          title: const Text('Informations personnels'),
                          isActive: _Bcontroller.isCurrent(2),
                          content: Container(
                              margin: EdgeInsets.only(
                                top: Get.size.height * .025,
                                bottom: Get.size.height * .025,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              // padding: EdgeInsets.only(
                              //   top: 25,
                              // ),
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
                              )),
                          // isActive: (nom.value.text.length != 0 &&
                          //     prenom.value.text.length != 0 &&
                          //     phone.value.text.length != 0 &&
                          //     ViewFunctions()
                          //         .verifPhoneNumber(phone.value.text) &&
                          //     ViewFunctions().verifText(nom.value.text) &&
                          //     ViewFunctions().verifText(prenom.value.text)),
                          // state: (nom.value.text.length != 0 &&
                          //         prenom.value.text.length != 0 &&
                          //         phone.value.text.length != 0 &&
                          //         ViewFunctions()
                          //             .verifPhoneNumber(phone.value.text) &&
                          //         ViewFunctions().verifText(nom.value.text) &&
                          //         ViewFunctions().verifText(prenom.value.text))
                          //     ? StepState.complete
                          //     : StepState.editing),
                        ),
                        Step(
                            title: const Text('Payement'),
                            isActive: _Bcontroller.isCurrent(3),
                            content: Column(
                              children: [
                                // CinetPayCheckout(
                                //   title: 'Payment Checkout',
                                //   configData: <String, dynamic>{},
                                //   paymentData: <String, dynamic>{},
                                //   waitResponse: (data) {},
                                //   onError: (data) {},
                                // )
                              ],
                            ),
                            state: StepState.disabled),
                      ],
                    )
                  : Container()
            ]);
          }));
    });
  }
}
