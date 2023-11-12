// To parse this JSON data, do
//
//     final UserTagModel = UserTagModelFromJson(jsonString);
//545
class UserTagModel {
  UserTagModel({this.user_tag, this.nom, this.phone, this.profile});

  String? user_tag;
  String? nom;
  String? phone;
  String? profile;

  factory UserTagModel.fromJson(Map<String, dynamic> json) => UserTagModel(
        user_tag: json["user_tag"],
        nom: json["nom"],
        phone: json["phone"],
        profile: json["profile"],
      );
}
