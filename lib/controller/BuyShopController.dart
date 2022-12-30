import 'package:fahkapmobile/model/data/CartModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class BuyShopController extends GetxController {
  final service = new ApiService();

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
}
