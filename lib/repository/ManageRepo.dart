import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ManageRepo extends GetxService {
  final ApiClient apiClient;
  ManageRepo({required this.apiClient});
  String keySecret = '1234';
  Future getUser() async {
    Response a = await apiClient
        .getCollectionsP(ApiRoutes.USER, {'keySecret': keySecret});
    ;

    return a;
  }

   Future updateUser(data) async {
    Response a =
        await apiClient.getCollectionsP(ApiRoutes.UPDATE_USER, data);
    ;

    return a;
  }

  // Future desibledProduitFB(data) async {
  //   Response a =
  //       await apiClient.getCollectionsP(ApiRoutes.DESABLED_PRODUCT, data);
  //   ;

  //   return a;
  // }
}
