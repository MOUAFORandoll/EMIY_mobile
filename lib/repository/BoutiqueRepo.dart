import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BoutiqueRepo extends GetxService {
  final ApiClient apiClient;
  BoutiqueRepo({required this.apiClient});
  String keySecret = '1234';
  Future getBoutiqueForUser() async {
    Response a = await apiClient.getCollectionsP(
       ApiRoutes.BOUTIQUE_FOR_USER, {'keySecret': keySecret});;
    
    return a;
  }
}
