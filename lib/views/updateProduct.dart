import 'package:flutter/material.dart';
import 'package:textfield/dbHelper/mongodb.dart';
import 'package:textfield/models/productModel.dart';
import 'package:textfield/views/addProduct.dart';

class productUpdate extends StatefulWidget {
  @override
  State<productUpdate> createState() => _productUpdateState();
}

class _productUpdateState extends State<productUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.edit_note),
        title: Text("Update Product"),
        centerTitle: true,
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
      body: FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return displayCard(
                      productModel.fromJson(snapshot.data[index]));
                },
              );
            } else {
              return Center(
                child: Text('No Data Found'),
              );
            }
          }
        },
      ),
    );
  }

  Container displayCard(productModel data) {
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
                        Text(' - ${data.id.$oid}',
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
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.thumb_up,
                            color: Colors.grey,
                          )),
                      Text('20'),
                      Spacer(
                        flex: 5,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.comment, color: Colors.grey)),
                      Text('23'),
                      Spacer(
                        flex: 5,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return addProduct();
                                    },
                                    settings: RouteSettings(arguments: data)));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                      Text('Edit'),
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
}
