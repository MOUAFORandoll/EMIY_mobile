// To parse this JSON data, do
//
//     final CommentShortModel = CommentShortModelFromJson(jsonString);

import 'package:EMIY/utils/Services/apiUrl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:video_player/video_player.dart';

CommentShortModel commentShortModelFromJson(String str) =>
    CommentShortModel.fromJson(json.decode(str));

String CommentShortModelToJson(CommentShortModel data) =>
    json.encode(data.toJson());

class CommentShortModel {
  CommentShortModel({
    required this.id,
    required this.commentaire,
    required this.username,
    required this.userphoto,
    required this.date,
  });

  final int id;
  final String commentaire;
  final String userphoto;
  final String username;
  final String date;

  factory CommentShortModel.fromJson(Map<String, dynamic> json) =>
      CommentShortModel(
        id: json["id"] == null ? null : json["id"],
        commentaire: json["commentaire"] == null ? null : json["commentaire"],
        username: json["username"] == null ? null : json["username"],
        userphoto: json["userphoto"] == null ? null : json["userphoto"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userphoto": userphoto == null ? null : userphoto,
        "username": username == null ? null : username,
        "commentaire": commentaire == null ? null : commentaire,
        "date": date == null ? null : date,
      };
}
