import 'dart:io';

import 'package:Fahkap/model/data/BoutiqueModel.dart';
import 'package:Fahkap/model/data/BoutiqueUserModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/CommandeBoutiqueModel.dart';
import 'package:Fahkap/model/data/ProduitBoutiqueModel.dart';
import 'package:Fahkap/model/data/ShortModel.dart';
import 'package:Fahkap/repository/BoutiqueRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/Services/storageService2.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:video_player/video_player.dart';

class BoutiqueController extends GetxController {
  final service = new ApiService();

  final BoutiqueRepo boutiqueRepo;
  BoutiqueController({required this.boutiqueRepo});

  var fn = new ViewFunctions();
  BoutiqueUserModel? _Boutique;
  BoutiqueUserModel get Boutique => _Boutique!;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  bool _isExist = false;
  bool get isExist => _isExist;
  bool _addProduct = false;
  bool get addProduct => _addProduct;
  List<File> _listImgProduits = [];

  var s = Get.find<DB>();
  List<File> get listImgProduits => _listImgProduits;

  chageState(bool i) {
    _addProduct = i;
    update();
  }

  onInitData() {
    _listImgProduits = [];
    _listImgProduits.clear();
    _addProduct = false;
    // update();
  }

  File imageFile = new File('');

  Future getImage() async {
    try {
      print("wwwwwwwww");

      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
          maxHeight: 500,
          maxWidth: 500);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      // );
      _listImgProduits.add(image);
      print(_listImgProduits.length);
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
        Response response = await boutiqueRepo.getListCategory();

        if (response.body != null) {
          if (response.body['data'].length != 0) {
            _categoryList.addAll((response.body['data'] as List)
                .map((e) => CategoryModel.fromJson(e))
                .toList());
          }
          _isLoadedC = 1;
          update();
        }
        // print(_categoryList);
      }
    } catch (e) {
      print(e);
    }
  }

  File boutiqueImage = new File('');
  bool _isImage = false;
  bool get isImage => _isImage;
  Future getImageBoutique() async {
    try {
      print("wwwwwwwww");

      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
          maxHeight: 500,
          maxWidth: 500);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      // );
      boutiqueImage = image;
      _isImage = true;
      // print(_listImgProduits.length);
      update();
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  bool _isOk = false;
  bool get isOk => _isOk;
  newBoutique(data) async {
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
        var key = await s.getKey();

        FormData formData = new FormData({
          "file": await MultipartFile(
            boutiqueImage.path,
            filename: "Image.jpg",
          ),
          'titre': data['titre'],
          'description': data['description'],
          'idCategory': data['category'],
          'ville': ville,
          'longitude': longitude,
          'latitude': latitude,
          'keySecret': key
        });

        Response response = await boutiqueRepo.newBoutique(formData);
        print(response.body);

        if (response.statusCode == 200) {
          _isOk = false;
          update();

          await getBoutique();
        }
        Get.back();

        fn.snackBar(
            'Mise a jour', response.body['message'], ColorsApp.bleuLight);
        _isUpdatingB = false;
        // Get.back(closeOverlays: true);
        update();
      } else {
        Get.back();
        fn.snackBar('Boutique', 'Remplir tous les champs', ColorsApp.red);
      }
    } catch (e) {
      fn.snackBar('Mise a jour', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isUpdatingB = false;
      update();
      print(e);
    }
  }

  Future updateImageBoutique() async {
    try {
      var image = await ImagePicker.pickImage(
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
        var key = await s.getKey();

        try {
          FormData formData = new FormData({
            "file": await MultipartFile(
              image.path,
              filename: "Image.jpg",
            ),
            'codeBoutique': Boutique.codeBoutique,
            'keySecret': key
          });

          print(formData.files);

          Response response = await boutiqueRepo.updateImageBoutique(formData);
          print(response.body);
          if (response.statusCode == 200) {
            await getBoutique();
          }

          Get.back();
          fn.snackBar(
              'Mise a jour', response.body['message'], ColorsApp.bleuLight);
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
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  // BoutiqueController({required this.service});
  getBoutique() async {
    try {
      Response response = await boutiqueRepo.getBoutiqueForUser();
      if (response.body != null) {
        if (response.body['data'] != null) {
          print('-----------boutiqr************************');
          print(response.body['data']);
          _Boutique = BoutiqueUserModel.fromJson(response.body['data']);
          _isExist = response.body['exist'];
          update();
          // print(_Boutique);
        }
      }
      _isLoaded = 1;

      getListShort();
    } catch (e) {
      _isExist = false;
      _isLoaded = 1;

      update();
      print(e);
    }
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
      print(e);
    }
  }

  List<CommandeBoutiqueModel> _HcommandeBoutiqueListSave = [];
  List<CommandeBoutiqueModel> _HcommandeBoutiqueList = [];
  List<CommandeBoutiqueModel> get HcommandeBoutiqueList =>
      _HcommandeBoutiqueList;
  int _isLoadedPH = 0;
  int get isLoadedPH => _isLoadedPH;
  getListHCommandeForBoutique() async {
    // _HcommandeBoutiqueList = [];
    _isLoadedPH = 0;
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
        _isLoaded = 1;

        update();
      }
      _HcommandeBoutiqueListSave = _HcommandeBoutiqueList;
      print('i-----');
      print(response.body['data']);
      _isLoadedPH = 1;
      update();
    } catch (e) {
      print(e);
    }
  }

  List<ProduitBoutiqueModel> _produitBoutiqueList = [];
  List<ProduitBoutiqueModel> _produitBoutiqueListSave = [];
  List<ProduitBoutiqueModel> get produitBoutiqueList => _produitBoutiqueList;
  int _isLoadedPB = 0;
  int get isLoadedPB => _isLoadedPB;
  getListProduitForBoutique() async {
    // _produitBoutiqueList = [];
    _isLoadedPB = 0;
    _searchProB = false;

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
      print(e);
    }
  }

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  updateProduit(data) async {
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
      Response response = await boutiqueRepo.updateProduitFB(data);
      print(response.body);
      if (response.statusCode == 200) {
        await getBoutique();
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

  addProduit(data) async {
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
      Response response = await boutiqueRepo.newProduit(data);
      print(response.body);
      if (response.statusCode == 200) {
        await getBoutique();
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

  deletteProduit(data) async {
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
      Response response = await boutiqueRepo.desibledProduitFB(data);
      print(response.body);

      if (response.statusCode == 200) {
        await getBoutique();
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

  bool _isUpdatingB = false;
  bool get isUpdatingB => _isUpdatingB;
  updateBoutique(data) async {
    _isUpdatingB = true;
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
      Response response = await boutiqueRepo.updateBoutique(data);
      print(response.body);

      if (response.statusCode == 200) {
        await getBoutique();
      }

      Get.back();
      fn.snackBar('Mise a jour', response.body['message'], ColorsApp.bleuLight);
      _isUpdatingB = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Mise a jour', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isUpdatingB = false;
      update();
      print(e);
    }
  }

  var _ville;
  String get ville => _ville;

  var _longitude;
  double get longitude => _longitude;

  var _latitude;
  double get latitude => _latitude;

  getLocalU() async {
    var data = await s.getLonLat();
    print('*****************data');
    print(data);
    if (data.isNotEmpty) {
      _ville = data['ville'];
      _longitude = data['long'];
      _latitude = data['lat'];
      update();
    }
    print('*****************data');
  }

  updateLocalisationBoutique() async {
    var key = await s.getKey();
    await getLocalU();
    var data = {
      'codeBoutique': Boutique.codeBoutique,
      'keySecret': key,
      'ville': ville,
      'longitude': longitude,
      'latitude': latitude,
    };
    print(data);
    _isUpdatingB = true;
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
      Response response = await boutiqueRepo.updateLocalisationBoutique(data);
      print(response.body);

      if (response.statusCode == 200) {
        await getBoutique();
      }

      Get.back();
      fn.snackBar('Mise a jour', response.body['message'], ColorsApp.bleuLight);
      _isUpdatingB = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Mise a jour', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isUpdatingB = false;
      update();
      print(e);
    }
  }

  bool _searchCom = false;
  bool get searchCom => _searchCom;

  searchButtom() {
    _searchCom = !_searchCom;
    // searchCommande('');
    if (!_searchCom) {
      _commandeBoutiqueList = _commandeBoutiqueListSave;
    }
    update();
  }

  searchCommande(text) {
    print(text);
    _commandeBoutiqueList = [];
    List<CommandeBoutiqueModel> cont = [];
    _commandeBoutiqueListSave.forEach((item) {
      if (item.numCommande.toUpperCase().contains(text.toUpperCase()) ||
          item.titre.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    print(cont.length);
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
    print(text);
    _HcommandeBoutiqueList = [];
    List<CommandeBoutiqueModel> cont = [];
    _HcommandeBoutiqueListSave.forEach((item) {
      if (item.numCommande.toUpperCase().contains(text.toUpperCase()) ||
          item.titre.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    print(cont.length);
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
    print(text);
    _produitBoutiqueList.clear();
    List<ProduitBoutiqueModel> cont = [];
    _produitBoutiqueListSave.forEach((item) {
      if (item.titre.toUpperCase().contains(text.toUpperCase()) ||
          item.codeProduit.toUpperCase().contains(text.toUpperCase())) {
        cont.add(item);
      }
    });
    print(cont.length);
    if (cont.length != 0) {
      _produitBoutiqueList = cont;
    } else {
      _produitBoutiqueList = _produitBoutiqueListSave;
    }

    update();
  }

  bool _addShoort = false;
  bool get addShoort => _addShoort;

  chageStateShort(bool i) {
    _addShoort = i;
    update();
  }

  List<ShortModel> _listShortBoutique = [];
  List<ShortModel> get listShortBoutique => _listShortBoutique;
  int _isLoadedShort = 0;
  int get isLoadedShort => _isLoadedShort;
  Future<void> getListShort() async {
    // print('***short******************response**********');

    _isLoadedShort = 0;
    try {
      Response response = await boutiqueRepo.getListShortBoutique(
        {'codeBoutique': Boutique.codeBoutique},
      );

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
      print(e);
    }
  }

  VideoPlayerController? controller;

  bool _initialise = false;
  bool get initialise => _initialise;
  changeVideoBoutique(index) async {
    _initialise = false;
    // update();
    // ignore: unnecessary_null_comparison
    if (_listShortBoutique[index].controller == null) {
      await _listShortBoutique[index].loadController();
    }
    controller = _listShortBoutique[index].controller!;
    controller!.play();
    _initialise = true;
    update();
    // ignore: unused_local_variable
    int prevVideo = (index - 1) > 0 ? index - 1 : 0;
    // ignore: unnecessary_null_comparison
    // if (listShort[prevVideo].controller != null) controller!.pause();

    print(index);
  }

  List<File> _videoShort = [];

  List<File> get videoShort => _videoShort;

  onInitDataShort() {
    _videoShort = [];
    _videoShort.clear();
    _addProduct = false;
    // update();
  }

  File videoFile = new File('');

  Future getVideo() async {
    try {
      print("wwwwwwwww");

      var image = await ImagePicker.pickVideo(source: ImageSource.gallery);

      // File? croppedFile = await ImageCropper().cropImage(
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   sourcePath: image.path,
      // );
      _videoShort.add(image);
      print(_videoShort.length);
      update();
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  deleteVideo(index) {
    _videoShort.remove(_videoShort[index]);

    update();
  }

  addShort(data) async {
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
      Response response = await boutiqueRepo.newShort(data);
      print(response.body);
      if (response.statusCode == 200) {
        await getBoutique();
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
