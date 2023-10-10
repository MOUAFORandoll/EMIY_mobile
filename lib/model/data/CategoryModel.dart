// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.nombreBoutique,
    required this.libelle,
    required this.logo,
    required this.description,
    required this.status,
  });

  final int id;
  final int nombreBoutique;
  final String libelle;
  final String logo;
  final String description;
  final bool status;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] == null ? null : json["id"],
        nombreBoutique:
            json["nombreBoutique"] == null ? 0 : json["nombreBoutique"],
        libelle: json["libelle"] == null ? null : json["libelle"],
        logo: json["logo"] == null ? null : json["logo"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nombreBoutique": nombreBoutique == null ? null : nombreBoutique,
        "logo": logo == null ? null : logo,
        "libelle": libelle == null ? null : libelle,
        "description": description == null ? null : description,
        "status": status == null ? null : status,
      };
}
