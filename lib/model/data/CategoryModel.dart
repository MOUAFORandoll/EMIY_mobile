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
    required this.libelle,
    required this.icon,
    required this.description,
    required this.status,
  });

  final int id;
  final String libelle;
  final int icon;
  final String description;
  final bool status;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] == null ? null : json["id"],
        libelle: json["libelle"] == null ? null : json["libelle"],
        icon:  json["icon"] == null ? null : json["icon"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "icon": icon == null ? null : icon,
        "libelle": libelle == null ? null : libelle,
        "description": description == null ? null : description,
        "status": status == null ? null : status,
      };
}
