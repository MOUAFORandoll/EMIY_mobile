// To parse this JSON data, do
//
//     final AbonnementUserModel = AbonnementUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AbonnementUserModel {
  AbonnementUserModel({
    required this.id,
    required this.boutique_id,
    required this.boutique_title,
    required this.date,
  });

  final int id;
  final String boutique_id;
  final String boutique_title;
  final String date;
  var controller;

  factory AbonnementUserModel.fromJson(Map<String, dynamic> json) =>
      AbonnementUserModel(
          id: json["id"] == null ? null : json["id"],
          boutique_id: json["boutique_id"] == null ? null : json["boutique_id"],
          boutique_title:
              json["boutique_title"] == null ? null : json["boutique_title"],
          date: json["date"] == null ? null : json["date"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "boutique_title": boutique_title == null ? null : boutique_title,
        "boutique_id": boutique_id == null ? null : boutique_id,
        "date": date == null ? null : date,
      };
}
