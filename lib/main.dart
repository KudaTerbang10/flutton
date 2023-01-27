import 'package:flutter/material.dart';
import 'package:textfield/views/productView.dart';
import 'package:textfield/views/addProduct.dart';
import 'package:textfield/views/updateProduct.dart';

import 'dbHelper/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutton',
      debugShowCheckedModeBanner: false,
      home: productView(),
      // home: productUpdate(),
    );
  }
}
