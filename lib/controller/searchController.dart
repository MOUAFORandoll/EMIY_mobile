import 'package:Fahkap/components/Widget/BoutiqueComponentHome.dart';
import 'package:Fahkap/components/Widget/seacrhIngCompo.dart';
import 'package:Fahkap/model/data/BoutiqueModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/repository/SearchRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/repository/popularProductRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final SearchRepo searchRepo;
  SearchController({required this.searchRepo});
  int _tsearch = 0;
  int get tsearch => _tsearch;

  searchType(int i) {
    // if (i == 0) {
    //   _controllerField.text = '';
    // }
    _tsearch = i;
    _listResultSeaarch = [];

    update();
    print(_tsearch);
  }

  TextEditingController _controllerField = TextEditingController();
  TextEditingController get controllerField => _controllerField;

  bool _searchPro = false;
  bool get searchPro => _searchPro;

  selectFilter() {
    Get.defaultDialog(
        title: 'Filtre',
        content: SizedBox(
            // height: Get.size.height * .02,
            // width: Get.size.width * .02,
            child: Column(children: [
          SeacrhIngCompo(
            title: 'Produit',
            actif: _tsearch == 0,
            onTap: () {
              searchType(0);
              Get.back();
            },
          ),
          SeacrhIngCompo(
            title: 'Boutique',
            actif: _tsearch == 1,
            onTap: () {
              searchType(1);
              Get.back();
            },
          ),
          SeacrhIngCompo(
            actif: _tsearch == 2,
            title: 'Category',
            onTap: () {
              searchType(2);
              Get.back();
            },
          ),
        ])));
  }

  List _listResultSeaarch = [];
  List get listResultSeaarch => _listResultSeaarch;

  searchForCont() async {
    try {
      _listResultSeaarch = [];
      _searchPro = true;
      update();

      Response response =
          await searchRepo.searchData(tsearch, controllerField.text);

      if (response.body != null) {
        print('**********search');
        print(response.body['data']);
        if (response.body['data'].length != 0) {
          _listResultSeaarch.addAll((response.body['data'] as List)
              .map((e) => tsearch == 0
                  ? ProduitModel.fromJson(e)
                  : tsearch == 1
                      ? BoutiqueModel.fromJson(e)
                      : CategoryModel.fromJson(e))
              .toList());
        }
        _searchPro = false;
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
