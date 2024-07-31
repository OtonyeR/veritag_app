import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';
import '../utils/onboarding_controller.dart';
import 'package:veritag_app/views/router_screen.dart';
import 'package:veritag_app/utils/app_state.dart'; // Import AppState

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingController _controller = OnboardingController();

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'assets/illustrations/ndi-nne.png',
      title: 'Tired of fake products?',
      description:
          'We have a solution for you!\nLet’s go unravel those products!',
    ),
    OnboardingModel(
      image: 'assets/illustrations/scan1.png',
      title: 'With your NFC enabled device',
      description:
          'Streamline your production process\n and get the most out of it!',
    ),
    OnboardingModel(
      image: 'assets/illustrations/ndi1.png',
      title: 'Simple and Fast',
      description: 'Just like that, you`ve discovered more',
    ),
  ];

  @override
  void dispose() {
    _controller.pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() async {
    await AppState.instance.completeOnboarding();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RouterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            bottom: -65,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/illustrations/o-bg.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // PageView for onboarding
          PageView.builder(
            controller: _controller.pageController,
            onPageChanged: (index) {
              setState(() {
                _controller.currentPage = index;
              });
            },
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              final page = onboardingPages[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 195.68,
                    width: 273.31,
                    child: Image.asset(page.image),
                  ),
                  const SizedBox(height: 150),
                  Text(
                    page.title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    page.description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              );
            },
          ),

          // Conditional Skip Button
          if (_controller.currentPage < onboardingPages.length - 1)
            Positioned(
              top: 30,
              right: 20,
              child: TextButton(
                onPressed: _finishOnboarding,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorPrimary,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),

          // Dot controllers
          Positioned(
            bottom: 100, // here to adjust the position of the dots
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingPages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _controller.currentPage == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _controller.currentPage == index
                          ? colorSec
                          : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Conditional Next Button
          Positioned(
            top: 30,
            left: _controller.currentPage == onboardingPages.length - 1
                ? null
                : 20,
            right: _controller.currentPage == onboardingPages.length - 1
                ? 20
                : null,
            child: TextButton(
              onPressed: () {
                if (_controller.currentPage == onboardingPages.length - 1) {
                  _finishOnboarding();
                } else {
                  _controller.nextPage();
                }
              },
              child: Text(
                _controller.currentPage == onboardingPages.length - 1
                    ? 'Start'
                    : 'Next',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: colorPrimary,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
