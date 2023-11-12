import 'dart:io';

import 'package:EMIY/Views/UsersMange/LoginScreen.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/core.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class ViewFunctions {
  notifivation(String title) {
    return Get.showSnackbar(GetSnackBar(
      messageText: Container(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        alignment: Alignment.center,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorsApp.greyFirst,
      borderRadius: 2,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      duration: Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.linear,
    ));
  }

  snackBar(String title, String body, bool correct) {
    // return Get.snackbar(
    //   title,
    //   body,
    //   icon: Icon(correct ? FontAwesomeIcons.check : Icons.error,
    //       color: correct ? Colors.greenAccent : Colors.red),
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: Colors.grey[500],
    //   borderRadius: 20,
    //   margin: EdgeInsets.all(20),
    //   colorText: Colors.white,
    //   duration: Duration(seconds: 5),
    //   // isDismissible: true,
    //   dismissDirection: DismissDirection.horizontal,
    //   forwardAnimationCurve: Curves.linear,
    // );

    Color? color = correct ? Colors.green : Colors.orange[600];
    return Get.snackbar(title, body,
        // icon: Icon(
        //   correct ? Icons. : Icons.wifi_off_sharp,
        //   color: correct ? Colors.greenAccent : Colors.red,
        // ),
        borderRadius: 5,
        isDismissible: true,
        onTap: (getBar) {},
        snackPosition: SnackPosition.TOP,
        duration:
            correct ? const Duration(seconds: 10) : const Duration(seconds: 4),
        barBlur: 20,
        shouldIconPulse: true,
        maxWidth: 1450,
        snackStyle: SnackStyle.FLOATING,
        leftBarIndicatorColor: color,
        backgroundColor: Colors.white);
  }

  // void loading(title, description) {
  //   Get.dialog(Container(
  //       height: 18,
  //       width: 18,
  //       decoration: BoxDecoration(
  //         color: ColorsApp.greySecond,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       margin: EdgeInsets.symmetric(
  //           vertical: kHeight * .43, horizontal: kWidth * .40),
  //       child: Container(
  //           child: Center(
  //               child: CircularProgressIndicator(
  //         color: ColorsApp.skyBlue,
  //       )))));
  // }

  isConnected() async {
    final dababase = Get.find<DataBaseController>();

    var key = await dababase.getKey();
    if (key == null || key == 'null') {
      Get.bottomSheet(
        Container(
            margin: EdgeInsets.only(
              top: kMarginY * 8,
            ),
            decoration: BoxDecoration(
                color: ColorsApp.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            height: 800,
            padding: EdgeInsets.symmetric(horizontal: kMarginX),
            child: Column(children: [
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text('Annuler'),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      // TextButton(
                      //   child: Text('Ajouter'),
                      //   onPressed: () async {
                      //     // await _controller.addShort();
                      //     // _controller.chageState(!_controller.addProduit);
                      //   },
                      // )
                    ]),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                // _controller.listImgProduits.length != 0
                //     ? smallText(
                //         text: 'Listes images',
                //       )
                //     : Container(),

                Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    child: LoginScreen())
              ])))
            ])),
        isScrollControlled: true,
      );
      return false;
    } else {
      return true;
    }
  }

  void loading(title, description) {
    Get.dialog(
      Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: ColorsApp.greySecond,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(
              vertical: kHeight * .43, horizontal: kWidth * .40),
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(
              color: ColorsApp
                  .secondBlue)) /*  Container(
            child: Shimmer.fromColors(
                baseColor: ColorsApp.grey,
                highlightColor: Colors.blueGrey,
                child:  SvgPicture.asset(
                  Assets.logo_esq,
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
                ) 

                  
          ))*/
      ,
      barrierDismissible: false,
    );
  }

  void closeLoader() {
    Get.back(
      closeOverlays: false,
    );
  }

  // void loading(title, description) {
  //   Get.snackbar(
  //     ' ', '',
  //     titleText: Container(
  //         margin: EdgeInsets.only(top: 5),
  //         child: Text(
  //           title,
  //           style: TextStyle(
  //               fontFamily: 'OpenSan',
  //               fontWeight: FontWeight.w600,
  //               fontSize: 15),
  //         )),
  //     messageText: Container(
  //         margin: EdgeInsets.only(bottom: 5, left: 3),
  //         child: Text(
  //           description,
  //           style: TextStyle(fontFamily: 'OpenSan', fontSize: 12),
  //         )),
  //     icon: Container(
  //       margin: EdgeInsets.all(9),
  //       child: SpinKitWave(color: Colors.blueAccent, size: 23.0),
  //     ),
  //     borderRadius: 5,
  //     isDismissible: true,
  //     onTap: (getBar) {},
  //     snackPosition: SnackPosition.TOP,
  //     duration: Duration(seconds: 400),
  //     barBlur: 200,
  //     shouldIconPulse: true,
  //     // maxWidth: 1450,
  //     snackStyle: SnackStyle.FLOATING,
  //     leftBarIndicatorColor: Colors.green,
  //     backgroundColor: Colors.white,
  //     maxWidth: kWidth,
  //     margin: EdgeInsets.zero,
  //     padding: EdgeInsets.zero,

  //     borderWidth: 100,
  //     // showProgressIndicator: true,
  //   );
  // }

  closeSnack() {
    //print('*****************************${Get.isSnackbarOpen}');
    Get.closeCurrentSnackbar();
    // Get.closeAllSnackbars();
  }

  toast(
    title,
  ) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    Get.snackbar(
      'Notification',
      'This is a WhatsApp Toast',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[600],
      colorText: Colors.white,
      margin: EdgeInsets.all(16),
      borderRadius: 16,
      duration: Duration(seconds: 3),
    );
  }
  /*
   leftBarIndicatorColor,   Gradient? backgroundGradient, TextButton? mainButton, void Function(GetSnackBar)? onTap, bool? isDismissible, bool? showProgressIndicator, DismissDirection? dismissDirection, AnimationController? progressIndicatorController, Color? progressIndicatorBackgroundColor, Animation<Color>? progressIndicatorValueColor, SnackStyle? snackStyle, Curve? forwardAnimationCurve, Curve? reverseAnimationCurve, Duration? animationDuration, double? barBlur, double? overlayBlur, void Function(SnackbarStatus?)? snackbarStatus, Color? overlayColor, Form? userInputForm*/

  /* 
Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } catch (err) {
      setState(() {
        _isConnected = false;
      });
      if (kDebugMode) {
        //print(err);
      }
    }
  } */
