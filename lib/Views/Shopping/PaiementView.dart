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
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementView extends StatefulWidget {
  PaiementView({Key? key}) : super(key: key);

  @override
  State<PaiementView> createState() => _PaiementViewState();
}

class _PaiementViewState extends State<PaiementView> {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var functions = ViewFunctions();

    return GetBuilder<BuyShopController>(builder: (_Bcontroller) {
      return GetBuilder<ActionController>(
          builder: (_Acontroller) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              child: _Acontroller.selected == 3
                  ? SingleChildScrollView(
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
                                            onChange: _Bcontroller.setSlash(),
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
                                            controller: _Bcontroller
                                                .expiryYearController,
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
                              if (_Bcontroller.dateController.text.length ==
                                      5 ||
                                  _Bcontroller
                                          .cardNumberController.text.length ==
                                      16 ||
                                  _Bcontroller.cvvController.text.length == 3) {
                                _Bcontroller.setDate();
                                if (_Bcontroller.expiryMonthController.text
                                            .length !=
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
                    ))
                  :/*  WebView(
                        initialUrl: _Bcontroller
                            .paiementUrl, // Replace with your desired URL
                      ) */ WebviewScaffold(
        url: _Bcontroller.paiementUrl, // Replace with your desired URL
      ),));
    });
  }
}
