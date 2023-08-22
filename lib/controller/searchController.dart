import 'package:EMIY/components/Widget/BoutiqueComponentHome.dart';
import 'package:EMIY/components/Widget/seacrhIngCompo.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/model/data/BoutiqueModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/ShortModel.dart';
import 'package:EMIY/repository/SearchRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/repository/ProduitRepo.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final SearchRepo searchRepo;
  SearchController({required this.searchRepo});
  int _tsearch = 0;
  int get tsearch => _tsearch;

  searchIsEmty() {
    if (_controllerField.text.isEmpty) {
      _tsearch = 0;
    } else {
      _tsearch = 1;
    }

    update();
  }

  clearAll() {
    _controllerField.clear();
    _listProduit = [];
    _categoryList = [];
    _listBoutique = [];
    _listShort = [];

    indexP = 1;
    indexB = 1;
    indexC = 1;
    indexS = 1;
    index = 1;
    _tsearch = 0;
    isType = null;
    update();
  }

  clearSearch() {
    _listProduit = [];
    _categoryList = [];
    _listBoutique = [];
    _listShort = [];
    _search = 0;
    indexP = 1;
    indexB = 1;
    indexC = 1;
    indexS = 1;
    index = 1;
    isType = null;
    update();
  }

  TextEditingController _controllerField = TextEditingController();
  TextEditingController get controllerField => _controllerField;

  int _search = 0;
  int get search => _search;

  List<ProduitModel> _listProduit = [];
  List<ProduitModel> get listProduit => _listProduit;

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;

  List<BoutiqueModel> _listBoutique = [];
  List<BoutiqueModel> get listBoutique => _listBoutique;

  List<ShortModel> _listShort = [];
  List<ShortModel> get listShort => _listShort;

  final dababase = Get.find<DataBaseController>();

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  var isType = null;
  setType(val) {
    isType = val;
    // index = 0;
    _isLoaded = false;
    update();
    print(isType);
  }

  int indexP = 1;
  int indexB = 1;
  int indexC = 1;
  int indexS = 1;
  int index = 1;
  setIndex() {
    if (isType == 0) {
      indexP++;
      update();
    }
    if (isType == 1) {
      indexB++;
      update();
    }
    if (isType == 2) {
      indexC++;
      update();
    }
    if (isType == 3) {
      indexS++;
      update();
    }
  }

  getIndex() {
    if (isType == 0) {
      index = indexP;
      update();
    }
    if (isType == 1) {
      index = indexB;

      update();
    }
    if (isType == 2) {
      index = indexC;

      update();
    }
    if (isType == 3) {
      index = indexS;

      update();
    }
  }

  searchForCont() async {
    print(_search);
    var key = await dababase.getKey();
    getIndex();
    try {
      _isLoaded = true;
      update();
      if (isType == null) {
        _search = 1;
        update();
      }

      Response response =
          await searchRepo.searchData(isType, controllerField.text, index, key);

      if (response.body != null) {
        print('**********${_search}');
        //print(response.body['data']);
        if (isType == null || isType == 0) {
          _listProduit.addAll((response.body['produit'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
        }
        if (isType == null || isType == 1) {
          _listBoutique.addAll((response.body['boutique'] as List)
              .map((e) => BoutiqueModel.fromJson(e))
              .toList());
        }
        if (isType == null || isType == 2) {
          _categoryList.addAll((response.body['categorie'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList());
        }
        if (isType == null || isType == 3) {
          _listShort.addAll((response.body['short'] as List)
              .map((e) => ShortModel.fromJson(e))
              .toList());
        }
        _search = 2;
        isType = 0;
        _isLoaded = false;
        setIndex();
        print('**********${_search}');

        update();
      }
    } catch (e) {
      //print(e);
      _search = 3;
      update();
    }
  }

  ScrollController _controllerT = new ScrollController();

  ScrollController get controllerT => _controllerT;
  @override
  void onInit() {
    super.onInit();

    _controllerT = ScrollController()..addListener(_scrollListener);

    // _savedPosition = _controllerT.position.pixels;
    update();
  }

  void _scrollListener() {
    print('.......');
    print(_controllerT.offset + Get.height / 2.5);
    print(_controllerT.position.maxScrollExtent);
    if (_controllerT.offset + Get.height / 2.5 >=
        _controllerT.position.maxScrollExtent) {
      if (_isLoaded == false) {
        _isLoaded = true;
        update();
        searchForCont();
      }
    }
  }
}
