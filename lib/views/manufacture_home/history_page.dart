import '../../models/product.dart';
import '../../services/remote_db.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/veritag_appbar.dart';
import 'package:veritag_app/views/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

enum ProductHistoryState { loading, loaded, error }

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  ProductHistoryState productHistoryState = ProductHistoryState.loading;
  String error = 'We encountered problems getting your product';

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
        // _isLoading = false;
        productHistoryState = ProductHistoryState.loaded;
      });
    } catch (e) {
      setState(() {
        //   _isLoading = false;
        productHistoryState = ProductHistoryState.error;
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
        body: switch (productHistoryState) {
          ProductHistoryState.loading => const Center(
              child: CircularProgressIndicator(
                color: colorPrimary,
              ),
            ),
          ProductHistoryState.loaded => SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Recently Added',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return Column(
                            children: [
                              ListTile(
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
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                            productInfo: product,
                                          ),
                                        ));
                                  },
                                  child: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Divider(
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ProductHistoryState.error => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Center(
                child: Text(error),
              ),
            )
        });
  }
}
