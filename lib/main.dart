import 'dart:async';

import 'package:EMIY/Views/UsersMange/RegisterScreen.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/linkController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
import 'package:EMIY/utils/Services/UniLinkService.dart';
import 'package:EMIY/utils/Services/core.dart';
import 'package:EMIY/utils/Services/dependancies.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/storageService2.dart';
import 'package:EMIY/utils/Services/translations.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:uni_links/uni_links.dart' as UniLink;
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializePlatformNotifications();
  await FlutterDownloader.initialize(debug: true);

  await initServices();
  await initApp();

// await MyBinding().onInit();

  runApp(MyApp());
// await init();
}

final light = ThemeData(
    fontFamily: 'Josefin_Sans',
    textTheme: const TextTheme(
        bodyText1: TextStyle(color: ColorsApp.black),
        bodyText2: TextStyle(color: ColorsApp.black)),
    backgroundColor: ColorsApp.bg,
    appBarTheme: const AppBarTheme(foregroundColor: ColorsApp.black));
final dark = ThemeData.dark().copyWith(
  backgroundColor: ColorsApp.black,
);

final _darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: ColorsApp.primaryText,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: ColorsApp.black),
  dividerColor: ColorsApp.greyTh,
  textTheme: TextTheme(
    bodyText2:
        TextStyle(fontFamily: 'Montserrat', color: ColorsApp.primaryText),
  ),
);

final _lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  // Couleur du texte principal
  backgroundColor: ColorsApp.bgColor,

  primaryTextTheme: TextTheme(
    headline6: TextStyle(
      color: ColorsApp.primaryText,
    ),
  ),
  // Couleur du bouton pour autoriser la localisation
  buttonColor: ColorsApp.skyBlue,
  // Couleur du bouton pour refuser la localisation
  disabledColor: ColorsApp.greySearch,
  dividerColor: Colors.white54,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      color: ColorsApp.primaryText,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: ColorsApp.primaryText,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      color: ColorsApp.primaryText,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      color: ColorsApp.primaryText,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      color: ColorsApp.primaryText,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 12,
      color: ColorsApp.primaryText,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      color: ColorsApp.primaryText,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      color: ColorsApp.primaryText,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      color: ColorsApp.primaryText,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      color: ColorsApp.primaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      color: ColorsApp.primaryText,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      color: ColorsApp.primaryText,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      color: ColorsApp.primaryText,
    ),
  ),
  appBarTheme: const AppBarTheme(
      foregroundColor: ColorsApp.bgColor, backgroundColor: ColorsApp.bgColor),

  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(background: ColorsApp.bgColor)
      .copyWith(
        secondary: ColorsApp.primaryText,
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

    Get.find<GeneralController>().getThemeInit(context);

    return GetMaterialApp(
      translations: Transalations(),
      locale: Get.find<GeneralController>().lan,
      theme: _lightTheme,
      darkTheme: dark,
      themeMode: ThemeMode.light, //ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // initialBinding: MyBinding(),
      initialRoute: AppLinks.SPLASHSCREEN,
      getPages: AppRoutes.pages,
    );
  }
}
