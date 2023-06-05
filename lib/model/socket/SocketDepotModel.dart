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

class SocketDepotModel {
  final String message;
  final bool status;

  SocketDepotModel({
    required this.message,
    required this.status,
  });

  factory SocketDepotModel.fromJson(Map<String, dynamic> json) =>
      SocketDepotModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
