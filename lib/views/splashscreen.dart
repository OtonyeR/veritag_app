import 'dart:async';
import 'package:flutter/material.dart';
import 'package:veritag_app/utils/app_state.dart';
import 'package:veritag_app/utils/constants.dart';
import 'package:veritag_app/views/router_screen.dart';
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
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AppState.instance.onboardingCompleted
                ? const RouterScreen()
                : const OnboardingScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: const Center(
        child: Image(
          image: AssetImage('assets/vlogow.png'),
        ),
      ),
    );
  }
}
