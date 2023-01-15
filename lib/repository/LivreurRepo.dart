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
    print('--long---------------');
    print(await s.getLonLat());

    var longlat = await s.getLonLat();
    Response a = await apiClient.getCollectionsP(ApiRoutes.LIVREUR,
        {'longitude': longlat['long'], 'latitude': longlat['lat']});
    ;
    print(a.body);
    return a;
  }
}
