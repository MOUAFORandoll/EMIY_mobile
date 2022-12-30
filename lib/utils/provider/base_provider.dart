import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';

abstract class BaseProvider {
  Dio dio = Dio();

  GetStorage box = GetStorage();

  void onInit() {
    var headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
    };

    dio.options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: headers,
      sendTimeout: 50000,
      receiveTimeout: 50000,
      connectTimeout: 50000,
    );
  }
}
