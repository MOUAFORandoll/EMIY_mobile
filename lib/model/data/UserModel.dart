class UserModel {
  UserModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.phone,
    required this.status,
    required this.password,
    required this.typeUser,
    required this.agences,
    required this.voyages,
    required this.pointDeVentes,
    required this.dateCreate,
    required this.transactions,
  });
  late final int id;
  late final String nom;
  late final String prenom;
  late final String email;
  late final String phone;
  late final bool status;
  late final String password;
  late final String typeUser;
  late final List<String> agences;
  late final List<String> voyages;
  late final List<String> pointDeVentes;
  late final String dateCreate;
  late final List<Transactions> transactions;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    password = json['password'];
    typeUser = json['typeUser'];
    agences = List.castFrom<dynamic, String>(json['agences']);
    voyages = List.castFrom<dynamic, String>(json['voyages']);
    pointDeVentes = List.castFrom<dynamic, String>(json['pointDeVentes']);
    dateCreate = json['dateCreate'];
    transactions = List.from(json['transactions'])
        .map((e) => Transactions.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nom'] = nom;
    _data['prenom'] = prenom;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['status'] = status;
    _data['password'] = password;
    _data['typeUser'] = typeUser;
    _data['agences'] = agences;
    _data['voyages'] = voyages;
    _data['pointDeVentes'] = pointDeVentes;
    _data['dateCreate'] = dateCreate;
    _data['transactions'] = transactions.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Transactions {
  Transactions();

  Transactions.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
