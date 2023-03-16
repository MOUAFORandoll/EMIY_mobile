// To parse this JSON data, do
//
//     final boutiqueUserModel = boutiqueUserModelFromJson(jsonString);

import 'dart:convert';

BoutiqueUserModel boutiqueUserModelFromJson(String str) =>
    BoutiqueUserModel.fromJson(json.decode(str));

String boutiqueUserModelToJson(BoutiqueUserModel data) =>
    json.encode(data.toJson());

class BoutiqueUserModel {
  BoutiqueUserModel({
    required this.codeBoutique,
    required this.user,
    required this.description,
    required this.titre,
    required this.status,
    required this.dateCreated,
    required this.images,
    required this.produits,
    required this.localisation,

  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  String dateCreated;
  final List<Image> images;
  List<Produit> produits;
  Localisation localisation;


  factory BoutiqueUserModel.fromJson(Map<String, dynamic> json) =>
      BoutiqueUserModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
        dateCreated: json["dateCreated"],
        produits: List<Produit>.from(
            json["produits"].map((x) => Produit.fromJson(x))),
      
        localisation: Localisation.fromJson(json["localisation"]),
      
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "codeBoutique": codeBoutique,
        "user": user,
        "description": description,
        "titre": titre,
        "status": status,
        "dateCreated": dateCreated,
        "produits": List<dynamic>.from(produits.map((x) => x.toJson())),
        "images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toJson())),

        "localisation": localisation.toJson(),

      };
}

class Localisation {
  Localisation({
    required this.ville,
    required this.longitude,
    required this.latitude,
  });

  String ville;
  double longitude;
  double latitude;

  factory Localisation.fromJson(Map<String, dynamic> json) => Localisation(
        ville: json["ville"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ville": ville,
        "longitude": longitude,
        "latitude": latitude,
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
