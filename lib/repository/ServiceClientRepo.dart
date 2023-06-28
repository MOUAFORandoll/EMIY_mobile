import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ServiceClientRepo extends GetxService {
  final ApiClient apiClient;
  ServiceClientRepo({required this.apiClient});

  Future<Response> getEchange(code) async {
    //print('get----------------');
    // try {
    Response response = await apiClient.getCollections(
        ApiRoutes.LIST_MESSAGE_SC + '?code=' + code.toString());

    return response;
  }

  Future echangeMessageNew(data) async {
    Response a =
        await apiClient.postData(ApiRoutes.LIST_MESSAGE_NEW, data);
    ;

    return a;
  }
}
