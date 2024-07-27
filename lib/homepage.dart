import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:veritag_app/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var product = Product(uid: '12345', productName: 'Product 2');
  void addDataToDb() {
    var db = FirebaseFirestore.instance;
    // We shouldn't use add because we need to be able to set our id for the document.
    // set() is more appropriate.
    db.collection("testproducts").add(product.toMap());
  }

  Future<Product> getDataFromDb() async {
    var db = FirebaseFirestore.instance;
    var rawData = <String, dynamic>{};
    await db.collection("testproducts").get().then((event) {
      for (var doc in event.docs) {
        debugPrint("${doc.id} => ${doc.data()}");
        rawData = doc.data();
      }
    });
    return Product.fromMap(rawData);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: () {
                getDataFromDb();
              },
              child: const Text('Get data')),
          OutlinedButton(
              onPressed: () {
                addDataToDb();
              },
              child: const Text('Add data')),
          FutureBuilder(
            future: getDataFromDb(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                    'Product name: ${snapshot.data?.productName} Product uid: ${snapshot.data?.uid}');
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
