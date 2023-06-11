import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CommandeRepo extends GetxService {
  final ApiClient apiClient;
  CommandeRepo({required this.apiClient});

  // Future getListCommande() async {
  //   // //print('get----------------');
  //   // try {
  //   var response = this.getListCommande();
  //   //print('response-----------------------------');
  //   //print(response);
  //   return response;
  // }

  Future getListProductForComm(id) async {
    // try {
    Response response = await await apiClient
        .getCollectionsP(ApiRoutes.USER_READ_COMMANDE_PRODUIT, {
      'idCom': id, /* 'keySecret': keySecret */
    });
    //print(response.body);
    return response;
  }
}
