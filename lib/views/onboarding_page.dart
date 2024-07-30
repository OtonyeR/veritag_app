import '../utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';
import '../utils/onboarding_controller.dart';
import 'package:veritag_app/views/router_screen.dart';

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
      description: 'We have a solution for you!',
    ),
    OnboardingModel(
      image: 'assets/illustrations/ndi1.png',
      title: 'With your NFC enabled device',
      description: 'Streamline your production process and get the most out of it!',
    ),
    OnboardingModel(
      image: 'assets/illustrations/ndi1.png',
      title: 'Simple and Fast',
      description: 'Just like that, you know your product',
    ),
  ];

  @override
  void dispose() {
    _controller.pageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            bottom: 0,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 32)
                    height: 195.68,
                    width: 273.31,
                    child: Image.asset(page.image),
                  ),
                  const SizedBox(height: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          page.title,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    ),
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
                onPressed: () {
                  // Navigates to RouterScreen when "Skip" is pressed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RouterScreen(),
                    ),
                  );
                },
                child: const Text('Skip'),
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
            left: _controller.currentPage == onboardingPages.length - 1 ? null : 20,
            right: _controller.currentPage == onboardingPages.length - 1 ? 20 : null,
            child: TextButton(
              onPressed: () {
                if (_controller.currentPage == onboardingPages.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RouterScreen(),
                    ),
                  );
                } else {
                  _controller.nextPage();
                }
              },
              child: Text(
                _controller.currentPage == onboardingPages.length - 1
                    ? 'Start'
                    : 'Next',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
