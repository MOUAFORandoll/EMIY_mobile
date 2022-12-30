import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fahkapmobile/model/data/UserModel.dart';

class StorageService extends GetxService {
  late GetStorage _box;

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

  UserModel getUser() {
    return jsonDecode(this.find('user'));
  }
}
