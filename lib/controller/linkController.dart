import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/BoutiqueModel.dart';
import 'package:EMIY/model/data/BoutiqueModelLink.dart';
import 'package:EMIY/repository/linkRepo.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/model/data/ProduitModel.dart'; 
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class LinkController extends GetxController {
  final LinkRepo linkRepo;
  LinkController({required this.linkRepo});
  int _current = 0;
  int get current => _current;
  initCurrent() {
    _current = 0;
    update();
    // //print('curent ${_current}');
  }

  setCurrent(int i) {
    _current = i;
    update();
    // //print('curent ${_current}');
  }

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

  final dababase = Get.find<DataBaseController>();
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  var _produit;
  ProduitModel get produit => _produit;
  Future<void> getUniLinkProduit(codeProduit) async {
    _isLoaded = 0;
    print('-++++++++----debut eget---');

    update();
    var key = await dababase.getKey();

    try {
      Response response = await linkRepo.getUniLinkProduit(codeProduit, key);

      if (response.body != null) {
        if (response.body['data'] != null) {
          _produit = ProduitModel.fromJson(response.body['data']);
          update();

          _isLoaded = 1;

          update();
        } else {
          // _isLoaded = 2;
          // update();
        }
      }
    } catch (e) {
      _isLoaded = 2;
      // u  _isLoaded = 2;
      // update();
      //print(e);
    }
  }

  CartController _cart = Get.find();
  ProduitController _prodCont = Get.find();
  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  int get totalItems {
    return _cart.totalItems;
  }

  void setQuantity(bool isIncrement) {
    //print(
    // "QUanite $_quantity",
    // );

    //print("increment $isIncrement");
    _quantity = isIncrement == true
        ? checkQuantity(_quantity + 1)
        : checkQuantity(_quantity - 1);
    _qChanged = isIncrement == true ? _qChanged + 1 : _qChanged - 1;
    //print("*******$_quantity");
    _inCartItems = _cart.getQuantity(produit);
    update();
  }

  int _qChanged = 0;
  int checkQuantity(int quantity) {
    return (quantity + _inCartItems) < 0
        ? 0
        : (quantity + _inCartItems > produit.quantite)
            ? 0
            : quantity;
  }

  bool exitP() {
    return _produit == null ? false : _cart.existInCart(produit);
  }

  void addItem() {
    var index = _prodCont.addProduitInPopular(produit);
    _cart.addItem(produit, _quantity, index, '0');
    _quantity = 0;
    _inCartItems = _cart.getQuantity(produit);

    update();
    _cart.items.forEach((k, v) {});
  }

  var _boutique;
  BoutiqueModelLink get boutique => _boutique;
  Future<void> getUniLinkBoutique(codeProduit) async {
    _isLoaded = 0;
    update();

    var key = await dababase.getKey();
    try {
      Response response = await linkRepo.getUniLinkBoutique(codeProduit, key);
      print('-++++boutique++++-----${response.body['data']}');

      if (response.body != null) {
        if (response.body['data'] != null) {
          _boutique = BoutiqueModelLink.fromJson(response.body['data']);

          _isLoaded = 1;

          update();
        } else {
          // _isLoaded = 2;
          // update();
        }
      }
    } catch (e) {
      // _isLoaded = 2;
      // update();
      print(e);
    }
  }
}
