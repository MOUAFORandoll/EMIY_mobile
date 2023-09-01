import 'package:EMIY/components/Button/AppIconButton.dart'; 
import 'package:EMIY/controller/BuyShopController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyShopController>(
        builder: (_Bcontroller) => Scaffold(
            appBar: AppBar(
              title: Text("Valider Paiement",
                  style: TextStyle(color: ColorsApp.black)),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: ColorsApp.black,
              leading: InkWell(
                child: Icon(Icons.close, color: ColorsApp.black),
                onTap: () {
                  return Navigator.pop(context);
                },
              ),
            ),
            body: Stack(children: [
              // WebView(
              //   initialUrl: _Bcontroller.paiementUrl,
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onPageStarted: (String url) {
              //     _Bcontroller.setLoadTransaction(true);
              //   },
              //   onPageFinished: (String url) {
              //     _Bcontroller.setLoadTransaction(false);
              //   },
              // ),
                    WebViewWidget(controller: _Bcontroller.controller),
              if (_Bcontroller.isLoad)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ])));
  }
}
