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

class PaiementView extends StatelessWidget  { 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyShopController>(
        builder: (_Bcontroller) => Scaffold(
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
            body: Stack(children: [
              WebView(
                initialUrl: _Bcontroller.paiementUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (String url) {
                  _Bcontroller.setLoadTransaction(true);
                },
                onPageFinished: (String url) {
                 
                     _Bcontroller.setLoadTransaction(false);
                },
              ),
              if (_Bcontroller.isLoad)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ])));
  }
}
