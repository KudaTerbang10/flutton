import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:textfield/models/productModel.dart';
import 'package:textfield/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Texter extends StatefulWidget {
  const Texter({Key? key}) : super(key: key);

  @override
  State<Texter> createState() => _TexterState();
}

class _TexterState extends State<Texter> {
  var productNameController = new TextEditingController();
  var productPriceController = new TextEditingController();
  var productCategoryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add),
        title: Text("Add Products"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset('img/loli.png',
                width: 200,
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                colorBlendMode: BlendMode.modulate),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    newField('Nama Produk', 'Tambahkan nama produk',
                        productNameController, false, Icons.dinner_dining),
                    newField('Harga', '1500', productPriceController, false,
                        Icons.discount),
                    newField('Kategori', 'makanan | minuman',
                        productCategoryController, false, Icons.category),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _insertData(
                                  productNameController.text,
                                  productPriceController.text,
                                  productCategoryController.text);
                            },
                            child: Text('Insert Data'))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container newField(String label, String hint,
      TextEditingController controller, bool obscure, IconData iconData) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
            child: Icon(
              iconData,
              color: Colors.blue,
            ),
          ),
        ),
        textAlign: TextAlign.left,
        cursorColor: Colors.deepOrange,
        style: TextStyle(color: Colors.blue, fontSize: 20),
        onChanged: (value) {
          setState(() {});
        },
        controller: controller,
        obscureText: obscure,
      ),
    );
  }

  Future<void> _insertData(
      String namaProduk, String harga, String kategori) async {
    // var _id = M.ObjectId();
    final data =
        productModel(namaProduk: namaProduk, harga: harga, kategori: kategori);
    var result = await MongoDatabase.insert(data);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data produk ${namaProduk} ditambahkan")));
    _clearAll();
  }

  void _clearAll() {
    productNameController.text = "";
    productPriceController.text = "";
    productCategoryController.text = "";
  }
}
