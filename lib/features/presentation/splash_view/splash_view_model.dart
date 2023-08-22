import 'package:chat_gpt/features/core/hive/hive_box.dart';
import 'package:chat_gpt/features/data/datasource/message_limit_local_datasource.dart';
import 'package:chat_gpt/features/data/datasource/onboarding_local_datasource.dart';
import 'package:chat_gpt/features/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/features/data/models/get_premium_model.dart';
import 'package:chat_gpt/features/data/models/message_limit_model.dart';

class SplashViewModel {
  late OnboardingLocalDataSource _onboardingLocalDataSource;
  late PremiumLocalDataSource _premiumLocalDataSource;
  late MessageLimitLocalDataSource _messageLimitLocalDataSource;

  bool firstOpen = false;
  bool isPremium = false;
  String firstMessage = "Hi, how can i help you?";
  String sender = 'robot';

  Future<void> init(Function navigate) async {
    _onboardingLocalDataSource = OnboardingLocalDataSource();
    _premiumLocalDataSource = PremiumLocalDataSource();
    _messageLimitLocalDataSource = MessageLimitLocalDataSource();
    await createPremium();
    await getOnboard();
    await getPremium();
    await createMessageLimit();
    navigate();
  }

  Future<void> createPremium() async {
    if (getPremiumBox.isEmpty) {
      GetPremiumModel model = GetPremiumModel(isPremium: false);
      await _premiumLocalDataSource.create(model);
    }
  }

  Future<void> createMessageLimit() async {
    if (messageLimitBox.isEmpty) {
      MessageLimitModel model =
          MessageLimitModel(isLimitFull: false, messageCount: 0);
      await _messageLimitLocalDataSource.create(model);
    }
  }

  Future<void> getPremium() async {
    if (getPremiumBox.isNotEmpty) {
      var premiumModel = await _premiumLocalDataSource.get();
      if (premiumModel != null) {
        isPremium = premiumModel.isPremium!;
      }
    }
  }

  Future<void> getOnboard() async {
    if (onboardingBox.isNotEmpty) {
      var onboardingModel = await _onboardingLocalDataSource.get();
      firstOpen = onboardingModel!.firstOpen!;
    }
  }
}
