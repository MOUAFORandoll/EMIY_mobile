// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompteModel cmopteModelFromJson(String str) =>
    CompteModel.fromJson(json.decode(str));

String cmopteModelToJson(CompteModel data) => json.encode(data.toJson());

class CompteModel {
  CompteModel({
    required this.id,
    required this.solde,
  });

  int id;
  int solde;

  factory CompteModel.fromJson(Map<String, dynamic> json) => CompteModel(
        id: json["id"],
        solde: json["solde"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "solde": solde,
      };
}
