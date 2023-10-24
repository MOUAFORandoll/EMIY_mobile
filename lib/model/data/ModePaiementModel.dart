class ModePaiementModel {
  ModePaiementModel({
    required this.id,
    required this.libelle,
    required this.img,
  });
  late final int id;
  late final String libelle;
  late final String img;

  ModePaiementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['libelle'] = libelle;
    _data['img'] = img;

    return _data;
  }
}
