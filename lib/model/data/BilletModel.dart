class BilletModel {
  BilletModel({
    required this.id,
    required this.titre,
    required this.place,
    required this.dateCreate,
    required this.transaction,
    required this.typeBillet,
    required this.nomClient,
    required this.prenomClient,
    required this.cni,
  });
  late final int id;
  late final String titre;
  late final String place;
  late final String dateCreate;
  late final Transaction transaction;
  late final String typeBillet;
  late final String nomClient;
  late final String prenomClient;
  late final String cni;

  BilletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titre = json['titre'];
    place = json['place'];
    dateCreate = json['dateCreate'];
    transaction = Transaction.fromJson(json['transaction']);
    typeBillet = json['typeBillet'];
    nomClient = json['nomClient'];
    prenomClient = json['prenomClient'];
    cni = json['cni'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titre'] = titre;
    _data['place'] = place;
    _data['dateCreate'] = dateCreate;
    _data['transaction'] = transaction.toJson();
    _data['typeBillet'] = typeBillet;
    _data['nomClient'] = nomClient;
    _data['prenomClient'] = prenomClient;
    _data['cni'] = cni;
    return _data;
  }
}

class Transaction {
  Transaction({
    required this.id,
    required this.libelle,
    required this.montant,
    required this.token,
    required this.dateCreate,
    required this.status,
    required this.client,
    required this.modePaiement,
    required this.billets,
  });
  late final int id;
  late final String libelle;
  late final int montant;
  late final String token;
  late final String dateCreate;
  late final bool status;
  late final String client;
  late final String modePaiement;
  late final List<String> billets;

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    montant = json['montant'];
    token = json['token'];
    dateCreate = json['dateCreate'];
    status = json['status'];
    client = json['client'];
    modePaiement = json['modePaiement'];
    billets = List.castFrom<dynamic, String>(json['billets']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['libelle'] = libelle;
    _data['montant'] = montant;
    _data['token'] = token;
    _data['dateCreate'] = dateCreate;
    _data['status'] = status;
    _data['client'] = client;
    _data['modePaiement'] = modePaiement;
    _data['billets'] = billets;
    return _data;
  }
}
