import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ShortRepo extends GetxService {
  final ApiClient apiClient;
  ShortRepo({required this.apiClient});
  var store = Get.find<DB>();

  Future getListShort(indexC) async {
    Response a = await apiClient
        .getCollections(ApiRoutes.SHORT_READ + '/' + indexC.toString());

    return a;
  }

  Future getListCommandeForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollectionsP(
        ApiRoutes.BOUTIQUE_READ_COMMANDE, {'codeBoutique': codeBoutique});
    ;

    return a;
  }

  Future getListHCommandeForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollectionsP(
        ApiRoutes.BOUTIQUE_READ_HCOMMANDE, {'codeBoutique': codeBoutique});
    //print(a.body);

    return a;
  }

  Future getListProduitForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollectionsP(
        ApiRoutes.BOUTIQUE_READ_PRODUIT, {'codeBoutique': codeBoutique});

    return a;
  }

  Future getListCategory() async {
    Response a = await apiClient.getCollections(ApiRoutes.CATEGORY);
    ;

    return a;
  }

  Future newProduit(data) async {
    Response a = await apiClient.postData(ApiRoutes.NEW_PRODUCT, data);
    ;

    return a;
  }

  Future updateProduitFB(data) async {
    Response a = await apiClient.postData(ApiRoutes.UPDATE_PRODUCT, data);
    ;

    return a;
  }

  Future updateImageBoutique(data) async {
    Response a =
        await apiClient.postData(ApiRoutes.BOUTIQUE_IMAGE_UPDATE, data);
    ;

    return a;
  }

  Future desibledProduitFB(data) async {
    Response a = await apiClient.postData(ApiRoutes.DESABLED_PRODUCT, data);
    ;

    return a;
  }

  Future updateBoutique(data) async {
    Response a = await apiClient.postData(ApiRoutes.BOUTIQUE_FOR_UPDATE, data);
    ;

    return a;
  }

  Future newBoutique(data) async {
    //print('************oc');
    Response a = await apiClient.postData(ApiRoutes.BOUTIQUE_NEW, data);

    //print(a.body);
    return a;
  }

  Future updateLocalisationBoutique(data) async {
    Response a = await apiClient.postData(
        ApiRoutes.BOUTIQUE_FOR_UPDATE_LOCALISATION, data);
    ;

    return a;
  }
}
