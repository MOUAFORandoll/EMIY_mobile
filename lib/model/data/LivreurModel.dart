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
    required this.localisation,
  });

  int id;
  String nom;
  String prenom;
  String phone;
  Localisation localisation;

  factory LivreurModel.fromJson(Map<String, dynamic> json) => LivreurModel(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        phone: json["phone"],
        localisation: Localisation.fromJson(json["localisation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "phone": phone,
        "localisation": localisation.toJson(),
      };
}

class Localisation {
  Localisation({
    required this.distance,
  });

  String distance;

  factory Localisation.fromJson(Map<String, dynamic> json) => Localisation(
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
      };
}
