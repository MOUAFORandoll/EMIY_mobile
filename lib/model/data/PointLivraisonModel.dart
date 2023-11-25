// To parse this JSON data, do
//
//     final PointLivraisonModel = PointLivraisonModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PointLivraisonModel {
  PointLivraisonModel({
    required this.id,
    required this.libelle,
    required this.ville,
    required this.quartier,
    required this.image,
    required this.longitude,
    required this.latitude,
  });

  final int id;
  final String libelle;
  final String ville;
  final String quartier;
  final String image;
  final longitude;
  final latitude;

  factory PointLivraisonModel.fromJson(Map<String, dynamic> json) =>
      PointLivraisonModel(
        id: json["id"] == null ? null : json["id"],
        latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"].toString()),
        longitude: json["longitude"] == null
            ? null
            : double.parse(json["longitude"].toString()),
        libelle: json["libelle"] == null ? null : json["libelle"],
        ville: json["ville"] == null ? null : json["ville"],
        quartier:
            (json["quartier"] == null ? null : json["quartier"]).toString(),
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "ville": ville == null ? null : ville,
        "libelle": libelle == null ? null : libelle,
        "quartier": quartier == null ? null : quartier,
        "image": image == null ? null : image,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
