// import 'dart:convert';

// import 'package:Fahkap/utils/Services/storageService.dart';
// import 'package:Fahkap/utils/api/apiUrl.dart';
// import 'package:Fahkap/utils/provider/base_provider.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:jwt_decode/jwt_decode.dart';

// class AuthProvider extends BaseProvider {
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   StorageService service = Get.find();

//   Future login(data) async {
//     //print('******** envoi du login');

//     try {
//       final response = await dio.post("/api/logins",
//           options: Options(headers: {"Accept": "application/json"}),
//           data: data);
//       //print('****a**** ${response.data}');
//       await saveToken(response.data['token'], response.data['refreshToken']);
//       return response.data;
//     } catch (e) {
//       //print('********eroor $e');
//       return null;
//     }
//   }

//   Future register(data) async {
//     try {
//       final response = await dio.post(
//         "/api/users",
//         options: Options(headers: {"Accept": "application/json"}),
//         data: data,
//       );
//       //print('****a**** ${response.data}');
//       var dataLogin = {'phone': data['phone'], 'password': data['password']};
//       login(dataLogin);
//       return response.data;
//     } catch (e) {
//       //print('********eroor $e');
//       return null;
//     }
//   }

//   Future logout() async {
//     StorageService service = Get.find();
//     await service.save('token', null);
//     await service.save('refreshToken', null);

//     // if (Security.enableFirstInitControl) {
//     //   Get.offAllNamed(Security.firstInitRedirect);
//     // }
//   }

//   Future saveToken(String token, String refreshToken) async {
//     StorageService service = Get.find();
//     await service.save('token', token);
//     await service.save('refreshToken', refreshToken);
//   }
// }
