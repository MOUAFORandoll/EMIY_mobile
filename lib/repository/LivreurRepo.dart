import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService2.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class LivreurRepo extends GetxService {
  final ApiClient apiClient;
  LivreurRepo({required this.apiClient});

  final dababase = Get.find<DataBaseController>();

  Future getLivreur() async {
    //print('--long---------------');
    //print(await s.getLonLat());

    var longlat = await dababase.getLonLat();
    Response a = await apiClient.getCollectionsP(ApiRoutes.LIVREUR,
        {'longitude': longlat['long'], 'latitude': longlat['lat']});
    ;
    //print(a.body);
    return a;
  }
}
