// import 'package:connectivity/connectivity.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class User {
//   final int id;
//   final String name;
//   final int age;

//   User({required this.id, required this.name, required this.age});
// }

// class UserController extends GetxController {
//   late Database _database;

//   final _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _initDatabase();

//     _connectivity.onConnectivityChanged.listen((event) async {
//       if (event != ConnectivityResult.none) {
//         await syncUsers();
//       }
//     });
//   }

//   Future<void> _initDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'my_database.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
//         );
//       },
//       version: 1,
//     );
//   }

//   Future<List<User>> getUsers() async {
//     final List<Map<String, dynamic>> maps = await _database.query('users');
//     return List.generate(maps.length, (i) {
//       return User(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         age: maps[i]['age'],
//       );
//     });
//   }

//   Future<void> insertUser(User user) async {
//     await _database.insert('users', user.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<void> updateUser(User user) async {
//     await _database
//         .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
//   }

//   Future<void> deleteUser(int id) async {
//     await _database.delete('users', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<void> syncUsers() async {
//     try {
//       final apiUsers = await _userService.getUsers();
//       final localUsers = await getUsers();

//       // Compare les données locales avec les données de l'API
//       for (final apiUser in apiUsers) {
//         final localUser =
//             localUsers.firstWhereOrNull((u) => u.id == apiUser.id);

//         if (localUser != null) {
//           // Si l'utilisateur existe déjà localement, mettez à jour les données
//           updateUser(UserLocal(
//             id: apiUser.id,
//             name: apiUser.name,
//             age: apiUser.age,
//           ));
//         } else {
//           // Si l'utilisateur n'existe pas encore localement, insérez-le
//           insertUser(UserLocal(
//             id: apiUser.id,
//             name: apiUser.name,
//             age: apiUser.age,
//           ));
//         }
//       }

//       // Supprime les utilisateurs locaux qui ne sont plus présents dans l'API
//       for (final localUser in localUsers) {
//         final apiUser = apiUsers.firstWhereOrNull((u) => u.id == localUser.id);

//         if (apiUser == null) {
//           deleteUser(localUser.id);
//         }
//       }
//     } catch (e) {
//       // Gérer les erreurs de connexion
//       //print('Error syncing users: $e');
//     }
//   }
// }
