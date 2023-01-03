import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/model/data/UserModel.dart';
import 'package:fahkapmobile/repository/ManageRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ManagerController extends GetxController {
  final service = new ApiService();
  bool _state = true;
  bool get state => _state;

  final ManageRepo manageRepo;
  ManagerController({required this.manageRepo});

  chageState(bool i) {
    _state = i;
    update();
  }

  bool _userP = new GetStorage().read('keySecret') != null;
  bool get userP => _userP;

  var _User;
  UserModel get User => _User;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  // CategoryController({required this.service});
  getUser() async {
    try {
      Response response = await manageRepo.getUser();
      _User = UserModel.fromJson(response.body['data']);

      _isLoaded = 1;
      update();
    } catch (e) {
      _isLoaded = 1;
      update();
      print(e);
    }
  }

  var fn = new ViewFunctions();

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  updateUser(data) async {
    _isUpdating = true;
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
      Response response = await manageRepo.updateUser(data);
      print(response.body);

      if (response.statusCode == 200) {
        await getUser();
      }

      Get.back();
      fn.snackBar('Mise a jour', response.body['message'], ColorsApp.bleuLight);
      _isUpdating = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Mise a jour', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isUpdating = false;
      update();
      print(e);
    }
  }
}
