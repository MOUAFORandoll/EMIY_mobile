import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/utils/Services/ApiClient.dart';
import 'package:Fahkap/utils/Services/storageService.dart';
import 'package:Fahkap/utils/constants/apiRoute.dart';
import 'package:Fahkap/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ActionRepo extends GetxService {
  final ApiClient apiClient;
  ActionRepo({required this.apiClient});
  var store = Get.find<DB>();

  Future getModePaiement() async {
    Response a = await apiClient.getCollections(
      ApiRoutes.MODEPAIEMENT,
    );

    return a;
  }

  Future addNotationProduit(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.NOTAITON_PRODUIT, data);
    ;

    return a;
  }

  Future addNotationBoutique(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.NOTAITON_BOUTIQUE, data);
    ;

    return a;
  }
}
