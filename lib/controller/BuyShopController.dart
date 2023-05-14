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
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyShopController extends GetxController {
  final BuyShoopingCartRepo buySoppingCartRepo;
  BuyShopController({required this.buySoppingCartRepo});
  String _paiementUrl = '';
  get paiementUrl => _paiementUrl;
  final service = new ApiService();
  LivreurRepo livreurRepo = Get.find();
  CommandeController commande = Get.find();
  int _state = 0;
  int get state => _state;
  // ignore: must_call_super
  onInit() {
    _state = 0;
    update();
  }

  // int _current = 0;
  // int get current => _current;

  stateChangeX(i) {
    // _current = _state;
    _state = i;

    update();
    print('_state..........${_state}');
  }

  stateChange(bool i) {
    // _current = _state;
    _state = i ? checkVal(_state + 1) : checkVal(_state - 1);

    update();
  }

  checkVal(val) {
    if (val > 3) {
      return 3;
    } else if (val <= 0) {
      return 0;
    } else {
      return val;
    }
  }

  isCurrent(int index) {
    return _state == index;
  }

  bool _isOk = false;
  bool get isOk => _isOk;
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
            // 'ville': user.ville,
            // 'longitude': user.longitude,
            // 'latitude': user.latitude,
            'ville': "user.ville",
            'longitude': "1.01",
            'latitude': "12.5",
          };

    print(data);

    update();
    Get.defaultDialog(
        title: 'En cours',
        barrierDismissible: false,
        content: SizedBox(
            // height: Get.size.height * .02,
            // width: Get.size.width * .02,
            child: Center(
          child: SpinKitRing(
            lineWidth: 4,
            color: ColorsApp.skyBlue,
            size: 45,
          ),
        )));
    try {
      Response response = await buySoppingCartRepo.buyCart(data);
      print(response.body);

      Get.back();
      // fn.snackBar('Achat', response.body['message'], true);
      print(response.body);
      _isOk = response.body['status'];
      if (response.statusCode == 201 && _isOk) {
        _paiementUrl = response.body['url'];
        update();
        print(_paiementUrl);
        await Get.bottomSheet(PaiementView());
        print('dssdsd');
        commande.saveCommande(
            response.body['id'],
            response.body['codeCommande'],
            response.body['codeClient'],
            response.body['date']);
        // await downloadFacture(response.body['pdf']);
        // fn.snackBar('Achat',
        //     'Votre facture a ete energistre dans votre telephone', true);
      }
      Get.find<CommandeController>().getListCommandes();

      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      Get.back();
      fn.snackBar('Achat', 'Une erreur est survenue', false);
      // Get.back();

      update();
      print(e);
    }
  }

  downloadFacture(url) async {
    final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download',
        showNotification: true, // afficher une notification de téléchargement
        openFileFromNotification:
            true // ouvrir le fichier après le téléchargement
        );
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
