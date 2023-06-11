import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CategoryBoutiqueRepo extends GetxService {
  final ApiClient apiClient;
  CategoryBoutiqueRepo({required this.apiClient});

  Future getListCategory() async {
    Response a = await apiClient.getCollections(ApiRoutes.CATEGORY_PRODUCT);
    //print(a.body);
    return a;
  }

  Future getListBoutiques() async {
    Response a = await apiClient.getCollections(
      ApiRoutes.BOUTIQUE_READ_ALL,
    );

    return a;
  }

  Future getListCommandeForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollections(
        ApiRoutes.BOUTIQUE_READ_COMMANDE +
            "?codeBoutique=${codeBoutique.toString()}");
    ;

    return a;
  }

  Future getListBoutiqueForCategory(id) async {
    // try {
    Response response = await await apiClient.getCollections(
        ApiRoutes.BOUTIQUE_FOR_CATEGORY + "?id=${id.toString()}");
    //print(response.body);
    return response;
  }

  Future getListHCommandeForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollections(
        ApiRoutes.BOUTIQUE_READ_HCOMMANDE +
            "?codeBoutique=${codeBoutique.toString()}");
    ;

    return a;
  }

  Future getListProduitForBoutique(codeBoutique) async {
    Response a = await apiClient.getCollections(
        ApiRoutes.BOUTIQUE_READ_PRODUIT +
            "?codeBoutique=${codeBoutique.toString()}");
    ;

    return a;
  }
}
