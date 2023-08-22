// ignore_for_file: use_build_context_synchronously

import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/features/data/models/get_premium_model.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PurchaseViewModel extends ChangeNotifier {
  final PremiumLocalDataSource _premiumLocalDataSource =
      PremiumLocalDataSource();

  Future<void> updatePremiumAndShowDialog(BuildContext context) async {
    final model = GetPremiumModel(isPremium: true);
    await _premiumLocalDataSource.update(model);
    await showAlertDialog(context);
    //CustomNavigator.goToScreen(context, const HomeView());
  }

  Future<void> showAlertDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder<bool>(
          future: _delayed(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/loading.json',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            } else {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/completed.json',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );

    await Future.delayed(const Duration(seconds: 4));

    Navigator.of(context, rootNavigator: true).pop();
    CustomNavigator.goToScreen(context, const HomeView());
  }

  Future<bool> _delayed() async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }
}
