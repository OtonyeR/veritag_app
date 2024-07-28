import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

//add list of products to db
  Future<void> addDataToDb(List<Product> products) async {
    for (var product in products) {
      await _db
          .collection("testproducts")
          .doc(product.uid)
          .set(product.toMap());
    }
  }

//Gets all products in db.
  Future<List<Product>> getDataFromDb() async {
    final querySnapshot = await _db.collection("testproducts").get();
    return querySnapshot.docs.map((e) => Product.fromMap(e.data())).toList();
  }

  Future<Product?> getSpecificProductByUid(String uid) async {
    final docSnapshot = await _db.collection("testproducts").doc(uid).get();
    if (docSnapshot.exists) {
      return Product.fromMap(docSnapshot.data()!);
    } else {
      return null;
    }
  }
}
