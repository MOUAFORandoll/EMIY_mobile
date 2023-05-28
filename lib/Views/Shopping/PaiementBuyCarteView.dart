import 'package:Fahkap/components/Button/AppIconButton.dart';
import 'package:Fahkap/components/Button/IconButtonF.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/FormPaiement.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Text/bigtitleText0.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Widget/shoppingproductComponent.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/BuyShopController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementBuyCarteView extends StatefulWidget {
  PaiementBuyCarteView({Key? key}) : super(key: key);

  @override
  State<PaiementBuyCarteView> createState() => _PaiementBuyCarteViewState();
}

class _PaiementBuyCarteViewState extends State<PaiementBuyCarteView> {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var functions = ViewFunctions();
    bool isLoading = true;

    return GetBuilder<BuyShopController>(builder: (_Bcontroller) {
      return GetBuilder<ActionController>(
          builder: (_Acontroller) => Scaffold(
              appBar: AppBar(
                title: Text("Valider Paiement",
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                leading: InkWell(
                  child: Icon(Icons.close, color: Colors.black),
                  onTap: () {
                    return Navigator.pop(context);
                  },
                ),
              ),
              body: Container(
                  height: kHeight * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                              child: Icon(Icons.close,
                                  color: ColorsApp.greySecond),
                              onTap: () => Get.back()),
                          SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(height: 20),
                      BigtitleText0(
                        text: "Card information",
                        bolder: true,
                      ),
                      SizedBox(height: 20),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorsApp.skyBlue,
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          // margin: EdgeInsets.symmetric(horizontal: kMarginX),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FormPaiement(
                                            controller: _Bcontroller
                                                .cardNumberController,
                                            hintText: "Card Number",
                                            icon: true,
                                            border: true),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FormPaiement(
                                          controller:
                                              _Bcontroller.dateController,
                                          hintText: "MM / YY",
                                          // onChange: _Bcontroller.setSlash(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FormPaiement(
                                          border0: true,
                                          controller:
                                              _Bcontroller.expiryYearController,
                                          hintText: "CVC",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(height: 20),
                      CustomBtn(
                        color: ColorsApp.greenLight,
                        title: 'Terminer',
                        onTap: () async {
                          var mode = Get.find<ActionController>().selected;
                          if (mode == 3) {
                            if (_Bcontroller.dateController.text.length == 5 ||
                                _Bcontroller.cardNumberController.text.length ==
                                    16 ||
                                _Bcontroller.cvvController.text.length == 3) {
                              _Bcontroller.setDate();
                              if (_Bcontroller
                                          .expiryMonthController.text.length !=
                                      2 ||
                                  _Bcontroller
                                          .expiryYearController.text.length !=
                                      2) {
                                _Bcontroller.fn.snackBar(
                                    'Achat',
                                    'Renseigner les informations correctes',
                                    false);

                                return false;
                              } else {
                                await _Bcontroller.buyCart();
                              }
                            } else {
                              _Bcontroller.fn.snackBar(
                                  'Achat',
                                  'Renseigner les informations correctes',
                                  false);

                              return false;
                            }
                          } else {
                            await _Bcontroller.buyCart();
                          }
                        },
                      )
                    ],
                  )))));
    });
  }
}
