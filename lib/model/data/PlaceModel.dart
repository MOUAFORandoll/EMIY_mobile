class PlaceModel {
  PlaceModel({
    required this.id,
    required this.dateCreate,
    required this.status,
    required this.voyage,
    required this.numeroPlace,
    required this.libellePlace,
  });
  late final int id;
  late final String dateCreate;
  late final bool status;
  late final String voyage;
  late final int numeroPlace;
  late final String libellePlace;

  PlaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreate = json['dateCreate'];
    status = json['status'];
    voyage = json['voyage'];
    numeroPlace = json['numeroPlace'];
    libellePlace = json['libellePlace'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['dateCreate'] = dateCreate;
    _data['status'] = status;
    _data['voyage'] = voyage;
    _data['numeroPlace'] = numeroPlace;
    _data['libellePlace'] = libellePlace;
    return _data;
  }
}
