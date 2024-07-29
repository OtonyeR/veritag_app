import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:veritag_app/manufacture_home/maufacture_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veritag_app/firebase_options.dart';
import 'package:veritag_app/utils/bottom_nav.dart';
import 'package:veritag_app/views/onboarding_page.dart';
import 'package:veritag_app/views/splashscreen.dart';
import 'package:veritag_app/views/router_screen.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:
            GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme.apply()),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        }),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ManufacturerForm(),
    );
  }
}
