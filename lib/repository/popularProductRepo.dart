import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getListProductPopular() async {
    print('get----------------');
    // try {
    Response response =
        await apiClient.getCollections(ApiRoutes.POPULAR_PRODUCT);
     
    return response;
  }

}
