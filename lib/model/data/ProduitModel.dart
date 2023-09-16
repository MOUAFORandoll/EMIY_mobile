// To parse this JSON data, do
//
//     final produitModel = produitModelFromJson(jsonString);

import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'ImageModel.dart';

ProduitModel produitModelFromJson(String str) =>
    ProduitModel.fromJson(json.decode(str));

String produitModelToJson(ProduitModel data) => json.encode(data.toJson());

class ProduitModel {
  ProduitModel({
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
    required this.negociable,
    required this.images,
    required this.lienProduit,
  });

  final String codeProduit;
  final String boutique;
  final String description;
  final String titre;
  final String lienProduit;
  final int quantite;
  final int id;
  final int prix;
  int like;
  bool islike;
  final bool status;
  final bool negociable;
  final List<ImageModel> images;

  factory ProduitModel.fromJson(Map<String, dynamic> json) => ProduitModel(
        id: json["id"] == null ? null : json["id"],
        codeProduit: json["codeProduit"] == null ? null : json["codeProduit"],
        lienProduit: ApiUrl.external_link + 'produits/' + json["codeProduit"],
        boutique: json["boutique"] == null ? null : json["boutique"],
        description: json["description"] == null ? null : json["description"],
        titre: json["titre"] == null ? null : json["titre"],
        quantite: json["quantite"] == null ? null : json["quantite"],
        prix: json["prix"] == null ? null : json["prix"],
        like:
            int.parse((json["like"] == null ? null : json["like"]).toString()),
        islike: json["islike"] == null ? null : json["islike"],
        status: json["status"] == null ? null : json["status"],
        negociable: json["negociable"] == null ? null : json["negociable"],
        images: json["images"] == null
            ? []
            : List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "codeProduit": codeProduit == null ? null : codeProduit,
        "boutique": boutique == null ? null : boutique,
        "description": description == null ? null : description,
        "titre": titre == null ? null : titre,
        "quantite": quantite == null ? null : quantite,
        "prix": prix == null ? null : prix,
        "like": like == null ? null : double.parse(like.toString()),
        "status": status == null ? null : status,
        "islike": islike == null ? null : islike,
        "negociable": negociable == null ? null : negociable,
        "images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toJson())),
      };
}
 