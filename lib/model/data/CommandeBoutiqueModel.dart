// To parse this JSON data, do
//
//     final commandeBoutiqueModel = commandeBoutiqueModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CommandeBoutiqueModel commandeBoutiqueModelFromJson(String str) =>
    CommandeBoutiqueModel.fromJson(json.decode(str));

String commandeBoutiqueModelToJson(CommandeBoutiqueModel data) =>
    json.encode(data.toJson());

class CommandeBoutiqueModel {
  CommandeBoutiqueModel({
    required this.codeProduit,
    required this.numCommande,
    required this.codeCommande,
    required this.titre,
    required this.prix,
    required this.quantite,
    required this.status,
    required this.date,
    required this.photo,
  });

  String numCommande;
  String codeProduit;
  String codeCommande;
  String titre;
  int prix;
  int quantite;
  String status;
  String date;
  Photo photo;

  factory CommandeBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      CommandeBoutiqueModel(
        codeProduit: json["codeProduit"],
        numCommande: json["numCommande"],
        codeCommande: json["codeCommande"],
        titre: json["titre"],
        prix: json["prix"],
        quantite: json["quantite"],
        status: json["status"],
        date: json["date"],
        photo: Photo.fromJson(json["photo"]),
      );

  Map<String, dynamic> toJson() => {
        "numCommande": numCommande,
        "codeProduit": codeProduit,
        "codeCommande": codeCommande,
        "titre": titre,
        "prix": prix,
        "quantite": quantite,
        "status": status,
        "date": date,
        "photo": photo.toJson(),
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
