import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

productModel mongoDbModelFromJson(String str) =>
    productModel.fromJson(json.decode(str));

String mongoDbModelToJson(productModel data) => json.encode(data.toJson());

class productModel {
  productModel({
    required this.namaProduk,
    required this.harga,
    required this.kategori,
  });

  String namaProduk;
  String harga;
  String kategori;

  factory productModel.fromJson(Map<String, dynamic> json) => productModel(
        namaProduk: json["namaProduk"],
        harga: json["harga"],
        kategori: json["kategori"],
      );

  Map<String, dynamic> toJson() => {
        "namaProduk": namaProduk,
        "harga": harga,
        "kategori": kategori,
      };
}
