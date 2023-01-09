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

    Response a = await apiClient
        .getCollectionsP(ApiRoutes.USER, {'keySecret': this.getKey()});
    ;

    return a;
  }

  Future updateUser(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.UPDATE_USER, data);
    ;

    return a;
  }

  Future Login(data) async {
    Response a = await apiClient.getCollectionsP(ApiRoutes.LOGIN, data);
    var logdata = {'phone': data['phone'], 'password': data['password']};
    await this.saveKeyKen(a.body);

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
