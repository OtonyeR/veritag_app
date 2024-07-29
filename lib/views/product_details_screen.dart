import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/size.dart';
import '../utils/constants.dart';
import '../widgets/details_tile.dart';


class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

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
                  image: DecorationImage(
                    image: AssetImage('assets/placeholder.jpg'),
                    // Your image asset path
                    fit: BoxFit
                        .cover, // Adjust the fit as needed (cover, contain, fill, etc.)
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child:               SingleChildScrollView(
                    child: Column(children: [
                      const DetailTile(
                          detailTitle: 'Product Name', detailInfo: 'Tape Of Healing'),
                      const DetailTile(
                          detailTitle: 'Product Name', detailInfo: 'Tape Of Healing'),
                      const DetailTile(
                          detailTitle: 'Product Name', detailInfo: 'Tape Of Healing'),
                      const DetailTile(
                          detailTitle: 'Product Name', detailInfo: 'Tape Of Healing'),
                      const DetailTile(
                          detailTitle: 'Product Name', detailInfo: 'Tape Of Healing'),
                      const DetailTile(
                          detailTitle: 'Product Name', detailInfo: 'Tape Of Healing'),
                      const DetailTile(
                          detailTitle: 'Product Name', detailInfo: 'Tape Of Healing'),
                    ]))

              )
            ],
          ),
        ),
      ),
    );
  }
}

