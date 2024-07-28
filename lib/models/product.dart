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

  Product copyWith({
    String? uid,
    String? productName,
    String? manufacturerName,
    String? productImage,
    DateTime? manufactureDate,
    String? manufactureLocation,
    bool? isSentOut,
    String? productDescription,
  }) {
    return Product(
      uid: uid ?? this.uid,
      productName: productName ?? this.productName,
      manufacturerName: manufacturerName ?? this.manufacturerName,
      productImage: productImage ?? this.productImage,
      manufactureDate: manufactureDate ?? this.manufactureDate,
      manufactureLocation: manufactureLocation ?? this.manufactureLocation,
      isSentOut: isSentOut ?? this.isSentOut,
      productDescription: productDescription ?? this.productDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'productName': productName,
      'manufacturerName': manufacturerName,
      'productImage': productImage,
      'manufactureDate': manufactureDate.toIso8601String(),
      'manufactureLocation': manufactureLocation,
      'isSentOut': isSentOut,
      'productDescription': productDescription,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      uid: map['uid'] ?? '',
      productName: map['productName'] ?? '',
      manufacturerName: map['manufacturerName'] ?? '',
      productImage: map['productImage']??'',
      manufactureDate: DateTime.parse(map['manufactureDate']),
      manufactureLocation: map['manufactureLocation'] ?? '',
      isSentOut: map['isSentOut'] ?? false,
      productDescription: map['productDescription']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(uid: $uid, productName: $productName, manufacturerName: $manufacturerName, productImage: $productImage, manufactureDate: $manufactureDate, manufactureLocation: $manufactureLocation, isSentOut: $isSentOut, productDescription: $productDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
      other.uid == uid &&
      other.productName == productName &&
      other.manufacturerName == manufacturerName &&
      other.productImage == productImage &&
      other.manufactureDate == manufactureDate &&
      other.manufactureLocation == manufactureLocation &&
      other.isSentOut == isSentOut &&
      other.productDescription == productDescription;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      productName.hashCode ^
      manufacturerName.hashCode ^
      productImage.hashCode ^
      manufactureDate.hashCode ^
      manufactureLocation.hashCode ^
      isSentOut.hashCode ^
      productDescription.hashCode;
  }
}
