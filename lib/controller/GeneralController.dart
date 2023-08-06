import 'package:EMIY/Views/CategoryBoutique/CategoryView.dart';
import 'package:EMIY/Views/Home/HomeView.dart';
import 'package:EMIY/Views/Space/MySpace.dart';
import 'package:EMIY/Views/Space/Negociation/ListNegociationView.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/productController.dart';
import 'package:EMIY/model/data/CartModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/LivreurModel.dart';
import 'package:EMIY/model/data/ModePaiementModel.dart';
import 'package:EMIY/model/data/ProduitCategoryModel.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/model/socket/NotificationModel.dart';
import 'package:EMIY/repository/GeneralRepo.dart';
import 'package:EMIY/repository/BuyShoopingCartRepo.dart';
import 'package:EMIY/repository/LivreurRepo.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/utils/Services/storageService2.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:EMIY/Views/Shopping/ShoppingView.dart';
import 'package:EMIY/Views/UsersMange/ManageView.dart';
import 'package:get_storage/get_storage.dart';
import 'package:EMIY/controller/cartController.dart';

import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:EMIY/Views/ComplementView/AboutUsView.dart';
import 'package:EMIY/Views/Shopping/ShoppingView.dart';
import 'package:EMIY/Views/UsersMange/ManageView.dart';
import 'package:EMIY/components/Widget/optionComponent.dart';
// import 'package:antdesign_icons/antdesign_icons.dart';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneralController extends GetxController {
  final GeneralRepo generalRepo;
  GeneralController({required this.generalRepo});
  final dababase = Get.find<DataBaseController>();

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
    // refresh();
    try {
      Response response = await generalRepo.getModePaiement();
      _lmodePaiement.clear();
      if (response.body != null) {
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
      //print(e);
    }
  }

  GetStorage box = GetStorage();

  changeTheme() async {
    // //print(box.read('theme') == '1');
    _dark = !_dark;
    update();

    await dababase.saveTheme(_dark ? "1" : "0");

    // _dark = box.read('theme') != null ? box.read('theme') == '1' : false;

    // Get.changeThemeMode(
    //   _dark ? ThemeMode.dark : ThemeMode.light,
    // );
    getTheme();
    //print(box.read('theme'));
  }

  getCurrentTheme() {
    return this.dark;
  }

  getTheme() async {
    var theme = await dababase.getTheme();
    _dark = theme != null ? theme == '1' : false;
    update();
    Get.changeTheme(!_dark ? ThemeData.light() : ThemeData.dark());
  }

  getThemeInit(context) async {
    var theme = await dababase.getTheme();
    _dark = theme != null
        ? theme == '1'
        : Theme.of(context).brightness == Brightness.dark;
    Get.changeTheme(!_dark ? ThemeData.light() : ThemeData.dark());
    update();
  }

  Locale _lan = Locale('fr', 'FR');
  Locale get lan => _lan;

  // getLan() async {
  //   _lan = await dababase.getLan();
  //   //print('_lan********');
  //   //print(_lan);

  //   update();
  // }

  final List locale = [
    {'name': 'En', 'locale': const Locale('en', 'US')},
    {'name': 'Fr', 'locale': const Locale('fr', 'FR')},
  ];

  final lang = (Get.locale?.languageCode ?? 'Fr').obs;

  updateLanguage(String localLang) async {
    int index = locale.indexWhere((element) => element['name'] == localLang);
    if (index != -1) {
      lang.value = locale[index]['name'];
      //        fn.closeSnack();

      Get.updateLocale(locale[index]['locale']);

      await dababase.saveLan(lang.value);
    }
  }

  getLanguage(String localLang) {
    int index = locale.indexWhere((element) => element['name'] == localLang);
    if (index != -1) {
      return locale[index]['locale'];
    }
  }

  getLanguageInit() async {
    var lan = await dababase.getLan();
    int index = locale.indexWhere((element) => element['name'] == lan);
    if (index != -1) {
      lang.value = locale[index]['name'];
      Get.updateLocale(locale[index]['locale']);

      // return locale[index]['locale'];
    }
  }

  final CarouselController _controller = CarouselController();
  CarouselController get controller => _controller;
  int _index = 0;
  int get index => _index;
  var fn = new ViewFunctions();

  setIndex(index) {
    _index = index;
    update();
  }

  likeProduit(/* note, */ codeProduit) async {
    var getU = await dababase.getKey();
    if (getU == null) {
      fn.snackBar('Note', 'Veuillez vous connecter', true);
      return false;
    }
    var data = {
      // 'like': note,
      'codeProduit': codeProduit,
      "keySecret": getU,
    };

    Get.find<ProductController>().likeProductInPopular(codeProduit);
    //print(data);

    // fn.loading('Note', 'Notation du produit en cours');

    try {
      Response response = await generalRepo.addLikeProduit(data);

      fn.closeSnack();

      update();
      if (response.statusCode == 200) {
        // fn.snackBar('Like', 'Effectue', true);
        ProduitModel produit = ProduitModel.fromJson(response.body['produit']);
        Get.find<ProductController>().updateProductInPopular(produit);
        Get.find<ProductController>().getListProduitPreference();
      } else {
        Get.find<ProductController>().likeProductInPopular(codeProduit);
        fn.snackBar('Like', 'Erreur', false);
      }
    } catch (e) {
      fn.closeSnack();
      Get.find<ProductController>().likeProductInPopular(codeProduit);
      fn.snackBar('Like', 'Erreur', false);

      //print(e);
    }
  }

  notationBoutique(note, codeBoutique) async {
    if (note < 0 || note > 5) {
      return false;
    }
    var getU = await dababase.getKey();
    if (getU == null) {
      fn.snackBar('Note', 'Veuillez vous connecter', true);
    }
    var data = {
      'note': note,
      'codeBoutique': codeBoutique,
      "keySecret": getU,
    };
    //print(data);
    fn.loading('Note', 'Notation de la boutique en cours');

    try {
      Response response = await generalRepo.addNotationBoutique(data);
      //print(response.body);
      fn.closeLoader();

      update();
      if (response.statusCode == 200) {
        fn.snackBar('Note', 'Effectue', true);
      } else {
        fn.snackBar('Note', 'Erreur', false);
      }
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Note', 'Erreur', false);
      //print(e);
    }
  }

  late ScrollController _controllerScrollNotification;
  get controllerScrollNotification => _controllerScrollNotification;
  @override
  void onInit() {
    fn.verifiedConnection();
    _controllerScrollNotification = ScrollController()
      ..addListener(_scrollListenerNotification);
    update();
  }

  // int tabCurrentIndex = 0;

  // setTabIndex(index) {
  //   tabCurrentIndex = index;
  //   update();
  // }

  // Widget buildContentSpace() {
  //   switch (tabCurrentIndex) {
  //     case 0:
  //       return ListNegociationView();
  //     // case 1:
  //     //   return SearchView();
  //     case 1:
  //       //   return ListBoutiqueView();
  //       // case 2:
  //       return CategoryView();
  //     default:
  //       return ListNegociationView();
  //   }
  // }

  int _currentIndex = 0;
  Widget buildContent() {
    switch (_currentIndex) {
      case 0:
        return HomeView();
      // case 1:
      //   return SearchView();
      case 1:
        //   return ListBoutiqueView();
        // case 2:
        return CategoryView();

      // case 2:
      //   return SearchView();
      case 2:
        return MySpace();
      case 3:
        return ShoppingView();

      case 4:
        return ManageView();

      // case 4:
      //   return ProfileUserView();

      default:
        return HomeView();
    }
  }

  Widget buildBorderRadiusDesign() {
    return /*GetBuilder<ProductController>(builder: (_controller) {
      return  Offstage(
          offstage: _controller.isBottomBarVisible,
          child: */
        CustomNavigationBar(
      iconSize: 30.0,
      // elevation: 0.0,
      scaleFactor: 0.4,
      selectedColor: Color(0xff0c18fb),
      strokeColor: Color(0x300c18fb),
      unSelectedColor: Colors.grey[600],
      backgroundColor: ColorsApp.greySearch,
      // borderRadius: Radius.circular(15.0),
      // isFloating: true,
      // blurEffect: true,
      items: [
        CustomNavigationBarItem(
            icon: Container(
              height: kSmHeight / 1.7,
              width: kSmWidth / 4.2,
              child: SvgPicture.asset(
                Assets.home,
                width: 90,
                height: 90,
                color: _currentIndex == 0 ? ColorsApp.skyBlue : ColorsApp.grey,
              ),
            ),
            title: Container(
                padding: EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: _currentIndex == 0
                            ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                            : BorderSide.none,
                        top: BorderSide.none)),
                child: Text('home'.tr,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == 0
                          ? ColorsApp.skyBlue
                          : ColorsApp.grey,
                    )))), // CustomNavigationBarItem(

        CustomNavigationBarItem(
          icon: Container(
            height: kSmHeight / 1.7,
            width: kSmWidth / 4.2,
            child: SvgPicture.asset(
              Assets.grid1,
              width: 80,
              height: 80,
              color: _currentIndex == 1 ? ColorsApp.skyBlue : ColorsApp.grey,
            ),
          ),
          title: Container(
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: _currentIndex == 1
                          ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                          : BorderSide.none,
                      top: BorderSide.none)),
              child: Text('categories'.tr,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color:
                        _currentIndex == 1 ? ColorsApp.skyBlue : ColorsApp.grey,
                  ))),
        ),

        CustomNavigationBarItem(
          icon: Container(
            height: kSmHeight / 1.7,
            width: kSmWidth / 4.2,
            child: SvgPicture.asset(
              Assets.user,
              width: 90,
              height: 90,
              color: _currentIndex == 2 ? ColorsApp.skyBlue : ColorsApp.grey,
            ),
          ),
          title: Container(
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: _currentIndex == 2
                          ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                          : BorderSide.none,
                      top: BorderSide.none)),
              child: Text('My Space',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color:
                        _currentIndex == 2 ? ColorsApp.skyBlue : ColorsApp.grey,
                  ))),
        ),

        CustomNavigationBarItem(
          icon: Container(
            height: kSmHeight / 1.7,
            width: kSmWidth / 4.2,
            child: SvgPicture.asset(
              Assets.shoppingCart,
              width: 90,
              height: 90,
              color: _currentIndex == 3 ? ColorsApp.skyBlue : ColorsApp.grey,
            ),
          ),
          title: Container(
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: _currentIndex == 3
                          ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                          : BorderSide.none,
                      top: BorderSide.none)),
              child: Text('Shop',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color:
                        _currentIndex == 3 ? ColorsApp.skyBlue : ColorsApp.grey,
                  ))),
        ),

        CustomNavigationBarItem(
          icon: Container(
            height: kSmHeight / 1.7,
            width: kSmWidth / 4.2,
            child: Icon(
              Icons.settings,
              size: 25,
              color: _currentIndex == 4 ? ColorsApp.skyBlue : ColorsApp.grey,
            ),
          ),
          title: Container(
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: _currentIndex == 4
                          ? BorderSide(color: ColorsApp.skyBlue, width: 2)
                          : BorderSide.none,
                      top: BorderSide.none)),
              child: Text('setting'.tr,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color:
                        _currentIndex == 4 ? ColorsApp.skyBlue : ColorsApp.grey,
                  ))),

          // badgeCount: _badgeCounts[4],
          // showBadge: _badgeShows[4],
        ),
        // CustomNavigationBarItem(
        //   icon: Icon(Icons.hourglass_disabled),
        //   badgeCount: _badgeCounts[4],
        //   showBadge: _badgeShows[4],
        // ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        _currentIndex = index;
        update();
        if (index == 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.find<ProductController>().restoreScrollPosition();
          });
        }
      },
    );
    //});
    // });
  }

  generalSocket() {
    new SocketService().general(socketGeneralNotification);
  }

  socketGeneralNotification(data) {
    print('000-...............');
    print(data);
    new NotificationService().emitNotificationGenearal(data['message']);
    update();
    // ici on doit faire l'ajout a la liste des message en locale dans le telephone du user
  }

  NotificationSocket() async {
    var getU = await dababase.getKey();
    new SocketService().notifications(getU, generalNotification);
  }

  generalNotification(notification) {
    print('000-...............');
    print(notification);
    new NotificationService().emitNotifications(notification);

    _notificationList.insert(0, notification);
    update();
    // ici on doit faire l'ajout a la liste des message en locale dans le telephone du user
  }

  void _scrollListenerNotification() {
    if (_controllerScrollNotification.offset + Get.height * 1.5 >=
        _controllerScrollNotification.position.maxScrollExtent) {
      getListNotifications();
    }
  }

  List<NotificationModel> _notificationList = [];
  List<NotificationModel> _notificationListSave = [];
  List<NotificationModel> get notificationList => _notificationList;

  int indexNotification = 1;
  int _isLoadNotification = 0;
  int get isLoadNotification => _isLoadNotification;

  bool _loaddata = false;
  bool get loaddata => _loaddata;
  getListNotifications() async {
    var getU = await dababase.getKey();
    if (getU != null) {
      // _notificationList = [];

      // _isLoadNotification = 0;
      _loaddata = true;
      update();
      try {
        Response response =
            await generalRepo.getListNotifications(indexNotification, getU);
        _notificationList.clear();
        if (response.body != null) {
          if (response.body['data'].length != 0) {
            _notificationList.addAll((response.body['data'] as List)
                .map((e) => NotificationModel.fromJson(e))
                .toList());
          }
          indexNotification++;
          _isLoadNotification = 1;
          _loaddata = false;

          update();
        }
      } catch (e) {
        _loaddata = false;
        update();
        //print(e);
      }
    }
  }

  readNotification(idNotification) async {
    try {
      _notificationList
          .where((element) => element.id == idNotification)
          .first
          .read = true;
      update();
      Response response = await generalRepo.readNotifications(idNotification);
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Note', 'Erreur', false);
      //print(e);
    }
  }
}
