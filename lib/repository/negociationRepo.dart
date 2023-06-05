import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/utils/Services/ApiClient.dart';
import 'package:Fahkap/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class NegociationRepo extends GetxService {
  final ApiClient apiClient;
  NegociationRepo({required this.apiClient});
 

  Future<Response> getListnegociationProduit(keySecret) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getCollections(
        ApiRoutes.LIST_NEGOCIATION + '?keySecret=' + keySecret.toString());

    return response;
  }


  Future<Response> getListMessagenegociationProduit(codeNegociation) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getCollections(
        ApiRoutes.LIST_MESSAGE_NEGOCIATION + '?code=' + codeNegociation.toString());

    return response;
  }

  
  Future negociationProduit(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.NEW_NEGOCIATION, data);
    ;

    return a;
  }

  Future negociationMessageNew(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.NEW_MESSAGE_NEGOCIATION, data);
    ;

    return a;
  }

}
