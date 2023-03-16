import 'package:connectivity/connectivity.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class ViewFunctions {
  snackBar(title, body, bgColor) {
    return Get.snackbar(
      title,
      body,
      icon: Icon(Icons.shopping_bag, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      colorText: Colors.white,
      duration: Duration(seconds: 5),
      // isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  cronFunction(timer) {
    var i = 0;
    var cron = Cron();
    cron.schedule(Schedule.parse('*/$timer * * * * *'), () {
      verifiedConnection();
      print(i);
      i++;
    });
  }
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
        print(err);
      }
    }
  } */

  bool connexion = true;
  verifiedConnection() {
    DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print("connecte $connexion");
          if (connexion == false) {
            Get.back();
            showToast(true);
            connexion = true;
          } else {
            print(" deja connextio $connexion");
          }
          break;
        case DataConnectionStatus.disconnected:
          print("pas de connextio $connexion");

          if (connexion == true) {
            showToast(false);
            connexion = false;
          } else {
            // Get.back();
            print("attente de connextio $connexion");
          }
          break;
      }
    });

    //   var cron = Cron();
    //   cron.schedule(Schedule.parse('*/2 * * * * *'), () async {
    //     var a = Connectivity().checkConnectivity;
    //     print("voici *********************** $a");
    //     bool result = await InternetConnectionChecker().hasConnection;
    //     if (result == true) {
    //       print("connecte $connexion");
    //       if (connexion == false) {
    //         Get.back();
    //         showToast(result);
    //         connexion = true;
    //       } else {
    //         print(" deja connextio $connexion");
    //       }
    //     } else {
    //       print("pas de connextio $connexion");

    //       if (connexion == true) {
    //         showToast(result);
    //         connexion = false;
    //       } else {
    //         // Get.back();
    //         print("attente de connextio $connexion");
    //       }
    //       print(InternetConnectionChecker().connectionStatus.obs);
    //     }
    //   });
  }

  showToast(bool status) {
    Color? color = status ? Colors.green : Colors.orange[600];
    String message = !status
        ? "Votre appareil n'es pas connecté à Internet. \n veillez vous assurer que votre connexion fonctionne."
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
            status ? const Duration(seconds: 4) : const Duration(minutes: 10),
        barBlur: 20,
        shouldIconPulse: true,
        maxWidth: 450,
        snackStyle: SnackStyle.GROUNDED,
        leftBarIndicatorColor: color,
        backgroundColor: Colors.white);
  }

  GetStorage box = GetStorage();

  getTheme(context) {
    print("sarttttttttttttt----------------${box.read('isDark')}");

    return box.read('isDark') == null ? false : box.read('isDark');
  }

  changeTheme(context) {
    print("----------------${box.read('isDark')}");
    if (Theme.of(context).brightness == Brightness.dark) {
      box.write('isDark', false);
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
      box.write('isDark', true);
    }
  }
}
