import 'package:flutter/material.dart';

class ColorsClass {
  Color greenColor = const Color(0xff007C82);
  Color pinkColor = const Color(0xffFB6C8A);

  List<Color> loadingGradient = [
    Colors.grey.withOpacity(1),
    Colors.grey,
  ];
}

ColorsClass get colorsClass => ColorsClass();
