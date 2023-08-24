
import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
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
        text: TextConstants.instance.chat,
        style: TextStyle(
          fontFamily: TextConstants.instance.fontFamily,
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: TextConstants.instance.gpt,
            style: TextStyle(
              fontFamily: TextConstants.instance.fontFamily,
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
