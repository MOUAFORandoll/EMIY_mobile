 
import 'dart:io';
 
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/managerController.dart'; 
import 'package:EMIY/model/data/PointLivraisonModel.dart'; 
import 'package:EMIY/model/socket/SocketCommandModel.dart';
import 'package:EMIY/repository/BuyShoopingCartRepo.dart';
import 'package:EMIY/repository/LivreurRepo.dart'; 
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webview_flutter/webview_flutter.dart';
 

class BuyShopController extends GetxController {
  final BuyShoopingCartRepo buySoppingCartRepo;
  BuyShopController({required this.buySoppingCartRepo});
  String _paiementUrl = '';
  get paiementUrl => _paiementUrl;

  var _controller;
  get controller => _controller;
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  setLoadTransaction(val) {
    _isLoad = val;
    // update();
  }

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

  PointLivraisonModel _selected_livraison_point = new PointLivraisonModel(
      id: 0, libelle: '', ville: '', quartier: '', image: '');
  PointLivraisonModel get selected_livraison_point => _selected_livraison_point;
  selectPoint(point) {
    _selected_livraison_point = point;
    update();
  }

  final TextEditingController _searchController = TextEditingController();
  get searchController => _searchController;
  searchPointLivraison() {
    _search_livraison_point = [];
    update();

    _search_livraison_point.addAll(livraison_point.where(
      (element) =>
          element.libelle
              .toLowerCase()
              .contains(searchController.text.toLowerCase()) ||
          element.quartier
              .toLowerCase()
              .contains(searchController.text.toLowerCase()) ||
          element.ville
              .toLowerCase()
              .contains(searchController.text.toLowerCase()),
    ));
    if (_search_livraison_point.isEmpty) {
      _search_livraison_point = livraison_point;
      update();
    }
    update();
    print(_search_livraison_point.length);
  }

  List<PointLivraisonModel> _search_livraison_point = [];
  List<PointLivraisonModel> get search_livraison_point =>
      _search_livraison_point;
  List<PointLivraisonModel> _livraison_point = [];
  List<PointLivraisonModel> get livraison_point => _livraison_point;
  int _isLoaded = 0;
  int get isLoaded => _isLoaded;
  // CategoryController({required this.service});
  getPointLivraisom() async {
    try {
      print('*********debut get point');
      _livraison_point.clear();
      _isLoaded = 0;
      update();
      print('*********3...... get point');

      Response response = await buySoppingCartRepo.getLivraison_point();
      // print('*********fin get point ${response.body}');
      if (response.body != null) {
        // if (response.body['data'].length != 0) {

        _livraison_point.addAll((response.body['data'] as List)
            .map((e) => PointLivraisonModel.fromJson(e))
            .toList());
        _isLoaded = 1;
        update();
      }

      // }
      // //print(_livraison_point);
    } catch (e) {
      //print(e);
    }
  }

  bool _isOk = false;
  bool get isOk => _isOk;

  String _codeCommande = '';
  String get isIdCom => _codeCommande;
  var fn = new ViewFunctions();

  // CategoryController({required this.service});
  buyCart() async {
    var produits = Get.find<CartController>().getListPinCart();

    var mode = Get.find<GeneralController>().selected;

    var data = mode == 3
        ? {
            'nom': _nameController.text,
            'prenom': _prenameController.text,
            'phone': _phoneController.text,
            'idModePaiement': mode,
            // 'idLivreur': _Bcontroller.isLivreur,
            'listProduits': produits,
            'ville': manager.ville,
            'longitude': manager.longitude,
            'latitude': manager.latitude,
            'numCarte': cardNumberController.text,
            'cvv': cvvController.text,
            'exp_month': expiryMonthController.text,
            'point_livraison': selected_livraison_point.id,
            'exp_year': '20' + expiryYearController.text,
          }
        : {
            'nom': _nameController.text,
            'prenom': _prenameController.text,
            'phone': _phoneController.text,
            'idModePaiement': mode,
            // 'idLivreur': _Bcontroller.isLivreur,
            'listProduits': produits,

            'longitude': manager.longitude,
            'latitude': manager.latitude,
            'ville': manager.ville,
            'point_livraison': selected_livraison_point.id
          };

    //print(data);

    update();

    try {
      fn.loading('Paiement', 'Initialisation de votre paiement en cours');
      Response response = await buySoppingCartRepo.buyCart(data);
      //print(response.body);

      // fn.snackBar('Achat', response.body['message'], true);
      //print(response.body);

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
            fn.closeLoader();
          } else {
            print('----------------');
            _paiementUrl = response.body['url'];
            _codeCommande = response.body['codeCommande'];
            print('aa----------------');

_controller = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {
                    setLoadTransaction(true);
                  },
                  onPageFinished: (String url) {
                    setLoadTransaction(false);
                  },
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.google.com/')) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse(_paiementUrl));
            update();
            print(_paiementUrl);
            fn.closeLoader();
            Get.toNamed(AppLinks.BUYVIEW);
            new SocketService().commande(response.body['codeCommande'],
                ifBuyingCommande); //ici on doit lancer la verification

            //print('dssdsd');
          }
        }

