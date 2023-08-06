import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class LinkRepo extends GetxService {
  final ApiClient apiClient;
  LinkRepo({required this.apiClient});

  Future<Response> getUniLinkProduit(codeProduit, keySecret) async {
    Response response = await apiClient.getData(
      ApiRoutes.LINK_PRODUCT +
          "?codeProduit=${codeProduit.toString()}&keySecret=${keySecret.toString()}",
    );

    return response;
  }

  Future<Response> getUniLinkBoutique(codeBoutique, keySecret) async {
    Response response = await apiClient.getData(
      ApiRoutes.LINK_BOUTIQUE +
          "?codeBoutique=${codeBoutique.toString()}&keySecret=${keySecret.toString()}",
    );

    return response;
  }
}
