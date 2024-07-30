import '../models/product.dart';
import '../services/remote_db.dart';
import 'package:flutter/material.dart';
import '../widgets/veritag_appbar.dart';
import 'package:veritag_app/views/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productService.getDataFromDb();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching products: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VeritagAppbar(
        appbarTitle: 'History',
        arrowBackRequired: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 40),
                    child: Text(
                      'Recently Added',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return ListTile(
                          leading: SizedBox(
                            height: 19.5,
                            width: 21.3,
                            child: Image.asset('assets/box_icon.png'),
                          ),
                          // Assuming productImage is a URL
                          title: Text(product.productName),
                          subtitle: Text(product.manufactureDate),
                          trailing: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      productInfo: product,
                                    ),
                                  ));
                            },
                            child: const Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}