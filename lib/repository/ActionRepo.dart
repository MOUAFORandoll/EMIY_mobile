import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ActionRepo extends GetxService {
  final ApiClient apiClient;
  ActionRepo({required this.apiClient});
  var store = Get.find<DB>();

  Future test(indexC) async {
    Response a = await apiClient.getCollections(
      ApiRoutes.TEST + '/' + indexC.toString(),
    );

    return a;
  }

  Future getModePaiement() async {
    Response a = await apiClient.getCollections(
      ApiRoutes.MODEPAIEMENT,
    );

    return a;
  }

  Future addLikeProduit(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.LIKE_PRODUIT, data);
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
