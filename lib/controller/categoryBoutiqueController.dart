import 'dart:io';

import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/BoutiqueUserModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/CommandeBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/repository/categoryBoutiqueRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CategoryBoutiqueController extends GetxController {
  final service = new ApiService();

  final CategoryBoutiqueRepo categoryBoutiqueRepo;
  CategoryBoutiqueController({required this.categoryBoutiqueRepo});

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;
  int _isLoadedCat = 0;
  int get isLoadedCat => _isLoadedCat;
  // CategoryController({required this.service});
  getCategory() async {
    try {
      _categoryList.clear();
      _categoryList = [];

      _isLoadedCat = 0;
      update();

      Response response = await categoryBoutiqueRepo.getListCategory();
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _categoryList.addAll((response.body['data'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList());
        }
        _isLoadedCat = 1;
        update();
      }
      // print(_categoryList);

    } catch (e) {
      print(e);
    }
  }

  var fn = new ViewFunctions();
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  bool _isExist = false;
  bool get isExist => _isExist;
  bool _addProduct = false;
  bool get addProduct => _addProduct;
  List<File> _listImgProduits = [];

  List<File> get listImgProduits => _listImgProduits;

  chageState(bool i) {
    _addProduct = i;
    update();
  }

  int _isLoadedP = 0;
  int get isLoadedP => _isLoadedP;

  List<BoutiqueModel> _ListBoutique = [];
  List<BoutiqueModel> get ListBoutique => _ListBoutique;
  getCategoryBoutique(id) async {
    print(id);
    _ListBoutique.clear();
    _isLoadedP = 0;
    try {
      Response response =
          await categoryBoutiqueRepo.getListBoutiqueForCategory(id);

      if (response.body != null) {
        if (response.body['data'].length != 0) {
          print('****');
          print(response.body['data']);
          _ListBoutique.addAll((response.body['data'] as List)
              .map((e) => BoutiqueModel.fromJson(e))
              .toList());
        }
        print(_ListBoutique);
        _isLoadedP = 1;
        update();
      }
    } catch (e) {
      print(e);
    }
  }
  // bool gA = false;
  // // BoutiqueController({required this.service});
  // getListBoutiques() async {
  //   if (gA == false) {
  //     gA = true;
  //     try {
  //       _ListBoutique = [];
  //       _ListBoutique.clear();
  //       _isLoaded = 0;
  //       update();
  //       Response response = await categoryBoutiqueRepo.getListBoutiques();
  //       // print('------------------------/*****************************');
  //       // print(response.body);
  //       if (response.body != null) {
  //         if (response.body['data'].length != 0) {
  //           _ListBoutique.addAll((response.body['data'] as List)
  //               .map((e) => BoutiqueModel.fromJson(e))
  //               .toList());

  //           _isExist = response.body['exist'];
  //           // print(_ListBoutique);
  //         }
  //       }
  //       gA = false;
  //       _isLoaded = 1;

  //       update();
  //     } catch (e) {
  //       _isExist = false;
  //       _isLoaded = 1;
  //       gA = false;

  //       update();
  //       print(e);
  //     }
  //   }
  // }

  List<ProduitModel> _produitBoutiqueList = [];
  List<ProduitModel> _produitBoutiqueListSave = [];
  List<ProduitModel> get produitBoutiqueList => _produitBoutiqueList;
  int _isLoadedPB = 0;
  int get isLoadedPB => _isLoadedPB;
  getDataForBoutique(codeBoutique) async {
    // _produitBoutiqueList = [];
    _isLoadedPB = 0;

    try {
      Response response =
          await categoryBoutiqueRepo.getListProduitForBoutique(codeBoutique);
      _produitBoutiqueList.clear();
      print('-----------------');
      print(response.body);
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _produitBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
        }
        _isLoadedPB = 1;
        update();
      }
      _produitBoutiqueListSave = _produitBoutiqueList;
    } catch (e) {
      print(e);
    }
  }
}