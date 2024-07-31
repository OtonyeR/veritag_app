import '../utils/size.dart';
import '../models/product.dart';
import '../utils/constants.dart';
import '../widgets/details_tile.dart';
import 'package:flutter/material.dart';



class ProductDetailsScreen extends StatelessWidget {
  final Product productInfo;

  const ProductDetailsScreen({super.key, required this.productInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: colorBg,
            )),
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorBg,
          ),
        ),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Container(
                height: height(context) * 0.27,
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: const Border.fromBorderSide(BorderSide(width: 1.79,)),
                  image: DecorationImage(
                    image: NetworkImage(productInfo.productImage),
                    // Your image asset path
                    fit: BoxFit
                        .cover, // Adjust the fit as needed (cover, contain, fill, etc.)
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DetailTile(
                          detailTitle: 'Product Name',
                          detailInfo: productInfo.productName),
                      DetailTile(
                          detailTitle: 'Manufacturer Name',
                          detailInfo: productInfo.manufacturerName),
                      DetailTile(
                          detailTitle: 'Manufacturer Location',
                          detailInfo: productInfo.manufactureLocation),
                      DetailTile(
                          detailTitle: 'Manufacture Date',
                          detailInfo: productInfo.manufactureDate),
                      DetailTile(
                          detailTitle: 'Product Price',
                          detailInfo: productInfo.productPrice),
                      DetailTile(
                          detailTitle: 'Product Description',
                          detailInfo: productInfo.productDescription!),
                      DetailTile(
                          detailTitle: 'Additional Info',
                          detailInfo: productInfo.additionalInfo!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}