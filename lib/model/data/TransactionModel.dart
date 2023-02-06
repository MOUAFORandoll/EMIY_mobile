// To parse this JSON data, do
//
//     final transactinoModel = transactinoModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactinoModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactinoModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.montant,
    required this.status,
    required this.typeTransaction,
    required this.typeTransactionId,
    required this.dateCreated,
  });

  int id;
  String nom;
  String prenom;
  int montant;
  String status;
  String typeTransaction;
  int typeTransactionId;
  String dateCreated;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        montant: json["montant"],
        status: json["status"],
        typeTransaction: json["typeTransaction"],
        typeTransactionId: json["typeTransactionId"],
        dateCreated: json["dateCreated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "montant": montant,
        "status": status,
        "typeTransaction": typeTransaction,
        "typeTransactionId": typeTransactionId,
        "dateCreated": dateCreated,
      };
}