        // fn.snackBar('Achat',
        //     'Votre facture a ete energistre dans votre telephone', true);
      } else {
        fn.closeLoader();

        fn.snackBar('Achat', response.body['message'], false);
      }
      Get.find<CommandeController>().getListCommandes();

      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.snackBar('Achat', 'Une erreur est survenue', false);
      fn.closeLoader();
      update();
      //print(e);
    }
  }

  ifBuyingCommande(dataSend) async {
    SocketCommandModel dataSocket = SocketCommandModel.fromJson(dataSend);

    _isOk = dataSocket.status;

    update();

    commande.saveCommande(dataSocket.id, dataSocket.codeCommande,
        dataSocket.codeClient, dataSocket.date);
    fn.snackBar('Achat', dataSocket.message, true);

    await downloadFacture(dataSocket.pdf);

    Get.find<CommandeController>().getListCommandes();

    Get.back(closeOverlays: true);
    update();
  }

  // int _isCounter = 0;
  // int get isCounter => _isCounter;

  // bool _validateBuy = false;
  // bool get validateBuy => _validateBuy;
  // Timer? _timer;
  // void _startTimer() {
  //   if (_isOk && _isCounter < 10 && !_validateBuy) {
  //     Timer.periodic(Duration(seconds: 5), (_) {
  //       // Appeler la fonction souhaitée ici

  //       //print('La fonction se relance toutes les 10 secondes.');
  //       verifyCom();
  //       _isCounter = _isCounter + 1;
  //       update();
  //       if (_isCounter == 9) {
  //         Get.back();
  //       }
  //     });
  //   }
  // }

  // void _stopTimer() {
  //   //print('stop***********************');
  //   _timer?.cancel();
  // }

  // int _idSave = 0;
  // int get idSave => _idSave;
  // verifyCom() async {
  //   var data = {
  //     'id': _isIdCom,
  //   };

  //   //print(data);

  //   try {
  //     Response response = await buySoppingCartRepo.verifyCom(data);
  //     //print(response.body);

  //     // fn.snackBar('Achat', response.body['message'], true);
  //     //print(response.body);

  //     if (response.statusCode == 201) {
  //       _isOk = response.body['status'];
  //       _validateBuy = true;

  //       update();
  //       if (_isOk && _idSave != response.body['id']) {
  //         _idSave = response.body['id'];
  //         commande.saveCommande(
  //             response.body['id'],
  //             response.body['codeCommande'],
  //             response.body['codeClient'],
  //             response.body['date']);
  //         _stopTimer();
  //       }

  //       await downloadFacture(response.body['pdf']);
  //       // fn.snackBar('Achat',
  //       //     'Votre facture a ete energistre dans votre telephone', true);
  //     }
  //     Get.find<CommandeController>().getListCommandes();

  //     // Get.back(closeOverlays: true);
  //     update();
  //   } catch (e) {
  //     //         fn.closeLoader();

  //     // fn.snackBar('Achat', 'Une erreur est survenue', false);
  //     //         fn.closeLoader();

  //     update();
  //     //print(e);
  //   }
  // }

  downloadFacture(url) async {
    try {
      DateTime now = DateTime.now(); // ProgressDialog progress;
      // progress =
      //     new ProgressDialog(context, type: ProgressDialogType.Download);
      // progress.style(message: "Téléchargement en du fichier ...");

      Directory d = Directory('/storage/emulated/0/Download');

      final file = File(
          '/storage/emulated/0/Download/facture_${now.hour}_${now.minute}_${now.second}.pdf');

      await Dio().download(
        "${ApiUrl.baseUrl}" + url,
        file.path,
        onReceiveProgress: (rec, total) {
          print(rec);
          print(total);
          if (rec == total) {
            fn.snackBar('Facture',
                'Une facture a ete enregistre dans votre portable', true);
          }
          // progressDowloading =
          //     ((rec / total) * 100).toStringAsFixed(0) + "%";
          // print(progressDowloading);
          // progress.update(message: "svp veillez patienter ");
        },
      );

      // progress.hide();
    } catch (e) {
      print(e);
    }
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
  var manager = Get.find<ManagerController>();
  setUserInfo() {
    print('--setinfo');
    if (manager.Userget != null &&
        _nameController.text.length == 0 &&
        _phoneController.text.length == 0) {
      _nameController.text = manager.Userget.nom;
      _prenameController.text = manager.Userget.prenom;
      _phoneController.text = manager.Userget.phone;
      update();
      print('--setinfo---update');
    }
  }

  setDate() {
    _expiryMonthController.text = _dateController.text.split('')[0].toString() +
        _dateController.text.split('')[1].toString();
    _expiryYearController.text = _dateController.text.split('')[2].toString() +
        _dateController.text.split('')[3].toString();
    update();
  }
}
