import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/controller/BuyShopController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/controller/productController.dart';
import 'package:EMIY/controller/searchController.dart';
import 'package:EMIY/repository/ActionRepo.dart';
import 'package:EMIY/repository/BoutiqueRepo.dart';
import 'package:EMIY/repository/BuyShoopingCartRepo.dart';
import 'package:EMIY/repository/CommandeRepo.dart';
import 'package:EMIY/repository/SearchRepo.dart';
import 'package:EMIY/repository/ShortRepo.dart';
import 'package:EMIY/repository/TransactionRepo.dart';
import 'package:EMIY/repository/categoryBoutiqueRepo.dart';
import 'package:EMIY/repository/LivreurRepo.dart';
import 'package:EMIY/repository/ManageRepo.dart';
import 'package:EMIY/repository/categoryRepo.dart';
import 'package:EMIY/repository/negociationRepo.dart';
import 'package:EMIY/repository/popularProductRepo.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService2.dart';
import 'package:EMIY/utils/database/DataBase.dart';
import 'package:EMIY/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart' as uni_links;

Future<void> initApp() async {
  await requestPermission();

  Get.find<ManagerController>().chageN(true);
  await GetStorage.init();
  var database = Get.find<DB>();
  await database.init();
  Get.find<ManagerController>().getKeyU();
  Get.find<ManagerController>().getUser();
  Get.find<ActionController>().generalSocket();

  Get.find<ManagerController>().newLocalisation();

  Get.find<ProductController>().getPopularProduit();
  Get.find<BuyShopController>().getPointLivraisom();
  Get.find<BoutiqueController>().getBoutique();
  Get.find<BoutiqueController>().getListAbonnementForUser();
  Get.find<BoutiqueController>().getListAbonnementForBoutique();
  Get.find<CategoryBoutiqueController>().getCategory();
  Get.find<CommandeController>().getListCommandes();
  Get.find<CategoryBoutiqueController>().getListBoutiques();
  Get.find<ShortController>().getListShort();
  Get.find<NegociationController>().getListNegociation();

  Get.find<ActionController>().getListModePaiement();
}

Future<void> initServices() async {
  Get.put(DB(), permanent: true);

  Get.put(ApiClient(), permanent: true);

  Get.put(ActionRepo(apiClient: Get.find()));
  Get.put(ActionController(actionRepo: Get.find()), permanent: true);
  Get.put(LivreurRepo(apiClient: Get.find()), permanent: true);
  // Get.put(  StorageService(), permanent: true);
  Get.put(GetStorage(), permanent: true);
  Get.put(ManageRepo(apiClient: Get.find()), permanent: true);

  Get.put(ManagerController(manageRepo: Get.find()), permanent: true);
  Get.put(CommandeRepo(apiClient: Get.find()), permanent: true);
  Get.put(CommandeController(commandeRepo: Get.find()), permanent: true);
  Get.put(ProductRepo(apiClient: Get.find()), permanent: true);
  Get.put(ProductController(productRepo: Get.find()), permanent: true);
  Get.put(BoutiqueRepo(apiClient: Get.find()), permanent: true);
  Get.put(BoutiqueController(boutiqueRepo: Get.find()), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(BuyShoopingCartRepo(apiClient: Get.find()), permanent: true);
  Get.put(BuyShopController(buySoppingCartRepo: Get.find()), permanent: true);
  Get.put(CategoryBoutiqueRepo(apiClient: Get.find()), permanent: true);
  Get.put(CategoryBoutiqueController(categoryBoutiqueRepo: Get.find()),
      permanent: true);
  Get.put(TransactionRepo(apiClient: Get.find()), permanent: true);

  Get.put(TransactionController(transactionRepo: Get.find()), permanent: true);
  Get.put(NegociationRepo(apiClient: Get.find()), permanent: true);
  Get.put(NegociationController(negociationRepo: Get.find()), permanent: true);
  Get.put(SearchRepo(apiClient: Get.find()), permanent: true);
  Get.put(SearchController(searchRepo: Get.find()), permanent: true);
  Get.put(ShortRepo(apiClient: Get.find()), permanent: true);
  Get.put(ShortController(shortRepo: Get.find()), permanent: true);
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
    var database = Get.find<DB>();
    await database.init();
    await Get.find<ActionController>().getLanguageInit();

    Get.find<ManagerController>().getKeyU();
    Get.find<ManagerController>().getUser();

    Get.find<ManagerController>().newLocalisation();

    Get.find<CommandeController>().getListCommandes();
  }
}
void handleRedirect() async {
  // Vérifier si l'application est lancée depuis un lien externe
  Uri? initialUri;
  try {
    initialUri = await uni_links.getInitialUri();
  } catch (e) {
    print('Erreur lors de la récupération de l\'URI initial: $e');
  }

  // Rediriger vers l'application si l'URI initial est présent
  if (initialUri != null) {
    // Effectuer les actions nécessaires pour traiter l'URI
    // Par exemple, vous pouvez extraire des paramètres de l'URI et les utiliser dans votre application
    print('URI initial: $initialUri');
  } else {
    // L'application a été lancée normalement sans lien externe
    // Vous pouvez afficher l'écran principal de votre application ici
    print('Lancement normal de l\'application');
  }
}

void redirectToAppOrStore() async {
  // Vérifier si l'application mobile-shop est installée sur l'appareil
  if (await canLaunch('mobile-shop://')) {
    // Rediriger vers l'application mobile-shop
    await launch('mobile-shop://');
  } else {
    // Rediriger vers le magasin d'applications correspondant à l'appareil de l'utilisateur
    // Pour Android, le lien direct vers le Play Store
    // Pour iOS, le lien direct vers l'App Store
    await launch('https://play.google.com/store/apps/details?id=com.example.mobile_shop');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser le gestionnaire de liens pour gérer les liens externes
  uni_links.init();

  // Appeler la fonction handleRedirect() pour gérer la redirection
  handleRedirect();

  runApp(MyApp());
}
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri: $uri');
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }
