import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/utils/Services/dependancies.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyBinding().dependencies();
  // await MyBinding().onInit();

  // await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      box.write('isDark', true);
    } else {
      box.write('isDark', false);
    }
    MyBinding().onInit();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppLinks.SPLASHSCREEN,
      getPages: AppRoutes.pages,
    );
  }
}
