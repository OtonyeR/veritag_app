import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class ScannedProductService {
  static const String _scannedProductsKey = 'scannedProducts';

  Future<void> addScannedProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> scannedProducts =
        prefs.getStringList(_scannedProductsKey) ?? [];
    scannedProducts.add(product.toJson());
    await prefs.setStringList(_scannedProductsKey, scannedProducts);
  }

  Future<List<Product>> getScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> scannedProducts =
        prefs.getStringList(_scannedProductsKey) ?? [];
    return scannedProducts
        .map((productJson) => Product.fromJson(productJson))
        .toList();
  }

  Future<void> clearScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scannedProductsKey);
  }
}
