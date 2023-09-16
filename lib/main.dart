// @dart=2.12.0
import 'dart:async';

import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/styles/theme.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
import 'package:EMIY/utils/Services/core.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializePlatformNotifications();
  // await FlutterDownloader.initialize(debug: true);

  await initServices();
  await initApp();

// await MyBinding().onInit();

  runApp(MyApp());
// await init();
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).brightness == Brightness.dark) {
    //   box.write('isDark', true);
    // } else {
    //   box.write('isDark', false);
    // }

    Get.find<GeneralController>().getThemeInit(context);

    return GetMaterialApp(
      translations: Transalations(),
      locale: Get.find<GeneralController>().lan,
      theme: ThemeStyle().lightTheme,
      darkTheme:  ThemeStyle(). darkTheme,
      themeMode: ThemeMode.light, //ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // initialBinding: MyBinding(),
      initialRoute: AppLinks.SPLASHSCREEN,
      getPages: AppRoutes.pages,
    );
  }
}
