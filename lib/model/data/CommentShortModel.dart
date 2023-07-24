class CommentShortModel {
  CommentShortModel({
    required this.id,
    required this.date,
    required this.commentaire_text,
    required this.username,
    required this.target_user,
    required this.userphoto,
    required this.nbre_com,
    required this.nbre_like_com,
    required this.is_like_com,
    required this.sub_responses,
    this.comments = const [], // Déclaration d'une liste vide par défaut
  });

  int id;
  String date;
  String commentaire_text;
  String username;
  String target_user;
  String userphoto;
  int nbre_com;
  int nbre_like_com;
  bool sub_responses;
  bool is_like_com;
  List<CommentShortModel> comments; // Déclaration de la liste des commentaires

  factory CommentShortModel.fromJson(Map<String, dynamic> json) =>
      CommentShortModel(
        id: json["id"],
        date: json["date"],
        commentaire_text: json["commentaire"],
        target_user: json["target_user"],
        username: json["username"],
        userphoto: json["userphoto"],
        nbre_com: json["nbre_com"],
        nbre_like_com: json["nbre_like_com"],
        is_like_com: json["is_like_com"],
        sub_responses: json["sub_responses"],
        comments: [], // Initialisation de la liste des commentaires à vide
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "commentaire": commentaire_text,
        "username": username,
        "target_user": target_user,
        "userphoto": userphoto,
        "nbre_com": nbre_com,
        "nbre_like_com": nbre_like_com,
        "sub_responses": sub_responses,
        "is_like_com": is_like_com,
        "comments": comments
            .map((comment) => comment.toJson())
            .toList(), // Convertit la liste de CommentShortModel en liste JSON
      };
}
