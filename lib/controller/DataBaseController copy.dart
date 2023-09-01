// import 'dart:io';
// import 'dart:async';

// import 'package:EMIY/controller/GeneralController.dart';
// import 'package:EMIY/controller/GeneralController.dart';
// import 'package:EMIY/controller/managerController.dart';
// import 'package:EMIY/entity.dart';
// import 'package:EMIY/model/data/UserModel.dart';
// import 'package:EMIY/objectbox.g.dart';
// import 'package:EMIY/utils/Services/dependancies.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:jwt_decode/jwt_decode.dart';
// import 'package:objectbox/objectbox.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' as p;

// import 'package:path/path.dart';

// String linkDb = 'FahKap6.db';

// class DataBaseController {
//   /// The Store of this app.
//   late final Store store;

//   DataBaseController._create(this.store) {
//     // Add any additional setup code, e.g. build queries.
//   }

//   /// Create an instance of DataBaseController to use throughout the app.
//   static Future<DataBaseController> create() async {
//     final docsDir = await getApplicationDocumentsDirectory();
//     // Future<Store> openStore() {...} is defined in the generated DataBaseController.g.dart
//     final store = await openStore(directory: p.join(docsDir.path, linkDb));
//     return DataBaseController._create(store);
//   }

//   // Insert operation
//   insertCommande(int id, String codeCommande, String codeClient, String date) {
//     store.box<Commande>().put(Commande(
//         codeCommande: codeCommande, codeClient: codeClient, date: date));
//     return true;
//   }

//   saveUser(User user) async {
//     store.box<User>().put(user);
//     return true;
//   }

//   // Get operations
//   Future<User?> getUser() async {
//     final userBox = store.box<User>();
//     final users = userBox.getAll();
//     return users.isNotEmpty ? users.first : null;
//   }

//   Future<List<Commande>> getListCommande() async {
//     final commandeBox = store.box<Commande>();
//     return commandeBox.query().build().find();
//   }

//   Future<Map<String, dynamic>?> getLonLat() async {
//     final localisationBox = store.box<Localisation>();
//     final localisations = localisationBox.getAll();
//     return localisations.isNotEmpty ? localisations.first.toMap() : null;
//   }

//   Future<Map<String, dynamic>?> getKeyKen() async {
//     final keyUserBox = store.box<KeyUser>();
//     final keyUsers = keyUserBox.getAll();
//     return keyUsers.isNotEmpty ? keyUsers.first.toMap() : null;
//   }

//   Future<String?> getKey() async {
//     final keyUserBox = store.box<KeyUser>();
//     final keyUsers = keyUserBox.getAll();
//     return keyUsers.isNotEmpty ? keyUsers.first.keySecret : null;
//   }

//   Future<String?> getLan() async {
//     final langBox = store.box<Lang>();
//     final langs = langBox.getAll();
//     return langs.isNotEmpty ? langs.first.name : null;
//   }

//   getLanIs() async {
//     final langBox = store.box<Lang>();
//     return langBox.count() > 0;
//   }

//   Future<String?> getTheme() async {
//     final themeBox = store.box<Theme>();
//     final themes = themeBox.getAll();
//     return themes.isNotEmpty ? themes.first.value.toString() : null;
//   }

//   // ... autres méthodes

//   // InsertAll operation
//   insertAllCommandes() async {
//     try {
//       final commandeBox = store.box<Commande>();
//       for (var i = 0; i < 10; i++) {
//         commandeBox.put(Commande(
//             codeCommande: 'codeCommande$i', codeClient: '', date: 'date$i'));
//       }
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   // Delete operation
//   Future<void> deleteAll() async {
//     final databasesPath = await getApplicationDocumentsDirectory();
//     final path = join(databasesPath.path, "obx-example");
//     await databaseFactory.deleteDatabase(path);
//     store.close();
//     store = await openStore(directory: path);
//   }
// }
