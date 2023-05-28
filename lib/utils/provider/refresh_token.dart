// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:jwt_decode/jwt_decode.dart';
// import 'package:Fahkap/utils/api/apiUrl.dart';
// import 'package:Fahkap/utils/functions/route.dart';
// // 
// class CustomDio {
//   static GetStorage box = GetStorage();
//   static Dio _dio = Dio(
//     BaseOptions(baseUrl: ApiUrl.baseUrl, headers: {
//       "Accept": "application/json",
//       "Authorization": 'Bearer ${box.read(userKey)["token"]}',
//     }),
//   );
//   var token;

//   Future<Dio> getApiClient() async {
//     var userData = box.read(userKey);
//     if (userData != null && userData != []) {
//       if (userData['token'] is String) {
//         token = userData['token'];
//       } else if (userData['token'] is Map) {
//         token = userData['token']["token"];
//       }
//       _dio.interceptors.clear();
//       _dio.interceptors
//           .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
//         options.headers["Authorization"] = "Bearer " + token;
//         return options;
//       }, onResponse: (Response response) {
//         return response;
//       }, onError: (DioError error) async {
//         if (error.response?.statusCode == 403 ||
//             error.response?.statusCode == 401) {
//           _dio.interceptors.requestLock.lock();
//           _dio.interceptors.responseLock.lock();
//           RequestOptions options = error.response.request;
//           //print("Debut refresh token......ancien.......$token..............");
//           await refreshToken();

//           var userData = box.read(userKey);
//           if (userData['token'] is String) {
//             token = userData['token'];
//           } else if (userData['token'] is Map) {
//             token = userData['token']["token"];
//           }
//           //print(
//               " refresh token...........Termineeeeeeeee. NOuveau..$token.............");
//           options.headers["Authorization"] = "Bearer" + token;
//           _dio.interceptors.requestLock.unlock();
//           _dio.interceptors.responseLock.unlock();
//           // //print("voici lo token ${options.headers["Authorization"]}");
//           //print("voici  la requette qui a ete faite ${options.path}");

//           return await _dio.request(
//             options.path,
//             options: options,
//           );
//         } else {
//           return error;
//         }
//       }));
//       _dio.options.baseUrl = ApiUrl.baseUrl;
//     }
//     return _dio;
//   }

//   Future<bool> refreshToken() async {
//     //print("****************----------------");
//     var userData = box.read(userKey);
//     var data;
//     /* box.write(userKey, {
//       "token": 'token',
//     }); */

//     var refreshToken = await userData['refreshToken'];
//     //print("refreshTo $refreshToken");
//     if (refreshToken is String) {
//       data = {"refreshToken": refreshToken};
//       //print("refresh token on type string");
//     } else if (refreshToken is Map) {
//       data = {"refreshToken": refreshToken["refreshToken"]};
//       //print("refresh token on type map");
//       // //print("refresh token on type string");
//     }
//     // //print("refresh token on type a la sortir $data");

//     Response response = await Dio()
//         .post(ApiUrl.baseUrl + '/api/token/refresh', data: jsonEncode(data));

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var user = response.data;
//       //print('use on resfresh token $user');
//       Variable.token = user["token"];
//       var user1 = box.read(userKey);
//       //    //print('user1 du box reda  $user1');

//       var data = response.data;
//       //    //print('data du response data $data');
//       // box.write(
//       //   userKey,
//       //   user1
//       //     ..updateAll((key, value) => {
//       //           "token": data['token'],
//       //           "refreshToken": data['refreshToken'],
//       //         }),
//       // );
//       box.write(userKey, {
//         "token": data['token'],
//         "refreshToken": data['refreshToken'],
//       });
//       box.write(firstKey, {
//         "token": data['token'],
//         "refreshToken": data['refreshToken'],
//       });
//       //print("inale----------------------------");
//       return true;
//     } else {
//       //   //print("voici error userrefresh: ");
//       throw Exception("Exception occured: ");
//     }
//   }
// }
