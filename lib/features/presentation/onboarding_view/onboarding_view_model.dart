import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/data/datasource/onboarding_local_datasource.dart';
import 'package:chat_gpt/features/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/features/data/models/onboarding_model.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view_model.dart';
import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PremiumLocalDataSource _premiumLocalDataSource =
      PremiumLocalDataSource();
  final OnboardingLocalDataSource _onboardingLocalDataSource =
      OnboardingLocalDataSource();
  final HomeViewModel _homeViewModel = HomeViewModel();

  int currentPageIndex = 0;
  bool isPremium = false;
  String firstMessage = TextConstants.instance.firstMessage;
  String sender = TextConstants.instance.robot;

  final List<Map<String, String?>> onboardingData = [
    {
      TextConstants.instance.text1: TextConstants.instance.onBoarding1Text1,
      TextConstants.instance.text2: TextConstants.instance.onBoarding1Text2,
      TextConstants.instance.text3: TextConstants.instance.onBoarding1Text3,
      TextConstants.instance.imagePath:
          TextConstants.instance.onBoarding1imagePath,
    },
    {
      TextConstants.instance.text1: TextConstants.instance.onBoarding2Text1,
      TextConstants.instance.text2: TextConstants.instance.onBoarding2Text2,
      TextConstants.instance.text3: TextConstants.instance.onBoarding2Text3,
      TextConstants.instance.imagePath:
          TextConstants.instance.onBoarding2imagePath,
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
