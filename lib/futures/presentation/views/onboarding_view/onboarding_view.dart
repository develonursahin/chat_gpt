import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/core/routes/custom_navigator.dart';
import 'package:chat_gpt/futures/presentation/views/purchase_view/purchase_view.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentPageIndex = 0;
  Color primaryColor = ColorConstant.instance.green;

  final List<Map<String, String?>> onboardingData = [
    {
      'text1': 'Lorem',
      'text2': 'Ipsum dolor sit',
      'text3': 'Ask the bot anything, It’s always ready to help!',
      'imagePath': 'assets/icons/onboard1.png',
    },
    {
      'text1': 'Lorem',
      'text2': 'Ipsum dolor sit',
      'text3': 'Get the best answers from our application Enjoy!',
      'imagePath': 'assets/icons/onboard2.png',
    },
  ];

  void nextPage() {
    if (currentPageIndex < onboardingData.length - 1) {
      setState(() {
        currentPageIndex++;
      });
    } else {
      CustomNavigator.goToScreen(context, const PurchaseView());
    }
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
                  onboardingData[currentPageIndex]['imagePath']!,
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
                          text: onboardingData[currentPageIndex]['text1'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  " ${onboardingData[currentPageIndex]['text2']}",
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
                        onboardingData[currentPageIndex]['text3']!,
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
                          onboardingData.length,
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
                      ElevatedButton(
                        onPressed: nextPage,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(sizeOf, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          backgroundColor: ColorConstant.instance.green,
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
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

void main() {
  runApp(const MaterialApp(home: OnboardingView()));
}
