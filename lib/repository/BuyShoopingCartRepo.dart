import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BuyShoopingCartRepo extends GetxService {
  final ApiClient apiClient;
  BuyShoopingCartRepo({required this.apiClient});

  Future buyCart(data) async {
    Response a = await apiClient.postData(ApiRoutes.BUY, data);

    return a;
  }

  Future getLivraison_point() async {
    Response a = await apiClient.getData(ApiRoutes.LIVRAISON_POINT);

    return a;
  }

  Future verifyCom(data) async {
    Response a = await apiClient.postData(ApiRoutes.VERIFY, data);

    return a;
  }
}
