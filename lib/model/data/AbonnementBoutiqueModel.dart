// To parse this JSON data, do
//
//     final AbonnementBoutiqueModel = AbonnementBoutiqueModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AbonnementBoutiqueModel {
  AbonnementBoutiqueModel({
    required this.id,
    required this.cient_id,
    required this.client_name,
    required this.client_src,
    required this.date,
  });

  final int id;
  final String cient_id;
  final String client_name;
  final String client_src;
  final String date;
  var controller;

  factory AbonnementBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      AbonnementBoutiqueModel(
          id: json["id"] == null ? null : json["id"],
          cient_id: json["cient_id"] == null ? null : json["cient_id"],
          client_name: json["client_name"] == null ? null : json["client_name"],
          client_src: json["client_src"] == null ? null : json["client_src"],
          date: json["date"] == null ? null : json["date"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "client_name": client_name == null ? null : client_name,
        "cient_id": cient_id == null ? null : cient_id,
        "client_src": client_src == null ? null : client_src,
        "date": date == null ? null : date,
      };
}
