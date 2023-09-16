/* 
import 'dart:io';
import 'dart:async';

import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/GeneralController.dart';
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
  String linkDb = 'FahKap6.db';
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
       profile String,
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
        "profile": User.profile,
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
 

  getListCommande() async {
  
    var data = await _database!.rawQuery('SELECT * FROM COMMANDE');
    
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
   
  }
 

  saveKeyKen(key) async {
    try {
     
      var data = await _database!.rawQuery('SELECT * FROM KEYUSER');
     
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
    
      var data = await _database!.rawQuery('SELECT * FROM LOCALISATION');
     
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
   
    var data = await _database!.rawQuery('SELECT * FROM LOCALISATION');
   
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
  
    var data = await _database!.rawQuery('SELECT * FROM KEYUSER');
    
    if (data.isNotEmpty) {
      return /* {'keySecret':  */ data[0]['keySecret'] /* } */;
    } else {
      return null;
    }
  }

  saveLan(String name) async {
    try {
    
      var data = await _database!.rawQuery('SELECT * FROM LANG');
      
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
    
    try {
      var data = await _database!.rawQuery('SELECT * FROM LANG');

      //print(data);
      if (data.isNotEmpty) {
        var name = data[0]['name'].toString();
        return name;
        // Get.find<GeneralController>().getLanguage0(name);
      } else {
        return '';
      }
    } catch (e) {
      //print(e);
    }
  }

  getLanIs() async {
    
    try {
      var data = await _database!.rawQuery('SELECT * FROM LANG');
     
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
    
      return true;
    } catch (e) {
      return false;
    }
  }

  getTheme() async {
    
    try {
      if (_database != null) {
        var data = await _database!.rawQuery('SELECT * FROM THEME');

        //print(data);
        if (data.isNotEmpty) {
          var value = data[0]['value'].toString();
          return value;
        
        } else {
          return null;
        }
      }
    } catch (e) {
     
    }
  }
}
 */
 
import 'dart:async';
 
import 'package:EMIY/controller/entity.dart'; 
import 'package:EMIY/objectbox.g.dart'; 
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; 
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import 'package:path/path.dart';

String linkDb = 'FahKap0';

GetStorage box = GetStorage();

class DataBaseController extends GetxController {
  late final Store store;

  // Le constructeur est privé pour empêcher l'instanciation directe
  DataBaseController._create(this.store);

  // Instance unique du DataBaseController
  static DataBaseController? _instance;

  // Méthode pour obtenir l'instance unique du DataBaseController
  static Future<DataBaseController> getInstance() async {
    if (_instance == null) {
      _instance = await _createInstance();
    }
    return _instance!;
  }

  // Méthode interne pour créer l'instance du DataBaseController
  static Future<DataBaseController> _createInstance() async {
    final docsDir = await getApplicationDocumentsDirectory();

    // Vérifier si le store existe déjà dans GetStorage
    // if (box.read('store') != 1) {
    //   box.write('store', 1);
    final store = await openStore(directory: p.join(docsDir.path, linkDb));
    return DataBaseController._create(store);
    //  }s
  }

  // Insert operation
  insertCommande(int id, String codeCommande, String codeClient, String date) {
    final commandeBox = store.box<Commande>();
    store.box<Commande>().put(Commande(
        id: commandeBox.query().build().find().length + 1,
        codeCommande: codeCommande,
        codeClient: codeClient,
        date: date));
    return true;
  }

  saveUser(User user) async {
    print('----------------saveeeeeee');
    store.box<User>().put(user);
    return true;
  }

  // Get operations
  User? getUser() {
    final userBox = store.box<User>();
    final users = userBox.getAll();
    print(users.length);
    return users.isNotEmpty ? users.first : null;
  }

  List<Commande> getListCommande() {
    final commandeBox = store.box<Commande>();
    // commandeBox.query().build().find().forEach((e) => print(e.codeCommande));
    return commandeBox.query().build().find();
  }

  Future<Map<String, dynamic>?> getLonLat() async {
    final localisationBox = store.box<Localisation>();
    final localisations = localisationBox.getAll();
    return localisations.isNotEmpty ? localisations.first.toMap() : null;
  }

  saveLonLat(value) async {
    store.box<Localisation>().put(Localisation.fromJson(value));
    return true;
  }

  Future<Map<String, dynamic>?> getKeyKen() async {
    final keyUserBox = store.box<KeyUser>();
    final keyUsers = keyUserBox.getAll();
    return keyUsers.isNotEmpty ? keyUsers.first.toMap() : null;
  }

  saveKeyKen(value) async {
    store.box<KeyUser>().put(KeyUser.fromJson(value));
    return true;
  }

  Future<String?> getKey() async {
    final keyUserBox = store.box<KeyUser>();
    final keyUsers = keyUserBox.getAll();
    return keyUsers.isNotEmpty ? keyUsers.first.keySecret : null;
  }

  Future<String?> getLan() async {
    final langBox = store.box<Lang>();
    final langs = langBox.getAll();
    return langs.isNotEmpty ? langs.first.name : null;
  }

  getLanIs() async {
    final langBox = store.box<Lang>();
    return langBox.count() > 0;
  }

  saveLan(value) async {
    store.box<Lang>().put(Lang(
          name: value,
        ));
    return true;
  }

  Future<String?> getTheme() async {
    final themeBox = store.box<Theme>();
    final themes = themeBox.getAll();
    return themes.isNotEmpty ? themes.first.value.toString() : null;
  }

  saveTheme(value) async {
    store.box<Theme>().put(Theme(
          value: value,
        ));
    return true;
  }
  // ... autres méthodes

  // InsertAll operation
  insertAllCommandes() {
    var j = 8;
    for (var i = 10; i < 100; i++) {
      // final commandeBox =;
      print('-------ii--${i}');
      store.box<Commande>().put(Commande(
          codeCommande: 'codeCommande$i', codeClient: '', date: 'date$i'));
      j = i;
      update();
    }
    return true;
  }

  // Delete operation
  Future<void> deleteAll() async {
    await Box<User>(store).removeAll();
    await Box<KeyUser>(store).removeAll();
    final databasesPath = await getApplicationDocumentsDirectory();
    final path = join(databasesPath.path, "obx-example");
    await databaseFactory.deleteDatabase(path);
    store.close();

    store = await openStore(directory: path);
  }
}
