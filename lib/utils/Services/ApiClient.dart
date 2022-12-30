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
    // add your local storage here to load for every request
//     var token = LocalStorage.readToken();
    //1.base_url
    // httpClient.baseUrl = baseUrl;
    // //2.
    // httpClient.defaultContentType = "application/json";
    // httpClient.timeout = Duration(seconds: 1060);
    // httpClient.addResponseModifier((request, response) async {
    //   print(response.body);
    // });
    // httpClient.addRequestModifier((request) async {
    //   // add request here
    //   return request;
    // });
    // var headers = {'Authorization': "Bearer $token"};
    // httpClient.addAuthenticator((request) async {
    //   request.headers.addAll(headers);
    //   return request;
    // });

    super.onInit();
  }

  Future<Response> getCollections(url) => get(url);
  Future<Response> getCollectionsP(url, data) => post(url, data);

  // getCollections(url) async {
  //   print('base user***** ${ApiUrl.baseUrl + url}');
  //   try {
  //     Response response = await get(url);

  //     return response;
  //   } catch (error) {
  //     print("voici error du get unique: $error");
  //   }
  // }

  // getCollectionsP(url, data) async {
  //   print('base user***** ${ApiUrl.baseUrl + url}');
  //   try {
  //     Response response = await post(url, data);

  //     return response;
  //   } catch (error) {
  //     print("voici error du get unique: $error");
  //   }
  // }
}
