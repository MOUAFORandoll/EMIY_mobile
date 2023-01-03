import 'package:fahkapmobile/model/data/CartModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/LivreurModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/BuyShoopingCartRepo.dart';
import 'package:fahkapmobile/repository/LivreurRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyShopController extends GetxController {
  final BuyShoopingCartRepo buySoppingCartRepo;
  BuyShopController({required this.buySoppingCartRepo});

  final service = new ApiService();
  LivreurRepo livreurRepo = Get.find();
  int _state = 0;
  int get state => _state;
  // ignore: must_call_super
  onInit() {
    _state = 0;
    update();
  }

  // int _current = 0;
  // int get current => _current;

  stateChange(bool i) {
    // _current = _state;
    _state = i ? checkVal(_state + 1) : checkVal(_state - 1);

    update();
    print('_state..........${_state}');
  }

  checkVal(val) {
    if (val > 3) {
      return 3;
    } else if (val <= 0) {
      return 0;
    } else {
      return val;
    }
  }

  isCurrent(int index) {
    return _state == index;
  }

  List<LivreurModel> _livreurList = [];
  List<LivreurModel> get livreurList => _livreurList;
  int _isLivreur = 0;
  int get isLivreur => _isLivreur;
  setLivreur(int id) {
    _isLivreur = id;
    update();
  }

  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  // CategoryController({required this.service});
  getListLivreur() async {
    _isLoaded = 0;
    setLivreur(0);
    try {
      _livreurList = [];

      _livreurList.clear();
      update();
      Response response = await livreurRepo.getLivreur();
      print('livreur------------------');
      print(response.body['data']);
      _livreurList.addAll((response.body['data'] as List)
          .map((e) => LivreurModel.fromJson(e))
          .toList());
      // print(_categoryList);
      _isLoaded = 1;
      update();
    } catch (e) {
      print(e);
    }
  }

  bool _isOk = false;
  bool get isOk => _isOk;
  var fn = new ViewFunctions();
  // CategoryController({required this.service});
  buyCart(data) async {
    update();
    Get.defaultDialog(
        title: 'En cours',
        barrierDismissible: false,
        content: SizedBox(
            // height: Get.size.height * .02,
            // width: Get.size.width * .02,
            child: Center(
                child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ))));
    try {
      Response response = await buySoppingCartRepo.buyCart(data);
      print(response.body);
      Get.back();
   
      fn.snackBar('Achat', response.body['message'], ColorsApp.bleuLight);
      _isOk = response.body['status'];
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Achat', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();

      update();
      print(e);
    }
  }
}
