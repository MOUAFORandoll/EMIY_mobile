class AutoGenerate {
  AutoGenerate({
    required this.id,
    required this.libelle,
    required this.transactions,
    required this.type,
  });
  late final int id;
  late final String libelle;
  late final List<Transactions> transactions;
  late final int type;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    transactions = List.from(json['transactions'])
        .map((e) => Transactions.fromJson(e))
        .toList();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['libelle'] = libelle;
    _data['transactions'] = transactions.map((e) => e.toJson()).toList();
    _data['type'] = type;
    return _data;
  }
}

class Transactions {
  Transactions({
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

  Transactions.fromJson(Map<String, dynamic> json) {
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
