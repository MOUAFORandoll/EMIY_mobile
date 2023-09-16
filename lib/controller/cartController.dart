import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/CartModel.dart'; 
import 'package:EMIY/model/data/ProduitModel.dart'; 
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart'; 
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

  void updateQuantityProduit(int idProduit, bool state) {
    // if (quantity <= produit.quantite) {
    var idCart = 0;
    if (_items.containsKey(idProduit)) {
      var total = 0;
      _items.update(idProduit, (value) {
        total = value.quantity + (state ? 1 : -1);
        idCart = value.id;
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
          fn.snackBar('Panier', 'Limite pour ce produit', false);
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
          fn.snackBar('Panier', 'Impossible', false);
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
      //print(total);
      totalItems;
      Get.find<ProduitController>().getD0(idCart);
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
  //   //print(quantity);

  //   //print('taillen');
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

  bool existInCart(ProduitModel produit) {
    if (_items.containsKey(produit.id)) {
      return true;
    }
    return false;
  }

  getListPinCart() {
    var listF = [];
    _items.forEach((k, v) {
      listF.add([v.id, v.quantity]);
    });
    //print(listF);
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

  getQuantity(ProduitModel produit) {
    var quantity = 0;
    print('--${produit}');
    if (existInCart(produit)) {
      _items.forEach((key, value) {
        if (key == produit.id) {
          quantity = value.quantity;
        }
      });
    }
    return quantity;
  }

  void addItem(ProduitModel produit, int quantity, index, type) {
    //print(quantity);
    if (quantity <= produit.quantite) {
      //print('taillen');
      if (_items.containsKey(produit.id)) {
        var total = 0;
        _items.update(produit.id, (value) {
          total = value.quantity + quantity;

          return CartModel(
              id: value.id,
              name: value.name,
              index: value.index,
              type: value.type,
              prix: double.parse(value.prix.toString()),
              img: value.img,
              qtdispo: produit.quantite,
              quantity: value.quantity + quantity,
              isExist: true,
              time: DateTime.now().toString());
        });

        if (total <= 0) {
          _items.remove(produit.id);
        }
      } else {
        if (quantity > 0) {
          //print(index);
          //print(type);
          _items.putIfAbsent(
              produit.id,
              () => CartModel(
                  id: produit.id,
                  name: produit.titre,
                  index: index,
                  type: type,
                  prix: double.parse(produit.prix.toString()),
                  img: produit.images[0].src,
                  qtdispo: produit.quantite,
                  quantity: quantity,
                  isExist: true,
                  time: DateTime.now().toString()));
          _items.forEach((k, v) {
            //print('vall ' + v.quantity.toString());
          });
        }
      }
    } else {
      fn.snackBar('Panier', 'Qunatite incorrect', false);
    }
  }
}
