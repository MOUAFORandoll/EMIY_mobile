import 'package:get/get_connect/http/src/response/response.dart';

import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/repository/popularProductRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  ProductController({required this.productRepo});

  bool _conf = false;
  bool get conf => _conf;
  setConf() {
    _conf = true;
    update();
  }

  unSetConf() {
    _conf = false;
    update();
  }

  late CartController _cart;
  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  int get totalItems {
    return _cart.totalItems;
  }

  void setQuantity(bool isIncrement) {
    print(
      "QUanite $_quantity",
    );

    print("increment $isIncrement");
    _quantity = isIncrement == true
        ? checkQuantity(_quantity + 1)
        : checkQuantity(_quantity - 1);
    _qChanged = isIncrement == true ? _qChanged + 1 : _qChanged - 1;
    print("*******$_quantity");
    _inCartItems = _cart.getQuantity(_currentProduct);
    update();
  }

  int _qChanged = 0;
  int checkQuantity(int quantity) {
    print("quantite final $quantity");
    print("quantite final ${_currentProduct.quantite}");

    return (quantity + _inCartItems) < 0
        ? 0
        : (quantity + _inCartItems > _currentProduct.quantite)
            ? 0
            : quantity;
  }

  bool exitP(ProduitModel product) {
    return _cart.existInCart(product);
  }

  var _currentProduct = null;
  void initProduct(CartController cart, ProduitModel product) {
    _currentProduct = product;
    _quantity = 0;
    _inCartItems = 0;
    _qChanged = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
      // _quantity = _cart.getQuantity(product);
      print(_inCartItems);
    }
  }

  getD() {
    _inCartItems = _cart.getQuantity(_currentProduct);
    update();
  }

  void addItem(ProduitModel product, index, type) {
    print('quantitte : ${_quantity} total : ${_inCartItems}');

    _cart.addItem(product, _quantity, index, type);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    update();
    _cart.items.forEach((k, v) {
      print('produit id : ${v.id}  quantite : ' + v.quantity.toString());
    });
  }

  List<ProduitModel> _produitList = [];
  List<ProduitModel> _produitListSave = [];
  List<ProduitModel> get produitList => _produitList;
  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;
  Future<void> getPopularProduit() async {
    print('response**********');

    _isLoadedP = 0;
    try {
      Response response = await productRepo.getListProductPopular();

      print(response.body);
      _produitList = [];
      _produitList.clear();
      update();

      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            _produitList.addAll((response.body['data'] as List)
                .map((e) => ProduitModel.fromJson(e))
                .toList());
            _produitListSave.addAll((response.body['data'] as List)
                .map((e) => ProduitModel.fromJson(e))
                .toList());
            _isLoadedP = 1;
            update();
          } else {
            _isLoadedP = 1;
            update();
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  List<ProduitModel> _produitListAll = [];
  List<ProduitModel> _produitListAllSave = [];
  List<ProduitModel> get produitListAll => _produitListAll;
  int _isLoadedPAll = 0;
  int get isLoadedPAll => _isLoadedPAll;
  Future<void> getProduitAll() async {
    print('response**********');

    _isLoadedPAll = 0;
    try {
      Response response = await productRepo.getListProductAll();

      print(response.body);

      _produitListAll.clear();
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _produitListAll.addAll((response.body['data'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
          _produitListAllSave.addAll((response.body['data'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
        }
        _isLoadedPAll = 1;
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  int _tsearch = 0;
  int get tsearch => _tsearch;

  searchType(int i) {
    _tsearch = i;
    update();
  }

  bool _searchPro = false;
  bool get searchPro => _searchPro;

  searchProButtom() {
    _searchPro = !_searchPro;
    if (!_searchPro) {
      _produitList = _produitListSave;
    }
    // searchProduit('');
    update();
  }

  searchProduit(text) {
    _produitList = [];
    List<ProduitModel> cont = [];
    print(_produitListSave);

    _produitListSave.forEach((item) {
      print(item.titre.toUpperCase());
      print(text.toUpperCase());
      if (item.titre.toUpperCase().contains(text.toUpperCase()) ||
          item.codeProduit.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    print(cont.length);
    if (cont.length != 0) {
      _produitList = cont;
    } else {
      _produitList = _produitListSave;
    }

    update();
  }
}
