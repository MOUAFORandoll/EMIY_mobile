import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/utils/Services/NotificationService.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializePlatformNotifications();

  MyBinding().dependencies();

  // await MyBinding().onInit();

  // await init();
  runApp(MyApp());
}

ThemeData _darkTheme = ThemeData(
    accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ));

ThemeData _lightTheme = ThemeData(
    accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).brightness == Brightness.dark) {
    //   box.write('isDark', true);
    // } else {
    //   box.write('isDark', false);
    // }
    MyBinding().onInit();
    MyBinding().requestPermission();
    MyBinding().onGetAll();
    Get.find<ActionController>().getThemeInit(context);

    return GetMaterialApp(
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      initialRoute: AppLinks.FIRST,
      getPages: AppRoutes.pages,
    );
  }
}
