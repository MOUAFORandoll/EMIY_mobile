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
    required this.localisation,
    required this.nombre_produit,
    required this.commandes,
  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  String dateCreated;
  List<Image> images;
  Localisation localisation;
  int nombre_produit;
  int commandes;
  factory BoutiqueUserModel.fromJson(Map<String, dynamic> json) =>
      BoutiqueUserModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
        nombre_produit: json["nombre_produit"],
        commandes: json["commandes"],
        dateCreated: json["dateCreated"],
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
        "commandes": commandes,
        "nombre_produit": nombre_produit,
        "status": status,
        "dateCreated": dateCreated,
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
