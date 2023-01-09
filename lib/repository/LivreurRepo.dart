import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/Services/storageService2.dart'; 
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class LivreurRepo extends GetxService {
  final ApiClient apiClient;
  LivreurRepo({required this.apiClient});
    var s = Get.find<StorageService>();

  Future getLivreur() async {
    Response a = await apiClient
        .getCollectionsP(ApiRoutes.LIVREUR, {'keySecret': s.getKey()});
    ;

    return a;
  }
}
