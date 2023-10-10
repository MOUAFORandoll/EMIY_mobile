// To parse this JSON data, do
//
//     final produitModel = produitModelFromJson(jsonString);

import 'package:EMIY/model/exportmodel.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'ImageModel.dart';

class HomeComponentModel {
  HomeComponentModel({
    required this.type,
    required this.titre,
    required this.produits,
  });

  final String titre;
  final List<ProduitModel> produits;
  final int type;

  factory HomeComponentModel.fromJson(Map<String, dynamic> json) =>
      HomeComponentModel(
        type: json["type"] == null ? null : json["type"],
        produits: List<ProduitModel>.from(
            json["produits"].map((x) => ProduitModel.fromJson(x))),
        titre: json["titre"] == null ? null : json["titre"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "titre": titre == null ? null : titre,
        "produits": List<dynamic>.from(produits.map((x) => x.toJson())),
      };
}
