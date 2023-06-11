import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/utils/database/DataBase.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SearchRepo extends GetxService {
  final ApiClient apiClient;
  SearchRepo({required this.apiClient});

  // Future getListCommande() async {
  //   // //print('get----------------');
  //   // try {
  //   var response = this.getListCommande();
  //   //print('response-----------------------------');
  //   //print(response);
  //   return response;
  // }

  Future searchData(type, search) async {
    // try {
    // //print(
    //     'response------------------${type}-----${search}----${ApiRoutes.SEARCH}--');

    Response response = await apiClient.postData(ApiRoutes.SEARCH, {
      'type': type,
      'search': search,
    });
    // //print('response.body');
    // //print(response.body);
    return response;
  }
}
