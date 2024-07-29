import 'views/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:veritag_app/utils/bottom_nav.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VeriTag',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        }),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'onboarding',
      routes: {
        'onboarding': (context) => const OnboardingScreen(),
        'bnav': (context) => const BottomNav(),
      },
    );
  }
}
