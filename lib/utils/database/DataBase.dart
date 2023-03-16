import 'dart:io';
import 'dart:async';

import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DB {
  String linkDb = 'FahKap10.db';
  // ignore: unused_field
  Database? _db;

  // GetStorage box = GetStorage();
  Future<Database> init() async {
    Directory databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, linkDb);

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE IF NOT EXISTS COMMANDE (
       id INTEGER,
       codeCommande String, 
       codeClient String,
       date String
      )""");

      await db.execute("""CREATE TABLE IF NOT EXISTS KEYUSER (
       id INTEGER,
       
       keySecret String, 
       token String,
        refreshToken String
       
      )""");

      await db.execute("""CREATE TABLE IF NOT EXISTS LANG (
      
       id INTEGER,
       
       name String
     
       
      )""");

      await db.execute("""CREATE TABLE IF NOT EXISTS THEME (
      
       id INTEGER,
       
       value INTEGER
     
       
      )""");

      await db.execute("""CREATE TABLE IF NOT EXISTS  LOCALISATION (
      
       id INTEGER,
       
       ville String, 
       long String,
        lat String,
        ip String
       
      )""");
    });
    print("La bd a ete cree");
    print(_db);
    print("Go next");

    return _db!;
  }

  insert(id, codeCommande, codeClient, date) async {
    try {
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _db = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var a = await _db!.insert("COMMANDE", {
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
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _db = await openDatabase(
      //   path,
      //   version: 1,
      // );
      for (var i = 0; i < 10; i++) {
        var a = await _db!.insert("COMMANDE", {
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
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(databasesPath.path, linkDb);

    // Database _db = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _db!.rawQuery('SELECT * FROM COMMANDE');
    print('com*****ta');
    print(data);
    return data;
  }

  deleteAll() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, linkDb);

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

  saveKeyKen(key) async {
    try {
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _db = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var data = await _db!.rawQuery('SELECT * FROM KEYUSER');
      print(data);
      if (data.isNotEmpty) {
        var a = await _db!.update(
            "KEYUSER",
            {
              "id": 0,
              "refreshToken": key['refreshToken'],
              "token": key['token'],
              "keySecret": Jwt.parseJwt(key['token'])['keySecret'],
            },
            where: 'id= ?',
            whereArgs: [0]);
      } else {
        var a = await _db!.insert("KEYUSER", {
          "id": 0,
          "refreshToken": key['refreshToken'],
          "token": key['token'],
          "keySecret": Jwt.parseJwt(key['token'])['keySecret'],
        });
      }
      // print(a);
      return true;
    } catch (e) {
      return false;
    }
  }

  saveLonLat(key) async {
    try {
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _db = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var data = await _db!.rawQuery('SELECT * FROM LOCALISATION');
      print(data);
      if (data.isNotEmpty) {
        var a = await _db!.update(
            "LOCALISATION",
            {
              "id": 0,
              "ville": key['ville'],
              "long": key['longitude'],
              "lat": key['latitude'],
              "ip": key['ip'],
            },
            where: 'id= ?',
            whereArgs: [0]);
      } else {
        var a = await _db!.insert("LOCALISATION", {
          "id": 0,
          "ville": key['ville'],
          "long": key['longitude'],
          "lat": key['latitude'],
          "ip": key['ip'],
        });
        print(a);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  getLonLat() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(databasesPath.path, linkDb);

    // Database _db = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _db!.rawQuery('SELECT * FROM LOCALISATION');
    print('***************data[0]');
    print(data);
    if (data.isNotEmpty) {
      return {
        "id": 0,
        'long': data[0]['long'],
        'lat': data[0]['lat'],
        'ville': data[0]['ville']
      };
    } else {
      Get.find<ManagerController>().newLocalisation();

      getLonLat();
    }
  }

  getKeyKen() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(databasesPath.path, linkDb);

    // Database _db = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _db!.rawQuery('SELECT * FROM KEYUSER');
    if (data.isNotEmpty) {
      return {
        "id": 0,
        'token': data[0]['token'],
        'refreshToken': data[0]['refreshToken']
      };
    } else {
      return '';
    }
  }

  getKey() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(databasesPath.path, linkDb);

    // Database _db = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _db!.rawQuery('SELECT * FROM KEYUSER');
    // print(data);
    if (data.isNotEmpty) {
      return /* {'keySecret':  */ data[0]['keySecret'] /* } */;
    } else {
      return null;
    }
  }

  saveLan(String name) async {
    try {
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _db = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var data = await _db!.rawQuery('SELECT * FROM LANG');
      print(
          ' ${data}lan----------------------------****************************************');

      if (data.isNotEmpty) {
        var a = await _db!.update(
            "LANG",
            {
              "id": 0,
              "name": name,
            },
            where: 'id= ?',
            whereArgs: [0]);
      } else {
        var a = await _db!.insert("LANG", {
          "id": 0,
          "name": name,
        });
      }
      var data0 = await _db!.rawQuery('SELECT * FROM LANG');
      print(
          ' ${data0}lan----------------------------****************************************');

      return true;
    } catch (e) {
      return false;
    }
  }

  getLan() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(await getDatabasesPath(), linkDb);

    // Database _db = await openDatabase(
    //   path,
    //   version: 1,
    // );
    try {
      var data = await _db!.rawQuery('SELECT * FROM LANG');

      print(data);
      if (data.isNotEmpty) {
        var name = data[0]['name'].toString();
        return name;
        // Get.find<ActionController>().getLanguage0(name);
      } else {
        return '';
      }
    } catch (e) {
      print(e);
    }
  }

  getLanIs() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(await getDatabasesPath(), linkDb);

    // Database _db = await openDatabase(
    //   path,
    //   version: 1,
    // );
    try {
      var data = await _db!.rawQuery('SELECT * FROM LANG');
      print(
          'lan----------------------------****************************************');
      print(data);
      return data.isNotEmpty;
    } catch (e) {
      print(e);
    }
  }

  saveTheme(String val) async {
    try {
      var databasesPath = await getApplicationDocumentsDirectory();
      String path = join(databasesPath.path, linkDb);

      Database _db = await openDatabase(
        path,
        version: 1,
      );
      var data = await _db.rawQuery('SELECT * FROM THEME');
      print(
          ' ${data}lan----------------------------****************************************');

      if (data.isNotEmpty) {
        var a = await _db.update(
            "THEME",
            {
              "id": 0,
              "value": val,
            },
            where: 'id= ?',
            whereArgs: [0]);
      } else {
        var a = await _db.insert("THEME", {
          "id": 0,
          "value": val,
        });
      }
      var data0 = await _db.rawQuery('SELECT * FROM THEME');
      print(
          ' ${data0}lan----------------------------****************************************');

      return true;
    } catch (e) {
      return false;
    }
  }

  getTheme() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(await getDatabasesPath(), linkDb);

    // Database _db = await openDatabase(
    //   path,
    //   version: 1,
    // );
    try {
      var data = await _db!.rawQuery('SELECT * FROM THEME');

      print(data);
      if (data.isNotEmpty) {
        var value = data[0]['value'].toString();
        return value;
        // Get.find<ActionController>().getLanguage0(name);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
