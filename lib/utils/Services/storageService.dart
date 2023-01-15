import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fahkapmobile/model/data/UserModel.dart';
import 'package:jwt_decode/jwt_decode.dart';

mixin StorageService {
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
    print(key);
    await this.saveKey(Jwt.parseJwt(key['token'])['keySecret']);
  }

  getKeyKen() {
    return this.find('keyKen');
  }

  Future<void> saveKey(String key) async {
    await _box.write('keySecret', key);
  }

  Future<void> saveLonLat(key) async {
    await this.save('long', key['longitude']);
    await this.save('lat', key['latitude']);
  }

    getLonLat() async {
    return {
      'long': this.find('long'),
      'lat': this.find('lat')
    };
  }

  String getKey() {
    return this.find('keySecret').toString();
  }
}
