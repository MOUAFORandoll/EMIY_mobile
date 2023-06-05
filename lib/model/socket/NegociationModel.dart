// To parse this JSON data, do
//
//     final livreurModel = livreurModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

// SocketCommandModel socketCommandModelFromJson(String str) =>
//     SocketCommandModel.fromJson(json.decode(str));

// String socketCommandModelToJson(SocketCommandModel data) =>
//     json.encode(data.toJson());

// class SocketCommandModel {
//   int canal;
//   Data data;

//   SocketCommandModel({
//     required this.canal,
//     required this.data,
//   });

//   factory SocketCommandModel.fromJson(Map<String, dynamic> json) =>
//       SocketCommandModel(
//         canal: json["canal"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "canal": canal,
//         "data": data.toJson(),
//       };
// }

class NegociationModel {
  final int prixNegocie;
  final String codeNegociation;
  final String titre_produit;
  final String src_produit;
  final String date;
  final String last_message;

  NegociationModel({
    required this.prixNegocie,
    required this.codeNegociation,
    required this.titre_produit,
    required this.src_produit,
    required this.date,
    required this.last_message,
  });

  factory NegociationModel.fromJson(Map<String, dynamic> json) =>
      NegociationModel(
        prixNegocie: json["prixNegocie"] == null ? 0 : json["prixNegocie"],
        codeNegociation:
            json["codeNegociation"] == null ? null : json["codeNegociation"],
        titre_produit:
            json["titre_produit"] == null ? null : json["titre_produit"],
        src_produit: json["src_produit"] == null ? null : json["src_produit"],
        date: json["date"],
        last_message: json["last_message"],
      );

  Map<String, dynamic> toJson() => {
        "prixNegocie": prixNegocie == null ? null : prixNegocie,
        "codeNegociation": codeNegociation == null ? null : codeNegociation,
        "titre_produit": titre_produit == null ? null : titre_produit,
        "src_produit": src_produit == null ? null : src_produit,
        "date": date == null ? null : date,
        "last_message": last_message == null ? null : last_message,
      };
}
