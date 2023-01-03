import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BoutiqueRepo extends GetxService {
  final ApiClient apiClient;
  BoutiqueRepo({required this.apiClient});
  String keySecret = '1234';
  Future getBoutiqueForUser() async {
    Response a = await apiClient
        .getCollectionsP(ApiRoutes.BOUTIQUE_FOR_USER, {'keySecret': keySecret});
    ;

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
    ;

    return a;
  }

  Future getListProduitForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollectionsP(
        ApiRoutes.BOUTIQUE_READ_PRODUIT, {'codeBoutique': codeBoutique});
    ;

    return a;
  }

  Future updateProduitFB(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.UPDATE_PRODUCT, data);
    ;

    return a;
  }

  Future desibledProduitFB(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.DESABLED_PRODUCT, data);
    ;

    return a;
  }

  Future updateBoutique(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.BOUTIQUE_FOR_UPDATE, data);
    ;

    return a;
  }
}
