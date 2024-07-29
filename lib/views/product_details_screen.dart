import 'package:flutter/material.dart';
import 'package:veritag_app/widgets/appbar.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(appBarTitle: 'Product Details'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
