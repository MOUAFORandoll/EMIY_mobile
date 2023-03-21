import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/NotificationService.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:Fahkap/utils/Services/storageService2.dart';
import 'package:Fahkap/utils/Services/translations.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializePlatformNotifications();
//
//
// 
//   var database0 = new DB();
//   await database0.init();

  MyBinding().dependencies();

// await MyBinding().onInit();

// await init();
  runApp(MyApp());
}

final _darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final _lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).brightness == Brightness.dark) {
    //   box.write('isDark', true);
    // } else {
    //   box.write('isDark', false);
    // }

    // MyBinding().requestPermission();
    MyBinding().onInit();
    Get.find<ActionController>().getThemeInit(context);

    return GetMaterialApp(
      translations: Transalations(),
      locale: Get.find<ActionController>().lan,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: ThemeMode.light, //ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      initialRoute: AppLinks.SPLASHSCREEN,
      getPages: AppRoutes.pages,
    );
  }
}
