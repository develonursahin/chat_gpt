// ignore_for_file: use_build_context_synchronously

import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/presentation/views/common/widgets/custom_bottom_text_widget.dart';
import 'package:chat_gpt/features/presentation/views/common/widgets/custom_elevated_button.dart';
import 'package:chat_gpt/features/presentation/views/common/widgets/custom_logo_widget.dart';
import 'package:chat_gpt/features/presentation/views/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/features/presentation/views/home_view/home_view.dart';
import 'package:chat_gpt/features/presentation/views/purchase_view/widgets/purchase_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PurchaseView extends StatefulWidget {
  const PurchaseView({Key? key, required this.openedFromOnboarding})
      : super(key: key);
  final bool openedFromOnboarding;

  @override
  // ignore: library_private_types_in_public_api
  _PurchaseViewState createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  String? selectedPaymentOption;
  bool isLoad = false;
  bool isPaymentOptionSelected = false;
  bool isPremium = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.instance.black,
      appBar: AppBar(
        backgroundColor: ColorConstant.instance.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 34),
            child: IconButton(
              onPressed: () {
                if (widget.openedFromOnboarding) {
                  CustomNavigator.goToScreen(context, const HomeView());
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.close_rounded),
              color: ColorConstant.instance.darkGrey,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 52, left: 52),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CustomLogoWidget(),
              const CustomTextWidget(
                text: "Unlimited chat with gpt for only, Try It Now.",
                fontSize: 22,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    color: ColorConstant.instance.green,
                    size: 19,
                  ),
                  const SizedBox(width: 10),
                  const CustomTextWidget(
                    text: "Unlock to continue",
                    fontSize: 19,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: paymentOptions.map((paymentOption) {
                  return PurchaseCard(
                    isSelected: paymentOption['name'] == selectedPaymentOption,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedPaymentOption = paymentOption['name'];
                          isPaymentOptionSelected = true;
                        } else {
                          selectedPaymentOption = null;
                          isPaymentOptionSelected = false;
                        }
                      });
                    },
                    paymentName: paymentOption['name'],
                    paymentPrice: paymentOption['price'],
                  );
                }).toList(),
              ),
              CustomElevatedButton(
                onPressed: () {
                  if (isPaymentOptionSelected) {
                    _showAlertDialog(context);
                    isPremium = true;
                  } else {
                    _showToast(context, 'Please select a payment option');
                  }
                },
                buttonText: "Try It Now",
              ),
              const CustomBottomTextWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<bool> delayed() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoad = true;
    });
    return isLoad;
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder<bool>(
          future: delayed(),
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
}
