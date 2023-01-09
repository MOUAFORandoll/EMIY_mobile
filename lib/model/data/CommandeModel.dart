// To parse this JSON data, do
//
//     final commandeModel = commandeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CommandeModel commandeModelFromJson(String str) =>
    CommandeModel.fromJson(json.decode(str));

String commandeModelToJson(CommandeModel data) => json.encode(data.toJson());

class CommandeModel {
  CommandeModel({
    required this.codeCommande,
    required this.codeClient,
    required this.date,
    required this.id,
  });

  String date;
  int id;
  String codeCommande;
  String codeClient;

  factory CommandeModel.fromJson(Map<String, dynamic> json) => CommandeModel(
        codeCommande: json["codeCommande"],
        codeClient: json["codeClient"],
        date: json["date"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "codeClient": codeClient,
        "codeCommande": codeCommande,
        "id": id,
        "date": date,
      };
}

Produit? produitFromJson(String str) => Produit.fromJson(json.decode(str));

String produitToJson(Produit? data) => json.encode(data!.toJson());

class Produit {
  Produit({
    required this.codeProduit,
    required this.boutique,
    required this.titre,
    required this.prix,
    required this.quantite,
    required this.status,
    required this.photo,
  });

  String codeProduit;
  Boutique boutique;
  String titre;
  int prix;
  int quantite;
  String status;
  Photo photo;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        codeProduit: json["codeProduit"],
        boutique: Boutique.fromJson(json["boutique"]),
        titre: json["titre"],
        prix: json["prix"],
        quantite: json["quantite"],
        status: json["status"],
        photo: Photo.fromJson(json["photo"]),
      );

  Map<String, dynamic> toJson() => {
        "codeProduit": codeProduit,
        "boutique": boutique.toJson(),
        "titre": titre,
        "prix": prix,
        "quantite": quantite,
        "status": status,
        "photo": photo.toJson(),
      };
}

class Boutique {
  Boutique({
    required this.id,
    required this.titre,
    required this.codeBoutique,
    required this.description,
  });

  int id;
  String titre;
  String codeBoutique;
  String description;

  factory Boutique.fromJson(Map<String, dynamic> json) => Boutique(
        id: json["id"],
        titre: json["titre"],
        codeBoutique: json["codeBoutique"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "codeBoutique": codeBoutique,
        "description": description,
      };
}

class Photo {
  Photo({
    required this.id,
    required this.src,
  });

  int id;
  String src;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}
