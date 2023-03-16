import 'package:Fahkap/utils/api/apiUrl.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  String appBaseUrl = ApiUrl.baseUrl;
  late Map<String, String> _mainHeaders;
  ApiClient() {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 20);
    _mainHeaders = {
      'Content-type':
          'application/json; charset=UTF-8', /* 'Authorization':'***' */
    };
  }
  void onInit() {
    super.onInit();
  }

  Future<Response> getCollections(url) async {
    Response rep = await get(url);
    return rep;
  }

  Future<Response> getCollectionsP(url, data) async {
    Response rep = await post(url.toString(), data);
    return rep;
  }

  Future<Response> postData(url, data) async {
    // print(this.httpClient.defaultContentType);
    print(data);
    Response rep = await post(url.toString(), data);
    return rep;
  }
}
