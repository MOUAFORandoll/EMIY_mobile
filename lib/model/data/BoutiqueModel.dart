// To parse this JSON data, do
//
//     final boutiqueModel = boutiqueModelFromJson(jsonString);

import 'dart:convert';

BoutiqueModel boutiqueModelFromJson(String str) =>
    BoutiqueModel.fromJson(json.decode(str));

String boutiqueModelToJson(BoutiqueModel data) => json.encode(data.toJson());

class BoutiqueModel {
  BoutiqueModel({
    required this.codeBoutique,
    required this.user,
    required this.description,
    required this.titre,
    required this.status,
    required this.dateCreated,
    required this.produits,
  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  String dateCreated;
  List<Produit> produits;

  factory BoutiqueModel.fromJson(Map<String, dynamic> json) => BoutiqueModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
        dateCreated: json["dateCreated"],
        produits: List<Produit>.from(
            json["produits"].map((x) => Produit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "codeBoutique": codeBoutique,
        "user": user,
        "description": description,
        "titre": titre,
        "status": status,
        "dateCreated": dateCreated,
        "produits": List<dynamic>.from(produits.map((x) => x.toJson())),
      };
}

class Produit {
  Produit({
    required this.id,
    required this.codeProduit,
    required this.titre,
    required this.quantite,
    required this.prix,
    required this.status,
    required this.date,
    required this.description,
    required this.images,
  });

  int id;
  String codeProduit;
  String titre;
  int quantite;
  int prix;
  bool status;
  String date;
  String description;
  List<Image> images;
  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        id: json["id"],
        codeProduit: json["codeProduit"],
        titre: json["titre"],
        date: json["date "] == null ? null : json["date "],
        quantite: json["quantite"],
        prix: json["prix"],
        status: json["status"],
        description: json["description"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codeProduit": codeProduit,
        "titre": titre,
        "date ": date == null ? null : date,
        "quantite": quantite,
        "prix": prix,
        "status": status,
        "description": description,
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
