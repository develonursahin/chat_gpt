import 'package:chat_gpt/futures/data/models/onboarding_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class OnboardingLocalDataSource {
  Future<void> create(OnboardingModel model) async {
    try {
      var box = await Hive.openBox<OnboardingModel>("onboarding_model");
      await box.add(model);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<OnboardingModel?> get() async {
    try {
      var box = await Hive.openBox<OnboardingModel>("onboarding_model");
      return box.getAt(0);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete() async {
    try {
      var box = await Hive.openBox<OnboardingModel>("onboarding_model");
      box.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> update(OnboardingModel model) async {
    try {
      var box = await Hive.openBox<OnboardingModel>("onboarding_model");
      box.putAt(0, model);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
