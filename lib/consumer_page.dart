import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:veritag_app/models/product.dart';

class ConsumerPage extends StatefulWidget {
  const ConsumerPage({super.key});

  @override
  State<ConsumerPage> createState() => _ConsumerPageState();
}

class _ConsumerPageState extends State<ConsumerPage> {
  late Future<Product?> _productFuture;

  Future<Product?> getDataFromDb() async {
    var db = FirebaseFirestore.instance;
    var rawData = <String, dynamic>{};
    await db.collection("testproducts").get().then((event) {
      for (var doc in event.docs) {
        debugPrint("${doc.id} => ${doc.data()}");
        rawData = doc.data();
      }
    });
    if (rawData.isNotEmpty) {
      return Product.fromMap(rawData);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _productFuture = getDataFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumer Page'),
      ),
      body: Center(
        child: FutureBuilder<Product?>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error loading product data');
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              Product? product = snapshot.data;
              if (product != null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Name: ${product.productName}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('Product UID: ${product.uid}'),
                      const SizedBox(height: 10),
                      Text('Manufacturer Name: ${product.manufacturerName}'),
                      const SizedBox(height: 10),
                      Text(
                          'Manufacture Date: ${product.manufactureDate.toString()}'),
                      const SizedBox(height: 10),
                      Text(
                          'Manufacture Location: ${product.manufactureLocation}'),
                      const SizedBox(height: 10),
                      Text(
                          'Product Description: ${product.productDescription}'),
                      const SizedBox(height: 10),
                      product.productImage!.isNotEmpty
                          ? Image.network(product.productImage!)
                          : const Text('No product image available'),
                    ],
                  ),
                );
              } else {
                return const Text('No product data found');
              }
            } else {
              return const Text('No product data found');
            }
          },
        ),
      ),
    );
  }
}
