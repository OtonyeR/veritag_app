import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veritag_app/utils/color.dart';

class NfcRowBox extends StatelessWidget {
  const NfcRowBox({
    super.key,
    required this.image,
    required this.title,
    this.color,
    this.onTap,
  });

  final String image;
  final String title;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 137,
        width: 144,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeaderBoxWidget extends StatelessWidget {
  final bool isManufacturer;

  const HomeHeaderBoxWidget({
    super.key,
    required this.isManufacturer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 267,
      width: double.maxFinite,
      color: colorsClass.greenColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 246,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Welcome to VeriTag',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isManufacturer == true
                        ? 'Set and read your product tags'
                        : 'Scan to verify a product',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
    );
  }
}
