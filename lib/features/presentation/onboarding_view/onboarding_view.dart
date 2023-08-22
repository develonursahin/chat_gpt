// ignore_for_file: use_build_context_synchronously

import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_elevated_button.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view.dart';
import 'package:chat_gpt/features/presentation/onboarding_view/onboarding_view_model.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purchase_view.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final OnboardingViewModel _onboardingViewModel;
  int currentPageIndex = 0;
  Color primaryColor = ColorConstant.instance.green;

  Future<void> nextPage() async {
    if (currentPageIndex < _onboardingViewModel.onboardingData.length - 1) {
      setState(() {
        currentPageIndex++;
      });
    } else {
      await _onboardingViewModel.updateOnboard();
      if (_onboardingViewModel.isPremium) {
        CustomNavigator.goToScreen(
          context,
          const HomeView(),
        );
      } else {
        CustomNavigator.goToScreen(
          context,
          const PurchaseView(openedFromOnboarding: true),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _onboardingViewModel = OnboardingViewModel();
    _onboardingViewModel.createOnboard();
    _onboardingViewModel.getPremium();
    _onboardingViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    late double sizeOf = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.instance.black,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Image.asset(
                  _onboardingViewModel.onboardingData[currentPageIndex]
                      ['imagePath']!,
                  key: ValueKey<int>(currentPageIndex),
                  fit: BoxFit.cover,
                  height: sizeOf * 0.80,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: ColorConstant.instance.black,
                child: Container(
                  margin: const EdgeInsets.only(right: 52, left: 52),
                  height: sizeOf * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: _onboardingViewModel
                              .onboardingData[currentPageIndex]['text1'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  " ${_onboardingViewModel.onboardingData[currentPageIndex]['text2']}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _onboardingViewModel.onboardingData[currentPageIndex]
                            ['text3']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingViewModel.onboardingData.length,
                          (index) => Container(
                            width: 15,
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: index == currentPageIndex
                                  ? primaryColor
                                  : ColorConstant.instance.darkGrey,
                            ),
                          ),
                        ),
                      ),
                      CustomElevatedButton(
                          onPressed: () async {
                            await nextPage();
                          },
                          buttonText: "Next")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
