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
  List<ProduitModel> produits;

  factory BoutiqueModel.fromJson(Map<String, dynamic> json) => BoutiqueModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
        dateCreated: json["dateCreated"],
        produits: List<ProduitModel>.from(
            json["produits"].map((x) => ProduitModel.fromJson(x))),
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
  final bool status;
  final List<Image> images;

  factory ProduitModel.fromJson(Map<String, dynamic> json) => ProduitModel(
        id: json["id"] == null ? null : json["id"],
        codeProduit: json["codeProduit"] == null ? null : json["codeProduit"],
        boutique: json["boutique"] == null ? null : json["boutique"],
        description: json["description"] == null ? null : json["description"],
        titre: json["titre"] == null ? null : json["titre"],
        quantite: json["quantite"] == null ? null : json["quantite"],
        prix: json["prix"] == null ? null : json["prix"],
        status: json["status"] == null ? null : json["status"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "codeProduit": codeProduit == null ? null : codeProduit,
        "boutique": boutique == null ? null : boutique,
        "description": description == null ? null : description,
        "titre": titre == null ? null : titre,
        "quantite": quantite == null ? null : quantite,
        "prix": prix == null ? null : prix,
        "status": status == null ? null : status,
        "images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toJson())),
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
