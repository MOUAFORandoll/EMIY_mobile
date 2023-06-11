// To parse this JSON data, do
//
//     final produitCategoryModel = produitCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProduitCategoryModel produitCategoryModelFromJson(String str) =>
    ProduitCategoryModel.fromJson(json.decode(str));

String produitCategoryModelToJson(ProduitCategoryModel data) =>
    json.encode(data.toJson());

class ProduitCategoryModel {
  ProduitCategoryModel({
    required this.id,
    required this.codeProduit,
    required this.boutique,
    required this.description,
    required this.titre,
    required this.quantite,
    required this.prix,
    required this.islike,
    required this.like,
    required this.status,
    required this.images,
  });

  final String codeProduit;
  final String boutique;
  final String description;
  final String titre;
  final int quantite;
  final int id;
  final int prix;
  final int like;
  final bool islike;
  final bool status;
  final List<ImageU> images;

  factory ProduitCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProduitCategoryModel(
        id: json["id"] == null ? null : json["id"],
        codeProduit: json["codeProduit"] == null ? null : json["codeProduit"],
        boutique: json["boutique"] == null ? null : json["boutique"],
        description: json["description"] == null ? null : json["description"],
        titre: json["titre"] == null ? null : json["titre"],
      like:
            int.parse((json["like"] == null ? null : json["like"]).toString()),
        islike: json["islike"] == null ? null : json["islike"],
          quantite: json["quantite"] == null ? null : json["quantite"],
        prix: json["prix"] == null ? null : json["prix"],
        status: json["status"] == null ? null : json["status"],
        images: json["images"] == null
            ? []
            : List<ImageU>.from(json["images"].map((x) => ImageU.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "codeProduit": codeProduit == null ? null : codeProduit,
        "boutique": boutique == null ? null : boutique,
        "description": description == null ? null : description,
        "like": like == null ? null : double.parse(like.toString()),
        "titre": titre == null ? null : titre,
        "islike": islike == null ? null : islike,
        "quantite": quantite == null ? null : quantite,
        "prix": prix == null ? null : prix,
        "status": status == null ? null : status,
        "images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImageU {
  ImageU({
    required this.id,
    required this.src,
  });

  final int id;
  final String src;

  factory ImageU.fromJson(Map<String, dynamic> json) => ImageU(
        id: json["id"] == null ? null : json["id"],
        src: json["src"] == null ? null : json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "src": src == null ? null : src,
      };
}
