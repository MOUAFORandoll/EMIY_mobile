class VoyageModel {
  VoyageModel({
    required this.id,
    required this.nomVoyage,
    required this.numeroVoyage,
    required this.status,
    required this.places,
    required this.pointDeVente,
    required this.trajet,
    required this.user,
    required this.typeVoyage,
    required this.dateStart,
    required this.nombreDePlace,
  });
  late final int id;
  late final String nomVoyage;
  late final String numeroVoyage;
  late final bool status;
  late final List<String> places;
  late final String pointDeVente;
  late final String trajet;
  late final String user;
  late final String typeVoyage;
  late final String dateStart;
  late final int nombreDePlace;

  VoyageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomVoyage = json['nomVoyage'];
    numeroVoyage = json['numeroVoyage'];
    status = json['status'];
    places = List.castFrom<dynamic, String>(json['places']);
    pointDeVente = json['pointDeVente'];
    trajet = json['trajet'];
    user = json['user'];
    typeVoyage = json['typeVoyage'];
    dateStart = json['dateStart'];
    nombreDePlace = json['nombreDePlace'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nomVoyage'] = nomVoyage;
    _data['numeroVoyage'] = numeroVoyage;
    _data['status'] = status;
    _data['places'] = places;
    _data['pointDeVente'] = pointDeVente;
    _data['trajet'] = trajet;
    _data['user'] = user;
    _data['typeVoyage'] = typeVoyage;
    _data['dateStart'] = dateStart;
    _data['nombreDePlace'] = nombreDePlace;
    return _data;
  }
}
