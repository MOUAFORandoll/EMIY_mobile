// import 'package:jwt_decode/jwt_decode.dart';
// import 'package:objectbox/objectbox.dart';

// @Entity()
// class YourDataModel {
//   int id;
//   String name;

//   YourDataModel({this.id = 0, required this.name});
// }

// @Entity()
// class Second {
//   int id;
//   String name;

//   Second({this.id = 0, required this.name});
// }

// @Entity()
// class User {
//   int id = 0;

//   @Property()
//   String nom;

//   @Property()
//   String prenom;

//   @Property()
//   String email;

//   @Property()
//   String profile;

//   @Property()
//   int phone;

//   @Property()
//   String dateCreated;

//   User({
//     required this.nom,
//     required this.prenom,
//     required this.email,
//     required this.profile,
//     required this.phone,
//     required this.dateCreated,
//   });
//   Map<String, dynamic> toMap() {
//     return {
//       'nom': nom,
//       'prenom': prenom,
//       'email': email,
//       'profile': profile,
//       'phone': phone,
//       'dateCreated': dateCreated,
//     };
//   }

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       nom: json['nom'],
//       prenom: json['prenom'],
//       email: json['email'],
//       profile: json['profile'],
//       phone: json['phone'],
//       dateCreated: json['dateCreated'],
//     );
//   }
// }

// @Entity()
// class Lang {
//   int id = 0;

//   @Property()
//   String name;

//   Lang({required this.name});
// }

// @Entity()
// class Theme {
//   int id = 0;

//   @Property()
//   int value;

//   Theme({required this.value});
// }

// @Entity()
// class Localisation {
//   int id = 0;

//   @Property()
//   String ville;

//   @Property()
//   String long;

//   @Property()
//   String lat;

//   @Property()
//   String ip;

//   Localisation({
//     required this.ville,
//     required this.long,
//     required this.lat,
//     required this.ip,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'ville': ville,
//       'long': long,
//       'lat': lat,
//       'ip': ip,
//     };
//   }

//   factory Localisation.fromJson(Map<String, dynamic> json) {
//     return Localisation(
//       ville: json['ville'],
//       long: json['long'],
//       lat: json['lat'],
//       ip: json['ip'],
//     );
//   }
// }

// @Entity()
// class Commande {
//   int id = 0;

//   @Property()
//   String codeCommande;

//   @Property()
//   String codeClient;

//   @Property()
//   String date;

//   Commande(
//       {required this.codeCommande,
//       required this.codeClient,
//       required this.date});

//   Map<String, dynamic> toMap() {
//     return {
//       'codeCommande': codeCommande,
//       'codeClient': codeClient,
//       'date': date,
//     };
//   }

//   factory Commande.fromJson(Map<String, dynamic> json) {
//     return Commande(
//       codeCommande: json['codeCommande'],
//       codeClient: json['codeClient'],
//       date: json['date'],
//     );
//   }
// }

// @Entity()
// class KeyUser {
//   int id = 0;

//   @Property()
//   String keySecret;

//   @Property()
//   String codeCommunication;

//   @Property()
//   String token;

//   @Property()
//   String codeParrainnage;

//   @Property()
//   String refreshToken;

//   KeyUser({
//     required this.keySecret,
//     required this.codeCommunication,
//     required this.token,
//     required this.codeParrainnage,
//     required this.refreshToken,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'keySecret': keySecret,
//       'codeCommunication': codeCommunication,
//       'token': token,
//       'codeParrainnage': codeParrainnage,
//       'refreshToken': refreshToken,
//     };
//   }

//   factory KeyUser.fromJson(Map<String, dynamic> json) {
//     return KeyUser(
//       keySecret: Jwt.parseJwt(json['token'])['keySecret'],
//       codeCommunication: Jwt.parseJwt(json['token'])['codeCommunication'],
//       token: json['token'],
//       codeParrainnage: Jwt.parseJwt(json['token'])['codeParrainnage'],
//       refreshToken: json['refreshToken'],
//     );
//   }
// }
