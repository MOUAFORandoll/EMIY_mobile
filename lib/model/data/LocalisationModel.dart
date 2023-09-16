class LocalisationModel {
  LocalisationModel({
    required this.ville,
    required this.longitude,
    required this.latitude,
  });

  String ville;
  double longitude;
  double latitude;

  factory LocalisationModel.fromJson(Map<String, dynamic> json) =>
      LocalisationModel(
        ville: json["ville"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ville": ville,
        "longitude": longitude,
        "latitude": latitude,
      };
}
