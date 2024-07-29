import 'dart:async';
import 'package:flutter/material.dart';
import 'package:veritag_app/utils/constants.dart';
import 'package:veritag_app/views/onboarding_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorPrimary,
        child: const Image(
          image: AssetImage('assets/logo.png'))
        );
  }
}
