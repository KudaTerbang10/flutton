import 'package:flutter/material.dart';
import 'package:textfield/models/productModel.dart';
import 'package:textfield/dbHelper/mongodb.dart';

class editProduct extends StatefulWidget {
  const editProduct({Key? key}) : super(key: key);

  @override
  State<editProduct> createState() => _editProductState();
}

class _editProductState extends State<editProduct> {
  var productNameController = new TextEditingController();
  var productPriceController = new TextEditingController();
  var productCategoryController = new TextEditingController();
  var productImgPathController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    productModel data =
        ModalRoute.of(context)!.settings.arguments as productModel;

    // if (data != null) {
    //   productNameController.text = data.namaProduk;
    //   productPriceController.text = data.harga;
    //   productCategoryController.text = data.kategori;
    productImgPathController.text = data.imgPath;
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 175, 157),
        leading: Icon(Icons.add),
        title: Text('Update Data'),
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
                        Icons.dinner_dining, data.namaProduk),
                    newField('Harga', productPriceController, false,
                        Icons.discount, data.harga.toString()),
                    newField('Kategori', productCategoryController, false,
                        Icons.category, data.kategori),
                    newField('Image', productImgPathController, false,
                        Icons.image, data.imgPath),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _updateData(
                                  data.id,
                                  productNameController.text,
                                  int.parse(productPriceController.text),
                                  productCategoryController.text,
                                  productImgPathController.text);
                            },
                            child: Text('Update'))
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
      bool obscure, IconData iconData, String hint) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
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

  Future<void> _updateData(var id, String namaProduk, int harga,
      String kategori, String imgPath) async {
    final updateData = productModel(
        id: id,
        namaProduk: namaProduk,
        harga: harga,
        kategori: kategori,
        imgPath: imgPath);

    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
  }
}
