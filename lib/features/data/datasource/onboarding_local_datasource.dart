import 'package:chat_gpt/features/core/hive/hive_box.dart';
import 'package:chat_gpt/features/data/models/onboarding_model.dart';
import 'package:flutter/foundation.dart';

class OnboardingLocalDataSource {
  Future<void> create(OnboardingModel model) async {
    try {
      await onboardingBox.add(model);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<OnboardingModel?> get() async {
    try {
      return onboardingBox.getAt(0);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete() async {
    try {
      onboardingBox.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> update(OnboardingModel model) async {
    try {
      onboardingBox.putAt(0, model);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
