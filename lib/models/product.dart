import 'dart:convert';

class Product {
  final String uid; // unique id generated from uuid
  final String manufacturerName; // Name of manufacturer
  final String productName; // Name of product
  final String productPrice;
  final String productImage; //Image uploaded with image_picker package
  final String manufactureDate; //Current date gotten from time of product register
  final String manufactureLocation; //manufacture location from geolocation api
  String? productDescription; //brief description of product (optional)
  String? additionalInfo; //brief description of product (optional)


  Product({
    required this.uid,
    required this.manufacturerName,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.manufactureDate,
    required this.manufactureLocation,
    this.productDescription,
    this.additionalInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'manufacturerName': manufacturerName,
      'productName': productName,
      'productImage': productImage,
      'manufactureDate': manufactureDate,
      'manufactureLocation': manufactureLocation,
      'productDescription': productDescription,
      'additionalInfo': additionalInfo,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      uid: map['uid'] ?? '',
      manufacturerName: map['manufacturerName'] ?? '',
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productImage: map['productImage'] ?? '',
      manufactureDate: map['manufactureDate'],
      manufactureLocation: map['manufactureLocation'] ?? '',
      productDescription: map['productDescription'] ?? '',
      additionalInfo: map['additionalInfo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}