import 'package:flutter/material.dart';
import 'package:textfield/models/productModel.dart';
import 'package:textfield/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:textfield/views/productView.dart';

class addProduct extends StatefulWidget {
  const addProduct({Key? key}) : super(key: key);

  @override
  State<addProduct> createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  var productNameController = new TextEditingController();
  var productPriceController = new TextEditingController();
  var productCategoryController = new TextEditingController();
  var productImgPathController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // productModel data =
    //     ModalRoute.of(context)?.settings.arguments as productModel;

    // if (data != null) {
    //   // productNameController.text = data.namaProduk;
    //   // productPriceController.text = data.harga;
    //   // productCategoryController.text = data.kategori;
    //   productImgPathController.text = data.imgPath;
    //   _checkInsertUpdate = "Update";
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 175, 157),
        leading: Icon(Icons.add),
        title: Text('Add Product'),
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
                    newField('Nama Produk', productNameController, false,
                        Icons.dinner_dining),
                    newField(
                        'Harga', productPriceController, false, Icons.discount),
                    newField('Kategori', productCategoryController, false,
                        Icons.category),
                    newField(
                        'Image', productImgPathController, false, Icons.image),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _insertData(
                                productNameController.text,
                                int.parse(productPriceController.text),
                                productCategoryController.text,
                                productImgPathController.text,
                              );
                            },
                            child: Text('Add'))
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

  Container newField(String label, TextEditingController controller,
      bool obscure, IconData iconData) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
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
      String namaProduk, int harga, String kategori, String imgPath) async {
    var _id = M.ObjectId();
    final data = productModel(
        id: _id,
        namaProduk: namaProduk,
        harga: harga,
        kategori: kategori,
        imgPath: imgPath);
    var result = await MongoDatabase.insert(data)
        .whenComplete(() => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return productView();
              },
            )))
        .then((value) {
      setState(() {});
    });
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Data produk ${namaProduk} ditambahkan")));
    // _clearAll();
  }

  void _clearAll() {
    productNameController.text = "";
    productPriceController.text = "";
    productCategoryController.text = "";
    productImgPathController.text = "";
  }
}
