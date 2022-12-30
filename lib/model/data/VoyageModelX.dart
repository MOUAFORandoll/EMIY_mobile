// To parse this JSON data, do
//
//     final billet = billetFromJson(jsonString);

import 'dart:convert';

class Billet {
  Billet({
    required this.id,
    required this.phone,
    required this.prenom,
    required this.nom,
    required this.agence,
    required this.pointDeVente,
    required this.typeBillet,
    required this.numeroSiege,
    required this.date,
  });

  int id;
  String phone;
  String prenom;
  String nom;
  String agence;
  String pointDeVente;
  String typeBillet;
  String date;
  int numeroSiege;

  factory Billet.fromJson(Map<String, dynamic> json) => Billet(
        id: json["id"],
        phone: json["phone"],
        prenom: json["prenom"],
        nom: json["nom"],
        agence: json["agence"],
        pointDeVente: json["pointDeVente"],
        typeBillet: json["typeBillet"],
        numeroSiege: json["numeroSiege"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "prenom": prenom,
        "nom": nom,
        "agence": agence,
        "pointDeVente": pointDeVente,
        "typeBillet": typeBillet,
        "numeroSiege": numeroSiege,
        "date": date,
      };
}
