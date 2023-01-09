import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DB {
  GetStorage box = GetStorage();
  Future<Database?> init() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'FahKap.db');

    Database _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE IF NOT EXISTS COMMANDE (
      
       id INTEGER,
       codeCommande String, 
       codeClient String,
        date String
       
      )""");
    });
    print("La bd a ete cree");
    print(_db);
    print("Go next");

    return _db;
  }

  insert(id, codeCommande, codeClient, date) async {
    try {
      var databasesPath = await getApplicationDocumentsDirectory();
      String path = join(databasesPath.path, 'FahKap.db');

      Database _db = await openDatabase(
        path,
        version: 1,
      );
      var a = await _db.insert("COMMANDE", {
        "id": id,
        "codeCommande": codeCommande,
        "codeClient": codeClient,
        "date": date,
      });
      print(a);
      return true;
    } catch (e) {
      return false;
    }
  }

  insertAll() async {
    try {
      var databasesPath = await getApplicationDocumentsDirectory();
      String path = join(databasesPath.path, 'FahKap.db');

      Database _db = await openDatabase(
        path,
        version: 1,
      );
      for (var i = 0; i < 10; i++) {
        var a = await _db.insert("COMMANDE", {
          "id": i,
          "codeCommande": 'codeCommande${i}',
          "date": 'date${i}',
        });
        print(a);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // insertTR(token, refresh, date) async {
  //   try {
  //     var a = await _db!.insert("User", {
  //       "id": id,
  //       "codeCommande": codeCommande,
  //       "date": date,
  //     });
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  getListCommande() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'FahKap.db');

    Database _db = await openDatabase(
      path,
      version: 1,
    );
    var data = await _db.rawQuery('SELECT * FROM COMMANDE');
    print('com*****ta');
    print(data);
    return data;
  }

  deleteAll() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'FahKap.db');

    Database _db = await openDatabase(
      path,
      version: 1,
    );
    databaseFactory.deleteDatabase(path);
    init();
    print("fin delette");
  }

  // updateUser(data) async {
  //   var user = select();
  //   await _db!.update("User", data, where: 'id = ${user['id']}');
  //   var data1 = await _db!.rawQuery('SELECT * FROM User');
  //   print("*---------------------------up date user $data1");
  // }
}
