import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getListProductPopular(indexC, keySecret) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getCollections(
      ApiRoutes.POPULAR_PRODUCT +
          "?page=${indexC.toString()}&keySecret=${keySecret.toString()}",
    );

    return response;
  }

  Future<Response> getListProductAll() async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getCollections(ApiRoutes.POPULAR_ALL);

    return response;
  }
}
