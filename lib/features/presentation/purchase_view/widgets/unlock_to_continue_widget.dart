import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class UnlockToContinueWidget extends StatelessWidget {
  const UnlockToContinueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock,
          color: ColorConstant.instance.green,
          size: 19,
        ),
        const SizedBox(width: 10),
        CustomTextWidget(
          text: TextConstants.instance.unlockToContinue,
          fontSize: 19,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
