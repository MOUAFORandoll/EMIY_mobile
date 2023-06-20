// To parse this JSON data, do
//
//     final shortModel = shortModelFromJson(jsonString);

import 'package:EMIY/utils/api/apiUrl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:video_player/video_player.dart';

ShortModel shortModelFromJson(String str) =>
    ShortModel.fromJson(json.decode(str));

String shortModelToJson(ShortModel data) => json.encode(data.toJson());

class ShortModel {
  ShortModel(
      {required this.id,
      required this.titre,
      required this.src,
      required this.boutique,
      required this.description,
      required this.date,
      required this.status,
      required this.controller});

  final int id;
  final String titre;
  final String src;
  final BoutiqueModel boutique;
  final String description;
  final String date;
  final bool status;
  var controller;

  factory ShortModel.fromJson(Map<String, dynamic> json) => ShortModel(
      id: json["id"] == null ? null : json["id"],
      titre: json["titre"] == null ? null : json["titre"],
      src: json["src"] == null ? null : json["src"],
      boutique: BoutiqueModel.fromJson(json["boutique"]),
      description: json["description"] == null ? null : json["description"],
      date: json["date"] == null ? null : json["date"],
      status: json["status"] == null ? null : json["status"],
      controller: VideoPlayerController.network(json["src"]));

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "src": src == null ? null : src,
        "localisation": boutique.toJson(),
        "titre": titre == null ? null : titre,
        "description": description == null ? null : description,
        "date": date == null ? null : date,
        "status": status == null ? null : status,
      };

  loadController() async {
    print('**************${ApiUrl.stream_serveurUrl + "/short?video=" + src}');
    controller = VideoPlayerController.network(
        ApiUrl.stream_serveurUrl + "/short?video=" + src);
    await controller.initialize().then((_) {
      print('**************lectyre');

      controller.play();
    });
    controller.setLooping(true);
  }
}

class BoutiqueModel {
  BoutiqueModel({
    required this.codeBoutique,
    required this.user,
    required this.description,
    required this.titre,
    required this.status,
    required this.note,
    required this.dateCreated,
    required this.images,
    required this.localisation,
  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  final note;
  String dateCreated;
  List<Image> images;
  Localisation localisation;

  factory BoutiqueModel.fromJson(Map<String, dynamic> json) => BoutiqueModel(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        status: json["status"],
        dateCreated: json["dateCreated"],
        note: double.parse(
            (json["note"] == null ? null : json["note"]).toString()),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        localisation: Localisation.fromJson(json["localisation"]),
      );

  Map<String, dynamic> toJson() => {
        "codeBoutique": codeBoutique,
        "user": user,
        "description": description,
        "titre": titre,
        "status": status,
        "note": note == null ? null : double.parse(note.toString()),
        "dateCreated": dateCreated,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "localisation": localisation.toJson(),
      };
}

class Image {
  Image({
    required this.id,
    required this.src,
  });

  int id;
  String src;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}

class Localisation {
  Localisation({
    required this.ville,
    required this.longitude,
    required this.latitude,
  });

  String ville;
  double longitude;
  double latitude;

  factory Localisation.fromJson(Map<String, dynamic> json) => Localisation(
        ville: json["ville"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ville": ville,
        "longitude": longitude,
        "latitude": latitude,
      };
}
