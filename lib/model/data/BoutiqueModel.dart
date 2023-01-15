// To parse this JSON data, do
//
//     final boutiqueModel = boutiqueModelFromJson(jsonString);

import 'dart:convert';

BoutiqueModel boutiqueModelFromJson(String str) =>
    BoutiqueModel.fromJson(json.decode(str));

String boutiqueModelToJson(BoutiqueModel data) => json.encode(data.toJson());

class BoutiqueModel {
  BoutiqueModel({
    required this.codeBoutique,
    required this.user,
    required this.description,
    required this.titre,
    required this.status,
    required this.images,
    required this.dateCreated, 

  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  final List<ImageU> images;
  String dateCreated; 

  factory BoutiqueModel.fromJson(Map<String, dynamic> json) => BoutiqueModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
        dateCreated: json["dateCreated"],
        images: json["images"] == null
            ? []
            : List<ImageU>.from(json["images"].map((x) => ImageU.fromJson(x))),
       );

  Map<String, dynamic> toJson() => {
        "codeBoutique": codeBoutique,
        "user": user,
        "description": description,
        "titre": titre,
        "status": status,
        "dateCreated": dateCreated,
       "images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toJson())),
     };
} 
class ImageU {
  ImageU({
    required this.id,
    required this.src,
  });

  final int id;
  final String src;

  factory ImageU.fromJson(Map<String, dynamic> json) => ImageU(
        id: json["id"] == null ? null : json["id"],
        src: json["src"] == null ? null :  json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "src": src == null ? null : src,
      };
}
