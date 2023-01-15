// To parse this JSON data, do
//
//     final livreurModel = livreurModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LivreurModel livreurModelFromJson(String str) =>
    LivreurModel.fromJson(json.decode(str));

String livreurModelToJson(LivreurModel data) => json.encode(data.toJson());

class LivreurModel {
  LivreurModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.phone,
    required this.distance,
  });

  int id;
  String nom;
  String prenom;
  String phone;
  int distance;

  factory LivreurModel.fromJson(Map<String, dynamic> json) => LivreurModel(
      id: json["id"],
      nom: json["nom"],
      prenom: json["prenom"],
      phone: json["phone"],
      distance: json["distance"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "phone": phone,
        "distance": distance,
      };
}
