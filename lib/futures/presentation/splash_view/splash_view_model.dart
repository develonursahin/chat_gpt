import 'package:chat_gpt/futures/core/hive/hive_box.dart';
import 'package:chat_gpt/futures/data/datasource/message_counter_local_datasource.dart';
import 'package:chat_gpt/futures/data/datasource/onboarding_local_datasource.dart';
import 'package:chat_gpt/futures/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/futures/data/models/get_premium_model.dart';
import 'package:chat_gpt/futures/data/models/message_counter_model.dart';

class SplashViewModel {
  late OnboardingLocalDataSource _onboardingLocalDataSource;
  late PremiumLocalDataSource _premiumLocalDataSource;
  late MessageCounterLocalDataSource _messageCounterLocalDataSource;
  bool firstOpen = false;
  bool isPremium = false;

  Future<void> init(Function navigate) async {
    _onboardingLocalDataSource = OnboardingLocalDataSource();
    _premiumLocalDataSource = PremiumLocalDataSource();
    _messageCounterLocalDataSource = MessageCounterLocalDataSource();

    await createPremium();
    await getOnboard();
    await getPremium();
    await createMessageCounter();
    navigate();
  }

  Future<void> createMessageCounter() async {
    if (messageCounterBox.isEmpty) {
      await _messageCounterLocalDataSource
          .create(MessageCounterModel(counter: 0, index: 0));
    }
  }

  Future<void> createPremium() async {
    GetPremiumModel model = GetPremiumModel(isPremium: false);
    await _premiumLocalDataSource.create(model);
  }

  Future<void> getPremium() async {
    var premiumModel = await _premiumLocalDataSource.get();
    if (premiumModel != null) {
      isPremium = premiumModel.isPremium!;
    }
  }

  Future<void> getOnboard() async {
    try {
      var onboardingModel = await _onboardingLocalDataSource.get();
      firstOpen = onboardingModel?.firstOpen ?? false;
    } catch (e) {
      firstOpen = false;
    }
  }
}
