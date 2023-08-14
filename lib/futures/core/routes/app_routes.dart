import 'package:chat_gpt/futures/core/constants/enums/routes_enum.dart';
import 'package:chat_gpt/futures/presentation/views/home_view/home_view.dart';
import 'package:chat_gpt/futures/presentation/views/onboarding_view/onboarding_view.dart';
import 'package:chat_gpt/futures/presentation/views/purchase_view/purchase_view.dart';
import 'package:chat_gpt/futures/presentation/views/settings_view/settings_view.dart';
import 'package:chat_gpt/futures/presentation/views/splash_view/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._init();
  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;

  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    final routes = Routes.values.byName(routeSettings.name!);

    switch (routes) {
      case Routes.purchase:
        return navigate(const PurchaseView());
      case Routes.home:
        return navigate(const HomeView());
      case Routes.onBoarding:
        return navigate(const OnboardingView());
      case Routes.settings:
        return navigate(const SettingsView());
      case Routes.splash:
        return navigate(
            const SplashView()); // You might need to implement a SplashView
      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          ),
        );
    }
  }

  PageRouteBuilder navigate(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          child,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
