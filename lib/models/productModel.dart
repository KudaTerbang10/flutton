import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

productModel mongoDbModelFromJson(String str) =>
    productModel.fromJson(json.decode(str));

String mongoDbModelToJson(productModel data) => json.encode(data.toJson());

class productModel {
  productModel({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.kategori,
    required this.imgPath,
  });

  ObjectId id;
  String namaProduk;
  int harga;
  String kategori;
  String imgPath;

  factory productModel.fromJson(Map<String, dynamic> json) => productModel(
        id: json["_id"],
        namaProduk: json["namaProduk"],
        harga: json["harga"],
        kategori: json["kategori"],
        imgPath: json["imgPath"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "namaProduk": namaProduk,
        "harga": harga,
        "kategori": kategori,
        "imgPath": imgPath,
      };
}
