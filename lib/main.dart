import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/presentation/views/home_view/home_view.dart';
import 'package:chat_gpt/features/presentation/views/settings_view/settings_view.dart';
import 'package:chat_gpt/features/presentation/views/splash_view/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const HomeView(),
    );
  }
}
