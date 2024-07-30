import 'package:flutter/material.dart';
import 'package:veritag_app/manufacturer_form.dart';
import 'package:veritag_app/test_read_page.dart';
import 'package:veritag_app/utils/size.dart';
import 'package:veritag_app/views/manufacture_home/components/nfc_row_box.dart';
import 'package:veritag_app/utils/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height(context) * 0.35,
                ),
                Positioned(
                    child: Container(
                  width: width(context) * 0.85,
                  child: Center(
                      child: Container(
                    color: Colors.pink,
                    child: Column(
                      children: [],
                    ),
                  )),
                ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
