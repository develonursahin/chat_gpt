import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/data/models/chat_model.dart';
import 'package:chat_gpt/features/data/models/get_premium_model.dart';
import 'package:chat_gpt/features/data/models/message_limit_model.dart';
import 'package:chat_gpt/features/data/models/onboarding_model.dart';
import 'package:hive/hive.dart';

late Box<MessageLimitModel> messageLimitBox;
late Box<GetPremiumModel> getPremiumBox;
late Box<OnboardingModel> onboardingBox;
late Box<ChatModel> chatBox;

void hiveRegisterAdapter() {
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter<OnboardingModel>(OnboardingModelAdapter());
  Hive.registerAdapter<GetPremiumModel>(GetPremiumModelAdapter());
  Hive.registerAdapter<MessageLimitModel>(MessageLimitModelAdapter());
}

Future<void> hiveBox() async {
  getPremiumBox =
      await Hive.openBox<GetPremiumModel>(TextConstants.instance.premiumModel);
  onboardingBox = await Hive.openBox<OnboardingModel>(
      TextConstants.instance.onboardingModel);
  messageLimitBox = await Hive.openBox<MessageLimitModel>(
      TextConstants.instance.messageLimitModel);
}
