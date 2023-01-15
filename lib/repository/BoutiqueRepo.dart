import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/Services/storageService.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BoutiqueRepo extends GetxService with StorageService {
  final ApiClient apiClient;
  BoutiqueRepo({required this.apiClient});

  Future getBoutiqueForUser() async {
    Response a = await apiClient.getCollectionsP(
        ApiRoutes.BOUTIQUE_FOR_USER, {'keySecret': this.getKey()});

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
    print(a.body);

    return a;
  }

  Future getListProduitForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollectionsP(
        ApiRoutes.BOUTIQUE_READ_PRODUIT, {'codeBoutique': codeBoutique});
    ;

    return a;
  }

  Future getListCategory() async {
    Response a = await apiClient.getCollections(
        ApiRoutes.CATEGORY);
    ;

    return a;
  }

  Future newProduit(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.NEW_PRODUCT, data);
    ;

    return a;
  }
  
  Future updateProduitFB(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.UPDATE_PRODUCT, data);
    ;

    return a;
  }
  Future updateImageBoutique(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.BOUTIQUE_IMAGE_UPDATE, data);
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
