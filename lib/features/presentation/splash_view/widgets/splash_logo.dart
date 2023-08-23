import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(TextConstants.instance.logoPath),
    );
  }
}
