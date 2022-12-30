class PointDeVenteModel {
  PointDeVenteModel({
    required this.id,
    required this.nomPointDeVente,
    required this.status,
    required this.agence,
    required this.voyages,
    required this.chefAgence,
    required this.vendeur,
  });
  late final int id;
  late final String nomPointDeVente;
  late final bool status;
  late final Agence agence;
  late final List<String> voyages;
  late final String chefAgence;
  late final List<String> vendeur;

  PointDeVenteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomPointDeVente = json['nomPointDeVente'];
    status = json['status'];
    agence = Agence.fromJson(json['agence']);
    voyages = List.castFrom<dynamic, String>(json['voyages']);
    chefAgence = json['chefAgence'];
    vendeur = List.castFrom<dynamic, String>(json['vendeur']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nomPointDeVente'] = nomPointDeVente;
    _data['status'] = status;
    _data['agence'] = agence.toJson();
    _data['voyages'] = voyages;
    _data['chefAgence'] = chefAgence;
    _data['vendeur'] = vendeur;
    return _data;
  }
}

class Agence {
  Agence({
    required this.id,
    required this.nom,
    required this.dateCreate,
    required this.status,
    required this.user,
    required this.pointDeVentes,
  });
  late final int id;
  late final String nom;
  late final String dateCreate;
  late final bool status;
  late final String user;
  late final List<String> pointDeVentes;

  Agence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    dateCreate = json['dateCreate'];
    status = json['status'];
    user = json['user'];
    pointDeVentes = List.castFrom<dynamic, String>(json['pointDeVentes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nom'] = nom;
    _data['dateCreate'] = dateCreate;
    _data['status'] = status;
    _data['user'] = user;
    _data['pointDeVentes'] = pointDeVentes;
    return _data;
  }
}
