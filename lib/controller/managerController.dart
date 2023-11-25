import 'dart:async';

import 'package:EMIY/Views/BoutiqueUser/MesBoutiquesView.dart';
import 'package:EMIY/Views/Parrainnage/ParrainnageView.dart';
import 'package:EMIY/Views/UsersMange/InteretsView.dart';
import 'package:EMIY/Views/UsersMange/PreferenceView.dart';
import 'package:EMIY/Views/UsersMange/UserAbonnementView.dart';
import 'package:EMIY/Views/UsersMange/UserManageView.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/controller/entity.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/CompteModel.dart';
import 'package:EMIY/model/data/UserModel.dart';
import 'package:EMIY/model/data/UserTagModel.dart';
import 'package:EMIY/repository/ManageRepo.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:EMIY/utils/Services/core.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:image_picker/image_picker.dart';

import '../Views/Commandes/CommandeView.dart';
import '../Views/UsersMange/WalletView_SAVE_02112023.dart';
import '../utils/Services/routing.dart';
import 'boutiqueController.dart';

class ManagerController extends GetxController {
  final ManageRepo manageRepo;
  ManagerController({required this.manageRepo});

  // int _current = 0;
  // int get current => _current;
  // initCurrent() {
  //   _current = 0;
  //   update();
  //   // //print('curent ${_current}');
  // }
  final dababase = Get.find<DataBaseController>();

