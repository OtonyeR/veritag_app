// class Product {
//   final String uid; // unique id generated from uuid
//   final String manufacturerName; // Name of manufacturer
//   final String productName; // Name of product
//   final String productImage; //Image uploaded with image_picker package
//   final DateTime manufactureDate; //Current date gotten from time of product register
//   final List<Map<String, String>> manufactureLocation; //manufacture location from geolocation api
//   final bool isSentOut;  // Indicates if the product has been sent out from the manufacturer
//   String? productDescription; //brief description of product (optional)
//   Product({
//     required this.uid,
//     required this.manufacturerName,
//     required this.productName,
//     required this.productImage,
//     required this.manufactureDate,
//     required this.manufactureLocation,
//     required this.isSentOut,
//     this.productDescription,
//   });
// }

import 'dart:convert';

class Product {
  final String uid;
  final String productName;
  final String manufacturerName; 
  final String? productImage; 
  final DateTime manufactureDate;
  final String manufactureLocation;
  final bool isSentOut;  
  String? productDescription;

  Product({
    required this.uid,
    required this.productName,
    required this.manufacturerName,
    this.productImage,
    required this.manufactureDate,
    required this.manufactureLocation,
    required this.isSentOut,
    this.productDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'manufacturerName': manufacturerName,
      'productName': productName,
      'productImage': productImage,
      'manufactureDate': manufactureDate.millisecondsSinceEpoch,
      'manufactureLocation': manufactureLocation,
      'isSentOut': isSentOut,
      'productDescription': productDescription,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      uid: map['uid'] ?? '',
      manufacturerName: map['manufacturerName'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      manufactureDate: DateTime.fromMillisecondsSinceEpoch(map['manufactureDate']),
      manufactureLocation: map['manufactureLocation'] ?? '',
      isSentOut: map['isSentOut'] ?? false,
      productDescription: map['productDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
