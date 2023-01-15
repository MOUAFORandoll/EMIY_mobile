import 'dart:io';

import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/BoutiqueUserModel.dart';
import 'package:fahkapmobile/model/data/CommandeBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/repository/ListBoutiqueRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ListBoutiqueController extends GetxController {
  final service = new ApiService();

  final ListBoutiqueRepo listBoutiqueRepo;
  ListBoutiqueController({required this.listBoutiqueRepo});

  var fn = new ViewFunctions();
  List<BoutiqueModel> _ListBoutique = [];
  List<BoutiqueModel> get ListBoutique => _ListBoutique;
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


  bool gA = false;
  // BoutiqueController({required this.service});
  getListBoutiques() async {
    if (gA == false) {
      gA = true;
      try {
        _ListBoutique = [];
        _ListBoutique.clear();
        _isLoaded = 0;
        update();
        Response response = await listBoutiqueRepo.getListBoutiques();
        // print('------------------------/*****************************');
        // print(response.body);
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            _ListBoutique.addAll((response.body['data'] as List)
                .map((e) => BoutiqueModel.fromJson(e))
                .toList());

            _isExist = response.body['exist'];
            // print(_ListBoutique);
          }
        }
        gA = false;
        _isLoaded = 1;

        update();
      } catch (e) {
        _isExist = false;
        _isLoaded = 1;
        gA = false;

        update();
        print(e);
      }
    }
  }

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
          await listBoutiqueRepo.getListProduitForBoutique(codeBoutique);
      _produitBoutiqueList.clear();
      print('-----------------');
      print(response.body);
      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          _produitBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => ProduitModel.fromJson(e))
              .toList());
        }
      }
      _produitBoutiqueListSave = _produitBoutiqueList;
      _isLoadedPB = 1;
      update();
    } catch (e) {
      print(e);
    }
  }
}
