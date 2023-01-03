// To parse this JSON data, do
//
//     final produitBoutiqueModel = produitBoutiqueModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProduitBoutiqueModel produitBoutiqueModelFromJson(String str) =>
    ProduitBoutiqueModel.fromJson(json.decode(str));

String produitBoutiqueModelToJson(ProduitBoutiqueModel data) =>
    json.encode(data.toJson());

class ProduitBoutiqueModel {
  ProduitBoutiqueModel({
    required this.id,
    required this.codeProduit,
    required this.titre,
    required this.quantite,
    required this.prix,
    required this.description,
    required this.status,
    required this.date,
    required this.images,
  });

  int id;
  String codeProduit;
  String titre;
  int quantite;
  int prix;
  String description;
  bool status;
  String date;
  List<Image> images;

  factory ProduitBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      ProduitBoutiqueModel(
        id: json["id"],
        codeProduit: json["codeProduit"],
        titre: json["titre"],
        quantite: json["quantite"],
        prix: json["prix"],
        description: json["description"],
        status: json["status"],
        date: json["date "],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codeProduit": codeProduit,
        "titre": titre,
        "quantite": quantite,
        "prix": prix,
        "description": description,
        "status": status,
        "date ": date,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.id,
    required this.src,
  });

  int id;
  String src;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}
