import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/hive/hive_box.dart';
import 'package:chat_gpt/features/presentation/home_view/chat_view_model.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view_model.dart';
import 'package:chat_gpt/features/presentation/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  hiveRegisterAdapter();
  await hiveBox();
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
        scaffoldBackgroundColor: ColorConstant.instance.black,
        primaryColor: ColorConstant.instance.green,
        colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstant.instance.green,
            background: ColorConstant.instance.white),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
