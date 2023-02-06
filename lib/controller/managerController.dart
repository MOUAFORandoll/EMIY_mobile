import 'dart:async';

import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/CompteModel.dart';
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
  late Timer _timer;
  double _tailleAdd = 0.0;
  double get tailleAdd => _tailleAdd;

  void startTimer() {
    chageN(true);
    if (stateN) {
      const oneSec = const Duration(milliseconds: 3);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          // print('iii');
          if (_tailleAdd == 120) {
            _tailleAdd = 0;

            update();
          } else {
            _tailleAdd += 1;

            update();
          }
          // print(_tailleAdd);
        },
      );
    }
  }

  bool _stateN = true;
  bool get stateN => _stateN;

  chageN(bool i) {
    _stateN = i;
    update();
  }

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

  var _ville;
  String get ville => _ville;

  var _longitude;
  double get longitude => _longitude;

  var _latitude;
  double get latitude => _latitude;

  getLocalU() async {
    var data = await s.getLonLat();
    print(data);
    _ville = data['ville'];
    _longitude = data['long'];
    _latitude = data['lat'];
    update();
  }

  bool _userP = false;
  bool get userP => _userP;
  getKeyU() {
    _userP = s.getKey().isEmpty;
    _isConnected = !_userP;
    print('------------------${s.getKey()}');
    update();
  }

  bool _stateSign = true;
  bool get stateSign => _stateSign;
  steStateSign() {
    _stateSign = !_stateSign;
    update();
  }

  bool _stateCreate = true;
  bool get stateCreate => _stateCreate;
  steStateCreate() {
    _stateCreate = !_stateCreate;
    update();
  }

  initStateSign() {
    _stateSign = true;
    update();
  }

  var _User;
  UserModel get User => _User;

  var _Compte;
  CompteModel get Compte => _Compte;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  //
  // CategoryController({required this.service});
  getUser() async {
    // print('user-------------------------${new GetStorage().read('keySecret')}');
    try {
      Response response = await manageRepo.getUser();
      print('user-------------------------${response.body}');
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _User = UserModel.fromJson(response.body['data']);
          _Compte = CompteModel.fromJson(response.body['compte']);
          getKeyU();
        }
      }

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

      if (response.body != null) {
        if (response.body['data'].length != 0) {
          print('user-------------------------${response.body['data']}');
          if (response.statusCode == 203) {
            await newLocalisation();
          }
        }
      }
      getKeyU();
    } catch (e) {}
  }

  var fn = new ViewFunctions();
  deconnectUser() async {
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
    Get.find<StorageService>().deleteStorage();
    getKeyU();
    _User = null;
    Get.back();
    fn.snackBar('Mise a jour', 'Deconnecte', ColorsApp.bleuLight);
    _userP = true;
    update();

    print('---------userp---------${userP}');

    // Get.find<DB>().deleteAll();
  }

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
        getKeyU();
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
        getKeyU();
        await getUser();
        // await MyBinding().onGetAll();
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
        s.saveKeyKen(response.body);
        getKeyU();
        await getUser();
        // await MyBinding().onGetAll();
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
