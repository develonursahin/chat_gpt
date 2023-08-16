import 'package:chat_gpt/futures/data/datasource/onboarding_local_datasource.dart';
import 'package:chat_gpt/futures/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/futures/data/models/get_premium_model.dart';

class SplashViewModel {
  late OnboardingLocalDataSource _onboardingLocalDataSource;
  late PremiumLocalDataSource _premiumLocalDataSource;
  bool firstOpen = false;
  bool isPremium = false;

  Future<void> init(Function navigate) async {
    _onboardingLocalDataSource = OnboardingLocalDataSource();
    _premiumLocalDataSource = PremiumLocalDataSource();
    await createPremium();
    await getOnboard1();
    await getPremium();
    navigate();
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

  Future<void> getOnboard1() async {
    try {
      var onboardingModel = await _onboardingLocalDataSource.get();
      firstOpen = onboardingModel?.firstOpen ?? false;
    } catch (e) {
      firstOpen = false;
    }
  }
}
