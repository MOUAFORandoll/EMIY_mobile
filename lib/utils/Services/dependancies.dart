import 'package:fahkapmobile/controller/BuyShopController.dart';
import 'package:fahkapmobile/controller/CommandeController.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/repository/BuyShoopingCartRepo.dart';
import 'package:fahkapmobile/repository/CommandeRepo.dart';
import 'package:fahkapmobile/repository/LivreurRepo.dart';
import 'package:fahkapmobile/repository/ManageRepo.dart';
import 'package:fahkapmobile/repository/categoryRepo.dart';
import 'package:fahkapmobile/repository/popularProductRepo.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/Services/storageService2.dart';
import 'package:fahkapmobile/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqlite_api.dart';

class MyBinding extends Bindings {
  void dependencies() async {
    // httpClient.timeout = const Duration(seconds: 60);

    Get.lazyPut(() => LivreurRepo(apiClient: Get.find()));
    Get.lazyPut(() => StorageService());
    // Get.lazyPut(() => GetStorage());
    Get.lazyPut(() => DB());
    Get.lazyPut(() => ApiClient());

    Get.lazyPut(() => CommandeRepo(apiClient: Get.find()));
    Get.lazyPut(() => ManageRepo(apiClient: Get.find()));

    Get.lazyPut(() => ManagerController(manageRepo: Get.find()));

    Get.lazyPut(() => CommandeController(commandeRepo: Get.find()));
    Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
    Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => BoutiqueRepo(apiClient: Get.find()));
    Get.lazyPut(() => BuyShoopingCartRepo(apiClient: Get.find()));

    Get.lazyPut(() => ProductController(productRepo: Get.find()));
    Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => BuyShopController(buySoppingCartRepo: Get.find()));
    Get.lazyPut(() => BoutiqueController(boutiqueRepo: Get.find()));
  }

  onInit() async {
    await GetStorage.init();
    var database = Get.find<DB>();
    database.init();
    Get.find<ManagerController>();
    Get.find<ManagerController>().getKeyU();
    Get.find<ManagerController>().getUser();

    Get.find<ProductController>().getPopularProduit();
    Get.find<CategoryController>().getCategory();

    Get.find<CartController>();

    Get.find<BuyShopController>();
    Get.find<BoutiqueController>().getBoutique();
    Get.find<CommandeController>().getListCommandes();
  }

  onGetAll() async {
    Get.lazyPut(() => LivreurRepo(apiClient: Get.find()));
    Get.lazyPut(() => StorageService());

    // Get.lazyPut(() => GetStorage());
    Get.lazyPut(() => DB());
    Get.lazyPut(() => ApiClient());
    Get.lazyPut(() => CommandeRepo(apiClient: Get.find()));

    Get.lazyPut(() => ManageRepo(apiClient: Get.find()));

    Get.lazyPut(() => ManagerController(manageRepo: Get.find()));

    Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
    Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => BoutiqueRepo(apiClient: Get.find()));
    Get.lazyPut(() => BuyShoopingCartRepo(apiClient: Get.find()));

    Get.lazyPut(() => ProductController(productRepo: Get.find()));
    Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => CommandeController(commandeRepo: Get.find()));

    Get.lazyPut(() => BuyShopController(buySoppingCartRepo: Get.find()));
    Get.lazyPut(() => BoutiqueController(boutiqueRepo: Get.find()));
    var database = Get.find<DB>();
    database.init();
    Get.find<ManagerController>();
    Get.find<ManagerController>().getKeyU();

    Get.find<CommandeController>().getListCommandes();
    Get.find<ManagerController>().getUser();

    Get.find<ProductController>().getPopularProduit();
    Get.find<CategoryController>().getCategory();

    Get.find<CartController>();

    Get.find<BuyShopController>();
    Get.find<BoutiqueController>().getBoutique();
    // Get.find<CommandeController>().insertAll();
  }
}
