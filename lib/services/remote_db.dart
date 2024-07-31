import 'dart:io';
import '../models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> uploadProductImage(String imageName, String imagePath)  async {
    final file = File(imagePath);
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask =
        storageRef.child("images/$imageName").putFile(file, metadata);
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

//add list of products to db
  Future<void> addDataToDb(List<Product> products) async {
    for (var product in products) {
      await _db
          .collection("testproducts")
          .doc(product.uid)
          .set(product.toMap());
    }
  }

  Future<void> addProductToDb(Product product) async {
    await _db.collection("testproducts").doc(product.uid).set(product.toMap());
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

  Future<bool> isProductInDb(String uid) async {
    final docSnapshot = await _db.collection("testproducts").doc(uid).get();
    return docSnapshot.exists;
  }
}