import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/data/models/chat_model.dart';
import 'package:chat_gpt/futures/data/models/get_premium_model.dart';
import 'package:chat_gpt/futures/data/models/onboarding_model.dart';
import 'package:chat_gpt/futures/presentation/home_view/home_view_model.dart';
import 'package:chat_gpt/futures/presentation/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter<OnboardingModel>(OnboardingModelAdapter());
  Hive.registerAdapter<GetPremiumModel>(GetPremiumModelAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat GPT',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey[50],
        primaryColor: Colors.amber,
        colorScheme:
            ColorScheme.fromSeed(seedColor: ColorConstant.instance.green),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
