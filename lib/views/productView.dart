import 'package:flutter/material.dart';
import 'package:textfield/dbHelper/mongodb.dart';
import 'package:textfield/models/productModel.dart';
import 'package:textfield/views/addProduct.dart';
import 'package:textfield/views/editProduct.dart';

class productView extends StatefulWidget {
  const productView({Key? key}) : super(key: key);

  @override
  State<productView> createState() => _productViewState();
}

class _productViewState extends State<productView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.cake),
        title: Text('Kak Babayan Shop'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 247, 175, 157),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return addProduct();
                  },
                ));
              },
              icon: Icon(Icons.add_circle))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                print("Total Data ${totalData.toString()}");
                return ListView.builder(
                  itemCount: totalData,
                  itemBuilder: (context, index) {
                    return newCard(productModel.fromJson(snapshot.data[index]));
                  },
                );
              } else {
                return Center(
                  child: Text("No Data Available"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Container newCard(productModel data) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 250,
                  child: Expanded(
                      child: Image.network(
                    '${data.imgPath}',
                    width: 150,
                    fit: BoxFit.cover,
                  )),
                ))
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                children: <Widget>[
                  Text(
                    '${data.namaProduk}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 249, 165, 144),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Warung Boedack',
                    style: TextStyle(
                        color: Color.fromARGB(255, 249, 165, 144),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Harga ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text('Rp. ${data.harga}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 247, 175, 157),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(
                        flex: 10,
                      ),
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.thumb_up,
                      //       color: Colors.grey,
                      //     )),
                      // Text('20'),
                      // Spacer(
                      //   flex: 5,
                      // ),
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(Icons.comment, color: Colors.grey)),
                      // Text('23'),
                      // Spacer(
                      //   flex: 5,
                      // ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return editProduct();
                                        },
                                        settings:
                                            RouteSettings(arguments: data)))
                                .then((value) {
                              setState(() {});
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                      Text('Edit'),
                      Spacer(
                        flex: 5,
                      ),
                      IconButton(
                          onPressed: () async {
                            // await MongoDatabase.delete(data);
                            // setState(() {});
                            showAlertDialog(context, data);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          )),
                      Text('Delete'),
                      Spacer(
                        flex: 10,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, productModel data) {
    // set up the buttons
    Widget cancelButton = OutlinedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.red),
      child: Text("Delete"),
      onPressed: () async {
        await MongoDatabase.delete(data);
        setState(() {});
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Data produk ${data.namaProduk} dihapus")));
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Konfirmasi Delete"),
      content: Text(
          "Apakah anda yakin ingin menghapus ${data.namaProduk} dari daftar produk?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
