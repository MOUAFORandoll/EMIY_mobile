import 'package:EMIY/model/socket/MessageNegociationModel.dart';
import 'package:EMIY/model/socket/NegociationModel.dart';
import 'package:EMIY/repository/negociationRepo.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class NegociationController extends GetxController {
  final NegociationRepo negociationRepo;
  NegociationController({required this.negociationRepo});
  final dababase = Get.find<DataBaseController>();

  var fn = new ViewFunctions();
  newNegociation(codeProduit) async {
    textEditingController.text = '';
    _codeNegociation = '';
    _sending = false;
    update();
    var key = await dababase.getKey();

    fn.loading('Boutique', 'Creation de la negociation en cours');
    var token = await dababase.getKeyKen();
    _idUser = Jwt.parseJwt(token!['token'])['id'];

    try {
      var data = {'codeProduit': codeProduit, 'keySecret': key};
      print(data);
      Response response = await negociationRepo.negociationProduit(data);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['data'] != null) {
            print(response.body['data']);
            new SocketService().negociation(
                response.body['data']['canal'], socketMessageNegociation);
            _codeNegociation = response.body['data']['canal'];
            _listMessageNegociation = [];
            textEditingController.text = '';
            _titreNegociation = '';

            fn.closeLoader();
            update();
            _listMessageNegociation
                .add(MessageNegociationModel.fromJson(response.body['data']));
            Get.toNamed(AppLinks.NEGOCIATION_NEW);
            await getListNegociation();
            update();
          }
        }
      }
    } catch (e) {
      fn.closeLoader();
      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

      update();
      //print(e);
    }
  }

  TextEditingController _searchNegoController = TextEditingController();
  TextEditingController get searchNegoController => _searchNegoController;
  searchNego() {
    print('----------------****');

    print(searchNegoController.text);
    if (searchNegoController.text.isEmpty) {
      _listNegociation = _listNegociationSave;
    }
    _listNegociation = _listNegociationSave
        .where((element) => (((element.titre_produit
                .toLowerCase()
                .contains(searchNegoController.text.toLowerCase())) ||
            (element.last_message
                .toLowerCase()
                .contains(searchNegoController.text.toLowerCase())))))
        .toList();

    update();
  }

  List<NegociationModel> _listNegociationSave = [];
  List<NegociationModel> _listNegociation = [];
  List<NegociationModel> get listNegociation => _listNegociation;
  int _isLoadNego = 0;
  int get isLoadNego => _isLoadNego;
  getListNegociation() async {
    // fn.loading('Boutique', 'Creation de la negociation en cours');

    textEditingController.text = '';
    update();
    var key = await dababase.getKey();
//     var token = await s.getKeyKen();
// // if(token.length !=0){

//     _idUser = Jwt.parseJwt(token['token'])['id'];

    try {
      Response response = await negociationRepo.getListnegociationProduit(key);

      if (response.statusCode == 200) {
        print('---------------idd------------!!${_idUser}');
        if (response.body != null) {
          if (response.body['data'] != null) {
            print(response.body['data']);
            _listNegociation.clear();
            update();
            _listNegociation.addAll((response.body['data'] as List)
                .map((e) => NegociationModel.fromJson(e))
                .toList());
            _listNegociation.forEach((elt) => new SocketService()
                .negociation(elt.codeNegociation, socketMessageNegociation));
            _listNegociationSave = _listNegociation;
            _isLoadNego = 1;
            update();
          }
        }
      }
    } catch (e) {
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      _isLoadNego = 2;

      update();
      //print(e);
    }
    // }
  }

  var _imageNegociation = '';
  get imageNegociation => _imageNegociation;

  int _loadNegociation = 0;
  get loadNegociation => _loadNegociation;

  var _titreNegociation = '';
  get titreNegociation => _titreNegociation;
  getListMessageNegociation(NegociationModel negociation) async {
    _loadNegociation = 0;

    _listMessageNegociation = [];
    textEditingController.text = '';
    _codeNegociation = negociation.codeNegociation;
    _titreNegociation = negociation.titre_produit;
    _imageNegociation = negociation.src_produit;

    update();
    new SocketService().negociation(_codeNegociation, socketMessageNegociation);
    var key = await dababase.getKey();

    try {
      Response response = await negociationRepo
          .getListMessagenegociationProduit(_codeNegociation);

      if (response.statusCode == 200) {
        if (response.body != null) {
          if (response.body['data'] != null) {
            print(response.body['data']);

            _listMessageNegociation.addAll((response.body['data'] as List)
                .map((e) => MessageNegociationModel.fromJson(e))
                .toList());
            _loadNegociation = 1;
            scroolToEnd();
            update();
          }
        }
      }
      _loadNegociation = 1;

      update();
    } catch (e) {
      // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      _loadNegociation = 2;

      update();
    }
  }

  ScrollController _scrollcontroller = ScrollController();
  ScrollController get scrollcontroller => _scrollcontroller;
  scroolToEnd() {
    print('-----scroll');
    _scrollcontroller.animateTo(
      99,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    update();
    // _scrollcontroller
    //     .animateTo(99, duration: Duration(milliseconds: 500));
  }

  bool _sending = false;
  bool get sending => _sending;
  var _codeNegociation = '';
  get codeNegociation => _codeNegociation;
  TextEditingController _textEditingController = TextEditingController();
  get textEditingController => _textEditingController;
  newMessageNegociation() async {
    if (textEditingController.text.length != 0) {
      _sending = true;
      update();
      var key = await dababase.getKey();

      // fn.loading('Boutique', 'Creation de la negociation en cours');
      var token = await dababase.getKeyKen();
      _idUser = Jwt.parseJwt(token!['token'])['id'];

      try {
        var data = {
          'codeNegociation': codeNegociation,
          'keySecret': key,
          "message": textEditingController.text
        };
        print(data);
        textEditingController.text = '';
        update();
        Response response = await negociationRepo.negociationMessageNew(data);

        if (response.statusCode == 200) {
          textEditingController.text = '';
          update();
          if (response.body != null) {
            if (response.body['status'] == true) {
              print(response.body['data']);
              // new SocketService().negociation(
              //     response.body['data']['canal'], socketMessageNegociation);
              print('-------------------------');
              // _listMessageNegociation.add(response.body['data']);
              // Get.toNamed(AppLinks.NEGOCIATION_NEW);
              // fn.snackBar('Message', 'ok', true);
              _sending = false;

              textEditingController.text = '';
              update();
              // update();
              // fn.closeLoader();
            }
          }
        }
      } catch (e) {
        fn.closeLoader();
        fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
        _sending = false;

        update();
        //print(e);
      }
    }
  }

  int _idUser = 0;
  int get idUser => _idUser;
  setUserId(id) {
    _idUser = id;
    update();
  }
  // onInit() {
  //   super.onInit();
  //   var token = s.getKeyKen()['token'];
  //   _idUser = Jwt.parseJwt(token)['id'];
  //   update();
  //   print('---------------idd------------!!${_idUser}');
  // }

  List<MessageNegociationModel> _listMessageNegociation = [];
  List<MessageNegociationModel> get listMessageNegociation =>
      _listMessageNegociation;
  socketMessageNegociation(data) {
    print('-....dddsd...........');
    print(data);
    if (data["emetteurId"] != idUser) {
      new NotificationService().emitNotification(data['message']);
      // fn.snackBar('Message negociation', data['message'], true);
    }
    print(!_listMessageNegociation
        .any((elt) => elt.id == MessageNegociationModel.fromJson(data).id));
    if (!_listMessageNegociation
        .any((elt) => elt.id == MessageNegociationModel.fromJson(data).id)) {
      _listMessageNegociation.add(MessageNegociationModel.fromJson(data));
      update();
      // ici on doit faire l'ajout a la liste des message en locale dans le telephone du user
    }
  }
}
