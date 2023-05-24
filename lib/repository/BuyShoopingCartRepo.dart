import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/utils/Services/ApiClient.dart';
import 'package:Fahkap/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BuyShoopingCartRepo extends GetxService {
  final ApiClient apiClient;
  BuyShoopingCartRepo({required this.apiClient});
 
  Future buyCart(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.BUY, data);
    

    return a;
  }
  Future verifyCom(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.VERIFY, data);
 

    return a;
  }
}
