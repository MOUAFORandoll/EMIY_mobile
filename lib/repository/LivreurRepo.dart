import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class LivreurRepo extends GetxService {
  final ApiClient apiClient;
  LivreurRepo({required this.apiClient});
  String keySecret = '1234';
  Future getLivreur() async {
    Response a = await apiClient.getCollectionsP(
       ApiRoutes.LIVREUR, {'keySecret': keySecret});;
    
    return a;
  }
}
