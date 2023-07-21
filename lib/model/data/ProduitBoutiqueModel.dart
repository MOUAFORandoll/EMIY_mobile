// To parse this JSON data, do
//
//     final produitBoutiqueModel = produitBoutiqueModelFromJson(jsonString);

import 'package:EMIY/utils/Services/apiUrl.dart';
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
    required this.islike,
    required this.like,
    required this.description,
    required this.status,
    required this.date,
    required this.lienProduit,
    required this.images,
  });

  int id;
  String codeProduit;
  String titre;
  int quantite;
  int prix;
  final int like;
  final bool islike;
  final String lienProduit;
  String description;
  bool status;
  String date;
  List<ImageU> images;

  factory ProduitBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      ProduitBoutiqueModel(
        id: json["id"],
        codeProduit: json["codeProduit"],
        lienProduit: ApiUrl.external_link + 'produits/' + json["codeProduit"],
        titre: json["titre"],
        quantite: json["quantite"],
        like:
            int.parse((json["like"] == null ? null : json["like"]).toString()),
        islike: json["islike"] == null ? null : json["islike"],
        prix: json["prix"],
        description: json["description"],
        status: json["status"],
        date: json["date "],
        images:
            List<ImageU>.from(json["images"].map((x) => ImageU.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codeProduit": codeProduit,
        "titre": titre,
        "quantite": quantite,
        "prix": prix,
        "like": like == null ? null : double.parse(like.toString()),
        "islike": islike == null ? null : islike,
        "description": description,
        "status": status,
        "date ": date,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImageU {
  ImageU({
    required this.id,
    required this.src,
  });

  int id;
  String src;

  factory ImageU.fromJson(Map<String, dynamic> json) => ImageU(
        id: json["id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}
