import 'dart:io';

import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/model/data/BoutiqueModel.dart';
import 'package:Fahkap/model/data/BoutiqueUserModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/CommandeBoutiqueModel.dart';
import 'package:Fahkap/model/data/ProduitBoutiqueModel.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/model/data/TransactionModel.dart';
import 'package:Fahkap/repository/BoutiqueRepo.dart';
import 'package:Fahkap/repository/TransactionRepo.dart';
import 'package:Fahkap/repository/categoryBoutiqueRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class TransactionController extends GetxController {
  final service = new ApiService();

  final TransactionRepo transactionRepo;
  TransactionController({required this.transactionRepo});

  List<TransactionModel> _transactionList = [];
  List<TransactionModel> get transactionList => _transactionList;
  int _isLoadedTrans = 0;
  int get isLoadedTrans => _isLoadedTrans;
  ManagerController managerController = Get.find();

  // CategoryController({required this.service});
  getTransactions() async {
    if (managerController.User != null) {
      try {
        _transactionList.clear();
        _transactionList = [];

        _isLoadedTrans = 0;
        update();
        print(".............");

        Response response =
            await transactionRepo.getListTransaction(managerController.User.id);
        if (response.body != null) {
          if (response.body['data'].length != 0) {
            _transactionList.addAll((response.body['data'] as List)
                .map((e) => TransactionModel.fromJson(e))
                .toList());
            _isLoadedTrans = 1;
            update();
          } else {
            _transactionList = [];

            _isLoadedTrans = 1;
            update();
          }
        }
        print(isLoadedTrans);
      } catch (e) {
        print(e);
      }
    }
  }

  var fn = new ViewFunctions();

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  retrait(data) async {
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
      Response response = await transactionRepo.retraitCompte(data);
      print(response.body);

      if (response.statusCode == 200) {
        await Get.find<ManagerController>().getUser();
        getTransactions();
        Get.back();
        fn.snackBar('Retrait', response.body['message'], ColorsApp.bleuLight);
      } else {
        Get.back();
        fn.snackBar('Retrait', response.body['message'], ColorsApp.greenLight);
      }

      _isUpdating = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Retrait', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isUpdating = false;
      update();
      print(e);
    }
  }

  actualise() async {
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
      await Get.find<ManagerController>().getUser();
      await getTransactions();
      Get.back();

      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Retrait', 'Une erreur est survenue', ColorsApp.red);
      // Get.back();
      _isUpdating = false;
      update();
      print(e);
    }
  }
}
