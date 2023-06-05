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

class MessageNegociationModel {
  final int id;
  final int emetteurId;
  final String heure;
  final String date;
  final String message;

  MessageNegociationModel({
    required this.id,
    required this.emetteurId,
    required this.heure,
    required this.date,
    required this.message,
  });

  factory MessageNegociationModel.fromJson(Map<String, dynamic> json) =>
      MessageNegociationModel(
        id: json["id"] == null ? null : json["id"],
        emetteurId: json["emetteurId"] == null ? null : json["emetteurId"],
        heure: json["heure"] == null ? null : json["heure"],
        message: json["message"] == null ? null : json["message"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "emetteurId": emetteurId == null ? null : emetteurId,
        "heure": heure == null ? null : heure,
        "message": message == null ? null : message,
        "date": date == null ? null : date,
      };
}
