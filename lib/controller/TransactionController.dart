import 'package:EMIY/Views/UsersMange/DepotView.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/model/data/TransactionModel.dart';
import 'package:EMIY/model/socket/SocketDepotModel.dart';
import 'package:EMIY/repository/TransactionRepo.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    if (managerController.Userget != null) {
      try {
        //print(".............");

        Response response = await transactionRepo
            .getListTransaction(managerController.Userget.id);
        if (response.body != null) {
          if (response.body['data'].length != 0) {
            _transactionList.clear();
            _transactionList = [];

            // _isLoadedTrans = 0;
            update();
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
        //print(isLoadedTrans);
      } catch (e) {
        //print(e);
      }
    }
  }

  var fn = new ViewFunctions();

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;
  retrait(data) async {
    _isUpdating = true;
    update();
    fn.loading(
        'Retrait', 'Initialisation d\'un retrait de votre compte en cours');

    try {
      Response response = await transactionRepo.retraitCompte(data);
      //print(response.body);

      if (response.statusCode == 200) {
        await Get.find<ManagerController>().getUser();
        getTransactions();
        fn.closeLoader();

        fn.snackBar('Retrait', response.body['message'], true);
      } else {
        fn.closeLoader();

        fn.snackBar('Retrait', response.body['message'], false);
      }

      _isUpdating = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Retrait', 'Une erreur est survenue', false);
      //         fn.closeLoader();

      _isUpdating = false;
      update();
      //print(e);
    }
  }

  String _paiementUrl = '';
  get paiementUrl => _paiementUrl;

  var _controller;
  get controller => _controller;
  bool _isLoad = false;
  bool get isLoad => _isLoad;
  setLoadTransaction(val) {
    _isLoad = val;
    update();
  }

  String _token = '';
  get token => _token;
  depot(data) async {
    _isUpdating = false;

    update();
    fn.loading('Depot', 'Vous allez effectuer un depot sur votre compte');
    try {
      Response response = await transactionRepo.depotCompte(data);
      print(response.body);
      //print(_isCounter);
      if (response.statusCode == 201) {
        _paiementUrl = response.body['url'];

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
        _token = response.body['token'];
        update();
        //print(_paiementUrl);
        fn.closeLoader();

        new SocketService().transaction(response.body['token'], ifBuyingDepot);
        Get.to(() => DepotView());
        update();
      } else {
        fn.closeLoader();

        fn.snackBar('Achat', response.body['message'], false);
      }

      _isUpdating = false;
      // Get.back(closeOverlays: true);
      update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Depot', 'Une erreur est survenue', false);
      //         fn.closeLoader();

      _isUpdating = false;
      update();
      //print(e);
    }
  }

  ifBuyingDepot(dataSend) async {
    SocketDepotModel dataSocket = SocketDepotModel.fromJson(dataSend);

    update();
    print('ic-------------${dataSocket.message}-------');
    fn.snackBar('Depot', dataSocket.message, true);
    await actualise();

    Get.back();
    update();
  }

  // int _isCounter = 0;
  // int get isCounter => _isCounter;

  // bool _validateBuy = false;
  // bool get validateBuy => _validateBuy;

  // late Timer _timer;
  // void _startTimer() {
  //   if (_isCounter < 10 && !_validateBuy) {
  //     _timer = new Timer.periodic(Duration(seconds: 2), (_) {
  //       // Appeler la fonction souhaitée ici

  //       //print('counter********.${validateBuy}....*************. ${_isCounter}');
  //       verifyDepot();
  //     });
  //   }
  // }

  // void _stopTimer() {
  //   //print('stop***********************');

  //   _timer.cancel();
  //   update();
  //   //print('stop***********************');
  // }

  // verifyDepot() async {
  //   var data = {
  //     'token': token,
  //   };

  //   //print(data);

  //   try {
  //     Response response = await transactionRepo.verifyDepot(data);
  //     //print(response.body);

  //     // fn.snackBar('Achat', response.body['message'], true);
  //     //print(response.body);
  //     _isCounter = _isCounter + 1;
  //     update();
  //     if (response.statusCode == 201) {
  //       if (response.body['status']) {
  //         _validateBuy = true;
  //         _stopTimer();
  //         update();
  //         await actualise();
  //         fn.snackBar('Depot', response.body['message'], true);
  //       }
  //     }
  //   } catch (e) {
  //     //         fn.closeLoader();

  //     // fn.snackBar('Achat', 'Une erreur est survenue', false);

  //     update();
  //     //print(e);
  //   }
  // }

  actualise() async {
    update();
    fn.loading(
      'Compte',
      'Actualisation de vos transactions',
    );

    try {
      await Get.find<ManagerController>().getUser();
      await getTransactions();
      fn.closeLoader();

      update();
    } catch (e) {
      fn.closeLoader();

      fn.snackBar('Retrait', 'Une erreur est survenue', false);
      //         fn.closeLoader();

      _isUpdating = false;
      update();
      //print(e);
    }
  }
}
