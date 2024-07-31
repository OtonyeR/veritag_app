import 'package:veritag_app/utils/constants.dart';

import '../../models/product.dart';
import '../product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:veritag_app/services/local_db.dart';
import 'package:veritag_app/widgets/veritag_appbar.dart';

class HistoryPageConsumer extends StatefulWidget {
  const HistoryPageConsumer({super.key});

  @override
  State<HistoryPageConsumer> createState() => _HistoryPageConsumerState();
}

enum ProductHistoryState { loading, loaded, error }

class _HistoryPageConsumerState extends State<HistoryPageConsumer> {
  final ScannedProductService _scannedProductService = ScannedProductService();
  List<Product> _scannedProducts = [];
  ProductHistoryState productHistoryState = ProductHistoryState.loading;
  String error = '';
  @override
  void initState() {
    super.initState();
    _fetchScannedProducts();
  }

  Future<void> _fetchScannedProducts() async {
     productHistoryState = ProductHistoryState.loading;
    try {
      final scannedProducts = await _scannedProductService.getScannedProducts();
      setState(() {
        _scannedProducts = scannedProducts;
        productHistoryState = ProductHistoryState.loaded;
      });
    }catch (e) {
      // Handle errors appropriately
      // print("Error fetching scanned products: $e");
      setState(() {
        error = e.toString();
        productHistoryState = ProductHistoryState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const VeritagAppbar(
          appbarTitle: 'Scan History',
          arrowBackRequired: false,
        ),
        body: switch (productHistoryState) {
          ProductHistoryState.loading => const Center(
              child: CircularProgressIndicator(
                color: colorPrimary,
              ),
            ),
          ProductHistoryState.loaded => SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24, top: 40),
                  child: Text(
                    'Recent Scans',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _scannedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _scannedProducts[index];
                        return ListTile(
                          leading: SizedBox(
                            height: 19.5,
                            width: 21.3,
                            child: Image.asset('assets/box_icon.png'),
                          ),
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
                      }),
                )
                //Placeholder
              ],
            )),
          ProductHistoryState.error => Center(
              child: Text(error),
            )
        });
  }
}
