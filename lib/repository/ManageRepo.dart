import 'package:dio/dio.dart' hide Response;
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/ApiClient.dart';
import 'package:EMIY/utils/Services/storageService.dart';
import 'package:EMIY/utils/constants/apiRoute.dart';
import 'package:EMIY/controller/DataBaseController.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';

class ManageRepo extends GetxService {
  final ApiClient apiClient;
  ManageRepo({required this.apiClient});
  // String keySecret = new GetStorage().read('keySecret');
  final dababase = Get.find<DataBaseController>();

  Future getUser() async {
    var getU = await dababase.getKey();
    // //print('key******************** ${thidababase.getKey() }');
    // await this.userRefresh();
    // ignore: unnecessary_null_comparison
    if (getU != null) {
      // if (getU.length != 0) {
      Response a = await apiClient
          .getCollections(ApiRoutes.USER + '?keySecret=${getU}');
      ;

      return a;
      // } else {
      //   return new Response(body: {
      //     'data': [],
      //     'compte': [],
      //   }, statusCode: 200);
      // }
    } else {
      return new Response(body: {
        'data': [],
        'compte': [],
      }, statusCode: 200);
    }
  }

  Future userRefresh() async {
    var kk = await dababase.getKeyKen();
    if (kk != null) {
      Response a = await apiClient.getCollectionsP(
          ApiRoutes.Refresh, {'refreshToken': kk['refreshToken']});
      ;

      dababase.saveKeyKen(a.body);
    } else {
      return new Response(body: {'data': []}, statusCode: 200);
    }
  }

  Future updateUser(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.UPDATE_USER, data);
    ;

    return a;
  }

  Future newConnexion() async {
    // //print('newlocatio-------------------------${dababase.getKey()}');
    var getU = await dababase.getKey();

    // ignore: unnecessary_null_comparison
    if (getU != null) {
      // if (getU.length != 0) {
      /*   try {
     */
      // //print('newlocatio-');
      try {
        var loca = await new Dio().get('https://ipapi.co/json/');

        var data = {
          'ip': loca.data['ip'],
          'ville': loca.data['city'],
          'latitude': loca.data['latitude'],
          'keySecret': getU,
          'longitude': loca.data['longitude']
        };
        await dababase.saveLonLat(data);

        Response a =
            await apiClient.getCollectionsP(ApiRoutes.LOCATION_USER, data);

        // //print('ssnewlocatio-------------------------');
        // //print(a.body);

        return a;
      } catch (e) {
        return new Response(body: {'data': []}, statusCode: 203);
      }
      // } else {
      //   return new Response(body: {'data': []}, statusCode: 200);
      // }
    } else {
      return new Response(body: {'data': []}, statusCode: 200);
    }
  }

  Future Login(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.LOGIN, data);

    return a;
  }

  Future SignUp(data) async {
    //print(data);
    Response a0 = await apiClient.getCollectionsP(ApiRoutes.SIGNUP, data);
    if (a0.statusCode == 201) {
      var logdata = {
        'phone': data['phone'].toString(),
        'password': data['password']
      };
      //  //print(logdata);

      Response a = await this.Login(logdata);
      return a;
    } else {
      return a0;
    }
  }

  Future getListFieul(keySecret, page) async {
    Response a = await apiClient.getCollections(
        ApiRoutes.LIST_FIEUL + '?keySecret=${keySecret}&page=${page}');

    return a;
  }

  Future updateImageUser(data) async {
    Response a = await apiClient.postData(ApiRoutes.USER_IMAGE_UPDATE, data);
    ;

    return a;
  }
}
