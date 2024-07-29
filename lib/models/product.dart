class Product {
  final String uid; // unique id generated from uuid
  final String manufacturerName; // Name of manufacturer
  final String productName; // Name of product
  final String productImage; //Image uploaded with image_picker package
  final DateTime manufactureDate; //Current date gotten from time of product register
  final String manufactureLocation; //manufacture location from geolocation api
  final bool isSentOut;  // Indicates if the product has been sent out from the manufacturer
  String? productDescription; //brief description of product (optional)

  Product({
    required this.uid,
    required this.manufacturerName,
    required this.productName,
    required this.productImage,
    required this.manufactureDate,
    required this.manufactureLocation,
    this.productDescription,
    required this.isSentOut,
  });
}
