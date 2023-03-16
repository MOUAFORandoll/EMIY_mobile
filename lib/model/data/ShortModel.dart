// To parse this JSON data, do
//
//     final shortModel = shortModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:video_player/video_player.dart';

ShortModel shortModelFromJson(String str) =>
    ShortModel.fromJson(json.decode(str));

String shortModelToJson(ShortModel data) => json.encode(data.toJson());

class ShortModel {
  ShortModel({
    required this.id,
    required this.titre,
    required this.src,
    required this.srcBoutique,
    required this.description,
    required this.date,
    required this.status,
  });

  final int id;
  final String titre;
  final String src;
  final String srcBoutique;
  final String description;
  final String date;
  final bool status;
  VideoPlayerController? controller;

  factory ShortModel.fromJson(Map<String, dynamic> json) => ShortModel(
        id: json["id"] == null ? null : json["id"],
        titre: json["titre"] == null ? null : json["titre"],
        src: json["src"] == null ? null : json["src"],
        srcBoutique: json["srcBoutique"] == null ? null : json["srcBoutique"],
        description: json["description"] == null ? null : json["description"],
        date: json["date"] == null ? null : json["date"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "src": src == null ? null : src,
        "srcBoutique": srcBoutique == null ? null : srcBoutique,
        "titre": titre == null ? null : titre,
        "description": description == null ? null : description,
        "date": date == null ? null : date,
        "status": status == null ? null : status,
      };

  Future<Null> loadController() async {
    controller = VideoPlayerController.network(src);
    await controller?.initialize();

    controller?.setLooping(true);
    
  }
}
