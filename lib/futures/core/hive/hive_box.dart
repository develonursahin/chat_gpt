import 'package:chat_gpt/futures/data/models/chat_model.dart';
import 'package:chat_gpt/futures/data/models/get_premium_model.dart';
import 'package:chat_gpt/futures/data/models/message_counter_model.dart';
import 'package:chat_gpt/futures/data/models/onboarding_model.dart';
import 'package:hive/hive.dart';

late Box<MessageCounterModel> messageCounterBox;
late Box<GetPremiumModel> getPremiumBox;
late Box<OnboardingModel> onboardingBox;
late Box<ChatModel> chatBox;

void hiveRegisterAdapter() {
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter<OnboardingModel>(OnboardingModelAdapter());
  Hive.registerAdapter<GetPremiumModel>(GetPremiumModelAdapter());
  Hive.registerAdapter<MessageCounterModel>(MessageCounterModelAdapter());
}

Future<void> hiveBox() async {
  messageCounterBox =
      await Hive.openBox<MessageCounterModel>('message_counter_model');
  getPremiumBox = await Hive.openBox<GetPremiumModel>('premium_model');
  onboardingBox = await Hive.openBox<OnboardingModel>('onboarding_model');
}
