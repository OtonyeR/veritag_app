import 'package:flutter/material.dart';
import 'package:veritag_app/manufacture_home/components/nfc_row_box.dart';
import 'package:veritag_app/utils/color.dart';

class ManufactureHome extends StatelessWidget {
  const ManufactureHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 267,
            width: 393,
            color: colorsClass.greenColor,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 246,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome to VERItag',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          'Get to set/write a Tag as a manufacturer and Read/Scan a Tag as a customer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/veritag.png',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NfcRowBox(
                      image: 'assets/scan_nfc.png',
                      title: 'Verify tag',
                      color: colorsClass.pinkColor,
                      onTap: () {},
                    ),
                    NfcRowBox(
                      image: 'assets/add.png',
                      title: 'Add product',
                      color: colorsClass.greenColor,
                      onTap: () {},
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
}
