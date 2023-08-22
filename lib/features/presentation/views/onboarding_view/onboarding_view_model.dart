import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int currentPageIndex = 0;

  final List<Map<String, String?>> onboardingData = [
    {
      'text1': 'Lorem',
      'text2': 'Ipsum dolor sit',
      'text3': 'Ask the bot anything, It’s always ready to help!',
      'imagePath': 'assets/icons/onboard1.png',
    },
    {
      'text1': 'Lorem',
      'text2': 'Ipsum dolor sit',
      'text3': 'Get the best answers from our application Enjoy!',
      'imagePath': 'assets/icons/onboard2.png',
    },
  ];

  void nextPage() {
    if (currentPageIndex < onboardingData.length - 1) {
      currentPageIndex++;
      notifyListeners();
    }
  }
}
