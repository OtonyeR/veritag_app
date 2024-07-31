import '../utils/constants.dart';
import 'package:flutter/material.dart';


class DetailTile extends StatelessWidget {
  final String detailTitle;
  final String detailInfo;

  const DetailTile(
      {super.key, required this.detailTitle, required this.detailInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Added crossAxisAlignment
      children: [
        Text(
          detailTitle,
          style: const TextStyle(
              fontSize: 18, color: colorPrimary, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          detailInfo, // Assuming this should be a different text
          style: const TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(34, 34, 34, 1),
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 8),
        const Divider(height: ,),
        const SizedBox(height: 15),
      ],
    );
  }
}
