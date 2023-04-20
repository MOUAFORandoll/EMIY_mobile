import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/model/data/CartModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/LivreurModel.dart';
import 'package:Fahkap/model/data/ModePaiementModel.dart';
import 'package:Fahkap/model/data/ProduitCategoryModel.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/repository/ActionRepo.dart';
import 'package:Fahkap/repository/BuyShoopingCartRepo.dart';
import 'package:Fahkap/repository/LivreurRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/Services/storageService2.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';

class ActionController extends GetxController {
  final ActionRepo actionRepo;
  ActionController({required this.actionRepo});

  notificationSnackBar(title, id) async {
    //print("****************MNOtifii");
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Recover',
      'ddd',
      '$title',
      icon: 'launcher_icon',
      importance: Importance.max,
      // priority: Priority.high,
      visibility: NotificationVisibility.public,
      fullScreenIntent: true,
      largeIcon: DrawableResourceAndroidBitmap('launcher_icon'),
      enableVibration: true,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    // if (box.read("open") == false) {
    // return await flutterLocalNotificationsPlugin.show(
    //     id, 'Notification in :', '$title', platformChannelSpecifics,
    //     payload: 'item x');
    // } else {
    //   return Fluttertoast.showToast(
    //       msg: 'New Notifications in : $title',
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.TOP,
    //       timeInSecForIosWeb: 5,
    //       backgroundColor: ColorsApp.skyBlue,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

  ScrollController _scrollcontroller = new ScrollController();
  ScrollController get scrollcontroller => _scrollcontroller;
  bool _dark = false;
  bool get dark => _dark;
  // getTheme(context) {
  //   _dark = vf.getTheme(context);
  //   update();
  // }

  // var vf = new ViewFunctions();
  // changeTheme(context) {
  //   vf.changeTheme(context);
  //   getTheme(context);
  // }

  List<ModePaiementModel> _lmodePaiement = [];
  List<ModePaiementModel> get lmodePaiement => _lmodePaiement;
  int _isLoadedMP = 0;
  int get isLoadedMP => _isLoadedMP;

  int _selected = 0;
  int get selected => _selected;
  selectMode(mode) {
    _selected = mode;
    update();
  }

  getListModePaiement() async {
    _isLoadedMP = 0;
    update();
    try {
      Response response = await actionRepo.getModePaiement();
      _lmodePaiement.clear();
      if (response.body != null) {
        print('***************************************mpp');
        print(response.body);
        if (response.body['data'].length != 0) {
          _lmodePaiement.addAll((response.body['data'] as List)
              .map((e) => ModePaiementModel.fromJson(e))
              .toList());
        }
        // _isLoadedMP = 1;

        // update();
      }
      _isLoadedMP = 1;

      update();
      _isLoadedMP = 1;
      update();
    } catch (e) {
      print(e);
    }
  }

  GetStorage box = GetStorage();

  changeTheme() async {
    // print(box.read('theme') == '1');
    _dark = !_dark;
    update();

    await Get.find<DB>().saveTheme(_dark ? "1" : "0");

    // _dark = box.read('theme') != null ? box.read('theme') == '1' : false;

    // Get.changeThemeMode(
    //   _dark ? ThemeMode.dark : ThemeMode.light,
    // );
    getTheme();
    print(box.read('theme'));
  }

  getCurrentTheme() {
    return this.dark;
  }

  getTheme() async {
    var theme = await Get.find<DB>().getTheme();
    _dark = theme != null ? theme == '1' : false;
    update();
    Get.changeTheme(!_dark ? ThemeData.light() : ThemeData.dark());
  }

  getThemeInit(context) async {
    var theme = await Get.find<DB>().getTheme();
    _dark = theme != null
        ? theme == '1'
        : Theme.of(context).brightness == Brightness.dark;
    Get.changeTheme(!_dark ? ThemeData.light() : ThemeData.dark());
    update();
  }

  Locale _lan = Locale('fr', 'FR');
  Locale get lan => _lan;

  // getLan() async {
  //   _lan = await Get.find<DB>().getLan();
  //   print('_lan********');
  //   print(_lan);

  //   update();
  // }

  final List locale = [
    {'name': 'En', 'locale': const Locale('en', 'US')},
    {'name': 'Fr', 'locale': const Locale('fr', 'FR')},
  ];

  final lang = (Get.locale?.languageCode ?? 'Fr').obs;
  var store = Get.find<DB>();

  updateLanguage(String localLang) async {
    int index = locale.indexWhere((element) => element['name'] == localLang);
    if (index != -1) {
      lang.value = locale[index]['name'];
      // Get.back();
      Get.updateLocale(locale[index]['locale']);
      print(lang.value);
      await store.saveLan(lang.value);
    }
  }

  getLanguage(String localLang) {
    int index = locale.indexWhere((element) => element['name'] == localLang);
    if (index != -1) {
      return locale[index]['locale'];
    }
  }

  getLanguageInit() async {
    var lan = await Get.find<DB>().getLan();
    int index = locale.indexWhere((element) => element['name'] == lan);
    if (index != -1) {
      lang.value = locale[index]['name'];
      print(
          '${lan} *-*-*-*-*--*-**-*-*-*-*-*-*--*-**-*-*-*-*-*-*--*-**-*-*-*-*-*-*--*-**-*-');
      Get.updateLocale(locale[index]['locale']);
      print(locale[index]['locale']);

      print(
          '*-*-*-*-*--*-**-*-*-*-*-*-*--*-**-*-*-*-*-*-*--*-**-*-*-*-*-*-*--*-**-*-');

      // return locale[index]['locale'];
    }
  }

  final CarouselController _controller = CarouselController();
  CarouselController get controller => _controller;
  int _index = 0;
  int get index => _index;

  setIndex(index) {
    _index = index;
    update();
  }
   

}
