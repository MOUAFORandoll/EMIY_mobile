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

class MyBinding extends Bindings {
  void dependencies() async {
    Get.lazyPut(() => DB(), fenix: true);
    Get.lazyPut(() => ActionRepo(apiClient: Get.find()));

    Get.lazyPut(() => ActionController(actionRepo: Get.find()), fenix: true);
    Get.lazyPut(() => LivreurRepo(apiClient: Get.find()), fenix: true);
    // Get.lazyPut(() => StorageService(), fenix: true);
    Get.lazyPut(() => GetStorage(), fenix: true);
    Get.lazyPut(() => ApiClient(), fenix: true);

    Get.lazyPut(() => CommandeRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => ManageRepo(apiClient: Get.find()), fenix: true);

    Get.lazyPut(() => ManagerController(manageRepo: Get.find()), fenix: true);

    Get.lazyPut(() => CommandeController(commandeRepo: Get.find()),
        fenix: true);
    Get.lazyPut(() => CategoryBoutiqueRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => ProductRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => BoutiqueRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => CategoryBoutiqueRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => BuyShoopingCartRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => TransactionRepo(apiClient: Get.find()), fenix: true);

    Get.lazyPut(() => ProductController(productRepo: Get.find()), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => BuyShopController(buySoppingCartRepo: Get.find()),
        fenix: true);
    Get.lazyPut(() => BoutiqueController(boutiqueRepo: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => CategoryBoutiqueController(categoryBoutiqueRepo: Get.find()),
        fenix: true);

    Get.lazyPut(() => TransactionController(transactionRepo: Get.find()),
        fenix: true);
    Get.lazyPut(() => SearchRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => SearchController(searchRepo: Get.find()), fenix: true);
    Get.lazyPut(() => ShortRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => ShortController(shortRepo: Get.find()), fenix: true);

    // var database = Get.find<DB>();
    // await database.init();
    // await Get.find<ActionController>().getLanguageInit();
  }

  onInit() async {
    // Get.find<ManagerController>().chageN(true);
    // await requestPermission();

    // await GetStorage.init();
    // var database = Get.find<DB>();
    // await database.init();
    // Get.find<StorageService>().init();
    // Get.find<ManagerController>().getKeyU();
    // Get.find<ManagerController>().getUser();

    // Get.find<ManagerController>().newLocalisation();

    Get.find<ProductController>().getPopularProduit();

    Get.find<CartController>();

    Get.find<BuyShopController>();
    Get.find<BoutiqueController>().getBoutique();
    Get.find<CategoryBoutiqueController>().getCategory();
    // Get.find<CommandeController>().getListCommandes();
    Get.find<CategoryBoutiqueController>().getListBoutiques();
    // Get.find<ShortController>().getListShort();

    Get.find<ActionController>().getListModePaiement();
    // Get.find<BuyShopController>().getListLivreur();
  }

  onGetAll() async {
    // var database = Get.find<DB>();
    // await database.init();
    // Get.find<StorageService>().init();
    Get.lazyPut(() => ActionRepo(apiClient: Get.find()));

    Get.lazyPut(() => ActionController(actionRepo: Get.find()));
    Get.lazyPut(() => LivreurRepo(apiClient: Get.find<ApiClient>()));
    // Get.lazyPut(() => StorageService());

    Get.lazyPut(() => GetStorage());
    Get.lazyPut(() => DB());
    Get.lazyPut(() => ApiClient());
    Get.lazyPut(() => CommandeRepo(apiClient: Get.find()));

    Get.lazyPut(() => ManageRepo(apiClient: Get.find()));

    Get.lazyPut(() => ManagerController(manageRepo: Get.find()));

    Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => BoutiqueRepo(apiClient: Get.find()));
    Get.lazyPut(() => BuyShoopingCartRepo(apiClient: Get.find()));
    Get.lazyPut(() => TransactionRepo(apiClient: Get.find()));
    Get.lazyPut(() => ProductController(productRepo: Get.find()));
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => CommandeController(commandeRepo: Get.find()));

    Get.lazyPut(() => BuyShopController(buySoppingCartRepo: Get.find()));
    Get.lazyPut(() => BoutiqueController(boutiqueRepo: Get.find()));
    Get.lazyPut(() => CategoryBoutiqueRepo(apiClient: Get.find()));
    Get.lazyPut(
        () => CategoryBoutiqueController(categoryBoutiqueRepo: Get.find()));

    Get.lazyPut(() => TransactionController(transactionRepo: Get.find()));
    Get.lazyPut(() => ShortRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => ShortController(shortRepo: Get.find()), fenix: true);

    Get.find<ActionController>();
    // Get.find<ManagerController>().getKeyU();
    // Get.find<ManagerController>().getUser();

    // Get.find<ManagerController>().newLocalisation();

    // Get.find<CommandeController>().getListCommandes();
    // Get.find<ManagerController>().getUser();

    Get.find<ProductController>().getPopularProduit();
    // Get.find<BoutiqueController>().getCategory();
    Get.find<CategoryBoutiqueController>().getCategory();
    Get.find<CategoryBoutiqueController>().getListBoutiques();

    Get.find<CartController>();

    Get.find<BuyShopController>();
    Get.lazyPut(
        () => CategoryBoutiqueController(categoryBoutiqueRepo: Get.find()));

    Get.find<TransactionController>().getTransactions();

    Get.lazyPut(() => SearchRepo(apiClient: Get.find()), fenix: true);
    Get.lazyPut(() => SearchController(searchRepo: Get.find()), fenix: true);
    Get.lazyPut(() => SearchController(searchRepo: Get.find()), fenix: true);
    // Get.find<ShortController>().getListShort();

    // Get.find<CommandeController>().insertAll();
  }

  onGetDataNew() async {
    var database = Get.find<DB>();
    await database.init();
    Get.find<ManagerController>().newLocalisation();

    Get.find<ManagerController>().getKeyU();

    Get.find<CommandeController>().getListCommandes();
    Get.find<BoutiqueController>().getBoutique();
    Get.find<ManagerController>().getUser();
    // Get.find<ShortController>().getListShort();
  }

  requestPermission() async {
    var status = await Permission.storage.status;
    print("voici le statut ,  $status");
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}
