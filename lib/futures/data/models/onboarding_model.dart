import 'package:hive_flutter/hive_flutter.dart';

part 'onboarding_model.g.dart';

@HiveType(typeId: 1)
class OnboardingModel {
  @HiveField(0)
  bool? firstOpen;
  OnboardingModel({required this.firstOpen});
}
