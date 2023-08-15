import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.text,
    this.isPrimaryColor = false,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
  });

  final String text;
  final double? fontSize;
  final bool isPrimaryColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: isPrimaryColor
            ? ColorConstant.instance.green
            : ColorConstant.instance.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
