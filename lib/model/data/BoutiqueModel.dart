// To parse this JSON data, do
//
//     final boutiqueModel = boutiqueModelFromJson(jsonString);

import 'dart:convert';

import 'package:EMIY/utils/Services/apiUrl.dart';

import 'ImageModel.dart';
import 'LocalisationModel.dart';

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
    required this.status_abonnement,
    required this.note,
    required this.dateCreated,
    required this.images,
    required this.lienBoutique,
    required this.localisation,
    required this.nombre_produit,
  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  bool status_abonnement;
  final String lienBoutique;
  final note;
  String dateCreated;
  int nombre_produit;
  List<ImageModel> images;
  LocalisationModel localisation;

  factory BoutiqueModel.fromJson(Map<String, dynamic> json) => BoutiqueModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        nombre_produit: json["nombre_produit"],
        titre: json["titre"],
        status: json["status"],
        lienBoutique:
            ApiUrl.external_link + 'boutiques/' + json["codeBoutique"],
        status_abonnement: json["status_abonnement"],
        dateCreated: json["dateCreated"],
        note: double.parse(
            (json["note"] == null ? null : json["note"]).toString()),
        images: List<ImageModel>.from(
            json["images"].map((x) => ImageModel.fromJson(x))),
        localisation: LocalisationModel.fromJson(json["localisation"]),
      );

  Map<String, dynamic> toJson() => {
        "codeBoutique": codeBoutique,
        "user": user,
        "description": description,
        "nombre_produit": nombre_produit,
        "titre": titre,
        "status_abonnement": status_abonnement,
        "status": status,
        "note": note == null ? null : double.parse(note.toString()),
        "dateCreated": dateCreated,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "localisation": localisation.toJson(),
      };
}
