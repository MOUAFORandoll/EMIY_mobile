import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:EMIY/Views/UsersMange/DepotView.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/model/data/BoutiqueModel.dart';
import 'package:EMIY/model/data/BoutiqueUserModel.dart';
import 'package:EMIY/model/data/CategoryModel.dart';
import 'package:EMIY/model/data/CommandeBoutiqueModel.dart';
import 'package:EMIY/model/data/ProduitBoutiqueModel.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/model/data/TransactionModel.dart';
import 'package:EMIY/model/socket/SocketDepotModel.dart';
import 'package:EMIY/repository/BoutiqueRepo.dart';
import 'package:EMIY/repository/ServiceClientRepo.dart';
import 'package:EMIY/model/socket/MessageEchangeModel.dart';
import 'package:EMIY/utils/Services/NotificationService.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:EMIY/utils/Services/SocketService.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/utils/Services/requestServices.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ServiceClientController extends GetxController {
  final service = new ApiService();

  final ServiceClientRepo serviceClientRepo;
  ServiceClientController({required this.serviceClientRepo});

  final dababase = Get.find<DataBaseController>();
  var fn = new ViewFunctions();

  List<MessageEchangeModel> _listMessageEchange = [];
  List<MessageEchangeModel> get listMessageEchange => _listMessageEchange;
  getEchange() async {
    var keys = await dababase.getKeyKen();
    if (keys != null) {
      // fn.loading('Boutique', 'Creation de la negociation en cours');
      var codeCommunication = keys['codeCommunication'];
      print('codeCommunication-----------------${codeCommunication}');

      textEditingController.text = '';
      update();

      var token = await dababase.getKeyKen();
      if (token.length != 0) {
        try {
          Response response =
              await serviceClientRepo.getEchange(codeCommunication);

          if (response.statusCode == 200) {
            if (response.body != null) {
              if (response.body['data'] != null) {
                print(response.body['data']);
                _listMessageEchange.clear();
                update();
                _listMessageEchange.addAll((response.body['data'] as List)
                    .map((e) => MessageEchangeModel.fromJson(e))
                    .toList());

                update();
              }
            }
          }
        } catch (e) {
          // fn.snackBar('Mise a jour', 'Une erreur est survenue', false);

          update();
          //print(e);
        }
      }
    }
  }

  bool _sending = false;
  bool get sending => _sending;
  var _codeMessageEchange = '';
  get codeMessageEchange => _codeMessageEchange;
  TextEditingController _textEditingController = TextEditingController();
  get textEditingController => _textEditingController;
  newMessageMessageEchange() async {
    _sending = true;
    update();
    var key = await dababase.getKey();

    var keys = await dababase.getKeyKen();
    var codeCommunication = keys['codeCommunication'];
    print('codeCommunication-----------------${codeCommunication}');

    try {
      var data = {
        'codeCommunication': codeCommunication,
        'keySecret': key,
        "message": textEditingController.text
      };
      print(data);
      textEditingController.text = '';
      update();
      Response response = await serviceClientRepo.echangeMessageNew(data);

      if (response.statusCode == 200) {
        textEditingController.text = '';
        update();
        if (response.body != null) {
          if (response.body['status'] == true) {
            print(response.body);
            print('-------------------------');
            // _listMessageEchange.addAll((response.body['message'] as List)
            //     .map((e) =>
            //         MessageEchangeModel.fromJson(response.body['message']))
            //     .toList());
            _sending = false;

            textEditingController.text = '';
            update();

            // fn.closeSnack();
          }
        }
      }
    } catch (e) {
      fn.closeSnack();
      fn.snackBar('Mise a jour', 'Une erreur est survenue', false);
      _sending = false;

      update();
      //print(e);
    }
  }

  // onOpen() {
  //   scrollController.jumpTo(scrollController.position.maxScrollExtent);

  //   update();

  //   // _scrollController.animateTo(
  //   //   Get.height,
  //   //   duration: Duration(milliseconds: 10),
  //   //   curve: Curves.easeInOut,
  //   // );
  //   // update();
  // }

  int _idUser = 0;
  int get idUser => _idUser;

  socketMessageCommunication(data) async {
    print('-...............');
    print(data);
    if (data["emetteurId"] != idUser) {
      new NotificationService().emitServiceClient(data['message']);
      // fn.snackBar('Message negociation', data['message'], true);
    }
    var message = MessageEchangeModel.fromJson(data);
    if (noContain(message)) {
      _listMessageEchange.add(message);
      // Positionner le ScrollController en bas de la liste

      update();

// ou

      update();
    }
    print(_listMessageEchange.length);
    // ici on doit faire l'ajout a la liste des message en locale dans le telephone du user
  }

  noContain(message) {
    return !_listMessageEchange.contains(message);
  }

  connectSockey() async {
    var keys = await dababase.getKeyKen();
    if (keys != null) {
      _idUser = Jwt.parseJwt(keys['token'])['id'];
      update();

      var codeCommunication = keys['codeCommunication'];
      new SocketService()
          .service_client(codeCommunication, socketMessageCommunication);
    }
  }
}
