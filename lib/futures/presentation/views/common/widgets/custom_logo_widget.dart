import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:flutter/material.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Chat",
        style: const TextStyle(
          fontFamily: "Inter",
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "GPT",
            style: TextStyle(
              fontFamily: "Inter",
              color: ColorConstant.instance.green,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
