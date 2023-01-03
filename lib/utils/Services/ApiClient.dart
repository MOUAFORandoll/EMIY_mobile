import 'package:fahkapmobile/utils/api/apiUrl.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  String appBaseUrl = ApiUrl.baseUrl;
  late Map<String, String> _mainHeaders;
  ApiClient() {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-type':
          'application/json; charset=UTF-8', /* 'Authorization':'***' */
    };
  }
  void onInit() { 

    super.onInit();
  }

  Future<Response> getCollections(url) => get(url);
  Future<Response> getCollectionsP(url, data) => post(url, data);
 
}
