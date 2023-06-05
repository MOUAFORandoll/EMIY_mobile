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

class SocketCommandModel {
  final int id;
  final String pdf;
  final String codeClient;
  final String codeCommande;
  final String date;
  final String message;
  final bool status;

  SocketCommandModel({
    required this.id,
    required this.pdf,
    required this.codeClient,
    required this.codeCommande,
    required this.date,
    required this.message,
    required this.status,
  });

  factory SocketCommandModel.fromJson(Map<String, dynamic> json) => SocketCommandModel(
        id: json["id"] == null ? null : json["id"],
        pdf: json["pdf"] == null ? null : json["pdf"],
        codeClient: json["codeClient"] == null ? null : json["codeClient"],
        codeCommande:
            json["codeCommande"] == null ? null : json["codeCommande"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "pdf": pdf == null ? null : pdf,
        "codeClient": codeClient == null ? null : codeClient,
        "status": status == null ? null : status,
        "codeCommande": codeCommande == null ? null : codeCommande,
        "message": message == null ? null : message,
        "date": date,
      };
}
