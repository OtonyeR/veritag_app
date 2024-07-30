import '../models/product.dart';
import 'product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:veritag_app/services/local_db.dart';
import 'package:veritag_app/widgets/veritag_appbar.dart';


class HistoryPageConsumer extends StatefulWidget {
  const HistoryPageConsumer({super.key});

  @override
  State<HistoryPageConsumer> createState() => _HistoryPageConsumerState();
}

class _HistoryPageConsumerState extends State<HistoryPageConsumer> {
  final ScannedProductService _scannedProductService =
  ScannedProductService();
  List<Product> _scannedProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchScannedProducts();
  }

  Future<void> _fetchScannedProducts() async {
    try {
      final scannedProducts =
      await _scannedProductService.getScannedProducts();
      setState(() {
        _scannedProducts = scannedProducts;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching scanned products: $e");
      setState(() {
        _isLoading = false;
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
      body: SafeArea(
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

          

          //Placeholder
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('Rolex Submariner'),
            subtitle: const Text('08-07-2024'),
            trailing: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           const ScanNfcResultPage(isProductAuthentic: false),
                  //     ));
                },
                child: const Icon(Icons.arrow_forward_ios)),
          )
        ],
      )),
    );
  }
}