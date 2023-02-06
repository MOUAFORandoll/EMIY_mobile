import 'dart:io';

import 'package:fahkapmobile/controller/managerController.dart';
import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/BoutiqueUserModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/CommandeBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitBoutiqueModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/model/data/TransactionModel.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/repository/TransactionRepo.dart';
import 'package:fahkapmobile/repository/categoryBoutiqueRepo.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:fahkapmobile/utils/functions/viewFunctions.dart';
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
  int _isLoadedTRansa = 0;
  int get isLoadedTRans => _isLoadedTRansa;
  // CategoryController({required this.service});
  getTransactions(id) async {
    try {
      _transactionList.clear();
      _transactionList = [];

      _isLoadedTRansa = 0;
      update();

      Response response = await transactionRepo.getListTransaction(id);
      if (response.body != null) {
        print("response.body['data']");
        print(response.body['data']);
        if (response.body['data'].length != 0) {
          _transactionList.addAll((response.body['data'] as List)
              .map((e) => TransactionModel.fromJson(e))
              .toList());
        }
        _isLoadedTRansa = 1;
        update();
      }
      print(isLoadedTRans);
    } catch (e) {
      print(e);
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
}
