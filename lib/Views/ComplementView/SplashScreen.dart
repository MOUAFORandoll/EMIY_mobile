import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/Services/storageService.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:get/get.dart';
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
import 'dart:async';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  GetStorage box = GetStorage();

  start() {
    Get.find<ManagerController>().startTimer();

    Future.delayed(Duration(seconds: 10), () async {
      print('10');

      Get.offNamedUntil(AppLinks.ONBOARDING, (route) => false);
      Get.find<ManagerController>().chageN(false);

      // MyBinding().onGetAll();
    });
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.blue,
        body: Container(
            alignment: Alignment.center,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(child: Image.asset(Assets.logo)),
                      Container(
                        padding: EdgeInsets.only(top: kMdHeight / 4),
                        child: SpinKitRing(
                          lineWidth: 4,
                          color: ColorsApp.skyBlue,
                          size: 45,
                        ),
                      ),
                    ],
                  ))
                ])));
  }
}
