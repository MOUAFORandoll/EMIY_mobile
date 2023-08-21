import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/BuyShopController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ServiceClientController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/linkController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/controller/searchController.dart';
import 'package:EMIY/repository/GeneralRepo.dart';
import 'package:EMIY/repository/BoutiqueRepo.dart';
import 'package:EMIY/repository/BuyShoopingCartRepo.dart';
import 'package:EMIY/repository/CommandeRepo.dart';
import 'package:EMIY/repository/SearchRepo.dart';
import 'package:EMIY/repository/ServiceClientRepo.dart';
import 'package:EMIY/repository/ShortRepo.dart';
import 'package:EMIY/repository/TransactionRepo.dart';
import 'package:EMIY/repository/categoryBoutiqueRepo.dart';
import 'package:EMIY/repository/LivreurRepo.dart';
import 'package:EMIY/repository/ManageRepo.dart';
import 'package:EMIY/repository/categoryRepo.dart';
import 'package:EMIY/repository/negociationRepo.dart';
import 'package:EMIY/repository/ProduitRepo.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/Services/UniLinkService.dart';
import 'package:EMIY/utils/Services/storageService2.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart' as uni_links;

import 'dart:async';
import 'dart:io';

import '../../repository/linkRepo.dart';

// ...
Future<void> initApp() async {
  await requestPermission();
  Get.find<ManagerController>().chageN(true);
  await GetStorage.init();

  await Get.find<DataBaseController>().init();
//  await Get.find<ManagerController>().getUserDB();
// await  Get.find<ManagerController>().getKeyU();
//  await Get.find<ManagerController>().getUser();





  await Get.find<GeneralController>().generalSocket();
  await Get.find<GeneralController>().NotificationSocket();
  await Get.find<GeneralController>().getListNotifications();

  await Get.find<ShortController>().disposePLayerAll();
  await Get.find<ShortController>().disposeUniquePLayer();

  await Get.find<ServiceClientController>().connectSockey();
}

Future<void> secondInit() async {
  Get.find<CommandeController>().getListCommandes();
  // Get.find<ProduitController>().getPopularProduit();
  // Get.find<CategoryBoutiqueController>().getCategory();
  // Get.find<CategoryBoutiqueController>().getListBoutiques();
  Get.find<GeneralController>().getHome();
  Get.find<ManagerController>().newLocalisation();
  Get.find<ManagerController>().getListFieul();
  Get.find<BuyShopController>().getPointLivraisom();
  Get.find<BoutiqueController>().getBoutique();
  Get.find<BoutiqueController>().getListAbonnementForBoutique();
  Get.find<ShortController>().getListShort();
  Get.find<NegociationController>().getListNegociation();
  Get.find<ProduitController>().getListProduitPreference();

  Get.find<GeneralController>().getListModePaiement();
  Get.find<BuyShopController>().setUserInfo();

  Get.find<ServiceClientController>().connectSockey();
  Get.find<ServiceClientController>().getEchange();
}

// ...
Future<void> initAllApp() async {
  await requestPermission();

  Get.find<ManagerController>().chageN(true);
  await GetStorage.init();

  await Get.find<DataBaseController>().init();
  Get.find<ManagerController>().getKeyU();
  Get.find<ManagerController>().getUser();
  Get.find<GeneralController>().generalSocket();
  await Get.find<GeneralController>().NotificationSocket();

  Get.find<GeneralController>().getListNotifications();
  Get.find<GeneralController>().getHome();

  Get.find<ManagerController>().newLocalisation();
  Get.find<CommandeController>().getListCommandes();
  // Get.find<CategoryBoutiqueController>().getListBoutiques();

  // Get.find<ProduitController>().getPopularProduit();
  Get.find<BuyShopController>().getPointLivraisom();
  Get.find<BoutiqueController>().getBoutique();
  Get.find<BoutiqueController>().getListAbonnementForBoutique();
  // Get.find<CategoryBoutiqueController>().getCategory();
  Get.find<ShortController>().getListShort();
  Get.find<NegociationController>().getListNegociation();
  Get.find<ProduitController>().getListProduitPreference();

  Get.find<BuyShopController>().setUserInfo();
  Get.find<GeneralController>().getListModePaiement();

  Get.find<ServiceClientController>().connectSockey();
  Get.find<ServiceClientController>().getEchange();
}

