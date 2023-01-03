import 'package:fahkapmobile/controller/BuyShopController.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/repository/BuyShoopingCartRepo.dart';
import 'package:fahkapmobile/repository/LivreurRepo.dart';
import 'package:fahkapmobile/repository/ManageRepo.dart';
import 'package:fahkapmobile/repository/categoryRepo.dart';
import 'package:fahkapmobile/repository/popularProductRepo.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyBinding extends Bindings {
  void dependencies() async {
    // httpClient.timeout = const Duration(seconds: 60);

    Get.lazyPut(() => ApiClient());

    Get.lazyPut(() => ManageRepo(apiClient: Get.find()));
    Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
    Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => BoutiqueRepo(apiClient: Get.find()));
    Get.lazyPut(() => BuyShoopingCartRepo(apiClient: Get.find()));

    Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
    Get.lazyPut(() => ProductController(productRepo: Get.find()));
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => BuyShopController(buySoppingCartRepo: Get.find()));
    Get.lazyPut(() => ManagerController(manageRepo: Get.find()));
    Get.lazyPut(() => BoutiqueController(boutiqueRepo: Get.find()));
    Get.lazyPut(() => LivreurRepo(apiClient: Get.find()));
  }

  onInit() {
    
  new GetStorage().write('keySecret', 1234);
    Get.find<ManagerController>().getUser();
    Get.find<CategoryController>().getCategory();
    Get.find<ProductController>().getPopularProduit();

    Get.find<BoutiqueController>().getBoutique();

    Get.find<ManagerController>();
    Get.find<BuyShopController>();
    Get.find<CartController>();
  }
}
