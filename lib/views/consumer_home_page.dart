import 'package:flutter/material.dart';
import 'package:veritag_app/utils/color.dart';
import 'package:veritag_app/views/product_details_screen.dart';
import 'package:veritag_app/widgets/bottom_sheet.dart';
import 'package:veritag_app/views/manufacture_home/components/nfc_row_box.dart';

import '../models/product.dart';
import '../services/nfc_services.dart';
import '../services/remote_db.dart';

class ConsumerHomePage extends StatelessWidget {
  final NfcService _nfc = NfcService();
  final ProductService _productService = ProductService();

  ConsumerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomeHeaderBoxWidget(
            isManufacturer: false,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 300,
                ),
                Image.asset(
                  'assets/vgroup.png',
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white,
              shape: const BeveledRectangleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NfcRowBox(
                      image: 'assets/scan_nfc.png',
                      title: 'Verify Product',
                      color: colorsClass.pinkColor,
                      onTap: () async {
                        final nfcData = await _nfc.readNfc();
                        _fetchDataAndNavigate(context, nfcData);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchDataAndNavigate(
      BuildContext context, String nfcData) async {
    final product = await _productService.getSpecificProductByUid(nfcData);
    if (product != null) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ScanBottomSheet(
            title: 'Done',
            icon: SizedBox(
                height: 108,
                width: 108,
                child: Image.asset(
                  'assets/done_icon.png',
                  fit: BoxFit.cover,
                )),
            buttonPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    productInfo: product,
                  ),
                ),
              );
            },
            buttonText: 'See Result',
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product not found')),
      );
    }
  }
}
