import 'package:get/get.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/utils/DataBase/DataBase.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/api/apiUrl.dart';
import 'package:Fahkap/utils/functions/route.dart';
import 'package:Fahkap/utils/provider/refresh_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:Fahkap/views/UsersMange/LoginScreen.dart';
import 'package:Fahkap/views/ComplementView/wrapper.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              flex: 2,
              child: new Container(
                  child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Hero(
                    tag: "splashscreenImage",
                    child: new Container(child: Image.asset('assets/bus.png')),
                  ),
                  new Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text('BienVenu Sur notre plateform',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  new Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Vous desirez voyager, vous n'avez pas de temps a perdre alors desormais reservez votre place dans les agences du cameroun via notre application ",
                        textAlign: TextAlign.center,
                      )),
                  Button(
                      borderRadius: 1.0,
                      width: Get.size.height * .8,
                      margin: EdgeInsets.only(
                          top: Get.size.height * .10,
                          bottom: 0,
                          left: Get.size.width * .01,
                          right: Get.size.width * .01),
                      height: Get.size.height * .08,
                      loaderColor: Colors.white,
                      title: "Commencer",
                      textColor: Colors.white,
                      itemColor: Colors.black,
                      borderColor: Colors.transparent,
                      // state: validator,
                      enabled: true,
                      onTap: () async {
                        Get.toNamed(AppLinks.LOGIN);
                      }),
                ],
              )),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       SpinKitCircle(
            //         color: Colors.blue,
            //         size: 40,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 20.0),
            //       ),
            //       (this.subtitle == null) ? Text('') : Text(this.subtitle)
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    ));
  }
}
