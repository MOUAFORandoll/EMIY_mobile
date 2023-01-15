import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/repository/categoryRepo.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  // CategoryController({required this.service});
  getCategory() async {
    try {
      _categoryList.clear();
      _isLoaded = 0;
      Response response = await categoryRepo.getListCategory();
      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          _categoryList.addAll((response.body['data'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList());
        }
      }
      // print(_categoryList);
      _isLoaded = 1;
      update();
    } catch (e) {
      print(e);
    }
  }
}
