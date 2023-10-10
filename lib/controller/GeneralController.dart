import 'package:EMIY/Views/CategoryBoutique/CategoryView.dart';
import 'package:EMIY/Views/Home/HomeView.dart';
import 'package:EMIY/Views/Short/ShortView.dart';
import 'package:EMIY/Views/Space/Negociation/ListNegociationView.dart';
import 'package:EMIY/Views/Space/Notifications/NotificationView.dart';
import 'package:EMIY/Views/Space/ServiceClient/ServiceClientView.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Widget/SelectComponent.dart';
import 'package:EMIY/controller/MySearchController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/linkController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/BoutiqueModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/HomeComponentModel.dart';
import 'package:EMIY/model/data/ModePaiementModel.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/model/socket/NotificationModel.dart';
import 'package:EMIY/repository/GeneralRepo.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:EMIY/Views/Shopping/ShoppingView.dart';
import 'package:EMIY/Views/UsersMange/ManageView.dart';
import 'package:get_storage/get_storage.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class GeneralController extends GetxController {
  final GeneralRepo generalRepo;
  GeneralController({required this.generalRepo});
  final dababase = Get.find<DataBaseController>();

  void onInit() async {
    super.onInit();
    // TODO: implement initState
    // dababase = await DataBaseController.getInstance();
    // ;

    fn.verifiedConnection();
    _controllerScrollNotification = ScrollController()
      ..addListener(_scrollListenerNotification);
    update();
  }

  // final GlobalKey _scaffoldKey = new GlobalKey();
  // GlobalKey get scaffoldKey => _scaffoldKey;
  openDrawer(context) {
    // _scaffoldKey.currentState!.openDrawer();
    Scaffold.of(context).openDrawer();
  }

  ScrollController _scrollcontroller = new ScrollController();
  ScrollController get scrollcontroller => _scrollcontroller;
  bool _dark = false;
  bool get dark => _dark;
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

  updateBoutiqueAll(codeBoutique) {
    int index = Get.find<BoutiqueController>()
        .listAbonnememtUser
        .indexWhere((boutique) => boutique.codeBoutique == codeBoutique);
    print('-${index}');
    if (index > 0) {
      Get.find<BoutiqueController>()
              .listAbonnememtUser[index]
              .status_abonnement =
          !Get.find<BoutiqueController>()
              .listAbonnememtUser[index]
              .status_abonnement;
      update();
    }

    int index0 = Get.find<CategoryBoutiqueController>()
        .ListBoutiqueF
        .indexWhere((boutique) => boutique.codeBoutique == codeBoutique);
    print('-${index}');
    if (index0 > 0) {
      Get.find<CategoryBoutiqueController>()
              .ListBoutiqueF[index0]
              .status_abonnement =
          !Get.find<CategoryBoutiqueController>()
              .ListBoutiqueF[index0]
              .status_abonnement;
      update();
    }

    int index1 = Get.find<CategoryBoutiqueController>()
        .ListBoutique
        .indexWhere((boutique) => boutique.codeBoutique == codeBoutique);
    if (index1 > 0) {
      Get.find<CategoryBoutiqueController>()
              .ListBoutique[index1]
              .status_abonnement =
          !Get.find<CategoryBoutiqueController>()
              .ListBoutique[index1]
              .status_abonnement;
      update();
    }
    if (Get.find<LinkController>().boutique != null) {
      var exist =
          Get.find<LinkController>().boutique.codeBoutique == codeBoutique;
      print('-${index}');
      if (exist) {
        Get.find<LinkController>().boutique.status_abonnement =
            !Get.find<LinkController>().boutique.status_abonnement!;
        update();
      }
    }
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

  likeProduit(/* note, */ codeProduit, source) async {
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

    //liste produit populaire
    if (source == 0) {
      Get.find<ProduitController>().likeProduitInPopular(codeProduit);
    }
    //liste produit supplementaire
    if (source == 1) {
      Get.find<ProduitController>().likeProduitInSupp(codeProduit);
    }
    //print(data);

    // fn.loading('Note', 'Notation du produit en cours');

    try {
      Response response = await generalRepo.addLikeProduit(data);

      fn.closeSnack();

      update();
      if (response.statusCode == 200) {
        // fn.snackBar('Like', 'Effectue', true);
        ProduitModel produit = ProduitModel.fromJson(response.body['produit']);
        Get.find<ProduitController>().updateProduitInPopular(produit);
        Get.find<ProduitController>().getListProduitPreference();
      } else {
        Get.find<ProduitController>().likeProduitInPopular(codeProduit);
        fn.snackBar('Like', 'Erreur', false);
      }
    } catch (e) {
      fn.closeSnack();
      Get.find<ProduitController>().likeProduitInPopular(codeProduit);
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
        return ShortView();
      //MySpace();
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

  Widget floatingActionButton() {
    return GetBuilder<ManagerController>(
        builder: (manage) => GetBuilder<TransactionController>(
            builder: (transaction) => manage.current == 4
                ? Container(
                    decoration: BoxDecoration(
                      color: ColorsApp.grey,
                    ),
                    margin: EdgeInsets.only(
                      left: kMdWidth / 4,
                      // right: kMdWidth / 6,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button(
                            borderRadius: 15.0,
                            width: Get.size.width * .4,
                            margin: EdgeInsets.only(
                                top: Get.size.height * .025, bottom: 0),
                            height: Get.size.height * .08,
                            loaderColor: Colors.white,
                            title: "Depot",
                            textColor: Colors.white,
                            itemColor: Colors.grey,
                            borderColor: Colors.transparent,
                            state: false,
                            enabled: true,
                            onTap: () async {
                              Get.bottomSheet(
                                Container(
                                  height: kHeight * .7,
                                  decoration: BoxDecoration(
                                      color: ColorsApp.grey,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kSmWidth * .07,
                                      vertical: kSmHeight * .09),
                                  // height: 800,

                                  child: SingleChildScrollView(
                                      child: Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FormComponent2(
                                          icon: Icons.money,
                                          type: 0,
                                          // controller: .montant,
                                          enabled: true,
                                          kType: TextInputType.number,
                                          titre: 'Montant',
                                          hint: ""),
                                      FormComponent2(
                                          icon: Icons.phone,
                                          type: 0,
                                          // controller: phone,
                                          kType: TextInputType.number,
                                          enabled: true,
                                          titre: 'phone',
                                          hint: " "),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text('Moyen de recharge'),
                                      ),
                                      GetBuilder<GeneralController>(
                                          builder: (_Acontroller) => Container(
                                              margin: EdgeInsets.only(
                                                  // top: Get.size.height * .015,
                                                  bottom:
                                                      Get.size.height * .025),
                                              // decoration: BoxDecoration(
                                              //     borderRadius: BorderRadius.circular(15),
                                              //     color: Colors.white),
                                              // padding: EdgeInsets.only(
                                              //   top: 25,
                                              // ),
                                              child: Column(
                                                children: [
                                                  SingleChildScrollView(
                                                      child: ListView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              _Acontroller
                                                                  .lmodePaiement
                                                                  .length,
                                                          itemBuilder: (_ctx,
                                                                  index) =>
                                                              SelectComponent(
                                                                  select: index +
                                                                          1 ==
                                                                      selected,
                                                                  mode: lmodePaiement[
                                                                      index])))
                                                ],
                                              ))),
                                      CustomBtn(
                                          color: ColorsApp.greenLight,
                                          title: 'Valider',
                                          onTap: () async {
                                            var _manager =
                                                Get.find<ManagerController>();
                                            var name = _manager.Userget.nom;
                                            var prenom = _manager.Userget.prenom
                                                .toString();

                                            var mode =
                                                Get.find<GeneralController>()
                                                    .selected;
                                            var keySecret = await _manager
                                                .dababase
                                                .getKey();
                                            // var data = {
                                            //   'keySecret': keySecret,
                                            //   'montant': montant.text,
                                            //   'numeroClient': phone.text,
                                            //   'nom': name,
                                            //   'prenom': prenom,
                                            //   'idModePaiement': mode
                                            // };
                                            // //print(data);
                                            // await transControll.depot(data);
                                          })
                                    ],
                                  )),
                                ),
                              );
                            }),
                        Button(
                            borderRadius: 15.0,
                            width: Get.size.width * .4,
                            margin: EdgeInsets.only(
                                top: Get.size.height * .025, bottom: 0),
                            height: Get.size.height * .08,
                            loaderColor: Colors.white,
                            title: "Retirer",
                            textColor: Colors.white,
                            itemColor: Colors.grey,
                            borderColor: Colors.transparent,
                            state: false,
                            enabled: true,
                            onTap: () async {
                              Get.bottomSheet(
                                Container(
                                  decoration: BoxDecoration(
                                      color: ColorsApp.grey,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kSmWidth * .07,
                                      vertical: kSmHeight * .09),
                                  // height: 800,

                                  child: SingleChildScrollView(
                                      child: Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FormComponent2(
                                          icon: Icons.money,
                                          type: 0,
                                          // controller: montant,
                                          enabled: true,
                                          kType: TextInputType.number,
                                          titre: 'Montant',
                                          hint: ""),
                                      FormComponent2(
                                          icon: Icons.phone,
                                          type: 0,
                                          // controller: phone,
                                          kType: TextInputType.number,
                                          enabled: true,
                                          titre: 'phone',
                                          hint: " "),
                                      FormComponent2(
                                          icon: Icons.lock,
                                          type: 0,
                                          // controller: password,
                                          enabled: true,
                                          titre: 'password',
                                          hint: " "),
                                      CustomBtn(
                                          color: ColorsApp.greenLight,
                                          title: 'Retirer',
                                          onTap: () async {
                                            // var data = {
                                            //   'keySecret': new GetStorage()
                                            //       .read('keySecret'),
                                            //   'montant': montant.text,
                                            //   'phone': phone.text,
                                            // };
                                            //print(data);
                                            // await transControll.retrait(data);
                                          })
                                    ],
                                  )),
                                ),
                              );
                            }),
                      ],
                    ),
                  )
                : manage.current == 3
                    ? FloatingActionButton(
                        onPressed: () {
                          Share.share(
                              'Inscris-toi avec mon lien et rejoins emiy : ' +
                                  manage.lienParrainnage,
                              subject: 'Look what I made!');
                        },
                        child: Container(
                            child: IconButtonF(
                          color: ColorsApp.black,
                          icon: Icons.share,
                        )),
                      )
                    : Container()));
  }

  Widget buildBorderRadiusDesign() {
    return /*GetBuilder<ProduitController>(builder: (_controller) {
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
      backgroundColor:
          _currentIndex == 2 ? ColorsApp.black : ColorsApp.greySearch,
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
                      fontSize: kMin,
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
                    fontSize: kMin,
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
              Assets.play,
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
              child: Text('Short',
                  style: TextStyle(
                    fontSize: kMin,
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
                    fontSize: kMin,
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
                    fontSize: kMin,
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
        Get.find<ManagerController>().setContain(0);
        update();
        if (index != 2) {
          // Get.find<ShortController>().disposePLayer();
          Get.find<ShortController>().setIntoShortView(false);
        }
        if (index == 2) {
          Get.find<ShortController>().setIntoShortView(true);

          // if (Get.find<ShortController>().controller != null) {
          //   if (Get.find<ShortController>().controller!.value.isPlaying) {
          //     Get.find<ShortController>().controller!.pause();
          //   } else {
          //     Get.find<ShortController>().controller!.play();
          //   }
          // }
        }

        if (index == 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.find<ProduitController>().restoreScrollPosition();
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

  //My Space
  int _spaceSelect = 0;
  int get spaceSelect => _spaceSelect;
  sectectSpace(index) {
    _spaceSelect = index;
    update();
  }

  buildSpace() {
    switch (_spaceSelect) {
      case 0:
        return NotificationView();
      // case 1:
      //   return SearchView();
      case 1:
        //   return ListBoutiqueView();
        // case 2:
        return ListNegociationView();
      case 2:
        //   return ListBoutiqueView();
        // case 2:
        return ServiceClientView();

      default:
        return NotificationView();
    }
  }

  int _isLoadedHome = 0;
  int get isLoadedHome => _isLoadedHome;
  ProduitController _prodController = Get.find();
  CategoryBoutiqueController _categoryBoutiqueController = Get.find();
  List<HomeComponentModel> _homeComponent = [];
  List<HomeComponentModel> get homeComponent => _homeComponent;
  Future<void> getHome() async {
    print('----${_loaddata}-------aaaaaaaaa---');
    var key = await dababase.getKey();

    print('-----------get---');
    _isLoadedHome = 0;
    update();
    try {
      Response response = await generalRepo.getHome(key);

      //print(response.body);
      // _produitList = [];
      // _produitList.clear();
      // update();

      if (response.body != null) {
        if (response.body['Produit'] != null &&
            response.body['Categorie'] != null &&
            response.body['Boutique'] != null) {
          print('-------------------venu');
          print(response.body);
          _isLoadedHome = 1;
          update();
          _homeComponent.clear();

          _homeComponent.clear();
          _homeComponent.addAll((response.body['homeComponent'] as List)
              .map((e) => HomeComponentModel.fromJson(e))
              .toList());
          var produits = ((response.body['Produit'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
          _prodController.getHomeProduit(produits);
          var categorie = ((response.body['Categorie'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList());
          _categoryBoutiqueController.getHomeCategpry(categorie);

          var boutiques = ((response.body['Boutique'] as List)
              .map((e) => BoutiqueModel.fromJson(e))
              .toList());
          _categoryBoutiqueController.getHomeBoutique(boutiques);
        } else {
          _isLoadedHome = 2;
          update();
        }
      }
    } catch (e) {
      _loaddata = false;
      update();
      //print(e);
    }
    // }
  }

  getProduit(codeProduit) {
    var produit;
    var produit0 = Get.find<ProduitController>()
        .produitList
        .where((element) => element.codeProduit == codeProduit);
    var produit1 = Get.find<ProduitController>()
        .produitList
        .where((element) => element.codeProduit == codeProduit);
    var produit2 = Get.find<ProduitController>()
        .produitSupplementaire
        .where((element) => element.codeProduit == codeProduit);
    var produit3 = Get.find<MySearchController>()
        .listProduit
        .where((element) => element.codeProduit == codeProduit);
    var produit4 = Get.find<ProduitController>()
        .preferenceList
        .where((element) => element.codeProduit == codeProduit);
    var produit5 = Get.find<CategoryBoutiqueController>()
        .produitBoutiqueList
        .where((element) => element.codeProduit == codeProduit);
    _homeComponent.forEach((hcp) => hcp.produits.forEach((prod) {
          if (prod.codeProduit == codeProduit) {
            print('--------------ic');
            produit = prod;
          }
        }));
    // for (var i = 0; i < _homeComponent.length; i++) {
    //   var hcp = _homeComponent[i];
    //   for (var j = 0; j < hcp.produits.length; j++) {
    //     var prod = hcp.produits[j];

    //     if (prod.codeProduit == codeProduit) {
    //       print('--------------ic');
    //       produit = prod;
    //     }
    //   }
    // }
    if (produit0.isNotEmpty) {
      produit = produit0.first;
    }
    if (produit1.isNotEmpty) {
      produit = produit1;
    }
    if (produit2.isNotEmpty) {
      produit = produit2.first;
    }
    if (produit3.isNotEmpty) {
      produit = produit3.first;
    }
    if (produit4.isNotEmpty) {
      produit = produit4.first;
    }
    if (produit5.isNotEmpty) {
      produit = produit5.first;
    }
    return produit;
  }
}
