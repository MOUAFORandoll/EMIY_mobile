import 'package:Fahkap/model/data/ProduitModel.dart';
import 'package:Fahkap/utils/Services/ApiClient.dart';
import 'package:Fahkap/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getListProductPopular(indexC) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getCollections(
      ApiRoutes.POPULAR_PRODUCT + '/' + indexC.toString(),
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
