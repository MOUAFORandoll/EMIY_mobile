// import 'dart:convert';

// import 'package:Fahkap/controller/ActionController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:Fahkap/model/data/UserModel.dart';
// import 'package:jwt_decode/jwt_decode.dart';

// class StorageService extends GetxController {
//   GetStorage _box = new GetStorage();

//   Future<StorageService> init() async {
//     await GetStorage.init();
//     _box = GetStorage();
//     return this;
//   }

//   Future<void> save(String key, data) async {
//     await _box.write(key, data);
//   }

//   T? find<T>(String key) {
//     return _box.read<T>(key);
//   }

//   Future<void> deleteStorage() async {
//     await _box.erase();
//   }

//   // UserModel getUser() {
//   //   return jsonDecode(this.find('user'));
//   // }

//   Future<void> saveKeyKen(key) async {
//     await _box.write('keyKen', key);

//     await this.saveKey(Jwt.parseJwt(key['token'])['keySecret']);
//   }

//   getLonLat() async {
//     return {
//       'long': this.find('long'),
//       'lat': this.find('lat'),
//       'ville': this.find('ville')
//     };
//   }

//   getKeyKen() {
//     return this.find('keyKen');
//   }

//   Future<void> saveKey(String key) async {
//     await _box.write('keySecret', key);
//   }

//   String getKey() {
//     //print(
//         "******************************************* ${this.find('keySecret')}");
//     return this.find('keySecret').toString();
//   }

//   Future<void> saveLan(String key) async {
//     await _box.write('name', key);
//   }

//   Locale getLan() {
//     final name = this.find('name') ?? 'Fr';
//     //print('namw---${this.find('name')}-------${name}');
//     return Get.find<ActionController>().getLanguage(name);
//   }
// }
