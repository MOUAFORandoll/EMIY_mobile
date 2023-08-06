import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class GeneralRepo extends GetxService {
  final ApiClient apiClient;
  GeneralRepo({required this.apiClient});

  Future test(indexC) async {
    Response a = await apiClient.getData(
      ApiRoutes.TEST + '/' + indexC.toString(),
    ); 

    return a;
  }

  Future getModePaiement() async {
    Response a = await apiClient.getData(
      ApiRoutes.MODEPAIEMENT,
    );

    return a;
  }

  Future addLikeProduit(data) async {
    Response a = await apiClient.postData(ApiRoutes.LIKE_PRODUIT, data);
 

    return a;
  }

  Future addNotationBoutique(data) async {
    Response a = await apiClient.postData(ApiRoutes.NOTAITON_BOUTIQUE, data);
 

    return a;
  }

  Future getListNotifications(index, keySecret) async {
    Response a = await apiClient.getData(
      ApiRoutes.LIST_NOTIFICATIONS +
          "?page=${index.toString()}&keySecret=${keySecret.toString()}",
    );

    return a;
  }

  Future readNotifications(idNotification) async {
    Response a = await apiClient.getData(
      ApiRoutes.READ_NOTIFICATIONS + "?id=${idNotification.toString()}",
    );

    return a;
  }
}
