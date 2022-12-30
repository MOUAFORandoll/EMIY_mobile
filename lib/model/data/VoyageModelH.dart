// To parse this JSON data, do
//
//     final voyageModelH = voyageModelHFromJson(jsonString);

import 'dart:convert';

VoyageModelH voyageModelHFromJson(String str) =>
    VoyageModelH.fromJson(json.decode(str));

String voyageModelHToJson(VoyageModelH data) => json.encode(data.toJson());

class VoyageModelH {
  VoyageModelH({
    required this.data,
    required this.listTypeVoyage,
    required this.listTrajet,
  });

  List<Datum> data;
  List<ListT> listTypeVoyage;
  List<TrajetModel> listTrajet;

  factory VoyageModelH.fromJson(Map<String, dynamic> json) => VoyageModelH(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        listTypeVoyage: List<ListT>.from(
            json["listTypeVoyage"].map((x) => ListT.fromJson(x))),
        listTrajet: List<TrajetModel>.from(
            json["listTrajet"].map((x) => TrajetModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "listTypeVoyage":
            List<dynamic>.from(listTypeVoyage.map((x) => x.toJson())),
        "listTrajet": List<dynamic>.from(listTrajet.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.numeroVoyage,
    required this.nomVoyage,
    required this.nombrePlace,
    required this.nomTrajet,
    required this.pointVente,
    required this.typeVoyage,
    required this.heureDepart,
    required this.place,
    required this.status,
    required this.dateCreated,
  });

  int id;
  String numeroVoyage;
  String nomVoyage;
  int nombrePlace;
  String nomTrajet;
  String pointVente;
  String typeVoyage;
  DateTime heureDepart;
  List<Place> place;
  bool status;
  DateTime dateCreated;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        numeroVoyage: json["numeroVoyage"],
        nomVoyage: json["nomVoyage"],
        nombrePlace: json["nombrePlace"],
        nomTrajet: json["nomTrajet"],
        pointVente: json["pointVente"],
        typeVoyage: json["typeVoyage"],
        heureDepart: DateTime.parse(json["heureDepart"]),
        place: List<Place>.from(json["place"].map((x) => Place.fromJson(x))),
        status: json["status"],
        dateCreated: DateTime.parse(json["dateCreated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numeroVoyage": numeroVoyage,
        "nomVoyage": nomVoyage,
        "nombrePlace": nombrePlace,
        "nomTrajet": nomTrajet,
        "pointVente": pointVente,
        "typeVoyage": typeVoyage,
        "heureDepart": heureDepart.toIso8601String(),
        "place": List<dynamic>.from(place.map((x) => x.toJson())),
        "status": status,
        "dateCreated": dateCreated.toIso8601String(),
      };
}

class Place {
  Place({
    required this.idPlace,
    required this.numeroPlace,
    required this.status,
  });

  int idPlace;
  int numeroPlace;
  bool status;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        idPlace: json["idPlace"],
        numeroPlace: json["numeroPlace"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "idPlace": idPlace,
        "numeroPlace": numeroPlace,
        "status": status,
      };
}

class TrajetModel {
  TrajetModel({
    required this.id,
    required this.libelle,
  });

  int id;
  String libelle;

  factory TrajetModel.fromJson(Map<String, dynamic> json) => TrajetModel(
        id: json["id"],
        libelle: json["libelle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
      };
}

class ListT {
  ListT({
    required this.id,
    required this.libelle,
  });

  int id;
  String libelle;

  factory ListT.fromJson(Map<String, dynamic> json) => ListT(
        id: json["id"],
        libelle: json["libelle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
      };
}
