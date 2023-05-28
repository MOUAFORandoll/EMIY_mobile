import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/utils/DataBase/DataBase.dart';
import 'package:Fahkap/utils/api/apiUrl.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../functions/viewFunctions.dart';

class ApiClient extends GetConnect implements GetxService {
  String token = '';
  String appBaseUrl = ApiUrl.baseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient() {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 600);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
    };

    httpClient.addRequestModifier<dynamic>((request) {
      _setAuthHeaders();

      // //print('===========================$token============================');
      // Intercept the request before it is sent to the server
      token.length != 0
          ? request.headers['Authorization'] = 'Bearer $token'
          : null;
      return request;
    });

    // add the token refresh logic to the response interceptor
    httpClient.addResponseModifier<dynamic>((request, response) async {
      _setAuthHeaders();

      if ((response.statusCode == '401' || response.statusCode == '403')) {
        //print(response.statusCode);
        await Get.find<ManagerController>()
            .refreshToken(request.url.path.toString());
        //  //print('secomnd8888888=+++}+++++++++++++++++++++++++++}-=======================================================');
        _setAuthHeaders();
        _mainHeaders['Authorization'] = 'Bearer $token';

        request.headers.addAll(_mainHeaders);
        request.headers['Authorization'] = 'Bearer $token';

        return await _retry(request);
      } else {
        return response;
      }
    });
  }
  Future<Response<dynamic>> _retry(Request request) async {
    return this.request<dynamic>(
      request.url.path,
      request.method,
      body: request.bodyBytes,
      headers: request.headers,
    );
  }

  var fn = new ViewFunctions();

  void onInit() {
    _setAuthHeaders();
    fn.verifiedConnection();
    super.onInit();
  }

  // var db = Get.find<DB>();

  void _setAuthHeaders() async {
    // var getU = await db.getKeyKen();
    // token = getU['token'];
    //print(token);
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
    // //print(this.httpClient.defaultContentType);
    //print(data);
    Response rep = await post(url.toString(), data);
    return rep;
  }
}
