import 'package:fahkapmobile/utils/Services/dependancies.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyBinding().dependencies();

  // await MyBinding().onInit();

  // await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (Theme.of(context).brightness == Brightness.dark) {
    //   box.write('isDark', true);
    // } else {
    //   box.write('isDark', false);
    // }
    MyBinding().onInit();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialBinding: MyBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppLinks.TEST,
      getPages: AppRoutes.pages,
    );
  }
}
