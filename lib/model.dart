import 'dart:convert';

class Product {
  final String uid;
  final String productName;
  Product({
    required this.uid,
    required this.productName,
  });

  Product copyWith({
    String? uid,
    String? productName,
  }) {
    return Product(
      uid: uid ?? this.uid,
      productName: productName ?? this.productName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'productName': productName,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      uid: map['uid'] ?? '',
      productName: map['productName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() => 'Product(uid: $uid, productName: $productName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.uid == uid &&
      other.productName == productName;
  }

  @override
  int get hashCode => uid.hashCode ^ productName.hashCode;
}
