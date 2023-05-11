import 'dart:async';

import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/CompteModel.dart';
import 'package:Fahkap/model/data/ProduitCategoryModel.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/model/data/UserModel.dart';
import 'package:Fahkap/repository/ManageRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/Services/storageService2.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Fahkap/utils/constants/apiRoute.dart';

import 'boutiqueController.dart';

class ManagerController extends GetxController {
  int _current = 0;
  int get current => _current;
  initCurrent() {
    _current = 0;
    update();
    // print('curent ${_current}');
  }

  setCurrent(int i) {
    _current = i;
    update();
    // print('curent ${_current}');
  }

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
    print('st****************');
    // print(_stateN);
  }

  final service = new ApiService();
  /**
   * 0 => init compte
   * 1 => profile ok 
   * 2 => boutique
   */
  int _state = 0;
  int get state => _state;

  final ManageRepo manageRepo;
  ManagerController({required this.manageRepo});

  chageState(int i) {
    _state = i;
    update();
  }

  var s = Get.find<DB>();

  var _ville;
  String get ville => _ville;

  var _longitude;
  double get longitude => _longitude;

  var _latitude;
  double get latitude => _latitude;

  getLocalU() async {
    var data = await s.getLonLat();
    // print('******************data');
    // print(data);
    if (data != null) {
      if (data.length != 0) {
        _ville = data['ville'];
        _longitude = data['long'];
        _latitude = data['lat'];
        update();
      }
    }
  }

  bool _userP = false;
  bool get userP => _userP;
  getKeyU() async {
    var u = await s.getKey();
    print('----------------uuuuu--$u');

    _userP = (u == null);

    _isConnected = !_userP;
    if (!_userP) {
      chageState(1);
    } else {
      chageState(0);
    }
    // print('------------------${s.getKey()}');
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

  CompteModel _Compte = new CompteModel(solde: 0, id: 0);
  CompteModel get Compte => _Compte;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  //
  // CategoryController({required this.service});
  getUser() async {
    // print('user-------------------------${new GetStorage().read('keySecret')}');
    var getU = await s.getKey();
    print('key******************** ${getU}');
    // await this.userRefresh();
    // ignore: unnecessary_null_comparison

    try {
      Response response = await manageRepo.getUser();
      print('user-------------------------${response.body}');
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _User = UserModel.fromJson(response.body['data']);
          _Compte = CompteModel.fromJson(response.body['compte']);
          update();
          if (_User != null) {
            nameU.text = User.nom;
            surnameU.text = User.prenom.toString();
            phoneU.text = User.phone.toString();
            emailU.text = User.email;
          }
          getKeyU();
          print(
              '_isok------------***********************-------------------------${_isLoaded}');
          Get.find<BoutiqueController>().getBoutique();
        }

        _isLoaded = 1;
        update();
      }
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
          // print('user-------------------------${response.body['data']}');
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
    // Get.defaultDialog(
    //     title: 'En cours',
    //     barrierDismissible: true,
    //     content: SizedBox(
    //         // height: Get.size.height * .02,
    //         // width: Get.size.width * .02,
    //         child: Center(
    //             child: CircularProgressIndicator(
    //       color: Colors.blueAccent,
    //     ))));
    Get.find<DB>().deleteAll();
    chageState(0);

    Get.find<BoutiqueController>().DeconectBoutique();
    // Get.back();
    fn.snackBar('Mise a jour', 'Deconnecte', true);
    _userP = true;

    update();

    print('---------userp---------${userP}');

    // Get.find<DB>().deleteAll();
  }

  TextEditingController _nameU = TextEditingController();
  get nameU => _nameU;
  TextEditingController _surnameU = TextEditingController();
  get surnameU => _surnameU;

  TextEditingController _phoneU = TextEditingController();
  get phoneU => _phoneU;

  TextEditingController _descriptionU = TextEditingController();
  get descriptionU => _descriptionU;

  TextEditingController _emailU = TextEditingController();
  get emailU => _emailU;

  TextEditingController _pwdCurrentU = TextEditingController();
  get pwdCurrentU => _pwdCurrentU;

  TextEditingController _newpwdU = TextEditingController();
  get newpwdU => _newpwdU;

  TextEditingController _rnewpwdU = TextEditingController();
  get rnewpwdU => _rnewpwdU;
  final _formKeyUpdateU = GlobalKey<FormState>();
  get formKeyUpdateU => _formKeyUpdateU;
  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  updateUser() async {
    _isUpdating = true;
    update();
    var data = {
      'keySecret': new GetStorage().read('keySecret'),
      'nom': nameU.text,
      'prenom': surnameU.text,
      'phone': phoneU.text,
      'email': emailU.text,
    };
    print(data);
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
      fn.snackBar('Mise a jour', response.body['message'], true);
      _isUpdating = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      // Get.back();
      _isUpdating = false;
      update();
      print(e);
    }
  }

  TextEditingController _phoneLog = TextEditingController();
  get phoneLog => _phoneLog;
  TextEditingController _passwordLog = TextEditingController();
  get passwordLog => _passwordLog;

  final _formKeyLog = GlobalKey<FormState>();
  get formKeyLog => _formKeyLog;
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  loginUser() async {
    var data = {
      'phone': phoneLog.text,
      'password': passwordLog.text,
    };
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
        _isConnected = true;
        // Get.back(closeOverlays: true);
        update(); // await MyBinding().onGetAll();
      }

      Get.back();
      // fn.snackBar('Mise a jour', response.body['message'], true);
      _isConnected = true;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Connexion', 'Une erreur est survenue', false);
      // Get.back();
      _isConnected = false;
      update();
      print(e);
    }
  }

  TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;

  TextEditingController _surname = TextEditingController();
  TextEditingController get surname => _surname;

  TextEditingController _phone = TextEditingController();
  TextEditingController get phone => _phone;

  TextEditingController _pass = TextEditingController();
  TextEditingController get pass => _pass;

  TextEditingController repass = TextEditingController();
  TextEditingController get _repass => _repass;

  TextEditingController _email = TextEditingController();
  TextEditingController get email => _email;
  final _formKeyReg = GlobalKey<FormState>();
  get formKeyReg => _formKeyReg;
  bool _isSignUp = false;
  bool get isSignUp => _isSignUp;
  signUp() async {
    if (pass.text != repass.text) {
      fn.snackBar('Mot de passse', 'Mot de passe differents', false);
      return false;
    }
    if (pass.text.length < 5 || repass.text.length < 5) {
      fn.snackBar('Mot de passse', '5 caractes minimum', false);
      return false;
    }

    var data = {
      'phone': phone.text,
      'password': pass.text,
      "nom": name.text,
      "prenom": surname.text,
      "email": email.text,
      "status": true,
    };
    print(data);
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
      // fn.snackBar('Mise a jour', response.body['message'], true);
      _isSignUp = true;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Inscription', 'Une erreur est survenue', false);
      // Get.back();
      _isSignUp = false;
      update();
      print(e);
    }
  }

  refreshToken(url) async {
    bool finalV = false;

    if (url != ApiRoutes.LOGIN &&
        // url != ApiRoutes.forgot &&
        url != ApiRoutes.Refresh) {
      try {
        Response rep = await manageRepo.userRefresh();
        if (rep.statusCode == 200) {
          s.saveKeyKen(rep.body);
          finalV = true;
        }
      } catch (e) {
        finalV = false;
      }
      return finalV;
    }
  }
}
