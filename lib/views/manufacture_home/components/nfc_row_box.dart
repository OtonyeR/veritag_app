import 'package:flutter/material.dart';
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
  const HomeHeaderBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 267,
      width: double.infinity, // Updated to use double.infinity for full width
      color: colorsClass.greenColor,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 246,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome to VeriTag',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    maxLines: 1, // Ensure the text stays on one line
                    overflow: TextOverflow.ellipsis, // Handle overflow
                    textAlign: TextAlign.center, // Center align text
                  ),
                  Text(
                    'Set/write a Tag as a manufacturer and Read Tag as a customer',
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
    );
  }
}
