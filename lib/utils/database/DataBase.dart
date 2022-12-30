import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class UserBD {
  static Database? _db;
  GetStorage box = GetStorage();
  Future<Database> init() async {
    var databasesPath = await getApplicationDocumentsDirectory();

    String path = join(databasesPath.path, 'UserSession.db');

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE IF NOT EXISTS User (
      
       id INTEGER,
       nom String,
        prenom String,
       numero String, 
       token String,
       refreshToken String,
      )""");
    });
    print("La bd a ete cree");
    print(_db);
    print("Go next");

    return _db!;
  }

  insert(id, nom, prenom, phone, token, refreshToken) async {
    var a = await _db!.insert("", {
      "id": id,
      "nom": nom,
      "prenom": prenom,
      "numero": phone,
      "token": token,
      "refreshToken": refreshToken,
    });
  }

  select() async {
    var data = await _db!.rawQuery('SELECT * FROM User');
    return data[0];
  }

  deleteUser() async {
    var user = select();
    var delette0 = await _db!.delete("User", where: 'id =${user['id']}');

    print("fin delette");
  }

  updateUser(data) async {
    var user = select();
    await _db!.update("User", data, where: 'id = ${user['id']}');
    var data1 = await _db!.rawQuery('SELECT * FROM User');
    print("*---------------------------up date user $data1");
  }
}
