import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/controller/DataBaseController.dart';
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

  Future searchData(type, search, index, keySecret) async {
    Response response = await apiClient.getData(
      ApiRoutes.SEARCH +
          "?type=$type&search=$search&page=${index.toString()}&keySecret=${keySecret.toString()}",
    );
    // //print('response.body');
    // //print(response.body);
    return response;
  }
}
