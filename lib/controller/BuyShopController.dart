import 'package:fahkapmobile/model/data/CartModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/LivreurModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/LivreurRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class BuyShopController extends GetxController {
  final service = new ApiService();
  LivreurRepo livreurRepo = Get.find();
  int _state = 0;
  int get state => _state;
  onInit() {
    _state = 0;
    update();
  }

  stateChange(bool i) {
    _state = i ? checkVal(_state + 1) : checkVal(_state - 1);

    update();
    print('_state..........${_state}');
  }

  checkVal(val) {
    if (val >= 3) {
      return 3;
    } else if (val <= 0) {
      return 0;
    } else {
      return val;
    }
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
    _livreurList = [];
    update();

    try {
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
}
