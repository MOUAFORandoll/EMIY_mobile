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
    required this.note,
    required this.dateCreated,
    required this.images,
    required this.localisation,
  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  final note;
  String dateCreated;
  List<Image> images;
  Localisation localisation;

  factory BoutiqueModel.fromJson(Map<String, dynamic> json) => BoutiqueModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
        dateCreated: json["dateCreated"],
        note: double.parse(
            (json["note"] == null ? null : json["note"]).toString()),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        localisation: Localisation.fromJson(json["localisation"]),
      );

  Map<String, dynamic> toJson() => {
        "codeBoutique": codeBoutique,
        "user": user,
        "description": description,
        "titre": titre,
        "status": status,
        "note": note == null ? null : double.parse(note.toString()),
        "dateCreated": dateCreated,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "localisation": localisation.toJson(),
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
