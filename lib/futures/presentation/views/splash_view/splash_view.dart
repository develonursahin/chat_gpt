import 'dart:async';

import 'package:chat_gpt/futures/core/routes/custom_navigator.dart';
import 'package:chat_gpt/futures/presentation/views/home_view/home_view.dart';
import 'package:chat_gpt/futures/presentation/views/onboarding_view/onboarding_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late bool firstLogin = true;
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    Timer(const Duration(seconds: 3), () {
      if (firstLogin) {
        CustomNavigator.goToScreen(context, const OnboardingView());
      } else {
        CustomNavigator.goToScreen(context, const HomeView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(
                flex: 3,
              ),
              Image.asset("assets/icons/splash.png"),
              const Spacer(
                flex: 2,
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
