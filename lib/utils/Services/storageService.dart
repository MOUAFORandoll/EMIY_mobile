import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fahkapmobile/model/data/UserModel.dart';
import 'package:jwt_decode/jwt_decode.dart';

mixin StorageService   {
  GetStorage _box = new GetStorage();

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  Future<void> save(String key, data) async {
    await _box.write(key, data);
  }

  T? find<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> deleteStorage() async {
    await _box.erase();
  }

  // UserModel getUser() {
  //   return jsonDecode(this.find('user'));
  // }

  Future<void> saveKeyKen(key) async {
    await _box.write('keyKen', key);

    await this.saveKey(Jwt.parseJwt(key['token'])['keySecret']);
  }

  getKeyKen() {
    return jsonDecode(this.find('keyKen'));
  }

  Future<void> saveKey(String key) async {
    await _box.write('keySecret', key);
  }

  String getKey() {
   

    return this.find('keySecret').toString();
  }
}
