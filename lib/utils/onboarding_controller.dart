import 'package:flutter/material.dart';

class OnboardingController with ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage < 2) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      notifyListeners();
    }
  }

  void skipToEnd() {
    currentPage = 2;
    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }
}
