import '../utils/constants.dart';
import '../utils/bottom_nav.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/onboarding_model.dart';
import '../utils/onboarding_controller.dart';


class OnboardingScreen extends StatelessWidget {
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'Tried of fake products?',
      description: 'We have a solution for you!',
      lottieAnimation: 'https://lottie.host/b86c6859-7f83-4740-8034-5917455d6ee6/s3sbl78wzy.json',
    ),
    OnboardingModel(
      title: 'With your NFC enabled device',
      description: 'Use our app to tap and verify products!',
      lottieAnimation: 'https://lottie.host/c99440e1-133e-46ec-bbcc-dd972373cc32/3z2CeRIrw3.json',
    ),
    OnboardingModel(
      title: 'Simple and Fast',
      description: 'Just like that, you know your product',
      lottieAnimation: 'https://lottie.host/b53086ff-52cc-4b40-ba6f-662ff6c73b9d/smgMrU7w4Z.json',
    ),
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingController>(
        builder: (context, controller, child) {
          return Stack(
            children: [
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.currentPage = index;
                  controller.notifyListeners();
                },
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  final page = onboardingPages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.network(page.lottieAnimation),
                      const SizedBox(height: 18),
                      Text(
                        page.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page.description,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.skipToEnd();
                      },
                      child: const Text('Skip'),
                    ),
                    Row(
                      children: List.generate(
                        onboardingPages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: controller.currentPage == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage == index
                                ? colorPrimary
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.currentPage == onboardingPages.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNav(),
                            ),
                          );
                        } else {
                          controller.nextPage();
                        }
                      },
                      child: Text(
                        controller.currentPage == onboardingPages.length - 1
                            ? 'Start'
                            : 'Next',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}