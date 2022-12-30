import 'package:get/get_connect/http/src/response/response.dart';

import 'package:fahkapmobile/controller/cartController.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/popularProductRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  ProductController({required this.productRepo});

  late CartController _cart;
  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  int get totalItems {
    return _cart.totalItems;
  }

  void setQuantity(bool isIncrement) {
    print(_quantity);
    _quantity = isIncrement
        ? checkQuantity(_quantity + 1)
        : checkQuantity(_quantity - 1);
    print(_quantity);

    update();
  }

  // void setQuantityAndUp(id, bool isIncrement) {
  //   print(_quantity);
  //   _quantity = isIncrement
  //       ? checkQuantity(_quantity + 1)
  //       : checkQuantity(_quantity - 1);
  //   print(_quantity);

  //   update();
  //   _cart.updateItem(id, _quantity);
  // }

  int checkQuantity(int quantity) {
    return ((quantity + inCartItems) < 0)
        ? 0
        : ((quantity + inCartItems) > 20)
            ? 20
            : quantity;
  }

  bool exitP(ProduitModel product) {
    return _cart.existInCart(product);
  }

  void initProduct(CartController cart, ProduitModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProduitModel product, index, type) {
    print('quantitte : ${_quantity} total : ${_inCartItems}');
    // var sebd = _quantity < 0 ? _inCartItems - _quantity : _quantity;
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity, index, type);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    // } else {
    // Get.snackbar("Add", 'E:ntrer une quantite correcte',
    //     backgroundColor: ColorsApp.grey, colorText: ColorsApp.skyBlue);
    // }
    update();
    _cart.items.forEach((k, v) {
      print('produit id : ${v.id}  quantite : ' + v.quantity.toString());
    });
  }

  List<ProduitModel> _produitList = [];
  List<ProduitModel> get produitList => _produitList;
  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;
  Future<void> getPopularProduit() async {
    print('response**********');

    _produitList = [];
    _isLoadedP = 0;
    try {
      Response response = await productRepo.getListProductPopular();
      print('*------response');
      print(response.body);

      _produitList = [];

      _produitList.addAll((response.body['data'] as List)
          .map((e) => ProduitModel.fromJson(e))
          .toList());

      _isLoadedP = 1;
      update();
    } catch (e) {
      print(e);
    }
  }

  List<ProduitModel> _produitcategoryList = [];
  List<ProduitModel> get produitcategoryList => _produitcategoryList;
  int _isLoadedPC = 0;
  int get isLoadedPC => _isLoadedPC;
  getCategoryProduit(id) async {
    _produitcategoryList = [];
    _isLoadedPC = 0;
    try {
      Response response = await productRepo.getListProductForCategory(id);
      print('*------response');
      print(response.body);

      _produitcategoryList.addAll((response.body['data'] as List)
          .map((e) => ProduitModel.fromJson(e))
          .toList());

      _isLoadedPC = 1;
      update();
    } catch (e) {
      print(e);
    }
  }
}
