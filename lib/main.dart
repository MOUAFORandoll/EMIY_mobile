import 'dart:async';

import 'package:EMIY/Views/UsersMange/RegisterScreen.dart';
import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/controller/linkController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
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

// await init();
  runApp(MyApp());
  await uniLink();
}

Future checkDeepLink() async {
  StreamSubscription _sub;
  try {
    print("checkDeepLink");
    await UniLink.getInitialLink();

    _sub = UniLink.getUriLinksStream().listen(
        (Uri uri) {
          print('uri: $uri');
          WidgetsFlutterBinding.ensureInitialized();
          // runApp(MyApp(uri: uri));
        } as void Function(Uri? event)?, onError: (err) {
      // Handle exception by warning the user their action did not succeed

      print("onError");
    });
  } on PlatformException {
    print("PlatformException");
  } on Exception {
    print('Exception thrown');
  }
}

uniLink() async {
  /**
     * 
     le lien de parainage est sous cette forme :
     * https://emiy-shop.000webhostapp.com/{type}/trgg
     *
     * type : 
     *    - produits => pour afficher un produit precis 
     *    - subscribes => pour inscrire avec un parain
     * 

     */
  try {
    final uri = await getInitialUri();
    if (uri == null) {
      print('no initial uri');
    } else {
      var direction = uri.path.split('/');
      var type = direction[1];
      print('--${uri}---00-lien----------ici----------------------');
      if (type == 'produits') {
        var codeProduit = direction[2];

        print('----------codeProduit--------${codeProduit}------');
        Get.find<LinkController>().getUniLinkProduit(codeProduit);
        Get.toNamed(AppLinks.PRODUCT_FOR_LINK);
      }
      if (type == 'boutiques') {
        var codeBoutique = direction[2];

        print('----------codeBoutique--------${codeBoutique}------');
        Get.find<LinkController>().getUniLinkBoutique(codeBoutique);
        Get.toNamed(AppLinks.BOUTIQUE_FOR_LINK);
      }

      if (type == 'subscribes') {
        var codeParrain = direction[2];
        print('----------codeParrain--------${codeParrain}------');
        Get.find<ManagerController>().setCodeParrain(codeParrain);
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
                        //     // _controller.chageState(!_controller.addProduct);
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
                      child: RegisterScreen())
                ])))
              ])),
          isScrollControlled: true,
        );
      }
      print('got initial uri: $uri');
    }
    // var direction = uri!.path!
  } on PlatformException {
    // Platform messages may fail but we ignore the exception
    print('falied to get initial uri');
  } on FormatException catch (err) {
    print('malformed initial uri');
  }
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
final light = ThemeData(
    fontFamily: 'OpenSan',
    textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black)),
    backgroundColor: ColorsApp.bg,
    appBarTheme: const AppBarTheme(foregroundColor: Colors.black87));
final dark = ThemeData.dark().copyWith(
  backgroundColor: Colors.black,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).brightness == Brightness.dark) {
    //   box.write('isDark', true);
    // } else {
    //   box.write('isDark', false);
    // }

    Get.find<ActionController>().getThemeInit(context);

    return GetMaterialApp(
      translations: Transalations(),
      locale: Get.find<ActionController>().lan,
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.light, //ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // initialBinding: MyBinding(),
      initialRoute: AppLinks.SPLASHSCREEN,
      getPages: AppRoutes.pages,
    );
  }
}