// class NetworkService extends GetxService {
//   Future<NetworkService> init() async {
//     return this;
//   }

//   Future<bool> checkIsOnline() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//     return false;
//   }

  // Future<bool> checkIsConnected() async {
  //   ConnectivityResult result = await Connectivity().checkConnectivity();
  //   if (result == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (result == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }
// }

  Future<bool> checkIsOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  bool connexion = true;
  verifiedConnection() {
    //print("debut check connexion");
    // DataConnectionChecker().onStatusChange.listen((status) async {
    //   var req = await checkIsOnline();
    //   switch (status) {
    //     case DataConnectionStatus.connected:
    //       //print("connecte $connexion");
    //       if (connexion == false) {
    //         // Get.back();

    //         showToast(req);
    //         initApp();
    //         connexion = true;
    //       } else {
    //         //print(" deja connextio $connexion");
    //       }
    //       break;
    //     case DataConnectionStatus.disconnected:
    //       //print("pas de connextio $connexion");

    //       if (connexion == true) {
    //         showToast(req);
    //         connexion = false;
    //       } else {
    //         // Get.back();
    //         //print("attente de connextio $connexion");
    //       }
    //       break;
    //   }
    // });

    //   var cron = Cron();
    //   cron.schedule(Schedule.parse('*/2 * * * * *'), () async {
    //     var a = Connectivity().checkConnectivity;
    //     //print("voici *********************** $a");
    //     bool result = await InternetConnectionChecker().hasConnection;
    //     if (result == true) {
    //       //print("connecte $connexion");
    //       if (connexion == false) {
    //         Get.back();
    //         showToast(result);
    //         connexion = true;
    //       } else {
    //         //print(" deja connextio $connexion");
    //       }
    //     } else {
    //       //print("pas de connextio $connexion");

    //       if (connexion == true) {
    //         showToast(result);
    //         connexion = false;
    //       } else {
    //         // Get.back();
    //         //print("attente de connextio $connexion");
    //       }
    //       //print(InternetConnectionChecker().connectionStatus.obs);
    //     }
    //   });
  }

  showToast(bool status) {
    Color? color = status ? Colors.green : Colors.orange[600];
    String message = !status
        ? "Votre appareil n'es pas connecté à Internet."
        : "Vous ête connecté.";
    Get.snackbar(
      status ? 'vous êtes en ligne maintenant' : 'vous êtes hors ligne',
      message,
      icon: Icon(
        status ? Icons.wifi : Icons.wifi_off_sharp,
        color: color,
      ),
      borderRadius: 5,
      isDismissible: true,
      onTap: (getBar) {},
      snackPosition: SnackPosition.TOP,
      duration:
          status ? const Duration(seconds: 4) : const Duration(seconds: 10),
      barBlur: 200,
      shouldIconPulse: true,
      maxWidth: kWidth,
      snackStyle: SnackStyle.GROUNDED,
      leftBarIndicatorColor: color,
      backgroundColor: Colors.white,
      margin: EdgeInsets.zero,
      // padding: EdgeInsets.zero,
      borderWidth: 100,
    );
  }

  showIndisponible() {
    Color? color = Colors.green;

    Get.snackbar('fonctionnalite', 'Bientot disponible...',
        icon: Icon(
          Icons.warning,
          color: color,
        ),
        borderRadius: 5,
        isDismissible: true,
        onTap: (getBar) {},
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        barBlur: 20,
        shouldIconPulse: true,
        maxWidth: 450,
        snackStyle: SnackStyle.GROUNDED,
        leftBarIndicatorColor: color,
        backgroundColor: Colors.white);
  }

  GetStorage box = GetStorage();

  getTheme(context) {
    //print("sarttttttttttttt----------------${box.read('isDark')}");

    return box.read('isDark') == null ? false : box.read('isDark');
  }

  changeTheme(context) {
    //print("----------------${box.read('isDark')}");
    if (Theme.of(context).brightness == Brightness.dark) {
      box.write('isDark', false);
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
      box.write('isDark', true);
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
