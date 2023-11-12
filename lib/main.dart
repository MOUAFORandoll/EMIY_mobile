import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
import 'package:EMIY/utils/Services/core.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'styles/colorApp.dart';
import 'styles/textStyle.dart';

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

final _darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: ColorsApp.primaryText,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  // accentColor: Colors.white,
  // accentIconTheme: IconThemeData(color: ColorsApp.primaryBlue),
  dividerColor: ColorsApp.primaryBlue,
  textTheme: TextTheme(
    bodyText2:
        TextStyle(fontFamily: 'Montserrat', color: ColorsApp.primaryText),
  ),
);

final _lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: ColorsApp.bgColor,
  iconTheme: IconThemeData(
    color: ColorsApp.primaryBlue,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: kBasics + 1,
        color: ColorsApp.primaryText,
        fontWeight: FontWeight.w700),
  ),
  // Couleur du texte principal
  primaryTextTheme: TextTheme(
    headline6: TextStyle(
      color: ColorsApp.primaryText,
    ),
  ),
  dividerColor: Colors.white54,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w600,
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kTitle,
      color: ColorsApp.primaryText,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kTitle,
      color: ColorsApp.primaryText,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kTitle,
      color: ColorsApp.primaryText,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: kBasics,
      color: ColorsApp.primaryText,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.grey,
    backgroundColor: ColorsApp.bgColor,
    errorColor: ColorsApp.red,
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).brightness == Brightness.dark) {
    //   box.write('isDark', true);
    // } else {
    //   box.write('isDark', false);
    // }

    // Get.find<GeneralController>().getThemeInit(context);

    return GetMaterialApp(
      translations: Transalations(),
      locale: Get.find<GeneralController>().lan,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: ThemeMode.light, //ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // initialBinding: MyBinding(),
      initialRoute: AppLinks.SPLASHSCREEN,
      getPages: AppRoutes.pages,
    );
  }
}


// flutter pub run flutter_launcher_icons:main