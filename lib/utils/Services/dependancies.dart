import 'package:fahkapmobile/controller/BuyShopController.dart';
import 'package:fahkapmobile/controller/boutiqueController.dart';
import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/controller/categoryController.dart';
import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/controller/productController.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/repository/LivreurRepo.dart';
import 'package:fahkapmobile/repository/categoryRepo.dart';
import 'package:fahkapmobile/repository/popularProductRepo.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class MyBinding extends Bindings {
  void dependencies() async {
    // httpClient.timeout = const Duration(seconds: 60);

    Get.lazyPut(() => ApiClient());
 
    Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
    Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => BoutiqueRepo(apiClient: Get.find()));
    Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
    Get.lazyPut(() => ProductController(productRepo: Get.find()));
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => BuyShopController());
    Get.lazyPut(() => ManagerController());
    Get.lazyPut(() => BoutiqueController(boutiqueRepo: Get.find()));
    Get.lazyPut(() => LivreurRepo(apiClient: Get.find()));

  }

  onInit() {
    Get.find<CategoryController>().getCategory();
    Get.find<ProductController>().getPopularProduit();

    Get.find<BoutiqueController>().getBoutique();

    Get.find<ManagerController>();
    Get.find<BuyShopController>();
    Get.find<CartController>();
  }
}