  // setCurrent(int i) {
  //   _current = i;
  //   update();
  //   // //print('curent ${_current}');
  // }

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
          // //print('iii');
          if (_tailleAdd == 120) {
            _tailleAdd = 0;

            update();
          } else {
            _tailleAdd += 1;

            update();
          }
          // //print(_tailleAdd);
        },
      );
    }
  }

  bool _stateN = true;
  bool get stateN => _stateN;

  chageN(bool i) {
    _stateN = i;
    update();
    //print('st****************');
    // //print(_stateN);
  }

  final service = new ApiService();
  /**
   * 0 => init compte
   * 1 => profile ok 
   * 2 => boutique
   */
  int _state = 0;
  int get state => _state;

  chageState(int i) {
    _state = i;
    update();
  }

  var _ville;
  String get ville => _ville;

  var _longitude;
  double get longitude => _longitude;

  var _latitude;
  double get latitude => _latitude;

  getLocalU() async {
    var data = await dababase.getLonLat();
    print('******************${data}');
    if (data != null) {
      print(data);
      if (data.length != 0) {
        print(data);
        _ville = data['ville'];
        _longitude = double.parse(data['longitude']);
        _latitude = double.parse(data['latitude']);
        update();
      }
    }
  }

  var _lienParrainnage = '';
  String get lienParrainnage => _lienParrainnage;
  bool _userP = false;
  bool get userP => _userP;
  getKeyU() async {
    var u = await dababase.getKey();
    //print('----------------uuuuu--$u');

    _userP = (u == null);

    _isConnected = !_userP;
    if (!_userP) {
      chageState(1);
    } else {
      chageState(0);
    }
    var kk = await dababase.getKeyKen();
    if (kk != null && kk != 'null') {
      _lienParrainnage =
          ApiUrl.external_link + 'subscribes/' + kk['codeParrainnage'];
    }
    // //print('------------------${dababase.getKey() }');
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

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getUserDB();
    getKeyU();
    getUser();
  }

  var _User;
  get Userget => _User;

  CompteModel _Compte = new CompteModel(solde: 0, id: 0);
  CompteModel get Compte => _Compte;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  //
  // CategoryController({required this.service});
  getUser() async {
    print('------------------debut get user');

    await manageRepo.getUser().then((value) async {
      print('------------------value----------${value.body}-');
      if (value.body['data'] != null &&
          value.body['data'] != [] &&
          value.body['data'].length != 0) {
        _User = UserModel.fromJson(value.body['data']);
        update();

        _Compte = CompteModel.fromJson(value.body['compte']);
        update();
        var _UserSave = User.fromJson(value.body['data']);

        await dababase.saveUser(_UserSave);
        if (_User != null) {
          // nameU.text = Userget.nom;
          // surnameU.text = Userget.prenom.toString();
          // phoneU.text = Userget.phone.toString();
          // emailU.text = Userget.email;
          initInfoUser();
          // Get.find<BoutiqueController>().getListBoutique();
        }
        getKeyU();
      }
    }).catchError((error) {
      _isLoaded = 1;
      update();
      print(error);
    });
    // try {
    //   Response response = await manageRepo.getUser();
    //   if (response.body != null) {
    //     if (response.body['data'].length != 0) {
    //       _User = UserModel.fromJson(response.body['data']);
    //       update();

    //       _Compte = CompteModel.fromJson(response.body['compte']);
    //       update();
    //       var _UserSave = User.fromJson(response.body['data']);

    //       await dababase.saveUser(_UserSave);
    //       if (_User != null) {
    //         // nameU.text = Userget.nom;
    //         // surnameU.text = Userget.prenom.toString();
    //         // phoneU.text = Userget.phone.toString();
    //         // emailU.text = Userget.email;
    //         initInfoUser();
    //         // Get.find<BoutiqueController>().getListBoutique();
    //       }
    //       getKeyU();
    //     }

    //     _isLoaded = 1;
    //     update();
    //   }
    // } catch (e) {
    //   _isLoaded = 1;
    //   update();
    //   //print(e);
    // }
  }

  getUserDB() async {
    // var data = await dababase.getUser();
    // print('-----------------------data-------${data!.id}-------------${data}');
    // ignore: unnecessary_null_comparison
    // if (data!.id != null) {
    // print(
    //     '-----------------------data-------${data.toMap()}-------------${data}');

    // _User = UserModel.fromJson(data.toMap());
    // update();
    // initInfoUserDB();
    // }
  }

  // CategoryController({required this.service});
  newLocalisation() async {
    try {
      Response response = await manageRepo.newConnexion();

      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            if (response.statusCode == 203) {
              await newLocalisation();
            }
          }
        }
      }
      getKeyU();
    } catch (e) {}
  }

  var fn = new ViewFunctions();
  deconnectUser() async {
    // fn.loading('Compte', 'Deconnexion en cours');

    dababase.deleteAll();
    chageState(0);

    Get.find<BoutiqueController>().DeconectBoutique();
    //        fn.closeLoader();

    fn.snackBar('Compte', 'Deconnecte', true);
    _userP = true;
    _User = null;
    fn.closeLoader();
    update();

    //print('---------userp---------${userP}');

    // dababase.deleteAll();
  }

  initInfoUser() {
    _nameU.text = Userget.nom;
    _surnameU.text = Userget.prenom;
    _phoneU.text = Userget.phone;
    _emailU.text = Userget.email;
    Get.find<NegociationController>().setUserId(_User.id);

    update();
  }

  initInfoUserDB() {
    _nameU.text = _User.nom;
    _surnameU.text = _User.prenom;
    _phoneU.text = _User.phone;
    _emailU.text = _User.email;
    Get.find<NegociationController>().setUserId(_User.id);
    update();
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
  final _formKeyUpdateU = new GlobalKey<FormState>();
  get formKeyUpdateU => _formKeyUpdateU;
  final _formKeyUpdatePassU = new GlobalKey<FormState>();
  get formKeyUpdatePassU => _formKeyUpdatePassU;
  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  updateUser() async {
    _isUpdating = true;
    update();
    var key = await dababase.getKey();
    var data = {
      'keySecret': key,
      'nom': nameU.text,
      'prenom': surnameU.text,
      'phone': phoneU.text,
      'email': emailU.text,
    };
    //print(data);
    fn.loading('Compte', 'Mise a jour de votre compte en cours');

    try {
      Response response = await manageRepo.updateUser(data);
      //print(response.body);

      if (response.statusCode == 200) {
        getKeyU();
        await getUser();
      }

      fn.closeLoader();

      fn.snackBar('Mise a jour', response.body['message'], true);
      _isUpdating = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      //        fn.closeLoader();

      _isUpdating = false;
      update();
      //print(e);
    }
  }

  Future updateImageUser() async {
    try {
      var image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
          maxHeight: 500,
          maxWidth: 500);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      //   aspectRatioPresets: [
      //     CropAspectRatioPreset.square,
      //     CropAspectRatioPreset.ratio3x2,
      //     CropAspectRatioPreset.original,
      //     CropAspectRatioPreset.ratio4x3,
      //     CropAspectRatioPreset.ratio16x9
      //   ],
      // );
      if (image != null) {
        fn.loading(
            'Boutique', 'Mise a jour de l\'affiche de votre boutique en cours');
        var key = await dababase.getKey();

        try {
          FormData formData = new FormData({
            "file": await MultipartFile(
              image.path,
              filename: "Image.jpg",
            ),
            'keySecret': key
          });

          print(formData.files);
          print(key);

          Response response = await manageRepo.updateImageUser(formData);
          print(response.body);
          if (response.statusCode == 200) {
            await getUser();
          }

          // fn.closeLoader();

          fn.snackBar('Mise a jour', response.body['message'], true);
          _isUpdating = false;
          // Get.back(closeOverlays: true);
          update();
        } catch (e) {
          fn.closeLoader();

          fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

          _isUpdating = false;
          update();
          //print(e);
        }
      }
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  TextEditingController _phoneLog = TextEditingController();
  get phoneLog => _phoneLog;
  TextEditingController _passwordLog = TextEditingController();
  get passwordLog => _passwordLog;

  final _formKeyLog = new GlobalKey<FormState>();
  get formKeyLog => _formKeyLog;
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  loginUser() async {
    var data = {
      'phone': phoneLog.text,
      'password': passwordLog.text,
    };
    fn.loading('Connexion', 'Connexion a votre compte en cours');

    try {
      Response response = await manageRepo.Login(data);
//       //print(response.body);
      if (response.statusCode == 200) {
        dababase.saveKeyKen(response.body);

        // getKeyU();
        // await getUser();
        await initAllApp();
        _isConnected = true;
        // Get.back(closeOverlays: true);
        update(); // await MyBinding().onGetAll();
        fn.closeLoader();
      } else {
        fn.closeLoader();

        fn.snackBar('Connexion', 'Identifiants incorrects', false);
      }

      // fn.snackBar('Mise a jour', response.body['message'], true);
      // _isConnected = true;
      // // Get.back(closeOverlays: true);
      // update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Connexion', 'Une erreur est survenue', false);
      //        fn.closeLoader();

      _isConnected = false;
      update();
      //print(e);
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

  TextEditingController _repass = TextEditingController();
  TextEditingController get repass => _repass;
  bool verifDataReg() {
    switch (_regStep) {
      case 0:
        return _formKeyReg1.currentState?.validate() ?? false;
      case 1:
        return _formKeyReg2.currentState?.validate() ?? false;
      default:
        return false;
    }
  }

  int _regStep = 0;
  get regStep => _regStep;

  setRegStep(bool l) {
    _regStep = l
        ? (verifDataReg())
            ? 1
            : 0
        : 0;
    update();
  }

  var _codeParrain = '';
  get codeParrain => _codeParrain;

  TextEditingController _userTag = TextEditingController();
  TextEditingController get userTag => _userTag;
  setCodeParrain(codeParrain0) {
    _codeParrain = codeParrain0;
    update();
    print('----------code :------${_codeParrain}');
  }

  TextEditingController _email = TextEditingController();
  TextEditingController get email => _email;
  final _formKeyReg1 = new GlobalKey<FormState>();
  get formKeyReg1 => _formKeyReg1;
  final _formKeyReg2 = new GlobalKey<FormState>();
  get formKeyReg2 => _formKeyReg2;
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
      'phone': int.parse(phone.text),
      'password': pass.text,
      "codeParrainage": codeParrain,
      "nom": name.text,
      "prenom": surname.text,
      "user_tag": userTag.text,
      // "email": email.text,
    };
    print(data);
    fn.loading('Inscription', 'Creatoin de votre compte en cours');

    try {
      Response response = await manageRepo.SignUp(data);
//       //print(response.body);
//  this.saveKeyKen(response.body);
      if (response.statusCode == 200) {
        dababase.saveKeyKen(response.body);

        // getKeyU();
        // await initApp();

        // await getUser();
        await initAllApp();

        // await MyBinding().onGetAll();
      }

      fn.closeLoader();

      // fn.snackBar('Mise a jour', response.body['message'], true);
      _isSignUp = true;
      Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Inscription', 'Une erreur est survenue', false);
      //        fn.closeLoader();

      _isSignUp = false;
      update();
      //print(e);
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
          dababase.saveKeyKen(rep.body);
          finalV = true;
        }
      } catch (e) {
        finalV = false;
      }
      return finalV;
    }
  }

  int _isAbUserPage = 1;
  int get isAbUserPage => _isAbUserPage;
  List<UserModel> _fieulList = [];
  List<UserModel> _fieulListSave = [];
  List<UserModel> get fieulList => _fieulList;
  int _isLoadedPB = 0;
  int get isLoadedPB => _isLoadedPB;
  getListFieul() async {
    var key = await dababase.getKey();
    _isLoadedPB = 0;

    try {
      Response response = await manageRepo.getListFieul(key, isAbUserPage);
      _fieulList.clear();
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _fieulList.addAll((response.body['data'] as List)
              .map((e) => UserModel.fromJson(e))
              .toList());

          // _isAbUserPage++;
        }

        _isLoadedPB = 1;
        update();
      }
      _fieulListSave = _fieulList;
    } catch (e) {
      //print(e);
    }
  }

  int _current = 0;
  int get current => _current;
  List title = [
    'Profile',
    'Commandes',
    'Abonnement',
    'Affilies',
    'Transactions',
    'Centre d\'iteret',
    'Preferences',
    'Mes boutiques',
  ];
  List _saveIndex = [];
  setContain(i) {
    print('-------------------------${i}');

    _current = i;
    print(i);

    update();
    print(_saveIndex);
    print(_saveIndex.contains(i));
    if (!_saveIndex.contains(i)) {
      if (i == 2) {
        print('----------------*');
        Get.find<BoutiqueController>().getListAbonnementForUser();
      }
      if (i == 4) {
        print('-------------TransactionController---*');
        Get.find<TransactionController>().getTransactions();
      }
      if (i == 7) {
        print('----------------*');
        Get.find<BoutiqueController>().getListBoutique();
      }
    }
    _saveIndex.add(i);
  }

  goToItemPage(i) {
    update();
    print(_saveIndex);
    print(_saveIndex.contains(i));
    if (!_saveIndex.contains(i)) {
      if (i == 1) {
        print('--------getListCommandes--------*');
        Get.find<CommandeController>().getListCommandes();
      }
      if (i == 2) {
        print('----------getListAbonnementForUser------*');
        Get.find<BoutiqueController>().getListAbonnementForUser();
      }
      if (i == 3) {
        print('----------------*');
        getListFieul();
      }
      if (i == 4) {
        print('-------------getTransactions---*');
        Get.find<TransactionController>().getTransactions();
      }
      if (i == 5) {
        // print('-------------TransactionController---*');
        // Get.find<TransactionController>().getTransactions();
      }
      if (i == 6) {
        print('-------------getListProduitPreference---*');
        Get.find<ProduitController>().getListProduitPreference();
      }
      if (i == 7) {
        print('---------getListBoutique-------*');
        Get.find<BoutiqueController>().getListBoutique();
      }
    }
    _saveIndex.add(i);
    switch (i) {
      case 0:
        Get.toNamed(AppLinks.USERVIEW);
        return 0;

      case 1:
        Get.toNamed(AppLinks.COMMANDE_FOR_USER);
        return 1;

      case 2:
        Get.toNamed(AppLinks.ABONNEMENT);
        return 2;

      case 3:
        Get.toNamed(AppLinks.FIEU_LIST);
        return 3;
      case 4:
        Get.toNamed(AppLinks.WALLET);
        return 4;

      case 5:
        Get.toNamed(AppLinks.INTERET);
        return 5;
      case 6:
        Get.toNamed(AppLinks.PREFERENCE_CLIENT);
        return 6;
      case 7:
        Get.toNamed(AppLinks.MES_BOUTIQUES);
        return 7;

      // case 4:
      //   return ProfileUserView();

      default:
        Get.toNamed(AppLinks.USERVIEW);
        return 0;
    }
  }

//                                         .getTransactions();
  Widget buildContent() {
    switch (_current) {
      case 0:
        return UserManageView();

      case 1:
        return CommandeView();

      case 2:
        return UserAbonnementView();

      case 3:
        return ParrainnageView();
      // case 4:
      //   return WalletView();

      case 5:
        return InteretsView();
      case 6:
        return PreferenceView();
      case 7:
        return MesBoutiquesView();

      // case 4:
      //   return ProfileUserView();

      default:
        return Container();
    }
  }
}
