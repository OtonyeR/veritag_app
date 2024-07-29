import 'package:flutter/material.dart';

import 'manufacturer_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VeriTag',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

      ),
      home: const ManufacturerForm(),
    );
  }
}


