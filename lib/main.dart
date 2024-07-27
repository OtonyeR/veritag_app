import 'package:flutter/material.dart';
import 'package:veritag_app/location.dart';
import 'package:veritag_app/manufacture_screen.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VeriTag',
      theme: ThemeData(useMaterial3: true),
      home: const ManufactureScreen(),
    );
  }
}
