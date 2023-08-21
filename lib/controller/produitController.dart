import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/repository/ProduitRepo.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class ProduitController extends GetxController {
  final ProduitRepo produitRepo;
  ProduitController({required this.produitRepo});

  int _choix = 0;
  int get choix => _choix;
  setChoix(val) {
    _choix = val;
    update();
  }

  final dababase = Get.find<DataBaseController>();

  bool _conf = false;
  bool get conf => _conf;
  setConf() {
    _conf = true;
    update();
  }

  unSetConf() {
    _conf = false;
    _choix = 0;
    indexSupp = 0;
    _produitSupplementaire.clear();
    update();
  }

  CartController _cart = Get.find();
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
    _inCartItems = _cart.getQuantity(_currentProduit);
    update();
  }

  int _qChanged = 0;
  int checkQuantity(int quantity) {
    //print("quantite final $quantity");
    //print("quantite final ${_currentProduit.quantite}");

    return (quantity + _inCartItems) < 0
        ? 0
        : (quantity + _inCartItems > _currentProduit.quantite)
            ? 0
            : quantity;
  }

  bool exitP(ProduitModel produit) {
    return _cart.existInCart(produit);
  }

  var _currentProduit = null;
  void initProduit(CartController cart, ProduitModel produit) {
    _currentProduit = produit;
    _quantity = 0;
    _inCartItems = 0;
    _qChanged = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(produit);
    if (exist) {
      _inCartItems = _cart.getQuantity(produit);
      // _quantity = _cart.getQuantity(produit);
      //print(_inCartItems);
    }
  }

  getD() {
    _inCartItems = _cart.getQuantity(_currentProduit);
    update();
  }

  addToProduitList(ProduitModel produit) {
    int index = _produitList.indexWhere((prod) => prod.id == produit.id);
    print('index-------------------        ${index}');

    if (index == -1) {
      _produitList.add(produit);
      update();
    }
  }

  getD0(id) {
    print(id);
    int index = _produitList.indexWhere((prod) => prod.id == id);
    print('index-------------------        ${index}');

    if (index != -1) {
      var produit = _produitList.where((prod) => prod.id == id).first;
      _inCartItems = _cart.getQuantity(produit);
      update();
    }
  }

  void addItem(ProduitModel produit, index, type) {
    //print('quantitte : ${_quantity} total : ${_inCartItems}');

    _cart.addItem(produit, _quantity, index, type);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(produit);

    update();
    _cart.items.forEach((k, v) {
      //print('produit id : ${v.id}  quantite : ' + v.quantity.toString());
    });
  }

  List<ProduitModel> _produitList = [];
  List<ProduitModel> _produitListSave = [];
  List<ProduitModel> get produitList => _produitList;
  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;
  double _savedPosition = 0;
  get savedPosition => _savedPosition;
  late ScrollController _controllerT;
  get controllerT => _controllerT;

  @override
  void onInit() {
    super.onInit();

    _controllerT = ScrollController(initialScrollOffset: savedPosition)
      ..addListener(_scrollListener);

    // _savedPosition = _controllerT.position.pixels;
    update();
  }

  void _scrollListener() {
    _savedPosition = _controllerT.position.pixels;
    update();
    // print('scroll------------------------------------${_savedPosition}');
    // print('-++++++++-----${_controllerT.offset + Get.height * 1.5}');
    // print('-------${_controllerT.position.maxScrollExtent}');
    if (_controllerT.offset + Get.height * 1.5 >=
        _controllerT.position.maxScrollExtent) {
      if (interest.isEmpty) {
        getPopularProduit();
      } else {
        getInterestProduit();
      }
    }
    _handleScroll();
  }

  bool _isBottomBarVisible = false;
  get isBottomBarVisible => _isBottomBarVisible;
  void _handleScroll() {
    if (_controllerT.position.userScrollDirection == ScrollDirection.reverse) {
      _isBottomBarVisible = true;
      update();
      // print('${_isBottomBarVisible}-----------------------------------');
    } else {
      _isBottomBarVisible = false;
      update();
      // print('${_isBottomBarVisible}-----------------------------------');
    }
    // print('idddd-----------------------------------');
  }

  void restoreScrollPosition() {
    if (_savedPosition != null) {
      _controllerT.jumpTo(_savedPosition);
      update();
    }
    // controllerT.animateTo(
    //   _savedPosition,
    //   duration: Duration(
    //       microseconds:
    //           5), // Durée de l'animation (modifiable selon vos besoins)
    //   curve:
    //       Curves.easeInOut, // Courbe d'animation (modifiable selon vos besoins)
    // );
    update();
    // print('restore------------------------------------${_savedPosition}');
  }

  bool _loaddata = false;
  bool get loaddata => _loaddata;

  int indexC = 2;
  updateProduitInPopular(ProduitModel newProduit) {
    int index =
        _produitList.indexWhere((produit) => produit.id == newProduit.id);
    if (index >= 0) {
      _produitList[index] = newProduit;
      update();
    }
  }

  likeProduitInPopular(codeProduit) {
    int index = _produitList
        .indexWhere((produit) => produit.codeProduit == codeProduit);
    if (index >= 0) {
      _produitList[index].islike = !_produitList[index].islike;
      if (_produitList[index].islike) {
        _produitList[index].like = _produitList[index].like - 1;
      } else {
        _produitList[index].like = _produitList[index].like + 1;
      }
      update();
    }
  }

  likeProduitInSupp(codeProduit) {
    int index = _produitSupplementaire
        .indexWhere((produit) => produit.codeProduit == codeProduit);
    if (index >= 0) {
      _produitSupplementaire[index].islike =
          !_produitSupplementaire[index].islike;
      if (_produitSupplementaire[index].islike) {
        _produitSupplementaire[index].like =
            _produitSupplementaire[index].like - 1;
      } else {
        _produitSupplementaire[index].like =
            _produitSupplementaire[index].like + 1;
      }
      update();
    }
  }

  Future<void> getPopularProduit() async {
    var key = await dababase.getKey();
    if (_loaddata == false) {
      print(_produitList.length);
      _isLoadedP = 0;
      _loaddata = true;
      update();
      try {
        Response response =
            await produitRepo.getListProduitPopular(indexC, key);

        //print(response.body);
        // _produitList = [];
        // _produitList.clear();
        // update();

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
              indexC++;

              _loaddata = false;
              update();
              // print('----${_loaddata}-------aaaaaaaaa---');
            } else {
              _isLoadedP = 1;
              update();
            }
          }
        }
      } catch (e) {
        _loaddata = false;
        update();
        //print(e);
      }
    }
  }

  int indexI = 0;
  List interest = [];
  stateInterest(cat) {
    if (interest.contains(cat)) {
      interest.remove(cat);
    } else {
      interest.add(cat);
    }
    indexI = 0;
    update();
  }

  select(cat) {
    return interest.contains(cat);
  }

  var fn = new ViewFunctions();

  Future<void> getInterestProduit() async {
    _savedPosition = 0;
    var key = await dababase.getKey();
    // if (_loaddata == false) {
    print(_produitList.length);
    _isLoadedP = 0;
    _loaddata = true;

    update();
    if (indexI == 0) {
      fn.loading('Boutique', 'Creation de votre boutique en cours');
    }

    try {
      Response response = await produitRepo.getListProduitInterest(
          indexI, key, interest.join(',').trim());

      //print(response.body);
      // _produitList = [];
      // _produitList.clear();
      // update();

      if (response.body != null) {
        if (response.body['data'] != null) {
          fn.closeLoader();

          if (response.body['data'].length != 0) {
            if (indexI == 0) {
              _produitList.clear();
              _produitListSave.clear();
            }

            _produitList.addAll((response.body['data'] as List)
                .map((e) => ProduitModel.fromJson(e))
                .toList());
            _produitListSave.addAll((response.body['data'] as List)
                .map((e) => ProduitModel.fromJson(e))
                .toList());
            _isLoadedP = 1;
            indexI++;

            _loaddata = false;
            update();

            // print('----${_loaddata}-------aaaaaaaaa---');
          } else {
            _isLoadedP = 1;
            update();
          }
        }
      }
    } catch (e) {
      _loaddata = false;
      update();
      fn.closeLoader();

      //print(e);
    }
    // }
  }

  getHomeProduit(List<ProduitModel> data) {
    _produitList = data;
    _produitListSave = data;
    update();
  }

  int indexSupp = 0;
  resetIndexSup() {
    indexSupp = 0;
    update();
  }

  bool _loadSupp = false;
  bool get loadSupp => _loadSupp;
  List<ProduitModel> _produitSupplementaire = [];
  List<ProduitModel> _produitSupplementaireSave = [];
  List<ProduitModel> get produitSupplementaire => _produitSupplementaire;
  int _isLoadedSupp = 0;
  int get isLoadedSupp => _isLoadedSupp;
  getListProduitSupplementaire(codeProduit) async {
    var key = await dababase.getKey();
    try {
      _isLoadedSupp = 0;

      update();
      Response response = await produitRepo.getListProduitSupplementaire(
          codeProduit, indexSupp, key);

      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            print(response.body['data']);
            _produitSupplementaire.addAll((response.body['data'] as List)
                .map((e) => ProduitModel.fromJson(e))
                .toList());
            indexSupp++;
          }
        }

        _isLoadedSupp = 1;
        update();
      }
    } catch (e) {
      //print(e);
    }
  }

  // List<ProduitModel> _produitListAll = [];
  // List<ProduitModel> _produitListAllSave = [];
  // List<ProduitModel> get produitListAll => _produitListAll;
  // int _isLoadedPAll = 0;
  // int get isLoadedPAll => _isLoadedPAll;
  // Future<void> getProduitAll() async {
  //   //print('response**********');

  //   _isLoadedPAll = 0;
  //   try {
  //     Response response = await produitRepo.getListProduitAll();

  //     //print(response.body);

  //     _produitListAll.clear();
  //     if (response.body != null) {
  //       if (response.body['data'].length != 0) {
  //         _produitListAll.addAll((response.body['data'] as List)
  //             .map((e) => ProduitModel.fromJson(e))
  //             .toList());
  //         _produitListAllSave.addAll((response.body['data'] as List)
  //             .map((e) => ProduitModel.fromJson(e))
  //             .toList());
  //       }
  //       _isLoadedPAll = 1;
  //       update();
  //     }
  //   } catch (e) {
  //     //print(e);
  //   }
  // }
  int indexP = 1;

  List<ProduitModel> _preferenceList = [];
  List<ProduitModel> _preferenceListSave = [];
  List<ProduitModel> get preferenceList => _preferenceList;
  int _isLoadedPB = 0;
  int get isLoadedPB => _isLoadedPB;
  getListProduitPreference() async {
    // _preferenceList = [];
    _isLoadedPB = 0;
    // update();

    var key = await dababase.getKey();
    try {
      Response response =
          await produitRepo.getListProduitPreference(indexP, key);
      _preferenceList.clear();
      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            _preferenceList.addAll((response.body['data'] as List)
                .map((e) => ProduitModel.fromJson(e))
                .toList());
            indexP++;
          }
        }

        _isLoadedPB = 1;
        update();
      }
    } catch (e) {
      //print(e);
    }
  }

  addProduitInPopular(ProduitModel newProduit) {
    int index =
        _produitList.indexWhere((produit) => produit.id == newProduit.id);
    print('-${index}');
    if (index > 0) {
      _produitList.add(newProduit);
      update();
      return _produitList.indexWhere((produit) => produit.id == newProduit.id);
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
    //print(_produitListSave);

    _produitListSave.forEach((item) {
      //print(item.titre.toUpperCase());
      //print(text.toUpperCase());
      if (item.titre.toUpperCase().contains(text.toUpperCase()) ||
          item.codeProduit.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    //print(cont.length);
    if (cont.length != 0) {
      _produitList = cont;
    } else {
      _produitList = _produitListSave;
    }

    update();
  }
}
