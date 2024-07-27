import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'manufacturer_form.dart';
import 'package:veritag_app/homepage.dart';
import 'package:veritag_app/manufacture_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VeriTag',
      theme: ThemeData(useMaterial3: true),
      // home: const ManufactureScreen(),
      home: const ManufacturerForm(),
    );
  }
}
