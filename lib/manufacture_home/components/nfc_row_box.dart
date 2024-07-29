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
