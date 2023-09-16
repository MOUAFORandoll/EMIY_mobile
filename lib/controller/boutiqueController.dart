import 'dart:io';

import 'package:EMIY/Views/BoutiqueUser/CommadesBoutiqueUserView.dart';
import 'package:EMIY/Views/BoutiqueUser/HistroriqueCBUView.dart';
import 'package:EMIY/Views/BoutiqueUser/ShortBoutiqueView.dart';
import 'package:EMIY/Views/BoutiqueUser/manageBoutiqueUserView.dart';
import 'package:EMIY/Views/BoutiqueUser/produitBoutiqueUserView.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/model/data/AbonnementBoutiqueModel.dart';

import 'package:EMIY/model/data/BoutiqueModel.dart';
import 'package:EMIY/model/data/BoutiqueUserModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/CommandeBoutiqueModel.dart';
import 'package:EMIY/model/data/ProduitBoutiqueModel.dart';
import 'package:EMIY/model/data/ShortModel.dart' show ShortModel;
import 'package:EMIY/repository/BoutiqueRepo.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class BoutiqueController extends GetxController {
  final service = new ApiService();

  final BoutiqueRepo boutiqueRepo;
  BoutiqueController({required this.boutiqueRepo});

  var fn = new ViewFunctions();
  var _Boutique;
  get Boutique => _Boutique;
  bool _isExist = false;
  bool get isExist => _isExist;

  List<File> _listImgProduits = [];

  final dababase = Get.find<DataBaseController>();
  void onInit() async {
    // TODO: implement initState

    super.onInit();
    _quantite.text = '0';
  }

  List<File> get listImgProduits => _listImgProduits;
  onInitData() {
    _listImgProduits = [];
    _listImgProduits.clear();
    _addProduit = false;
    // update();
  }

  File imageFile = new File('');

  Future getImageAppareil() async {
    try {
      //print("wwwwwwwww");

      var image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
          maxHeight: 500,
          maxWidth: 500);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      // );
      _listImgProduits.add(File(image!.path));

      update();
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  Future getImageGalerie() async {
    try {
      //print("wwwwwwwww");

      var image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
          maxHeight: 500,
          maxWidth: 500);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      // );
      _listImgProduits.add(File(image!.path));
      //print(_listImgProduits.length);
      update();
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  deleteImage(index) {
    _listImgProduits.remove(_listImgProduits[index]);

    update();
  }

  var _categorySelect;
  CategoryModel get categorySelect => _categorySelect;
  secelctCate(cat) {
    _categorySelect = cat;
    update();
  }

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;
  int _isLoadedC = 0;
  int get isLoadedC => _isLoadedC;
  // CategoryController({required this.service});
  getCategory() async {
    try {
      if (_categoryList.isEmpty) {
        _isLoadedC = 0;
        _categoryList = Get.find<CategoryBoutiqueController>().categoryList;
        // Response response = await boutiqueRepo.getListCategory();

        // if (response.body != null) {
        //   if (response.body['data'].length != 0) {
        //     _categoryList.addAll((response.body['data'] as List)
        //         .map((e) => CategoryModel.fromJson(e))
        //         .toList());
        //   }
        _isLoadedC = 1;
        update();
        // }
        // //print(_categoryList);
      }
    } catch (e) {
      //print(e);
    }
  }

  File boutiqueImage = new File('');
  bool _isImage = false;
  bool get isImage => _isImage;
  Future getImageBoutiqueCamera() async {
    try {
      //print("wwwwwwwww");

      var image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
          maxHeight: 500,
          maxWidth: 500);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      // );
      boutiqueImage = (File(image!.path));
      _isImage = true;
      // //print(_listImgProduits.length);
      update();
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  Future getImageBoutiqueGallery() async {
    try {
      //print("wwwwwwwww");

      var image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
          maxHeight: 500,
          maxWidth: 500);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      // );
      boutiqueImage = (File(image!.path));
      _isImage = true;
      // //print(_listImgProduits.length);
      update();
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  bool _isOk = false;
  bool get isOk => _isOk;

  TextEditingController _titreBoutique = TextEditingController();
  get titreBoutique => _titreBoutique;

  TextEditingController _descriptionBoutique = TextEditingController();
  get descriptionBoutique => _descriptionBoutique;
  newBoutique() async {
    _isOk = false;
    update();

    try {
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
      if (boutiqueImage.path != '') {
        fn.loading('Boutique', 'Creation de votre boutique en cours');

        var key = await dababase.getKey();

        FormData formData = new FormData({
          "file": await MultipartFile(
            boutiqueImage.path,
            filename: "Image.jpg",
          ),
          'titre': titreBoutique.text,
          'description': descriptionBoutique.text,
          'idCategory': categorySelect.id,
          'ville': ville,
          'longitude': longitude,
          'latitude': latitude,
          'keySecret': key
        });

        Response response = await boutiqueRepo.newBoutique(formData);
        //print(response.body);

        if (response.statusCode == 200) {
          _isOk = false;
          update();

          await getListBoutique();
          fn.closeLoader();

          fn.snackBar('Mise a jour', response.body['message'], true);
          _isUpdatingB = false;
          // Get.back(closeOverlays: true);
          update();
        } else {
          fn.closeLoader();
        }
      } else {
        fn.closeLoader();

        fn.snackBar('Boutique', 'Remplir tous les champs', false);
      }
    } catch (e) {
      fn.closeLoader();
      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

      _isUpdatingB = false;
      update();
      //print(e);
    }
  }

  Future updateImageBoutique() async {
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
            'codeBoutique': Boutique.codeBoutique,
            'keySecret': key
          });

          //print(formData.files);

          Response response = await boutiqueRepo.updateImageBoutique(formData);
          //print(response.body);
          if (response.statusCode == 200) {
            await getListBoutique();
          }

          fn.closeLoader();

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

  List<BoutiqueUserModel> _listBoutiques = [];

  List<BoutiqueUserModel> get listBoutiques => _listBoutiques;
  bool _loadBoutique = true;
  bool get loadBoutique => _loadBoutique;
  selectBoutique(_boutique) {
    _Boutique = _boutique;
    titre.text = _Boutique.titre;
    description.text = _Boutique.description;
    new SocketService().boutique(_Boutique.codeBoutique, socketBoutique);
    update();
    Get.toNamed(AppLinks.BOUTIQUE_USER);

    // getListShortBoutique();
    setBoutiqueContent(0);
  }

  // BoutiqueController({required this.service});
  getListBoutique() async {
    try {
      //print('---0000--------boutiqr************************');

      Response response = await boutiqueRepo.getBoutiqueForUser();
      if (response.body != null) {
        //print('---111--------boutiqr************************');

        if (response.body['data'] != null &&
            response.body['data'].length != 0) {
          // print('-----------boutiqr************************');
          // print(response.body['data']);

          _listBoutiques.addAll((response.body['data'] as List)
              .map((e) => BoutiqueUserModel.fromJson(e))
              .toList());
          // _loadBoutique = false;
          // update();
          _isExist = response.body['exist'];

          // //print(_Boutique);
        }
      }
      _loadBoutique = false;
      update();
    } catch (e) {
      _isExist = false;
      //print('---error--------boutiqr************************');

      _loadBoutique = false;

      update();
      //print(e);
    }
  }

  socketBoutique(data) {
    if (data['typeEcoute'] == 0) {
      fn.snackBar('Commande', data['message'], true);
    }
    if (data['typeEcoute'] == 1) {
      fn.snackBar('Nouvelle negociation', data['message'], true);
      new SocketService()
          .negociation(data['canalNegociation'], socketMessageNegociation);
    }
  }

  socketMessageNegociation(data) {
    fn.snackBar('Message negociation', data['message'], true);
    // ici on doit faire l'ajout a la liste des message en locale dans le telephone du user
  }

  DeconectBoutique() {
    _Boutique = null;
    _isExist = false;
    update();
  }

  List<CommandeBoutiqueModel> _commandeBoutiqueList = [];
  List<CommandeBoutiqueModel> _commandeBoutiqueListSave = [];
  List<CommandeBoutiqueModel> get commandeBoutiqueList => _commandeBoutiqueList;
  int _isLoadedPC = 0;
  int get isLoadedPC => _isLoadedPC;
  getListCommandeForBoutique() async {
    // _commandeBoutiqueList = [];
    _searchCom = false;
    _isLoadedPC = 0;
    //print('getCOmeee---------');
    try {
      Response response =
          await boutiqueRepo.getListCommandeForBoutique(Boutique.codeBoutique);
      _commandeBoutiqueList.clear();
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _commandeBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => CommandeBoutiqueModel.fromJson(e))
              .toList());
          _commandeBoutiqueListSave = _commandeBoutiqueList;
        }
        _isLoadedPC = 1;
        update();
      }
    } catch (e) {
      //print(e);
    }
  }

  List<CommandeBoutiqueModel> _HcommandeBoutiqueListSave = [];
  List<CommandeBoutiqueModel> _HcommandeBoutiqueList = [];
  List<CommandeBoutiqueModel> get HcommandeBoutiqueList =>
      _HcommandeBoutiqueList;
  int _loadFinishCommande = 0;
  int get loadFinishCommande => _loadFinishCommande;
  getListHCommandeForBoutique() async {
    // _HcommandeBoutiqueList = [];
    _loadFinishCommande = 0;
    _HsearchCom = false;
    try {
      Response response =
          await boutiqueRepo.getListHCommandeForBoutique(Boutique.codeBoutique);
      _HcommandeBoutiqueList.clear();
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _HcommandeBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => CommandeBoutiqueModel.fromJson(e))
              .toList());
        }
        _loadFinishCommande = 1;

        update();
      }
      _HcommandeBoutiqueListSave = _HcommandeBoutiqueList;
      //print(response.body['data']);
      _loadFinishCommande = 1;
      print('i--------------${_loadFinishCommande}------');
      update();
    } catch (e) {
      //print(e);
    }
  }

  List _listProduitSelect = [];
  List get listProduitSelect => _listProduitSelect;
  selectProduit(produit) {
    _listProduitSelect.add(produit.id);
    update();
  }

  isSelected(produit) {
    return _listProduitSelect.contains(produit.id);
  }

  List<ProduitBoutiqueModel> _produitBoutiqueList = [];
  List<ProduitBoutiqueModel> _produitBoutiqueListSave = [];
  List<ProduitBoutiqueModel> get produitBoutiqueList => _produitBoutiqueList;
  int _isLoadedPB = 0;
  int get isLoadedPB => _isLoadedPB;
  getListProduitForBoutique() async {
    // _produitBoutiqueList = [];
    _isLoadedPB = 0;
    // update();

    _searchProB = false;
    //print('getProduit---------');

    try {
      Response response =
          await boutiqueRepo.getListProduitForBoutique(Boutique.codeBoutique);
      _produitBoutiqueList.clear();
      if (response.body != null) {
        if (response.body['data'].length != 0) {
          _produitBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => ProduitBoutiqueModel.fromJson(e))
              .toList());
        }

        _isLoadedPB = 1;
        update();
      }
      _produitBoutiqueListSave = _produitBoutiqueList;
    } catch (e) {
      //print(e);
    }
  }

  updateProduitImage(idProduitObject) async {
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
        fn.loading('Produit', 'Mise a jour de la photo du produit en cours');
        var key = await dababase.getKey();

        try {
          FormData formData = new FormData({
            "file": await MultipartFile(
              image.path,
              filename: "Image.jpg",
            ),
            'codeBoutique': Boutique.codeBoutique,
            'keySecret': key,
            'idProduitObject': idProduitObject
          });

          //print(formData.files);

          Response response = await boutiqueRepo.updateProduitiMAGEFB(formData);
          //print(response.body);
          if (response.statusCode == 200) {
            await getListProduitForBoutique();
            fn.closeLoader();

            fn.snackBar('Mise a jour', response.body['message'], true);
            _isUpdating = false;
            // Get.back(closeOverlays: true);
            update();
          } else {
            fn.closeLoader();
          }
        } catch (e) {
          fn.closeLoader();

          fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
          //        fn.closeLoader();

          _isUpdating = false;
          update();
          //print(e);
        }
      }
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  addProduitImage(idProduit) async {
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
        fn.loading('Produit', 'Ajout d\'une image au produit en cours');

        var key = await dababase.getKey();

        try {
          FormData formData = new FormData({
            "file": await MultipartFile(
              image.path,
              filename: "Image.jpg",
            ),
            'codeBoutique': Boutique.codeBoutique,
            'keySecret': key,
            'idProduit': idProduit
          });

          //print(formData.files);

          Response response = await boutiqueRepo.newProduitiMAGEFB(formData);
          //print(response.body);
          if (response.statusCode == 200) {
            await getListProduitForBoutique();
            fn.closeLoader();

            fn.snackBar('Mise a jour', response.body['message'], true);
            _isUpdating = false;
            // Get.back(closeOverlays: true);
            update();
          } else {
            fn.closeLoader();
          }
        } catch (e) {
          fn.closeLoader();

          fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
          //        fn.closeLoader();

          _isUpdating = false;
          update();
          //print(e);
        }
      }
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  updateProduit(data) async {
    _isUpdating = true;
    update();

    fn.loading('Produit', 'Mise a jour du produit en cours');

    try {
      Response response = await boutiqueRepo.updateProduitFB(data);
      //print(response.body);
      if (response.statusCode == 200) {
        await getListProduitForBoutique();
        fn.closeLoader();
        fn.snackBar('Mise a jour', response.body['message'], true);
      }
      fn.closeLoader();

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

  TextEditingController _name = TextEditingController();
  get name => _name;

  TextEditingController _quantite = TextEditingController();
  get quantite => _quantite;

  TextEditingController _prix = TextEditingController();
  get prix => _prix;

  TextEditingController _descriptionP = TextEditingController();
  get descriptionP => _descriptionP;
  mamageQte(val) {
    quantite.text = val
        ? check(int.parse(quantite.text) + 1)
        : check(int.parse(quantite.text) - 1);
    update();
  }

  check(val) {
    return val < 0 ? '0' : val.toString();
  }

  ajouterProduit() async {
    try {
      fn.loading('Produit', 'Ajout d\'un nouveau produit en cours');
      var key = await dababase.getKey();
      if (Boutique != null) {
        var dataS = {
          'keySecret': key,
          'titre': name.text,
          'description': descriptionP.text,
          'prixUnitaire': prix.text,
          'quantite': quantite.text,
          // 'idCategory':
          //     _controller.categorySelect.id,
          'codeBoutique': Boutique.codeBoutique,
          'countImage': listImgProduits.length
        };
        //print(dataS);

        listImgProduits.forEach((e) {
          dataS.addAll({
            "file${listImgProduits.indexOf(e)}": MultipartFile(
              e.path,
              filename: "Image.jpg",
            )
          });
        });
        FormData data = new FormData(dataS);

        _isUpdating = true;
        update();

        Response response = await boutiqueRepo.newProduit(data);
        //print(response.body);
        if (response.statusCode == 200) {
          await getListBoutique();
        }

        fn.closeLoader();

        fn.snackBar('Mise a jour', response.body['message'], true);
        _isUpdating = false;
        // Get.back(closeOverlays: true);
        update();
      }
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      //        fn.closeLoader();

      _isUpdating = false;
      update();
      //print(e);
    }
  }

  deletteProduit(data) async {
    _isUpdating = true;
    update();
    fn.loading('Produit', 'Suppression du produit en cours');

    try {
      Response response = await boutiqueRepo.desibledProduitFB(data);
      //print(response.body);

      if (response.statusCode == 200) {
        await getListBoutique();
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

  bool _isUpdatingB = false;
  bool get isUpdatingB => _isUpdatingB;

  TextEditingController _titre = TextEditingController();
  TextEditingController get titre => _titre;
  TextEditingController _description = TextEditingController();
  TextEditingController get description => _description;
  updateBoutique() async {
    var key = await dababase.getKey();
    var data = {
      'keySecret': key,
      'titre': titre.text,

      'description': description.text,
      'codeBoutique': Boutique.codeBoutique,
      // 'email': email.text,
    };
    //print(data);
    _isUpdatingB = true;
    update();
    fn.loading('Boutique', 'Mise a jour de la boutique en cours');

    try {
      Response response = await boutiqueRepo.updateBoutique(data);
      //print(response.body);

      if (response.statusCode == 200) {
        await getListBoutique();
      }

      fn.closeLoader();

      fn.snackBar('Mise a jour', response.body['message'], true);
      _isUpdatingB = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      //        fn.closeLoader();

      _isUpdatingB = false;
      update();
      //print(e);
    }
  }

  var _ville;
  String get ville => _ville;

  var _longitude;
  double get longitude => _longitude;

  var _latitude;
  double get latitude => _latitude;

  getLocalU() async {
    var data = await dababase.getLonLat();
    //print('*****************data');
    //print(data);
    if (data != null) {
      _ville = data['ville'];
      _longitude = data['long'];
      _latitude = data['lat'];
      update();
    }
    //print('*****************data');
  }

  updateLocalisationBoutique() async {
    var key = await dababase.getKey();
    await getLocalU();
    var data = {
      'codeBoutique': Boutique.codeBoutique,
      'keySecret': key,
      'ville': ville,
      'longitude': longitude,
      'latitude': latitude,
    };
    //print(data);
    _isUpdatingB = true;
    update();
    fn.loading(
        'Boutique', 'Mise a jour de l\'emplacement de la boutique en cours');

    try {
      Response response = await boutiqueRepo.updateLocalisationBoutique(data);
      //print(response.body);

      if (response.statusCode == 200) {
        await getListBoutique();
      }

      fn.closeLoader();

      fn.snackBar('Mise a jour', response.body['message'], true);
      _isUpdatingB = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      //        fn.closeLoader();

      _isUpdatingB = false;
      update();
      //print(e);
    }
  }

  bool _searchCom = false;
  bool get searchCom => _searchCom;
  TextEditingController _controllerFieldSearch = TextEditingController();
  get controllerFieldSearch => _controllerFieldSearch;

  searchButtom() {
    _searchCom = !_searchCom;
    // searchCommande('');
    if (!_searchCom) {
      _commandeBoutiqueList = _commandeBoutiqueListSave;
    }
    update();
  }

  searchCommande(text) {
    //print(text);
    _commandeBoutiqueList = [];
    List<CommandeBoutiqueModel> cont = [];
    _commandeBoutiqueListSave.forEach((item) {
      if (item.numCommande.toUpperCase().contains(text.toUpperCase()) ||
          item.titre.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    //print(cont.length);
    if (cont.length != 0) {
      _commandeBoutiqueList = cont;
    } else {
      _commandeBoutiqueList = _commandeBoutiqueListSave;
    }

    update();
  }

  bool _HsearchCom = false;
  bool get HsearchCom => _HsearchCom;

  HsearchButtom() {
    _HsearchCom = !_HsearchCom;
    HsearchCommande('');
    update();
  }

  HsearchCommande(text) {
    //print(text);
    _HcommandeBoutiqueList = [];
    List<CommandeBoutiqueModel> cont = [];
    _HcommandeBoutiqueListSave.forEach((item) {
      if (item.numCommande.toUpperCase().contains(text.toUpperCase()) ||
          item.titre.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    //print(cont.length);
    if (cont.length != 0) {
      _HcommandeBoutiqueList = cont;
    } else {
      _HcommandeBoutiqueList = _HcommandeBoutiqueListSave;
    }

    update();
  }

  bool _searchProB = false;
  bool get searchProB => _searchProB;

  searchProBButtom() {
    _searchProB = !_searchProB;
    if (!_searchProB) {
      _produitBoutiqueList = _produitBoutiqueListSave;
    }
    update();
  }

  searchProduitB(text) {
    //print(text);
    _produitBoutiqueList.clear();
    List<ProduitBoutiqueModel> cont = [];
    _produitBoutiqueListSave.forEach((item) {
      if (item.titre.toUpperCase().contains(text.toUpperCase()) ||
          item.codeProduit.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    //print(cont.length);
    if (cont.length != 0) {
      _produitBoutiqueList = cont;
    } else {
      _produitBoutiqueList = _produitBoutiqueListSave;
    }

    update();
  }

  bool _addProduit = false;
  bool get addProduit => _addProduit;
  chageState(i) {
    _addProduit = i;
    update();
    //print(_addProduit);
    //print(!_addProduit);
  }

  List<ShortModel> _listShortBoutique = [];
  List<ShortModel> get listShortBoutique => _listShortBoutique;
  int _isLoadedShort = 0;
  int get isLoadedShort => _isLoadedShort;
  Future<void> getListShortBoutique() async {
    if (Boutique != null) {
      _isLoadedShort = 0;
      try {
        Response response =
            await boutiqueRepo.getListShortBoutique(Boutique.codeBoutique);

        _listShortBoutique = [];
        _listShortBoutique.clear();
        update();

        if (response.body != null) {
          if (response.body['data'] != null) {
            if (response.body['data'].length != 0) {
              _listShortBoutique.addAll((response.body['data'] as List)
                  .map((e) => ShortModel.fromJson(e))
                  .toList());
            }
            _isLoadedShort = 1;
            update();
          }
        }
      } catch (e) {
        //print(e);
      }
    }
  }

  VideoPlayerController? controller;

  bool _initialise = false;
  bool get initialise => _initialise;
  changeVideoBoutique(index) async {
    _initialise = false;
    // update();
    // ignore: unnecessary_null_comparison
    // if (_listShortBoutique[index].controller == null) {
    //   await _listShortBoutique[index].loadController();
    // }
    // controller = _listShortBoutique[index].controller;
    controller!.play();
    _initialise = true;
    update();
    // ignore: unused_local_variable
    int prevVideo = (index - 1) > 0 ? index - 1 : 0;
    // ignore: unnecessary_null_comparison
    // if (listShort[prevVideo].controller != null) controller!.pause();

    //print(index);
  }

  List<File> _videoShort = [];

  List<File> get videoShort => _videoShort;

  onInitDataShort() {
    _videoShort = [];
    _videoShort.clear();
    _addProduit = false;
    // update();
  }

  File videoFile = new File('');

  Future getVideo() async {
    try {
      _videoShort.clear();
      update();
      //print("wwwwwwwww  ${_videoShort.length}");
      // ignore: deprecated_member_use
      XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: video.path,
      // );
      if (video != null) {
        _videoShort.add(File(video.path));
        update();

        var _videoFile = File(video.path);
        _videoPlayerController = VideoPlayerController.file(_videoFile)
          ..initialize().then((_) {
            _videoPlayerController!.play();
          });

        update();
      }
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  bool _addShoort = false;
  bool get addShoort => _addShoort;

  chageStateShort(bool i) {
    _addShoort = i;
    update();
  }
  // deleteVideo(index) {
  //   _videoShort.remove(_videoShort[index]);

  //   update();
  // }

  VideoPlayerController? _videoPlayerController;
  VideoPlayerController get videoPlayerController => _videoPlayerController!;

  void playPauseVideo() {
    if (_videoPlayerController != null) {
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      } else {
        _videoPlayerController!.play();
      }
    }
  }

  TextEditingController _titreShort = TextEditingController();
  TextEditingController get titreShort => _titreShort;
  TextEditingController _descriptionShort = TextEditingController();
  TextEditingController get descriptionShort => _descriptionShort;
  addShort() async {
    _isUpdating = true;
    update();
    fn.loading('Short', 'Ajout d\'un short en cours');

    var data = {
      'titre': titreShort.text,
      'description': descriptionShort.text,
      'codeBoutique': Boutique.codeBoutique,
      'produits': _listProduitSelect.join(',')
    };
    print(data);
    var formData = FormData(data);

    for (var file in videoShort) {
      formData.files.add(MapEntry(
        "file",
        MultipartFile(
          file.path,
          filename: "video.mp4",
        ),
      ));
    }

    try {
      Response response = await boutiqueRepo.newShort(formData);
      //print(response.body);
      if (response.statusCode == 200) {
        await getListBoutique();
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

  abonnementAdd(codeBoutique) async {
    bool isConnected = await fn.isConnected();
    if (isConnected == true) {
      try {
        fn.loading('Abonnement', 'Abonnement a la boutique en cours');

        var key = await dababase.getKey();
        var data = {
          'codeBoutique': codeBoutique,
          'keySecret': key,
        };
        print(data);
        Response response = await boutiqueRepo.abonnementAdd(data);
        print(response.body);

        if (response.statusCode == 200) {
          await getListAbonnementForUser();
          Get.find<GeneralController>()
              .updateBoutiqueAll(response.body['codeBoutique']);
          // await getListBoutique();
          print('*-------------------------data');
        }
        fn.closeLoader();

        fn.snackBar('Mise a jour', response.body['message'], true);
        _isUpdatingB = false;
        // Get.back(closeOverlays: true);
        update();
      } catch (e) {
        fn.closeLoader();
        fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

        _isUpdatingB = false;
        update();
        //print(e);
      }
    }
  }

  List<BoutiqueModel> _listAbonnememtUser = [];
  List<BoutiqueModel> get listAbonnememtUser => _listAbonnememtUser;
  int _isAbUserPage = 1;
  int get isAbUserPage => _isAbUserPage;
  resetPageAbonnement() {
    _isAbUserPage = 1;
    update();
    print(_isAbUserPage);
  }

  int _isAbUseLoad = 0;
  int get isAbUseLoad => _isAbUseLoad;
  Future<void> getListAbonnementForUser() async {
    //_isAbUseLoad = 0;
    //update(); //print('***short******************response**********');

    var key = await dababase.getKey();

    try {
      Response response =
          await boutiqueRepo.abonnementForUser(key, isAbUserPage);

      _listAbonnememtUser = [];
      _listAbonnememtUser.clear();
      update();

      if (response.body != null) {
        if (response.body['data'] != null) {
          if (response.body['data'].length != 0) {
            _listAbonnememtUser.addAll((response.body['data'] as List)
                .map((e) => BoutiqueModel.fromJson(e))
                .toList());
            _isAbUserPage++;
            _isAbUseLoad = 1;
            print(
                '***_listAbonnememtUser******************${_listAbonnememtUser.length}**********');
            update();
          }
        }
      }
    } catch (e) {
      _isAbUseLoad = 2;
      update();
    }
  }

  List<AbonnementBoutiqueModel> _listAbonnememtBoutique = [];
  List<AbonnementBoutiqueModel> get listAbonnememtBoutique =>
      _listAbonnememtBoutique;
  int _isAbBoutiquePage = 0;
  int get isAbBoutiquePage => _isAbBoutiquePage;
  Future<void> getListAbonnementForBoutique() async {
    if (_Boutique != null) {
      try {
        Response response = await boutiqueRepo.abonnementForBoutique(
            Boutique.codeBoutique, isAbBoutiquePage);

        _listAbonnememtBoutique = [];
        _listAbonnememtBoutique.clear();
        update();

        if (response.body != null) {
          if (response.body['data'] != null) {
            if (response.body['data'].length != 0) {
              _listAbonnememtBoutique.addAll((response.body['data'] as List)
                  .map((e) => AbonnementBoutiqueModel.fromJson(e))
                  .toList());
              _isAbUserPage++;
              update();
            }
          }
        }
      } catch (e) {
        //print(e);
      }
    }
  }

  int _i = 0;
  get i => _i;
  List get contentBoutique =>
      ['produits'.tr, 'commandes'.tr, 'ventes'.tr, 'short'.tr, 'reglages'.tr];
  List _savePreviousBoutiqueItem = [];
  setBoutiqueContent(index) async {
    _i = index;
    update();
    if (!_savePreviousBoutiqueItem.contains(i)) {
      // if (i == 2) {
      //   print('----------------*');
      //   Get.find<BoutiqueController>().getListAbonnementForUser();
      // }
      // if (i == 4) {
      //   print('-------------TransactionController---*');
      //   Get.find<TransactionController>().getTransactions();
      // }
      // if (i == 7) {
      //   print('----------------*');
      //   Get.find<BoutiqueController>().getListBoutique();
      // }
      if (index == 0) {
        await getListProduitForBoutique();
      } else if (index == 1) {
        await getListCommandeForBoutique();
      } else if (index == 2) {
        await getListHCommandeForBoutique();
      } else if (index == 3) {
        await getListShortBoutique();
      } else if (index == 4) {
        //print('*************${isLoaded}');
        // await getListBoutique();
      }
    }
    _savePreviousBoutiqueItem.add(i);

    // if (index == 0) {
    //   await getListProduitForBoutique();
    // } else if (index == 1) {
    //   await getListCommandeForBoutique();
    // } else if (index == 2) {
    //   await getListHCommandeForBoutique();
    // } else if (index == 3) {
    //   await getListForYouShort();
    // } else if (index == 4) {
    //   //print('*************${isLoaded}');
    //   await getListBoutique();
    // }
  }

  getEltBoutique() {
    getListProduitForBoutique();

    getListCommandeForBoutique();

    getListHCommandeForBoutique();
    getListShortBoutique();
    //print('*************${isLoaded}');
  }

  boutiqueContent() {
    switch (i) {
      case 0:
        return ProduitBoutiqueUserView();
      case 1:
        return CommandesBoutiqueUserView();
      case 2:
        return HistroriqueCBUView();
      case 3:
        return ShortBoutiqueView();
      case 4:
        return ManageBoutiqueUserView();
      default:
        return ProduitBoutiqueUserView();
    }
  }
}
