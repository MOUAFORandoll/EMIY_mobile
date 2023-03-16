import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/Services/storageService.dart';
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
import 'package:Fahkap/views/ComplementView/wrapper.dart';

import 'dart:async';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  GetStorage box = GetStorage();
  // int isOpen = 0;
  // var rep = 0;
  // int count = 0;
  // var data;
  start() {
    Get.find<ManagerController>().startTimer();

    Future.delayed(Duration(seconds: 10), () async {
      print('10');

      Get.offNamedUntil(AppLinks.FIRST, (route) => false);
      Get.find<ManagerController>().chageN(false);

      MyBinding().onGetAll();
    });
  }

  // late Animation<double> _progress;
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   _animationController.dispose();

  //   super.dispose();
  // }

  // late Color color = Colors.red.shade900;

  // bool _isLoading = false;

  @override
  void initState() {
    start();
  }

  // @override
  // void dispose() {
  //   startTimer();
  //   start();
  // }

  late double height = 0;
  late String texte = "";

  bool _isOpened = false;
  late AnimationController _animationController;

  bool tile = false;

  @override
  void animate() {
    if (_isOpened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _isOpened = !_isOpened;
    });
  }

  ///@newConnexion start the new post in table connexion for userApp
  // getuser() async {
  //   var date =
  //       "${new DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())}";

  //   try {
  //     var token;
  //     print("loddddddddddddddddddddddddddddddd");
  //     await CustomDio().refreshToken();
  //     print("***************-ddddddddddddddddddddd");

  //     var dio = await CustomDio().getApiClient();

  //     print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");

  //     try {
  //       print("Wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
  //       final response = await dio.get(
  //         "/api/publications",
  //       );
  //       print("reppppppp ${response.data}");
  //       if (response.statusCode == 201 || response.statusCode == 200) {
  //         print("nouvelle connexion ok");
  //         setState(() {
  //           rep = 1;
  //         });
  //       } else {
  //         print("errorrrrrr nouvelle connexion ok ${response.statusCode}");
  //       }
  //     } catch (e) {
  //       setState(() {
  //         rep = 2;
  //       });
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return /* (isOpen == 0)
        ? */
        NewSplashScreen(
      title: "Fah Kap",
      //  subtitle: "LEGACY FINANCE \n Digital Finance",
      image: 'assets/logo/logoH.png',
      /*  loaderColor: Colors.yellow, */
    );
    // : (isOpen == 1)
    //     ? Wrapper()
    //     : LoginScreen();
  }
}

class NewSplashScreen extends StatelessWidget {
  NewSplashScreen({
    this.title,
    this.subtitle,
    this.image,
    this.loaderColor,
  });
  var title, subtitle, image, loaderColor;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(builder: (_controller) {
      return Scaffold(
          body: Container(
        // height: Get.height * .06,

        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   gradient: GradientApp.blueG,
        // ),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: 2,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(child: Image.asset(this.image)),

                      // Text('N',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         // fontFamily:  ,
                      //         fontSize: 120 + _controller.tailleAdd,
                      //         color: Colors.white))
                      //     ],
                      //   )),
                      // ),

                      Container(
                        padding: EdgeInsets.only(top: kMdHeight / 6),
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0),
                      // ),
                      // (this.subtitle == null) ? Text('') : Text(this.subtitle)
                    ],
                  )))
            ]),
      ));
    });
  }
}
