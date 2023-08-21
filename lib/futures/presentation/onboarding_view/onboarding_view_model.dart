import 'package:chat_gpt/futures/data/datasource/onboarding_local_datasource.dart';
import 'package:chat_gpt/futures/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/futures/data/models/onboarding_model.dart';
import 'package:chat_gpt/futures/presentation/home_view/home_view_model.dart';
import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PremiumLocalDataSource _premiumLocalDataSource =
      PremiumLocalDataSource();
  final OnboardingLocalDataSource _onboardingLocalDataSource =
      OnboardingLocalDataSource();
  final HomeViewModel _homeViewModel = HomeViewModel();

  int currentPageIndex = 0;
  bool isPremium = false;
  String firstMessage = "Hi, how can i help you?";
  String sender = 'robot';

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

  Future<void> init() async {
    await addFirstRobotMessage();
  }

  Future<void> addFirstRobotMessage() async {
    _homeViewModel.chatProvider.addMessage(firstMessage, sender);
  }

  void nextPage() {
    if (currentPageIndex < onboardingData.length - 1) {
      currentPageIndex++;
      notifyListeners();
    }
  }

  Future<void> createOnboard() async {
    OnboardingModel model = OnboardingModel(firstOpen: false);
    await _onboardingLocalDataSource.create(model);
  }

  Future<void> getPremium() async {
    var premiumModel = await _premiumLocalDataSource.get();
    if (premiumModel != null) {
      isPremium = premiumModel.isPremium!;
    }
  }

  Future<void> updateOnboard() async {
    OnboardingModel model = OnboardingModel(firstOpen: true);
    await _onboardingLocalDataSource.update(model);
  }
}
