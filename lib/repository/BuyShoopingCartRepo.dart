import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BuyShoopingCartRepo extends GetxService {
  final ApiClient apiClient;
  BuyShoopingCartRepo({required this.apiClient});
  String keySecret = '1234';
  Future buyCart(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.BUY, data);
    ;

    return a;
  }
}
