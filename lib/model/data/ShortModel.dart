// To parse this JSON data, do
//
//     final shortModel = shortModelFromJson(jsonString);

import 'package:EMIY/utils/Services/apiUrl.dart';
import 'dart:convert';

import 'package:video_player/video_player.dart';

import 'ProduitModel.dart';

ShortModel shortModelFromJson(String str) =>
    ShortModel.fromJson(json.decode(str));

String shortModelToJson(ShortModel data) => json.encode(data.toJson());

class ShortModel {
  ShortModel({
    required this.id,
    required this.titre,
    required this.src,
    required this.preview,
    required this.boutique,
    required this.produits,
    required this.description,
    required this.date,
    required this.codeShort,
    this.codeShortInit = '',
    required this.nbre_commentaire,
    required this.nbre_like,
    required this.status,
    required this.is_like,
    required this.controller,
  });

  final int id;
  final String titre;
  final String preview;
  final String src;
  final List<ProduitModel> produits;
  final BoutiqueModel0 boutique;
  final String description;
  int nbre_like;
  int nbre_commentaire;
  final String date;
  final String codeShort;
  final String codeShortInit;
  bool is_like;
  final bool status;
  final VideoPlayerController controller;

  factory ShortModel.fromJson(Map<String, dynamic> json) => ShortModel(
        id: json["id"] == null ? null : json["id"],
        nbre_like: json["nbre_like"] == null ? null : json["nbre_like"],
        nbre_commentaire:
            json["nbre_commentaire"] == null ? null : json["nbre_commentaire"],
        titre: json["titre"] == null ? null : json["titre"],
        src: json["src"] == null ? null : json["src"],
        produits: List<ProduitModel>.from(
            json["produits"].map((x) => ProduitModel.fromJson(x))),
        preview: json["preview"] == null ? null : json["preview"],
        boutique: BoutiqueModel0.fromJson(json["boutique"]),
        description: json["description"] == null ? null : json["description"],
        date: json["date"] == null ? null : json["date"],
        codeShortInit: json["codeShort"],
        codeShort: ApiUrl.external_link + 'shorts/' + json["codeShort"],
        status: json["status"] == null ? null : json["status"],
        is_like: json["is_like"] == null ? null : json["is_like"],
        controller: VideoPlayerController.network(
            ApiUrl.stream_serveurUrl + "/short?video=" + json["src"])
          ..initialize(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "preview": preview == null ? null : preview,
        "nbre_commentaire": nbre_commentaire == null ? null : nbre_commentaire,
        "nbre_like": nbre_like == null ? null : nbre_like,
        "src": src == null ? null : src,
        "produits": List<dynamic>.from(produits.map((x) => x.toJson())),
        "localisation": boutique.toJson(),
        "titre": titre == null ? null : titre,
        "description": description == null ? null : description,
        "date": date == null ? null : date,
        "codeShort": codeShort == null ? null : codeShort,
        "is_like": is_like == null ? null : is_like,
        "status": status == null ? null : status,
      };

  loadController() async {
    print('**************${ApiUrl.stream_serveurUrl + "/short?video=" + src}');
    // controller = VideoPlayerController.network(
    //     ApiUrl.stream_serveurUrl + "/short?video=" + src);
    await controller?.initialize().then((_) {
      print('**************lectyre');

      // controller.play();
    });
    
    VideoPlayerController.network(
        ApiUrl.stream_serveurUrl + "/short?video=" + src)
      ..initialize().then((_) {
        print('**************lectyre');

        // controller.play();
      }, onError: (error) {
        print('**************erreeeeeeeeeeee    ------  ${error}');
      });

    controller?.setLooping(true);
  }
}

class BoutiqueModel0 {
  BoutiqueModel0({
    required this.codeBoutique,
    required this.user,
    required this.description,
    required this.titre,
    required this.status,
    required this.note,
    required this.lienBoutique,
    required this.dateCreated,
    required this.images,
    required this.localisation,
  });

  String codeBoutique;
  String user;
  String description;
  String titre;
  bool status;
  final String lienBoutique;
  final note;
  String dateCreated;
  List<Image> images;
  Localisation localisation;

  factory BoutiqueModel0.fromJson(Map<String, dynamic> json) => BoutiqueModel0(
        codeBoutique: json["codeBoutique"],
        user: json["user"],
        description: json["description"],
        titre: json["titre"],
        lienBoutique:
            ApiUrl.external_link + 'boutiques/' + json["codeBoutique"],
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
