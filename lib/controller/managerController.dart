import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/model/data/UserModel.dart';
import 'package:fahkapmobile/repository/ManageRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/dependancies.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/Services/storageService2.dart';
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

  var s = Get.find<StorageService>();
  bool _userP = false;
  bool get userP => _userP;
  getKeyU() {
    _userP = s.getKey().isEmpty;
    _isConnected = !_userP;
    // print('------------------${_userP}');
    update();
  }

  var _User;
  UserModel get User => _User;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  //
  // CategoryController({required this.service});
  getUser() async {
    // print('user-------------------------${new GetStorage().read('keySecret')}');
    try {
      Response response = await manageRepo.getUser();
      // print('user-------------------------${response.body['data']}');
      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          _User = UserModel.fromJson(response.body['data']);
        }
      }
      getKeyU();
      _isLoaded = 1;
      update();
    } catch (e) {
      _isLoaded = 1;
      update();
      print(e);
    }
  }

  // CategoryController({required this.service});
  newLocalisation() async {
    // print('user-------------------------${new GetStorage().read('keySecret')}');
    try {
      Response response = await manageRepo.newConnexion();

      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          print('user-------------------------${response.body['data']}');
          if (response.statusCode == 203) {
            await newLocalisation();
          }
        }
      }
      getKeyU();
      _isLoaded = 1;
    } catch (e) {
      _isLoaded = 1;
      update();
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

  bool _isConnected = false;
  bool get isConnected => _isConnected;
  loginUser(data) async {
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
      Response response = await manageRepo.Login(data);
//       print(response.body);
      if (response.statusCode == 200) {
        s.saveKeyKen(response.body);
        await getUser();
        await MyBinding().onGetAll();
      }

      Get.back();
      // fn.snackBar('Mise a jour', response.body['message'], ColorsApp.bleuLight);
      _isConnected = true;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Connexion', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isConnected = false;
      update();
      print(e);
    }
  }

  bool _isSignUp = false;
  bool get isSignUp => _isSignUp;
  signUp(data) async {
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
      Response response = await manageRepo.SignUp(data);
//       print(response.body);
//  this.saveKeyKen(response.body);
      if (response.statusCode == 200) {
        await getUser();
        await MyBinding().onGetAll();
      }

      Get.back();
      // fn.snackBar('Mise a jour', response.body['message'], ColorsApp.bleuLight);
      _isSignUp = true;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Inscription', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isSignUp = false;
      update();
      print(e);
    }
  }
}
