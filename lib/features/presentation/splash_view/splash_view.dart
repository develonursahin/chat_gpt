import 'dart:async';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view.dart';
import 'package:chat_gpt/features/presentation/onboarding_view/onboarding_view.dart';
import 'package:chat_gpt/features/presentation/splash_view/splash_view_model.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel();
    _viewModel.init(navigate);
  }

  void navigate() {
    Timer(const Duration(seconds: 3), () {
      if (_viewModel.firstOpen) {
        CustomNavigator.goToScreen(context, const HomeView());
      } else {
        CustomNavigator.goToScreen(context, const OnboardingView());
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
