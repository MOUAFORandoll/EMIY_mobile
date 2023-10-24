// To parse this JSON data, do
//
//     final AbonnementUserModel = AbonnementUserModelFromJson(jsonString);

import 'package:EMIY/model/data/ImageModel.dart';
import 'package:EMIY/model/data/LocalisationModel.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class AbonnementUserModel {
  AbonnementUserModel({
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
  List<ImageModel> images;
  LocalisationModel localisation;

  factory AbonnementUserModel.fromJson(Map<String, dynamic> json) =>
      AbonnementUserModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
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
        "titre": titre,
        "status": status,
        "note": note == null ? null : double.parse(note.toString()),
        "dateCreated": dateCreated,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "localisation": localisation.toJson(),
      };
}
