class TrajetModel {
  TrajetModel({
    required this.id,
    required this.libelle,
    required this.pointDepart,
    required this.pointArrive,
    required this.status,
    required this.voyages,
  });
  late final int id;
  late final String libelle;
  late final String pointDepart;
  late final String pointArrive;
  late final bool status;
  late final List<String> voyages;

  TrajetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    pointDepart = json['pointDepart'];
    pointArrive = json['pointArrive'];
    status = json['status'];
    voyages = List.castFrom<dynamic, String>(json['voyages']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['libelle'] = libelle;
    _data['pointDepart'] = pointDepart;
    _data['pointArrive'] = pointArrive;
    _data['status'] = status;
    _data['voyages'] = voyages;
    return _data;
  }
}
