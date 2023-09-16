/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myBoutiqueModelLinkNode = BoutiqueModelLink.fromJson(map);
*/
import 'package:EMIY/model/data/ImageModel.dart';
import 'package:EMIY/utils/Services/apiUrl.dart';

import 'LocalisationModel.dart';

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
  List<ImageModel?>? images;

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
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
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
  bool? status_abonnement;
  String? lienBoutique;
  String? dateCreated;
  List<ImageModel?>? images;
  LocalisationModel? localisation;
  int? nombre_produit;
  List<Produit?>? produits;

  BoutiqueModelLink(
      {this.codeBoutique,
      this.user,
      this.description,
      this.titre,
      this.status,
      this.note,
      this.lienBoutique,
      this.status_abonnement,
      this.nombre_produit,
      this.dateCreated,
      this.images,
      this.localisation,
      this.produits});

  BoutiqueModelLink.fromJson(Map<String, dynamic> json) {
    codeBoutique = json['codeBoutique'];
    nombre_produit = json["nombre_produit"];
    user = json['user'];
    description = json['description'];
    lienBoutique = ApiUrl.external_link + 'boutiques/' + json["codeBoutique"];
    titre = json['titre'];
    status = json['status'];
    note = json['note'];
    status_abonnement = json['status_abonnement'];
    dateCreated = json['dateCreated'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    localisation = json['localisation'] != null
        ? LocalisationModel?.fromJson(json['localisation'])
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
    data['nombre_produit'] = nombre_produit;

    data['status'] = status;
    data['note'] = note;
    data['status_abonnement'] = status_abonnement;
    data['dateCreated'] = dateCreated;
    data['images'] =
        images != null ? images!.map((v) => v?.toJson()).toList() : null;
    data['localisation'] = localisation!.toJson();
    data['produits'] =
        produits != null ? produits!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
