// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
//545
import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.phone,
    this.status = true,
    required this.profile,
    required this.dateCreated,
  });

  int id;
  String nom;
  String prenom;
  String email;
  String phone;
  bool status;
  String dateCreated;
  String profile;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        phone: json["phone"].toString(),
        status: json["status"],
        profile: json["profile"],
        dateCreated: json["dateCreated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "phone": phone,
        "status": status,
        "dateCreated": dateCreated,
        "profile": profile,
      };
}
