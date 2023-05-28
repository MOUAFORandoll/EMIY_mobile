import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/BuyShopController.dart';
import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/controller/ShortController.dart';
import 'package:Fahkap/controller/TransactionController.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/controller/categoryBoutiqueController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/controller/productController.dart';
import 'package:Fahkap/controller/searchController.dart';
import 'package:Fahkap/repository/ActionRepo.dart';
import 'package:Fahkap/repository/BoutiqueRepo.dart';
import 'package:Fahkap/repository/BuyShoopingCartRepo.dart';
import 'package:Fahkap/repository/CommandeRepo.dart';
import 'package:Fahkap/repository/SearchRepo.dart';
import 'package:Fahkap/repository/ShortRepo.dart';
import 'package:Fahkap/repository/TransactionRepo.dart';
import 'package:Fahkap/repository/categoryBoutiqueRepo.dart';
import 'package:Fahkap/repository/LivreurRepo.dart';
import 'package:Fahkap/repository/ManageRepo.dart';
import 'package:Fahkap/repository/categoryRepo.dart';
import 'package:Fahkap/repository/popularProductRepo.dart';
import 'package:Fahkap/utils/Services/ApiClient.dart';
import 'package:Fahkap/utils/Services/storageService2.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqlite_api.dart';

Future<void> initApp() async {
  await requestPermission();

  Get.find<ManagerController>().chageN(true);
  await GetStorage.init();
  var database = Get.find<DB>();
  await database.init();
  Get.find<ManagerController>().getKeyU();
  Get.find<ManagerController>().getUser();

  Get.find<ManagerController>().newLocalisation();

  Get.find<ProductController>().getPopularProduit();
  Get.find<BuyShopController>().getPointLivraisom();
  Get.find<BoutiqueController>().getBoutique();
  Get.find<CategoryBoutiqueController>().getCategory();
  Get.find<CommandeController>().getListCommandes();
  Get.find<CategoryBoutiqueController>().getListBoutiques();
  Get.find<ShortController>().getListShort();

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
  Get.put(CommandeRepo(apiClient: Get.find()), permanent: true);
  Get.put(ManageRepo(apiClient: Get.find()), permanent: true);

  Get.put(ManagerController(manageRepo: Get.find()), permanent: true);

  Get.put(CommandeController(commandeRepo: Get.find()), permanent: true);
  Get.put(CategoryBoutiqueRepo(apiClient: Get.find()), permanent: true);
  Get.put(ProductRepo(apiClient: Get.find()), permanent: true);
  Get.put(BoutiqueRepo(apiClient: Get.find()), permanent: true);
  Get.put(CategoryBoutiqueRepo(apiClient: Get.find()), permanent: true);
  Get.put(BuyShoopingCartRepo(apiClient: Get.find()), permanent: true);
  Get.put(TransactionRepo(apiClient: Get.find()), permanent: true);

  Get.put(ProductController(productRepo: Get.find()), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(BuyShopController(buySoppingCartRepo: Get.find()), permanent: true);
  Get.put(BoutiqueController(boutiqueRepo: Get.find()), permanent: true);
  Get.put(CategoryBoutiqueController(categoryBoutiqueRepo: Get.find()),
      permanent: true);

  Get.put(TransactionController(transactionRepo: Get.find()), permanent: true);
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
