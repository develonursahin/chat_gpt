// ignore_for_file: library_private_types_in_public_api

import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_bottom_text_widget.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_elevated_button.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_logo_widget.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view_model.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purcahse_view_model.dart';
import 'package:chat_gpt/features/presentation/purchase_view/widgets/purchase_card_widget.dart';
import 'package:chat_gpt/features/presentation/purchase_view/widgets/unlock_to_continue_widget.dart';
import 'package:flutter/material.dart';

class PurchaseView extends StatefulWidget {
  const PurchaseView({Key? key, required this.openedFromOnboarding})
      : super(key: key);
  final bool openedFromOnboarding;

  @override
  _PurchaseViewState createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  late final PurchaseViewModel _purchaseViewModel;
  late final HomeViewModel _homeViewModel;

  String? selectedPaymentOption;
  bool isLoad = false;
  bool isPaymentOptionSelected = false;
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    _purchaseViewModel = PurchaseViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.instance.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              const UnlockToContinueWidget(),
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
                onPressed: () async {
                  if (isPaymentOptionSelected) {
                    await _purchaseViewModel
                        .updatePremiumAndShowDialog(context);
                    await _homeViewModel.updateMessageLimit(false);
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
}
