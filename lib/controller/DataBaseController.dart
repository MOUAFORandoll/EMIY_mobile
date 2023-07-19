import 'dart:io';
import 'dart:async';

import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/model/data/UserModel.dart';
import 'package:EMIY/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DataBaseController extends GetxController {
  String linkDb = 'FahKap5.db';
  // ignore: unused_field
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await init();
    return _database!;
  }

  // GetStorage box = GetStorage();
  Future<Database> init() async {
    Directory databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, linkDb);

    _database = await openDatabase(path, version: 1,
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
       codeCommunication String, 
       token String,
       codeParrainnage String,
        refreshToken String
       
      )""");
      await db.execute("""CREATE TABLE IF NOT EXISTS USER (
       id INTEGER,
       
       nom String, 
       prenom String, 
       email String,
        phone INTEGER,
        dateCreated String
       
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
    //print("La bd a ete cree");
    //print(_database);
    //print("Go next");

    return _database!;
  }

  insert(id, codeCommande, codeClient, date) async {
    try {
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _database = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var a = await _database!.insert("COMMANDE", {
        "id": id,
        "codeCommande": codeCommande,
        "codeClient": codeClient,
        "date": date,
      });
      //print(a);
      return true;
    } catch (e) {
      return false;
    }
  }

  saveUser(UserModel User) async {
    try {
      var a = await _database!.insert("USER", {
        "id": User.id,
        "nom": User.nom,
        "prenom": User.prenom,
        "phone": User.phone,
        "email": User.email,
        "dateCreated": User.dateCreated,
      });
      print(a);
      return true;
    } catch (e) {
      return false;
    }
  }

  getUserDB() async {
    var data = await _database!.rawQuery('SELECT * FROM USER');
    if (data.length != 0) {
      print(data[0]);
      return data[0];
    } else {
      return null;
    }
  }

  insertAll() async {
    try {
      for (var i = 0; i < 10; i++) {
        var a = await _database!.insert("COMMANDE", {
          "id": i,
          "codeCommande": 'codeCommande${i}',
          "date": 'date${i}',
        });
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // insertTR(token, refresh, date) async {
  //   try {
  //     var a = await _database!.insert("User", {
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

    // Database _database = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _database!.rawQuery('SELECT * FROM COMMANDE');
    //print('com*****ta');
    //print(data);
    return data;
  }

  deleteAll() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, linkDb);

    Database _database = await openDatabase(
      path,
      version: 1,
    );
    databaseFactory.deleteDatabase(path);
    init();
    //print("fin delette");
  }

  // updateUser(data) async {
  //   var user = select();
  //   await _database!.update("User", data, where: 'id = ${user['id']}');
  //   var data1 = await _database!.rawQuery('SELECT * FROM User');
  //   //print("*---------------------------up date user $data1");
  // }

  saveKeyKen(key) async {
    try {
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _database = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var data = await _database!.rawQuery('SELECT * FROM KEYUSER');
      //print(data);
      if (data.isNotEmpty) {
        var a = await _database!.update(
            "KEYUSER",
            {
              "id": 0,
              "refreshToken": key['refreshToken'],
              "codeParrainnage": Jwt.parseJwt(key['token'])['codeParrainnage'],
              "token": key['token'],
              "keySecret": Jwt.parseJwt(key['token'])['keySecret'],
              "codeCommunication":
                  Jwt.parseJwt(key['token'])['codeCommunication'],
            },
            where: 'id= ?',
            whereArgs: [0]);
      } else {
        var a = await _database!.insert("KEYUSER", {
          "id": 0,
          "refreshToken": key['refreshToken'],
          "codeParrainnage": Jwt.parseJwt(key['token'])['codeParrainnage'],
          "token": key['token'],
          "codeCommunication": Jwt.parseJwt(key['token'])['codeCommunication'],
          "keySecret": Jwt.parseJwt(key['token'])['keySecret'],
        });
      }
      // //print(a);
      return true;
    } catch (e) {
      return false;
    }
  }

  saveLonLat(key) async {
    try {
      // var databasesPath = await getApplicationDocumentsDirectory();
      // String path = join(databasesPath.path, linkDb);

      // Database _database = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var data = await _database!.rawQuery('SELECT * FROM LOCALISATION');
      //print(data);
      if (data.isNotEmpty) {
        var a = await _database!.update(
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
        var a = await _database!.insert("LOCALISATION", {
          "id": 0,
          "ville": key['ville'],
          "long": key['longitude'],
          "lat": key['latitude'],
          "ip": key['ip'],
        });
        //print(a);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  getLonLat() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(databasesPath.path, linkDb);

    // Database _database = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _database!.rawQuery('SELECT * FROM LOCALISATION');
    //print('***************data[0]');
    //print(data);
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

    // Database _database = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _database!.rawQuery('SELECT * FROM KEYUSER');
    if (data.isNotEmpty) {
      print({
        "id": 0,
        'token': data[0]['token'],
        'refreshToken': data[0]['refreshToken'],
        "codeCommunication": data[0]['codeCommunication'],
        "codeParrainnage": data[0]['codeParrainnage'],
      });
      return {
        "id": 0,
        'token': data[0]['token'],
        'refreshToken': data[0]['refreshToken'],
        "codeCommunication": data[0]['codeCommunication'],
        "codeParrainnage": data[0]['codeParrainnage'],
      };
    } else {
      return null;
    }
  }

  getKey() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(databasesPath.path, linkDb);

    // Database _database = await openDatabase(
    //   path,
    //   version: 1,
    // );
    var data = await _database!.rawQuery('SELECT * FROM KEYUSER');
    // //print(data);
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

      // Database _database = await openDatabase(
      //   path,
      //   version: 1,
      // );
      var data = await _database!.rawQuery('SELECT * FROM LANG');
      //print(
      // ' ${data}lan----------------------------****************************************');

      if (data.isNotEmpty) {
        var a = await _database!.update(
            "LANG",
            {
              "id": 0,
              "name": name,
            },
            where: 'id= ?',
            whereArgs: [0]);
      } else {
        var a = await _database!.insert("LANG", {
          "id": 0,
          "name": name,
        });
      }
      var data0 = await _database!.rawQuery('SELECT * FROM LANG');
      //print(
      // ' ${data0}lan----------------------------****************************************');

      return true;
    } catch (e) {
      return false;
    }
  }

  getLan() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(await getDatabasesPath(), linkDb);

    // Database _database = await openDatabase(
    //   path,
    //   version: 1,
    // );
    try {
      var data = await _database!.rawQuery('SELECT * FROM LANG');

      //print(data);
      if (data.isNotEmpty) {
        var name = data[0]['name'].toString();
        return name;
        // Get.find<ActionController>().getLanguage0(name);
      } else {
        return '';
      }
    } catch (e) {
      //print(e);
    }
  }

  getLanIs() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(await getDatabasesPath(), linkDb);

    // Database _database = await openDatabase(
    //   path,
    //   version: 1,
    // );
    try {
      var data = await _database!.rawQuery('SELECT * FROM LANG');
      //print(
      // 'lan----------------------------****************************************');
      // print(data);
      return data.isNotEmpty;
    } catch (e) {
      //print(e);
    }
  }

  saveTheme(String val) async {
    try {
      var databasesPath = await getApplicationDocumentsDirectory();
      String path = join(databasesPath.path, linkDb);

      Database _database = await openDatabase(
        path,
        version: 1,
      );
      var data = await _database.rawQuery('SELECT * FROM THEME');
      //print(
      // ' ${data}lan----------------------------****************************************');

      if (data.isNotEmpty) {
        var a = await _database.update(
            "THEME",
            {
              "id": 0,
              "value": val,
            },
            where: 'id= ?',
            whereArgs: [0]);
      } else {
        var a = await _database.insert("THEME", {
          "id": 0,
          "value": val,
        });
      }
      var data0 = await _database.rawQuery('SELECT * FROM THEME');
      //print(
      // ' ${data0}lan----------------------------****************************************');

      return true;
    } catch (e) {
      return false;
    }
  }

  getTheme() async {
    // var databasesPath = await getApplicationDocumentsDirectory();
    // String path = join(await getDatabasesPath(), linkDb);

    // Database _database = await openDatabase(
    //   path,
    //   version: 1,
    // );
    try {
      if (_database != null) {
        var data = await _database!.rawQuery('SELECT * FROM THEME');

        //print(data);
        if (data.isNotEmpty) {
          var value = data[0]['value'].toString();
          return value;
          // Get.find<ActionController>().getLanguage0(name);
        } else {
          return null;
        }
      }
    } catch (e) {
      //print(e);
    }
  }
}
