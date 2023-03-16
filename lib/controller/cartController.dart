import 'package:Fahkap/model/data/CartModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/ProduitCategoryModel.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final service = new ApiService();

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  int get totalItems {
    var totalQt = 0;
    _items.forEach((k, v) {
      totalQt += v.quantity;
    });
    return totalQt;
  }

  var fn = new ViewFunctions();

  void updateQuantityProduct(int idProduit, bool state) {
    // if (quantity <= product.quantite) {
    print('taillen');
    if (_items.containsKey(idProduit)) {
      var total = 0;
      _items.update(idProduit, (value) {
        total = value.quantity + (state ? 1 : -1);
        if (total > 0 && total <= value.qtdispo) {
          return CartModel(
              id: value.id,
              name: value.name,
              qtdispo: value.qtdispo,
              index: value.index,
              type: value.type,
              prix: double.parse(value.prix.toString()),
              img: value.img,
              quantity: total,
              isExist: true,
              time: DateTime.now().toString());
        } else if (total > value.qtdispo) {
          fn.snackBar('Panier', 'Limite pour ce produit', ColorsApp.skyBlue);
          return CartModel(
              id: value.id,
              name: value.name,
              index: value.index,
              qtdispo: value.qtdispo,
              type: value.type,
              prix: double.parse(value.prix.toString()),
              img: value.img,
              quantity: value.quantity,
              isExist: true,
              time: DateTime.now().toString());
        } else {
          fn.snackBar('Panier', 'Impossible', ColorsApp.red);
          return CartModel(
              id: value.id,
              name: value.name,
              index: value.index,
              qtdispo: value.qtdispo,
              type: value.type,
              prix: double.parse(value.prix.toString()),
              img: value.img,
              quantity: value.quantity,
              isExist: true,
              time: DateTime.now().toString());
        }
      });
      print(total);
      totalItems;
      update();
    }
  }

  double get totalPrix {
    double totalPrix = 0;
    _items.forEach((k, v) {
      totalPrix += v.quantity * v.prix;
    });
    return totalPrix;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  // void updateItem(id, int quantity) {
  //   print(quantity);

  //   print('taillen');
  //   if (_items.containsKey(id)) {
  //     var total = 0;
  //     _items.update(id, (value) {
  //       total = value.quantity + quantity;

  //       return CartModel(
  //           id: value.id,
  //           name: value.name,
  //           prix: double.parse(value.prix.toString()),
  //           img: value.img,
  //           quantity: value.quantity + quantity,
  //           isExist: true,
  //           time: DateTime.now().toString());
  //     });

  //     if (total <= 0) {
  //       _items.remove(id);
  //     }
  //   }
  // }

  bool existInCart(ProduitModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  getListPinCart() {
    var listF = [];
    _items.forEach((k, v) {
      listF.add([v.id, v.quantity]);
    });
    print(listF);
    return listF;
  }

  deleteAll() {
    _items.clear();
    update();
  }

  void removeItem(id) {
    _items.remove(id);
    update();
  }

  getQuantity(ProduitModel product) {
    var quantity = 0;
    if (existInCart(product)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity;
        }
      });
    }
    return quantity;
  }

  void addItem(ProduitModel product, int quantity, index, type) {
    print(quantity);
    if (quantity <= product.quantite) {
      print('taillen');
      if (_items.containsKey(product.id)) {
        var total = 0;
        _items.update(product.id, (value) {
          total = value.quantity + quantity;

          return CartModel(
              id: value.id,
              name: value.name,
              index: value.index,
              type: value.type,
              prix: double.parse(value.prix.toString()),
              img: value.img,
              qtdispo: product.quantite,
              quantity: value.quantity + quantity,
              isExist: true,
              time: DateTime.now().toString());
        });

        if (total <= 0) {
          _items.remove(product.id);
        }
      } else {
        if (quantity > 0) {
          print(index);
          print(type);
          _items.putIfAbsent(
              product.id,
              () => CartModel(
                  id: product.id,
                  name: product.titre,
                  index: index,
                  type: type,
                  prix: double.parse(product.prix.toString()),
                  img: product.images[0].src,
                  qtdispo: product.quantite,
                  quantity: quantity,
                  isExist: true,
                  time: DateTime.now().toString()));
          _items.forEach((k, v) {
            print('vall ' + v.quantity.toString());
          });
        }
      }
    } else {
      fn.snackBar('Panier', 'Qunatite incorrect', ColorsApp.bleuLight);
    }
  }
}
