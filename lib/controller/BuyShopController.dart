import 'package:Fahkap/Views/Shopping/PaiementView.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/controller/cartController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/model/data/CartModel.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/model/data/LivreurModel.dart';
import 'package:Fahkap/model/data/ProduitCategoryModel.dart';
import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/repository/BuyShoopingCartRepo.dart';
import 'package:Fahkap/repository/LivreurRepo.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/requestServices.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'dart:async';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyShopController extends GetxController {
  final BuyShoopingCartRepo buySoppingCartRepo;
  BuyShopController({required this.buySoppingCartRepo});
  String _paiementUrl = '';
  get paiementUrl => _paiementUrl;
  final service = new ApiService();
  LivreurRepo livreurRepo = Get.find();
  CommandeController commande = Get.find();

  checkVal(val) {
    if (val > 3) {
      return 3;
    } else if (val <= 0) {
      return 0;
    } else {
      return val;
    }
  }

  bool _isOk = false;
  bool get isOk => _isOk;

  int _isIdCom = 0;
  int get isIdCom => _isIdCom;
  var fn = new ViewFunctions();
  // CategoryController({required this.service});
  buyCart() async {
    var produits = Get.find<CartController>().getListPinCart();
    var user = Get.find<ManagerController>();
    var mode = Get.find<ActionController>().selected;

    var data = mode == 3
        ? {
            'nom': _nameController.text,
            'prenom': _prenameController.text,
            'phone': _phoneController.text,
            'idModePaiement': mode,
            // 'idLivreur': _Bcontroller.isLivreur,
            'listProduits': produits,
            'ville': user.ville,
            'longitude': user.longitude,
            'latitude': user.latitude,
            'numCarte': cardNumberController.text,
            'cvv': cvvController.text,
            'exp_month': expiryMonthController.text,
            'exp_year': '20' + expiryYearController.text
          }
        : {
            'nom': _nameController.text,
            'prenom': _prenameController.text,
            'phone': _phoneController.text,
            'idModePaiement': mode,
            // 'idLivreur': _Bcontroller.isLivreur,
            'listProduits': produits,

            'longitude': user.longitude,
            'latitude': user.latitude,
            'ville': user.ville,
          };

    print(data);

    update();

    try {
      fn.loading('Paiement', 'Initialisation de votre paiement en cours');
      Response response = await buySoppingCartRepo.buyCart(data);
      print(response.body);

      // fn.snackBar('Achat', response.body['message'], true);
      print(response.body);

      if (response.statusCode == 201) {
        _isOk = response.body['status'];
        var finish = response.body['finish'];
        if (_isOk) {
          fn.snackBar('Achat', response.body['message'], true);
          if (finish) {
            commande.saveCommande(
                response.body['id'],
                response.body['codeCommande'],
                response.body['codeClient'],
                response.body['date']);
            fn.closeSnack();
          } else {
            _startTimer();
            _paiementUrl = response.body['url'];
            _isIdCom = response.body['id'];
            update();
            print(_paiementUrl);
            fn.closeSnack();

            await Get.to(() => PaiementView());
            //ici on doit lancer la verification
            print('dssdsd');
          }
        }

        // await downloadFacture(response.body['pdf']);
        // fn.snackBar('Achat',
        //     'Votre facture a ete energistre dans votre telephone', true);
      } else {
        fn.closeSnack();

        fn.snackBar('Achat', response.body['message'], false);
      }
      Get.find<CommandeController>().getListCommandes();

      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.snackBar('Achat', 'Une erreur est survenue', false);
      fn.closeSnack();
      update();
      print(e);
    }
  }

  int _isCounter = 0;
  int get isCounter => _isCounter;

  bool _validateBuy = false;
  bool get validateBuy => _validateBuy;
  Timer? _timer;
  void _startTimer() {
    if (_isOk && _isCounter < 10 && !_validateBuy) {
      Timer.periodic(Duration(seconds: 5), (_) {
        // Appeler la fonction souhaitée ici

        print('La fonction se relance toutes les 10 secondes.');
        verifyCom();
        _isCounter = _isCounter + 1;
        update();
        if (_isCounter == 9) {
          Get.back();
        }
      });
    }
  }

  void _stopTimer() {
    print('stop***********************');
    _timer?.cancel();
  }

  int _idSave = 0;
  int get idSave => _idSave;
  verifyCom() async {
    var data = {
      'id': _isIdCom,
    };

    print(data);

    try {
      Response response = await buySoppingCartRepo.verifyCom(data);
      print(response.body);

      // fn.snackBar('Achat', response.body['message'], true);
      print(response.body);

      if (response.statusCode == 201) {
        _isOk = response.body['status'];
        _validateBuy = true;

        update();
        if (_isOk && _idSave != response.body['id']) {
          _idSave = response.body['id'];
          commande.saveCommande(
              response.body['id'],
              response.body['codeCommande'],
              response.body['codeClient'],
              response.body['date']);
          _stopTimer();
        }

        // await downloadFacture(response.body['pdf']);
        // fn.snackBar('Achat',
        //     'Votre facture a ete energistre dans votre telephone', true);
      }
      Get.find<CommandeController>().getListCommandes();

      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      //         fn.closeSnack();

      // fn.snackBar('Achat', 'Une erreur est survenue', false);
      //         fn.closeSnack();

      update();
      print(e);
    }
  }

  downloadFacture(url) async {
    // final taskId = await FlutterDownloader.enqueue(
    //     url: url,
    //     savedDir: '/storage/emulated/0/Download',
    //     showNotification: true, // afficher une notification de téléchargement
    //     openFileFromNotification:
    //         true // ouvrir le fichier après le téléchargement
    //     );
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _expiryYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _lieuxController = TextEditingController();
  get nameController => _nameController;
  get cardNumberController => _cardNumberController;
  get expiryMonthController => _expiryMonthController;
  get expiryYearController => _expiryYearController;
  get cvvController => _cvvController;
  get lieuxController => _lieuxController;

  final TextEditingController _prenameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  get prenameController => _prenameController;
  get phoneController => _phoneController;
  final TextEditingController _dateController = TextEditingController();
  get dateController => _dateController;
  setSlash() {
    print('fdfdf');
    // if (_dateController.text.length == 2) {
    //   _dateController.text = _dateController.text + '/';
    // }
  }

  setDate() {
    _expiryMonthController.text = _dateController.text.split('')[0].toString() +
        _dateController.text.split('')[1].toString();
    _expiryYearController.text = _dateController.text.split('')[2].toString() +
        _dateController.text.split('')[3].toString();
    update();
  }
}