Future<void> initServices() async {
  Get.put(UniLinkService(), permanent: true);
  Get.put(DataBaseController(), permanent: true);

  Get.put(ApiClient(), permanent: true);

  Get.put(LivreurRepo(apiClient: Get.find()), permanent: true);
  // Get.put(  StorageService(), permanent: true);
  Get.put(GetStorage(), permanent: true);
  Get.put(ManageRepo(apiClient: Get.find()), permanent: true);

  Get.put(ManagerController(manageRepo: Get.find()), permanent: true);
  Get.put(CommandeRepo(apiClient: Get.find()), permanent: true);
  Get.put(CommandeController(commandeRepo: Get.find()), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(ProduitRepo(apiClient: Get.find()), permanent: true);
  Get.put(ProduitController(produitRepo: Get.find()), permanent: true);
  Get.put(BoutiqueRepo(apiClient: Get.find()), permanent: true);
  Get.put(BoutiqueController(boutiqueRepo: Get.find()), permanent: true);

  Get.put(BuyShoopingCartRepo(apiClient: Get.find()), permanent: true);
  Get.put(BuyShopController(buySoppingCartRepo: Get.find()), permanent: true);
  Get.put(CategoryBoutiqueRepo(apiClient: Get.find()), permanent: true);
  Get.put(CategoryBoutiqueController(categoryBoutiqueRepo: Get.find()),
      permanent: true);

  Get.put(GeneralRepo(apiClient: Get.find()));
  Get.put(GeneralController(generalRepo: Get.find()), permanent: true);
  Get.put(TransactionRepo(apiClient: Get.find()), permanent: true);

  Get.put(TransactionController(transactionRepo: Get.find()), permanent: true);
  Get.put(NegociationRepo(apiClient: Get.find()), permanent: true);
  Get.put(NegociationController(negociationRepo: Get.find()), permanent: true);
  Get.put(SearchRepo(apiClient: Get.find()), permanent: true);
  Get.put(SearchController(searchRepo: Get.find()), permanent: true);
  Get.put(ShortRepo(apiClient: Get.find()), permanent: true);
  Get.put(ShortController(shortRepo: Get.find()), permanent: true);
  Get.put(ServiceClientRepo(apiClient: Get.find()), permanent: true);
  Get.put(ServiceClientController(serviceClientRepo: Get.find()),
      permanent: true);

  Get.put(LinkRepo(apiClient: Get.find()), permanent: true);

  Get.put(LinkController(linkRepo: Get.find()), permanent: true);
}

requestPermission() async {
  var status = await Permission.storage.status;
  //print("voici le statut ,  $status");
  if (!status.isGranted) {
    await Permission.storage.request();
    await requestPermission();
  } else {
    await getData();
  }
}

getData() async {
  // await MyBinding().requestPermission();
  var status = await Permission.storage.status;
  //print("voici le statut ,  $status");

  if (status.isGranted) {
    var database = Get.find<DataBaseController>();
    await database.init();
    await Get.find<GeneralController>().getLanguageInit();

    Get.find<ManagerController>().getKeyU();
    Get.find<ManagerController>().getUser();

    Get.find<ManagerController>().newLocalisation();

    Get.find<CommandeController>().getListCommandes();
  }
}

StreamSubscription? _sub;

Future<void> initUniLinks() async {
  // ... check initialLink
  print('------lien----------ici----------------------');

  // Attach a listener to the stream
  _sub = linkStream.listen((String? link) {
    print('--${link}---00-lien----------ici----------------------');

    // Parse the link and warn the user, if it is not correct
  }, onError: (err) {
    // Handle exception by warning the user their action did not succeed
  });

  // NOTE: Don't forget to call _sub.cancel() in dispose()
}

/// Handle the initial Uri - the one the app was started with
///
/// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
/// ONLY ONCE in your app's lifetime, since it is not meant to change
/// throughout your app's life.
///
/// We handle all exceptions, since it is called from initState.
// ...
/* 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser le gestionnaire de liens pour gérer les liens externes
  uni_links.init();

  // Appeler la fonction handleRedirect() pour gérer la redirection
  handleRedirect();

  runApp(MyApp());
// } */
//   void _handleIncomingLinks() {
//     if (!kIsWeb) {
//       // It will handle app links while the app is already started - be it in
//       // the foreground or in the background.
//       _sub = uriLinkStream.listen((Uri? uri) {
//         if (!mounted) return;
//         print('got uri: $uri');
//         setState(() {
//           _latestUri = uri;
//           _err = null;
//         });
//       }, onError: (Object err) {
//         if (!mounted) return;
//         print('got err: $err');
//         setState(() {
//           _latestUri = null;
//           if (err is FormatException) {
//             _err = err;
//           } else {
//             _err = null;
//           }
//         });
//       });
//     }
//   }
