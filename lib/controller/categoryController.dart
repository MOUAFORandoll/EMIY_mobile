import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/ProduitCategoryModel.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/repository/categoryRepo.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:get/get.dart';

// class CategoryController extends GetxController {
//   final CategoryRepo categoryRepo;
//   CategoryController({required this.categoryRepo});

//   List<CategoryModel> _categoryList = [];
//   List<CategoryModel> get categoryList => _categoryList;
//   int _isLoaded = 0;
//   int get isLoaded => _isLoaded;
//   // CategoryController({required this.service});
//   getCategory() async {
//     try {
//       _categoryList.clear();
//       _isLoaded = 0;
//       Response response = await categoryRepo.getListCategory();
//       if (response.body != null) {
//         if (response.body['data'].length != 0) {
//           _categoryList.addAll((response.body['data'] as List)
//               .map((e) => CategoryModel.fromJson(e))
//               .toList());
//         }
//         _isLoaded = 1;
//         update();
//       }
//       // //print(_categoryList);
     
//     } catch (e) {
//       //print(e);
//     }
//   }
// }
