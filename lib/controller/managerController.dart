import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class ManagerController extends GetxController {
  final service = new ApiService();
  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;
  bool _state = true;
  bool get state => _state;

  chageState(bool i) {
    _state = i;
    update();
  }
}
