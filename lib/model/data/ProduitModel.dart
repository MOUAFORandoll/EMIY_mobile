// To parse this JSON data, do
//
//     final produitModel = produitModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

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
    required this.note,
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
  final note;
  final bool status;
  final List<ImageU> images;

  factory ProduitModel.fromJson(Map<String, dynamic> json) => ProduitModel(
        id: json["id"] == null ? null : json["id"],
        codeProduit: json["codeProduit"] == null ? null : json["codeProduit"],
        boutique: json["boutique"] == null ? null : json["boutique"],
        description: json["description"] == null ? null : json["description"],
        titre: json["titre"] == null ? null : json["titre"],
        quantite: json["quantite"] == null ? null : json["quantite"],
        prix: json["prix"] == null ? null : json["prix"],
        note: double.parse(
            (json["note"] == null ? null : json["note"]).toString()),
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
        "titre": titre == null ? null : titre,
        "quantite": quantite == null ? null : quantite,
        "prix": prix == null ? null : prix,
        "note": note == null ? null : double.parse(note.toString()),
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
