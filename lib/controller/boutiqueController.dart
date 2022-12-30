import 'dart:io';

import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/repository/BoutiqueRepo.dart';
import 'package:fahkapmobile/utils/Services/requestServices.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class BoutiqueController extends GetxController {
  final service = new ApiService();

  final BoutiqueRepo boutiqueRepo;
  BoutiqueController({required this.boutiqueRepo});

  BoutiqueModel? _Boutique;
  BoutiqueModel get Boutique => _Boutique!;
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
      _Boutique = BoutiqueModel.fromJson(response.body['data']);
      _isExist = response.body['exist'];
      // print(_Boutique);
      _isLoaded = 1;

      update();
    } catch (e) {
      print(e);
    }
  }
}
