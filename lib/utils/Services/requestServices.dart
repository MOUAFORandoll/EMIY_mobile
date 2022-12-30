import 'dart:convert';
import 'dart:io';

import 'package:fahkapmobile/model/data/BoutiqueModel.dart';
import 'package:fahkapmobile/model/data/CategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitCategoryModel.dart';
import 'package:fahkapmobile/model/data/ProduitModel.dart';
import 'package:fahkapmobile/utils/constants/apiRoute.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:fahkapmobile/model/data/VoyageModelH.dart';
import 'package:fahkapmobile/model/data/VoyageModelX.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';

class ApiService extends GetConnect {
  GetStorage box = GetStorage();
  var keySecret = /* new GetStorage().read('keySecret') ?? */ "1234";
  init() {
    httpClient.baseUrl = ApiUrl.baseUrl;
    print('init********00 ${httpClient.baseUrl}----  ${ApiUrl.baseUrl}');
    httpClient.defaultContentType = "application/json";
    // httpClient.timeout = Duration(seconds: 100);
    // httpClient.addResponseModifier((request, response) async {
    //   print(response.body);
    // });
    // httpClient.addRequestModifier<dynamic>((request) async {
    //   // add request here
    //   return request;
    // });
    // box.read('keySecret');
    // var headers = {'Authorization': "Bearer $token"};
    // httpClient.addAuthenticator<dynamic>((request) async {
    //   request.headers.addAll(headers);
    //   return request;
    // });
  }

  
/**
 *  Start Section Billet 
 */

  getCollections(url) async {
    print('base user***** ${ApiUrl.baseUrl + url}');
    // try {
    var response =
        await get(ApiUrl.baseUrl + url).timeout(Duration(seconds: 70));
    //   print(response.statusCode);
    return response;
    // } catch (error, stacktrace) {
    //   print("voici error du get unique: $error");
    //   throw Exception("Exception occured: $error stackTrace: $stacktrace");
    // }
  }

  getCollectionsP(url, data) async {
    print('base user***** ${ApiUrl.baseUrl + url}');
    try {
      Response response =
          await post(ApiUrl.baseUrl + url, data).timeout(Duration(seconds: 70));

      return response;
    } catch (error, stacktrace) {
      print("voici error du get unique: $error");
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future getBoutiqueForUser() async {
    // try {
    //   Response response = await getCollectionsP(
    //       ApiRoutes.BOUTIQUE_FOR_USER, {'keySecret': keySecret});
    //   print('-*-*-*-*********************0');
    //   print(response.statusCode);
    //   // print(response.body);
    //   if (response.statusCode == 200) {
    //     return {
    //       'code': 200,
    //       'data': BoutiqueModel.fromJson(response.body['data']),
    //       'exist': response.body['exist']
    //     };
    //   } else {
    //     return {'code': 203, 'data': []};
    //   }
    // } catch (error, stacktrace) {
    //   print("voiccccccccccce: $error");
    //   throw Exception("Exception occured: $error stackTrace: $stacktrace");
    // }
  }

  Future getListCategory() async {
    try {
      Response response = await getCollectionsP(ApiRoutes.CATEGORY_PRODUCT, {});
      print('-*-*-*-*********************1');
      print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        return {
          'code': 200,
          'data': (response.body['data'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
        };
      } else {
        return {'code': 203, 'data': []};
      }
    } catch (error, stacktrace) {
      print("voiccccccccccce: $error");
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future getListProductForCategory(id) async {
    // try {
    //   var response = await getCollectionsP(ApiRoutes.PRODUCT_FOR_CATEGORY, {
    //     'id': id, /* 'keySecret': keySecret */
    //   });
    //   if (response.statusCode == 200) {
    //     print('---------------------');
    //     print(response.body['data']);
    //     return {
    //       'code': 200,
    //       'data': (response.body['data'] as List)
    //           .map((e) => ProduitModel.fromJson(e))
    //           .toList()
    //     };
    //   } else {
    //     print('----------eeee-----------');

    //     return {'code': 203, 'data': []};
    //   }
    // } catch (error, stacktrace) {
    //   print("voiccccccccccce: $error");
    //   throw Exception("Exception occured: $error stackTrace: $stacktrace");
    // }
  }

  Future getListProductPopular() async {
    // try {
    //   var response = await getCollections(ApiRoutes.POPULAR_PRODUCT);
    //   print(response.statusCode);
    //   // print(response.body);
    //   if (response.statusCode == 200) {
    //     print('---------------------');
    //     print(response.body['data']);
    //     return {
    //       'code': 200,
    //       'data': (response.body['data'] as List)
    //           .map((e) => ProduitModel.fromJson(e))
    //           .toList()
    //     };
    //   } else {
    //     print('----------eeee-----------');

    //     return {'code': 203, 'data': []};
    //   }
    // } catch (error, stacktrace) {
    //   print("voiccccccccccce: $error");
    //   throw Exception("Exception occured: $error stackTrace: $stacktrace");
    // }
  }
}
