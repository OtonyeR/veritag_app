import 'package:flutter/material.dart';
import 'package:veritag_app/manufacture_home/components/nfc_row_box.dart';
import 'package:veritag_app/manufacturer_form.dart';
import 'package:veritag_app/utils/color.dart';

class ManufactureHome extends StatelessWidget {
  const ManufactureHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomeHeaderBoxWidget(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 300,
                ),
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
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ManufacturerForm();
                          },
                        ));
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
}
