import 'package:dio/dio.dart' hide Response;
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/Services/ApiClient.dart';
import 'package:fahkapmobile/utils/Services/storageService.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';

class ManageRepo extends GetxService with StorageService {
  final ApiClient apiClient;
  ManageRepo({required this.apiClient});
  // String keySecret = new GetStorage().read('keySecret');

  Future getUser() async {
    // print('key******************** ${this.getKey()}');
    // await this.userRefresh();
    Response a = await apiClient
        .getCollectionsP(ApiRoutes.USER, {'keySecret': this.getKey()});
    ;

    return a;
  }

  Future userRefresh() async {
    if (this.getKeyKen() != null) {
      print('this.getKeyKen()');
      print(this.getKeyKen());

      Response a = await apiClient.getCollectionsP(ApiRoutes.Refresh,
          {'refreshToken': this.getKeyKen()['refreshToken']});
      ;
      print('toke***n  ');
      print(a.body);
      this.saveKeyKen(a.body);
    } else {}
  }

  Future updateUser(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.UPDATE_USER, data);
    ;

    return a;
  }

  Future newConnexion() async {
    print('newlocatio-------------------------${this.getKey()}');

    if (this.getKey() != null && this.getKey().length != 0) {
      try {
        print('newlocatio-');

        var loca = await new Dio().get('https://ipapi.co/json/');

        print(loca.data);
        var data = {
          'ip': loca.data['ip'],
          'ville': loca.data['city'],
          'latitude': loca.data['latitude'],
          'keySecret': this.getKey(),
          'longitude': loca.data['longitude']
        };
        await this.saveLonLat(loca.data);
        print(data);
        Response a =
            await apiClient.getCollectionsP(ApiRoutes.LOCATION_USER, data);

        print('ssnewlocatio-------------------------');
        print(a.body);

        return a;
      } catch (e) {
        return new Response(body: {'data': []}, statusCode: 203);
      }
    } else {
      return new Response(body: {'data': []}, statusCode: 200);
    }
  }

  Future Login(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.LOGIN, data);
    var logdata = {'phone': data['phone'], 'password': data['password']};

    return a;
  }

  Future SignUp(data) async {
    print(data);
    Response a0 = await apiClient.getCollectionsP(ApiRoutes.SIGNUP, data);
    if (a0.statusCode == 201) {
      var logdata = {'phone': data['phone'], 'password': data['password']};
      print(logdata);

      Response a = await this.Login(logdata);
      return a;
    } else {
      return a0;
    }
  }

  // Future desibledProduitFB(data) async {
  //   Response a =
  //       await apiClient.getCollectionsP(ApiRoutes.DESABLED_PRODUCT, data);
  //   ;

  //   return a;
  // }
}
