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
