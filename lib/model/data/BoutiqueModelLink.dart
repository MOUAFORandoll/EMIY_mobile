/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myBoutiqueModelLinkNode = BoutiqueModelLink.fromJson(map);
*/
class Image {
  int? id;
  String? src;

  Image({this.id, this.src});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['src'] = src;
    return data;
  }
}

class Localisation {
  String? ville;
  double? longitude;
  double? latitude;

  Localisation({this.ville, this.longitude, this.latitude});

  Localisation.fromJson(Map<String, dynamic> json) {
    ville = json['ville'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ville'] = ville;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class Produit {
  int? id;
  String? codeProduit;
  String? titre;
  int? quantite;
  int? prix;
  bool? negociable;
  bool? status;
  String? date;
  String? description;
  List<Image?>? images;

  Produit(
      {this.id,
      this.codeProduit,
      this.titre,
      this.quantite,
      this.prix,
      this.negociable,
      this.status,
      this.date,
      this.description,
      this.images});

  Produit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeProduit = json['codeProduit'];
    titre = json['titre'];
    quantite = json['quantite'];
    prix = json['prix'];
    negociable = json['negociable'];
    status = json['status'];
    date = json['date '];
    description = json['description'];
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((v) {
        images!.add(Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['codeProduit'] = codeProduit;
    data['titre'] = titre;
    data['quantite'] = quantite;
    data['prix'] = prix;
    data['negociable'] = negociable;
    data['status'] = status;
    data['date '] = date;
    data['description'] = description;
    data['images'] =
        images != null ? images!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class BoutiqueModelLink {
  String? codeBoutique;
  String? user;
  String? description;
  String? titre;
  bool? status;
  int? note;
  bool? statusabonnement;
  String? dateCreated;
  List<Image?>? images;
  Localisation? localisation;
  List<Produit?>? produits;

  BoutiqueModelLink(
      {this.codeBoutique,
      this.user,
      this.description,
      this.titre,
      this.status,
      this.note,
      this.statusabonnement,
      this.dateCreated,
      this.images,
      this.localisation,
      this.produits});

  BoutiqueModelLink.fromJson(Map<String, dynamic> json) {
    codeBoutique = json['codeBoutique'];
    user = json['user'];
    description = json['description'];
    titre = json['titre'];
    status = json['status'];
    note = json['note'];
    statusabonnement = json['status_abonnement'];
    dateCreated = json['dateCreated'];
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((v) {
        images!.add(Image.fromJson(v));
      });
    }
    localisation = json['localisation'] != null
        ? Localisation?.fromJson(json['localisation'])
        : null;
    if (json['produits'] != null) {
      produits = <Produit>[];
      json['produits'].forEach((v) {
        produits!.add(Produit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['codeBoutique'] = codeBoutique;
    data['user'] = user;
    data['description'] = description;
    data['titre'] = titre;
    data['status'] = status;
    data['note'] = note;
    data['status_abonnement'] = statusabonnement;
    data['dateCreated'] = dateCreated;
    data['images'] =
        images != null ? images!.map((v) => v?.toJson()).toList() : null;
    data['localisation'] = localisation!.toJson();
    data['produits'] =
        produits != null ? produits!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
