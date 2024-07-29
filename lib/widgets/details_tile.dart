import 'package:flutter/material.dart';

import '../utils/constants.dart';

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
          style: TextStyle(
              fontSize: 18, color: colorPrimary, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Text(
          detailInfo, // Assuming this should be a different text
          style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(34, 34, 34, 1),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8),
        Divider(),
        SizedBox(height: 15),
      ],
    );
  }
}
