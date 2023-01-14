import 'dart:io';

import 'package:fahkapmobile/model/data/BoutiqueUserModel.dart';
import 'package:fahkapmobile/model/data/CommandeBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitBoutiqueModel.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

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

  List<File> get listImgProduits => _listImgProduits;

  chageState(bool i) {
    _addProduct = i;
    update();
  }

  File imageFile = new File('');

  Future getImage() async {
    try {
      print("wwwwwwwww");

      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 10,
          maxHeight: 500,
          maxWidth: 500);

      File? croppedFile = await ImageCropper().cropImage(
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        sourcePath: image.path,
      );
      _listImgProduits.add(croppedFile!);
    } catch (e) {
      // _showToastPictureError(context);
    }
  }

  // BoutiqueController({required this.service});
  getBoutique() async {
    try {
      Response response = await boutiqueRepo.getBoutiqueForUser();
      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          _Boutique = BoutiqueUserModel.fromJson(response.body['data']);
          _isExist = response.body['exist'];
          // print(_Boutique);
        }
      }
      _isLoaded = 1;

      update();
    } catch (e) {
      _isExist = false;
      _isLoaded = 1;

      update();
      print(e);
    }
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
      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          _commandeBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => CommandeBoutiqueModel.fromJson(e))
              .toList());
          _commandeBoutiqueListSave = _commandeBoutiqueList;
        }
      }
      _isLoadedPC = 1;
      update();
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
      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          _HcommandeBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => CommandeBoutiqueModel.fromJson(e))
              .toList());
        }
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
      if (response.body['data'] != null) {
        if (response.body['data'].length != 0) {
          _produitBoutiqueList.addAll((response.body['data'] as List)
              .map((e) => ProduitBoutiqueModel.fromJson(e))
              .toList());
        }
      }
      _produitBoutiqueListSave = _produitBoutiqueList;
      _isLoadedPB = 1;
      update();
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
}
