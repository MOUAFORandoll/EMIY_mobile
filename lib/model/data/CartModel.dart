// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    required this.id,
    // required this.index,
    // required this.type,
    required this.name,
    required this.time,
    required this.img,
    required this.quantity,
    required this.qtdispo,
    required this.prix,
    required this.isExist,
  });

  final int id;
  final String name;
  // final int index;
  // final String type;
  final String img;
  final int quantity;
  final int qtdispo;
  final double prix;
  final String time;
  final bool isExist;
  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        // index: json["index"] == null ? null : json["index"],
        // type: json["type"] == null ? null : json["type"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        img: json["img"] == null ? null : json["img"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        qtdispo: json["qtdispo"] == null ? null : json["qtdispo"],
        prix: json["prix"] == null ? null : json["prix"],
        time: json["time"] == null ? null : json["time"],
        isExist: json["isExist"] == null ? null : json["isExist"],
      );

  Map<String, dynamic> toJson() => {
        // "index": index == null ? null : index,
        // "type": type == null ? null : type,
        "id": id == null ? null : id,
        "img": img == null ? null : img,
        "quantity": quantity == null ? null : quantity,
        "qtdispo": qtdispo == null ? null : qtdispo,
        "name": name == null ? null : name,
        "prix": prix == null ? null : prix,
        "time": time == null ? null : time,
        "isExist": isExist == null ? null : isExist,
      };
}
