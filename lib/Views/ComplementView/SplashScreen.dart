import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/core.dart';
import 'package:EMIY/utils/Services/dependancies.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:get/get.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:EMIY/utils/functions/route.dart';
import 'package:EMIY/utils/provider/refresh_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:EMIY/views/UsersMange/LoginScreen.dart';
import 'dart:async';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_svg/flutter_svg.dart';

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
      print(box.read('first'));
      if (box.read('first') != 1) {
        box.write('first', 1);
        Get.offNamedUntil(AppLinks.ONBOARDING, (route) => false);
          await secondInit();
      } else {
        Get.offNamedUntil(AppLinks.FIRST, (route) => false);
        await secondInit();
      }
      Get.find<ManagerController>().chageN(false);
    });
  }

  @override
  void initState() {
    super.initState();
      
    // initUniLinks();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.white,
        body: Container(
            alignment: Alignment.center,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: SvgPicture.asset(
                        Assets.logoSvg,
                        width: kHeight,
                        height: kHeight,
                      )),
                      // Container(
                      //   margin: EdgeInsets.only(top: kMdHeight / 15),
                      //   child: SpinKitRing(
                      //     lineWidth: 4,
                      //     color: ColorsApp.skyBlue,
                      //     size: 25,
                      //   ),
                      // ),
                    ],
                  ))
                ])));
  }
}
/**
 * 
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  GetStorage box = GetStorage(); 
  AnimationController? _controller;
  Animation<Color>? _colorAnimation;

  start() {
    Get.find<ManagerController>().startTimer();

    Future.delayed(Duration(seconds: 10), () async {
      print(box.read('first'));
      if (box.read('first') != 1) {
        box.write('first', 1);
        Get.offNamedUntil(AppLinks.ONBOARDING, (route) => false);
      } else {
        Get.offNamedUntil(AppLinks.FIRST, (route) => false);
      }
      Get.find<ManagerController>().chageN(false);

      // MyBinding().onGetAll();
    });
  }

  Future<void> initUniLinks() async {
    try {
      StreamSubscription _sub;

      // Écoutez les liens entrants
      _sub = linkStream.listen((uri) {
        // Traitez les liens entrants ici
        handleDeepLink(uri);
      });
    } on PlatformException {
      // Gestion des erreurs
    }
  }

  void handleDeepLink(uri) {
    // Votre logique pour traiter les liens entrants
    // Extrait les informations nécessaires de l'URL
  }

  @override
  void initState() {
  _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: ColorsApp.textBlue,
      end: ColorsApp.orange,
    ).animate(_controller as Animation<double>) as Animation<Color>?;
    initUniLinks();
    start();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AnimatedBuilder(
                animation: _colorAnimation!,
                builder: (context, child) {
                  return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          _colorAnimation!.value, BlendMode.modulate),
                      child: SvgPicture.asset(
                        Assets.logoSvg,
                        width: kHeight * 2.5,
                        height: kHeight * 2.5,
                      ));
                })));
  }
}

 */