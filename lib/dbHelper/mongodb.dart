import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:textfield/models/productModel.dart';
import 'package:textfield/dbHelper/constant.dart';

class MongoDatabase {
  static var db, productCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);

    productCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getDataMakanan() async {
    final arrData =
        await productCollection.find(where.eq('kategori', 'makanan')).toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getDataMinuman() async {
    final arrData =
        await productCollection.find(where.eq('kategori', 'minuman')).toList();
    return arrData;
  }

  static Future<void> update(productModel data) async {
    var result = await productCollection.findOne({"_id": data.id});
    result['namaProduk'] = data.namaProduk;
    result['harga'] = data.harga;
    result['kategori'] = data.kategori;
    result['imgPath'] = data.imgPath;
    var response = await productCollection.save(result);
    inspect(response);
  }

  static delete(productModel product) async {
    await productCollection.remove(where.id(product.id));
  }

  static Future<String> insert(productModel data) async {
    try {
      var result = await productCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong When Inserting Data";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
