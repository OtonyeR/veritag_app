import 'package:flutter/material.dart';

import 'primary_button.dart';

class ImageField extends StatelessWidget {
  final void Function()? onPressedCam;
  final void Function()? onPressedGallery;
  final Widget imageDetail;

  const ImageField(
      {super.key,
        required this.onPressedCam,
        required this.onPressedGallery,
        required this.imageDetail});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Enter Product Image',
        style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(95, 99, 119, 1),
            fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 12),
      Container(
        // height: MediaQuery.sizeOf(context).height * 0.14,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(232, 255, 247, 0.3),
          border: const Border.fromBorderSide(BorderSide(
            color: Color.fromRGBO(0, 124, 130, 1.0),
          )),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPressedCam,
              icon: Image.asset('assets/camera_icon.png'),
            ),
            const SizedBox(height: 6),
            const Text(
              'Take Photo',
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(0, 124, 130, 1)
                  ,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            const Text(
              'Or',
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(95, 99, 119, 1),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              buttonText: 'Choose from gallery',
              buttonWidth: 214,
              buttonFunction: onPressedGallery,
            ),
            const SizedBox(height: 20),
            imageDetail
          ],
        ),
      )
    ]);
  }
}
