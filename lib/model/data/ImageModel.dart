class ImageModel {
  int id;
  String src;

  ImageModel({required this.id, required this.src});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(id: json['id'], src: json['src']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['src'] = src;
    return data;
  }
}
